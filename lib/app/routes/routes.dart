import 'package:flutter/widgets.dart';
import 'package:prosoft_task/app/bloc/app_bloc.dart';
import 'package:prosoft_task/home/view/home_page.dart';
// import 'package:prosoft_task/login/view/login_page.dart';
import 'package:prosoft_task/auth/view/login_page_2.dart';

Widget onGenerateAppViewWidgets(AppStatus state) {
  switch (state) {
    case AppStatus.authenticated:
      return const HomePage();
    // case AppStatus.unauthenticated:
    //   return const LoginPage();
    case AppStatus.unauthenticated:
      return const LoginPage2();
  }
}
