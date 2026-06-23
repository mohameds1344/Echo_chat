part of 'theme_cubit.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {}

final class ThemeChange extends ThemeState {
  final bool isDark;

  ThemeChange({required this.isDark});
}
