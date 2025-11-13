import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/presentation/pages/login_page.dart';
import '../../home/presentation/home_page.dart';
import 'bloc/splash_bloc.dart';
import '../../../core/di/injector.dart' as di;

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late final SplashBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = di.sl<SplashBloc>();
    bloc.checkAuth();
    bloc.stream.listen((state) {
      if (state == SplashState.authenticated) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
      } else if (state == SplashState.unauthenticated) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
