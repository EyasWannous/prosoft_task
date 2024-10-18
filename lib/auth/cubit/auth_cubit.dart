import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prosoft_task/api/authentication/i_authentication_repository.dart';
import 'package:prosoft_task/app/bloc/app_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authenticationRepository, this._appBloc)
      : super(const AuthState()) {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    nameController = TextEditingController();
    contactNumberController = TextEditingController();
    emailController.text = 'kminchelle';
    passwordController.text = '0lelplR';
  }

  final IAuthenticationRepository _authenticationRepository;
  final AppBloc _appBloc;
  final loginFormKey = GlobalKey<FormState>();
  final signupFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  File? profileImage;

  Future<void> logInWithCredentials() async {
    if (!loginFormKey.currentState!.validate()) return;

    if (state.status == AuthStatus.inProgress) return;

    emit(state.copyWith(status: AuthStatus.inProgress));
    try {
      var userResult = await _authenticationRepository.login(
        username: emailController.text,
        password: passwordController.text,
      );
      if (userResult == null) {
        emit(state.copyWith(status: AuthStatus.failure));
      } else {
        emit(state.copyWith(status: AuthStatus.success));
      }

      _appBloc.add(AppTokenChecked(userResult?.token ?? ''));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: AuthStatus.failure,
        ),
      );
    }
  }

  Future pickProfileImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      profileImage = imageTemporary;
      emit(state.copyWith(status: AuthStatus.imageSuccess));
      emit(state.copyWith(status: AuthStatus.initial));
    } on PlatformException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: AuthStatus.imageFailure,
        ),
      );
      emit(state.copyWith(status: AuthStatus.initial));

      debugPrint('Failed to pick image error: $e');
    }
  }

  Future<void> handleLoginUser(BuildContext context) async {
    if (loginFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('Submitting data..')),
        );
      await logInWithCredentials();
    }
  }

  void handleSignupUser(BuildContext context) {
    if (signupFormKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Submitting data..')),
      );
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    contactNumberController.dispose();
    return super.close();
  }
}
