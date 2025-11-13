import 'package:bloc/bloc.dart';
import '../../../../core/network/http_service.dart';
import '../../../../core/storage/shared_prefs.dart';
import 'package:equatable/equatable.dart';

class HomeState {}
class HomeInitial extends HomeState {}
class HomeLoading extends HomeState {}
class HomeLoaded extends HomeState {
  final String welcome;
  HomeLoaded(this.welcome);
}
class HomeError extends HomeState {
  final String msg;
  HomeError(this.msg);
}

class HomeBloc extends Cubit<HomeState> {
  final HttpService httpService;
  final SharedPrefManager prefs;
  HomeBloc({required this.httpService, required this.prefs}) : super(HomeInitial());

  Future<void> loadHome() async {
    emit(HomeLoading());
    try {
      // simulate an API call using httpService; here we call a dummy endpoint that returns 401 once to trigger refresh if token is invalid
      final token = prefs.getString(SharedPrefManager.keyToken) ?? '';
      // simulate behavior: if token == 'invalid' then trigger 401 by throwing
      if (token == 'invalid') {
        throw Exception('401');
      }
      await Future.delayed(const Duration(seconds:1));
      final name = prefs.getString(SharedPrefManager.keyUserName) ?? 'Test User';
      emit(HomeLoaded('Welcome, $name'));
    } catch (e) {
      emit(HomeError('Failed to load home'));
    }
  }

  Future<void> logout() async {
    await prefs.clearAll();
  }
}
