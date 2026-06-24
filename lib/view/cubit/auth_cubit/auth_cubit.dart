import 'package:bloc/bloc.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  final AuthService _authService = AuthService();

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      if (ex.code == 'user-not-found' ||
          ex.code == 'wrong-password' ||
          ex.code == 'invalid-credential') {
        emit(LoginFailure(errMessage: "Invalid email or password"));
      } else if (ex.code == 'network-request-failed') {
        emit(LoginFailure(errMessage: "Check your internet connection"));
      } else {
        emit(LoginFailure(errMessage: "Error: ${ex.message}"));
      }
    }
  }

  Future<void> signInWithGoogle() async {
    emit(LoginLoading());
    try {
      UserCredential? userCredential = await _authService.signInWithGoogle();

      if (userCredential != null) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure(errMessage: "Google Sign-In failed"));
      }
    } catch (e) {
      emit(LoginFailure(errMessage: "Google Sign-In failed"));
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      emit(RegisterFailure(errMessage: "Faild with error code: ${ex.code}"));
    }
  }

  Future<void> registerInWithGoogle() async {
    emit(RegisterLoading());
    try {
      UserCredential? userCredential = await _authService.signInWithGoogle();

      if (userCredential != null) {
        emit(RegisterSuccess());
      } else {
        emit(RegisterFailure(errMessage: "Google Sign-In failed"));
      }
    } catch (e) {
      emit(RegisterFailure(errMessage: "Google Sign-In failed"));
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    super.onChange(change);
    print(change);
  }
}
