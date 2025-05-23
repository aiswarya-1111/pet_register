import 'package:bloc/bloc.dart';

class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState);

  @override
  void emit(T state) {
    if (isClosed) {
      return;
    }
    super.emit(state);
  }
}
