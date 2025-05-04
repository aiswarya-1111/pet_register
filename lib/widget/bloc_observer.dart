import 'package:flutter_bloc/flutter_bloc.dart';

class EchoCubitDelegate extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // ignore: avoid_print
    if (DebugMode.isInDebugMode) print(change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    // ignore: avoid_print
    if (DebugMode.isInDebugMode) print(error);
  }
}

class DebugMode {
  DebugMode._();
  static bool get isInDebugMode {
    bool inDebugMode = true;
    assert(inDebugMode = true);
    return inDebugMode;
  }
}