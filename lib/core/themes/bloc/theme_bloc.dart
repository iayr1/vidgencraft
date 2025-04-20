import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidgencraft/core/themes/app_theme.dart';

abstract class ThemeEvent {}

class ToggleThemeEvent extends ThemeEvent {}

class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);
}

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState(AppTheme.lightTheme)) {
    _init();
    on<ToggleThemeEvent>((event, emit) async {
      final newTheme = state.themeData.brightness == Brightness.light
          ? AppTheme.darkTheme
          : AppTheme.lightTheme;
      await _saveTheme(newTheme);
      emit(ThemeState(newTheme));
    });
  }

  void _init() async {
    final savedTheme = await _loadSavedTheme();
    emit(ThemeState(savedTheme));
  }

  static Future<ThemeData> _loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDarkMode') ?? false;
    return isDark ? AppTheme.darkTheme : AppTheme.lightTheme;
  }

  Future<void> _saveTheme(ThemeData theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', theme.brightness == Brightness.dark);
  }
}
