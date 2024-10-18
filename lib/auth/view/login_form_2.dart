import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prosoft_task/extensions/sizebox_extension.dart';
import 'package:prosoft_task/auth/cubit/auth_cubit.dart';

import '../widgets/widgets.dart';

class LoginForm2 extends StatelessWidget {
  const LoginForm2({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AuthStatus.failure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Scaffold(
            body: Column(
              children: [
                const PageHeader(),
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      // color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Form(
                        key: context.read<AuthCubit>().loginFormKey,
                        child: Column(
                          children: [
                            const PageHeading(title: 'Log-in'),
                            CustomInputField(
                                textEditingController:
                                    context.read<AuthCubit>().emailController,
                                labelText: 'Email',
                                hintText: 'Your email',
                                validator: (textValue) {
                                  if (textValue == null || textValue.isEmpty) {
                                    return 'Email is required!';
                                  }
                                  // if (!EmailValidator.validate(textValue)) {
                                  //   return 'Please enter a valid email';
                                  // }
                                  return null;
                                }),
                            16.h,
                            CustomInputField(
                              textEditingController:
                                  context.read<AuthCubit>().passwordController,
                              labelText: 'Password',
                              hintText: 'Your password',
                              obscureText: true,
                              suffixIcon: true,
                              validator: (textValue) {
                                if (textValue == null || textValue.isEmpty) {
                                  return 'Password is required!';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 16),
                            Container(
                              width: size.width * 0.80,
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                // onTap: () => {
                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (_) =>
                                //           BlocProvider<AuthCubit>.value(
                                //         value: context.read<AuthCubit>(),
                                //         child: const ForgetPasswordPage(),
                                //       ),
                                //     ),
                                //   )
                                // },
                                child: Text(
                                  'Forget password?',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                ),
                              ),
                            ),
                            20.h,
                            CustomFormButton(
                              innerText: 'Login',
                              onPressed: () => context
                                  .read<AuthCubit>()
                                  .handleLoginUser(context),
                            ),
                            18.h,
                            SizedBox(
                              width: size.width * 0.8,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Don\'t have an account ? ',
                                    // style: TextStyle(
                                    //   fontSize: 13,
                                    //   color: Color(0xff939393),
                                    //   fontWeight: FontWeight.bold,
                                    // ),
                                  ),
                                  GestureDetector(
                                    onTap: () => {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     // builder: (_) => BlocProvider(
                                      //     //       create: (_) => AuthCubit(
                                      //     //         context.read<
                                      //     //             IAuthenticationRepository>(),
                                      //     //         context.read<AppBloc>(),
                                      //     //       ),
                                      //     //       child: const SignupPage(),
                                      //     //     )
                                      //     builder: (_) =>
                                      //         BlocProvider<AuthCubit>.value(
                                      //       value: context.read<AuthCubit>(),
                                      //       child: const SignupPage(),
                                      //     ),
                                      //   ),
                                      // )
                                    },
                                    child: Text(
                                      'Sign-up',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            20.h,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
