import 'dart:io';
import 'package:yaml/yaml.dart';

void main() async {
  final yamlFile = File('features.yaml');
  if (!yamlFile.existsSync()) {
    print('❌ Missing features.yaml');
    exit(1);
  }

  final yamlContent = loadYaml(await yamlFile.readAsString());
  final features = yamlContent['features'] as YamlList;

  for (final feature in features) {
    final name = feature['name'];
    generateMVVMStructure(name.toString());
  }

  print('\n✅ All GetX MVVM features and routes generated!');
}

void generateMVVMStructure(String name) {
  final basePath = Directory('lib/features/$name');
  final folders = ['model', 'view', 'view_model'];

  final files = {
    'model': '${name}_model.dart',
    'view': '${name}_view.dart',
    'view_model': '${name}_view_model.dart',
    'binding': '${name}_binding.dart',
  };

  if (!basePath.existsSync()) basePath.createSync(recursive: true);

  for (final folder in folders) {
    final dir = Directory('${basePath.path}/$folder');
    dir.createSync(recursive: true);

    final fileName = files[folder]!;
    final file = File('${dir.path}/$fileName');
    final className = _toPascalCase(fileName.replaceAll('.dart', ''));

    String content = '';

    switch (folder) {
      case 'model':
        content = 'class $className {\n  // Define your data model\n}\n';
        break;
      case 'view_model':
        content = '''
import 'package:get/get.dart';

class $className extends GetxController {
  // Controller logic here
}
''';
        break;
      case 'view':
        content = '''
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_model/${files['view_model']}';

class $className extends GetView<${_toPascalCase(files['view_model']!.replaceAll('.dart', ''))}> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('${_toPascalCase(name)}')),
      body: Center(child: Text('This is ${_toPascalCase(name)} View')),
    );
  }
}
''';
        break;
    }

    file.writeAsStringSync(content);
  }

  // Generate binding file
  final bindingFile = File('${basePath.path}/${files['binding']}');
  final bindingClass = _toPascalCase(files['binding']!.replaceAll('.dart', ''));
  final viewModelImport = 'view_model/${files['view_model']}';
  final viewModelClass = _toPascalCase(files['view_model']!.replaceAll('.dart', ''));

  bindingFile.writeAsStringSync('''
import 'package:get/get.dart';
import '$viewModelImport';

class $bindingClass extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<$viewModelClass>(() => $viewModelClass());
  }
}
''');

  final routeConstName = name.toLowerCase();
  final routePath = '/$routeConstName';

  _addRouteConstant(routeConstName, routePath);
  _addRouteToAppPages(routeConstName, routePath, bindingClass, _toPascalCase(files['view']!.replaceAll('.dart', '')));

  print('📦 Generated MVVM for "$name"');
}

String _toPascalCase(String input) {
  return input.split('_').map((word) => word[0].toUpperCase() + word.substring(1)).join();
}

void _addRouteConstant(String name, String path) {
  final file = File('lib/routes/app_routes.dart');
  if (!file.existsSync()) {
    file.createSync(recursive: true);
    file.writeAsStringSync('class AppRoutes {\n}\n');
  }

  var content = file.readAsStringSync();
  final constLine = "  static const $name = '$path';";

  if (!content.contains(constLine)) {
    final insertIndex = content.lastIndexOf('}');
    content = content.replaceRange(insertIndex, insertIndex, '  $constLine\n');
    file.writeAsStringSync(content);
    print('🔠 Added AppRoutes.$name');
  } else {
    print('⚠️  AppRoutes.$name already exists');
  }
}

void _addRouteToAppPages(String routeConst, String path, String bindingClass, String viewClass) {
  final appPagesFile = File('lib/routes/app_pages.dart');
  if (!appPagesFile.existsSync()) {
    print('❌ app_pages.dart not found');
    return;
  }

  final content = appPagesFile.readAsStringSync();
  final routeEntry = '''
    GetPage<$viewClass>(
      name: AppRoutes.$routeConst,
      page: () => $viewClass(),
      binding: $bindingClass(),
    ),
''';

  String updatedContent = content;

  if (!content.contains("AppRoutes.$routeConst")) {
    // Add imports if not already there
    if (!content.contains("import 'app_routes.dart'")) {
      updatedContent = "import 'app_routes.dart';\n$updatedContent";
    }
    if (!content.contains("import '../features/$routeConst/view/${routeConst}_view.dart';")) {
      updatedContent =
      "import '../features/$routeConst/view/${routeConst}_view.dart';\n$updatedContent";
    }
    if (!content.contains("import '../features/$routeConst/${routeConst}_binding.dart';")) {
      updatedContent =
      "import '../features/$routeConst/${routeConst}_binding.dart';\n$updatedContent";
    }

    final match = RegExp(r'static final routes\s*=\s*\[(.*?)\];', dotAll: true).firstMatch(updatedContent);
    if (match != null) {
      final originalRoutes = match.group(1)!;
      final newRoutes = '$originalRoutes$routeEntry';
      updatedContent = updatedContent.replaceFirst(match.group(0)!, 'static final routes = [$newRoutes];');
      appPagesFile.writeAsStringSync(updatedContent);
      print('✅ Route added in AppPages for "$routeConst"');
    } else {
      print('❌ Failed to update static route list in app_pages.dart');
    }
  } else {
    print('⚠️  Route for "$routeConst" already exists in app_pages.dart');
  }
}
