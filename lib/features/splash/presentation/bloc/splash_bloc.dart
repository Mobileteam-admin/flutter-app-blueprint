import 'package:bloc/bloc.dart';

import '../../../../core/storage/shared_prefs.dart';

enum SplashState { initial, authenticated, unauthenticated }

class SplashBloc extends Cubit<SplashState> {
  final SharedPrefManager prefs;
  SplashBloc({required this.prefs}) : super(SplashState.initial);

  Future<void> checkAuth() async {
    final logged = prefs.getBool(SharedPrefManager.keyLogin) ?? false;
    if (logged) emit(SplashState.authenticated);
    else emit(SplashState.unauthenticated);
  }
}
