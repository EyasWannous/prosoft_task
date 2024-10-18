import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prosoft_task/api/authentication/i_authentication_repository.dart';
import 'package:prosoft_task/app/bloc/app_bloc.dart';
import 'package:prosoft_task/extensions/widget_extension.dart';
import 'package:prosoft_task/login/cubit/login_cubit.dart';
import 'package:prosoft_task/login/view/login_form.dart';
import 'package:prosoft_task/theme/bloc/theme_bloc.dart';
import 'package:prosoft_task/theme/theme.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          BlocBuilder<ThemeBloc, ThemeData>(
            builder: (_, themeData) {
              return IconButton(
                onPressed: () =>
                    context.read<ThemeBloc>().add(ThemeSwitchEvent()),
                icon: Icon(
                  themeData.colorScheme == FlutterTasksTheme.dark.colorScheme
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                ),
              );
            },
          ),
        ],
      ),
      body: BlocProvider(
        create: (_) => LoginCubit(
          context.read<IAuthenticationRepository>(),
          context.read<AppBloc>(),
        ),
        child: const LoginForm(),
      ).allPadding(8),
    );
  }
}
