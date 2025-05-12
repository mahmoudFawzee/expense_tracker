import 'package:expense_tracker/core/util/enum/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonOptionCubit extends Cubit<ButtonOption> {
  ButtonOptionCubit() : super(ButtonOption.weekly);
  selectOption(ButtonOption option) => emit(option);
}

