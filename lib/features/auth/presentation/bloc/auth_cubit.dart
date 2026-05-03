import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/usecases/login_usecase.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final LoginUseCase loginUseCase;

  AuthCubit({required this.loginUseCase}) : super(const AuthInitial());

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    emit(const AuthLoading());

    try {
      final user = await loginUseCase(
        identifier: identifier,
        password: password,
      );
      emit(AuthSuccess(user));
    } on UnauthorizedFailure catch (e) {
      emit(AuthFailure(e.message));
    } on NetworkFailure catch (e) {
      emit(AuthFailure(e.message));
    } on ServerFailure catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure('Something went wrong: $e'));
    }
  }

  void resetState() => emit(const AuthInitial());
}