import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  void toggleTheme({required bool isDark}) {
    emit(ThemeChange(isDark: isDark));
  }
}
