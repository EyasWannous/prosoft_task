import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:prosoft_task/theme/bloc/theme_helper.dart';
import 'package:prosoft_task/theme/theme.dart';

part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(ThemeData.light()) {
    on<InitialThemeSetEvent>(_onInitialThemeSetEvent);
    on<ThemeSwitchEvent>(_onThemeSwitchEvent);
  }

  Future<void> _onInitialThemeSetEvent(event, emit) async {
    final bool hasDarkTheme = await isDark();
    if (hasDarkTheme) {
      emit(FlutterTasksTheme.dark);
      return;
    }

    emit(FlutterTasksTheme.light);
  }

  void _onThemeSwitchEvent(event, emit) {
    final isDark = state.colorScheme == FlutterTasksTheme.dark.colorScheme;
    emit(isDark ? FlutterTasksTheme.light : FlutterTasksTheme.dark);
    setTheme(isDark);
  }
}
