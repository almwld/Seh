import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class ThemeEvent {}
class SetThemeEvent extends ThemeEvent {
  final bool isDark;
  SetThemeEvent(this.isDark);
}
class GetThemeEvent extends ThemeEvent {}

// States
abstract class ThemeState {}
class ThemeInitialState extends ThemeState {}
class ThemeLoadedState extends ThemeState {
  final ThemeMode themeMode;
  ThemeLoadedState(this.themeMode);
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitialState()) {
    on<GetThemeEvent>(_onGetTheme);
    on<SetThemeEvent>(_onSetTheme);
    add(GetThemeEvent());
  }

  Future<void> _onGetTheme(GetThemeEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool('isDark') ?? false;
    emit(ThemeLoadedState(isDark ? ThemeMode.dark : ThemeMode.light));
  }

  Future<void> _onSetTheme(SetThemeEvent event, Emitter<ThemeState> emit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDark', event.isDark);
    emit(ThemeLoadedState(event.isDark ? ThemeMode.dark : ThemeMode.light));
  }
}
