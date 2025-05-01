import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'bar_details_state.dart';

class BarDetailsCubit extends Cubit<BarDetailsState> {
  BarDetailsCubit() : super(const NoBarSelectedState());
  int? selectedIndex;
  void select(
    int barIndex, {
    required double amount,
    required String date,
  }) {
    selectedIndex = barIndex;
    emit(SelectedBarState(
      amount: amount,
      date: date,
      barIndex: barIndex,
      selectedIndex: selectedIndex,
    ));
  }

  void deSelect() {
    selectedIndex = null;
    emit(const NoBarSelectedState());
  }
}
