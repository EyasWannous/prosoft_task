import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prosoft_task/extensions/sizebox_extension.dart';
import 'package:prosoft_task/auth/cubit/auth_cubit.dart';
import 'package:prosoft_task/auth/view/login_page_2.dart';

import '../widgets/widgets.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.imageFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Image Load Failure'),
              ),
            );
        }
        if (state.status == AuthStatus.imageSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('Image loaded successfuly!'),
              ),
            );
        }
      },
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: const Color(0xffEEF1F3),
          body: SingleChildScrollView(
            child: Form(
              key: context.read<AuthCubit>().signupFormKey,
              child: Column(
                children: [
                  const PageHeader(),
                  Container(
                    decoration: const BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      children: [
                        const PageHeading(title: 'Sign-up'),
                        SizedBox(
                          width: 130,
                          height: 130,
                          child: BlocBuilder<AuthCubit, AuthState>(
                            builder: (_, state) {
                              return GestureDetector(
                                onTap:
                                    context.read<AuthCubit>().pickProfileImage,
                                child: CircleAvatar(
                                  // backgroundColor: Colors.grey.shade200,
                                  backgroundImage:
                                      context.read<AuthCubit>().profileImage !=
                                              null
                                          ? FileImage(
                                              context
                                                  .read<AuthCubit>()
                                                  .profileImage!,
                                            )
                                          : null,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        bottom: 5,
                                        right: 5,
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            // color: Colors.blue.shade400,
                                            border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimaryContainer,
                                              width: 3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: const Icon(
                                            Icons.camera_alt_sharp,
                                            // color: Colors.white,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        16.h,
                        CustomInputField(
                            textEditingController:
                                context.read<AuthCubit>().nameController,
                            labelText: 'Name',
                            hintText: 'Your name',
                            isDense: true,
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'Name field is required!';
                              }
                              return null;
                            }),
                        16.h,
                        CustomInputField(
                            textEditingController:
                                context.read<AuthCubit>().emailController,
                            labelText: 'Email',
                            hintText: 'Your email',
                            isDense: true,
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'Email is required!';
                              }
                              if (!EmailValidator.validate(textValue)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            }),
                        16.h,
                        CustomInputField(
                            textEditingController: context
                                .read<AuthCubit>()
                                .contactNumberController,
                            labelText: 'Contact no.',
                            hintText: 'Your contact number',
                            isDense: true,
                            validator: (textValue) {
                              if (textValue == null || textValue.isEmpty) {
                                return 'Contact number is required!';
                              }
                              return null;
                            }),
                        16.h,
                        CustomInputField(
                          textEditingController:
                              context.read<AuthCubit>().passwordController,
                          labelText: 'Password',
                          hintText: 'Your password',
                          isDense: true,
                          obscureText: true,
                          validator: (textValue) {
                            if (textValue == null || textValue.isEmpty) {
                              return 'Password is required!';
                            }
                            return null;
                          },
                          suffixIcon: true,
                        ),
                        22.h,
                        CustomFormButton(
                          innerText: 'Signup',
                          onPressed: () => context
                              .read<AuthCubit>()
                              .handleSignupUser(context),
                        ),
                        18.h,
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Already have an account ? ',
                                // style: TextStyle(
                                //   fontSize: 13,
                                //   color: Color(0xff939393),
                                //   fontWeight: FontWeight.bold,
                                // ),
                              ),
                              GestureDetector(
                                onTap: () => {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginPage2(),
                                    ),
                                  ),
                                },
                                child: Text(
                                  'Log-in',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                  // style: TextStyle(
                                  //   fontSize: 15,
                                  //   color: Color(0xff748288),
                                  //   fontWeight: FontWeight.bold,
                                  // ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        30.h,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
