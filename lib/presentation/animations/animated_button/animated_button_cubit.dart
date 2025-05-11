import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedButtonCubit extends Cubit<Alignment> {
  AnimatedButtonCubit() : super(Alignment.center);

  void startMove(Alignment end) => emit(end);
}
