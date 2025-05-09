import 'package:flutter_bloc/flutter_bloc.dart';

class EnableTextFieldCubit extends Cubit<bool> {
  EnableTextFieldCubit() : super(false);
  void changeState() => emit(!state);
}
