import 'package:flutter_bloc/flutter_bloc.dart';

class AnimatedContainerCubit extends Cubit<double> {
  final double endSize;
  AnimatedContainerCubit(this.endSize) : super(5);

  void start() {
    Future.delayed(const Duration(microseconds: 1), () {
      emit(endSize);
    });
  }
}
