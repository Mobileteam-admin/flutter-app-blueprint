import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/injector.dart' as di;
import 'core/connectivity/connectivity_cubit.dart';
import 'core/network/http_service.dart';
import 'features/splash/presentation/splash_page.dart';
import 'core/storage/shared_prefs.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // register services
  // init shared prefs
  await di.sl<SharedPrefManager>().init();
  // init http service (setup dio interceptors)
  await di.sl<HttpService>().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ConnectivityCubit>()..start(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Clean BLoC Full',
        theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
        home: const SplashPage(),
      ),
    );
  }
}
