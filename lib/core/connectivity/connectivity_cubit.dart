import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../utils/snackbar_service.dart';

enum ConnectivityStatus { connected, disconnected }

class ConnectivityCubit extends Cubit<ConnectivityStatus> {
  final Connectivity connectivity;
  StreamSubscription? _sub;

  ConnectivityCubit({required this.connectivity})
      : super(ConnectivityStatus.connected);

  void start() {
    _checkInitial();

    _sub = connectivity.onConnectivityChanged.listen((results) async {
      // Handle both old and new versions of connectivity_plus
      final result = (results is List<ConnectivityResult> && results.isNotEmpty)
          ? results.first
          : results is ConnectivityResult
          ? results
          : ConnectivityResult.none;

      if (result == ConnectivityResult.none) {
        emit(ConnectivityStatus.disconnected);
        SnackbarService.showError(
            "You're Offline ❌\nPlease check your internet connection.");
      } else {
        emit(ConnectivityStatus.connected);
        SnackbarService.showMessage(
            'Back Online ✅ Your internet connection is restored.');
      }
    });
  }

  Future<void> _checkInitial() async {
    final res = await connectivity.checkConnectivity();
    final result = (res is List<ConnectivityResult> && res.isNotEmpty)
        ? res.first
        : res is ConnectivityResult
        ? res
        : ConnectivityResult.none;

    if (result == ConnectivityResult.none) {
      emit(ConnectivityStatus.disconnected);
      SnackbarService.showError(
          "You're Offline ❌\nPlease check your internet connection.");
    } else {
      emit(ConnectivityStatus.connected);
    }
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
