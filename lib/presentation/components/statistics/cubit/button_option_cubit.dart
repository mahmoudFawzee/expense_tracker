import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonOptionCubit extends Cubit<ButtonOption> {
  ButtonOptionCubit() : super(ButtonOption.monthly);
  selectOption(ButtonOption option) => emit(option);
}

enum ButtonOption {
  monthly,
  yearly,
}
