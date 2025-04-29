import 'package:flutter_bloc/flutter_bloc.dart';

class BarDetailsCubit extends Cubit<int?> {
  BarDetailsCubit() : super(null);
  void select(int? index) => emit(index);
}
