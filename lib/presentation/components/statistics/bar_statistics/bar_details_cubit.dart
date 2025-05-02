import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'bar_details_state.dart';

class StatisticsItemDetailsCubit extends Cubit<StatisticsItemDetailsState> {
  StatisticsItemDetailsCubit() : super(const NoBarSelectedState());
  int? selectedIndex;
  void select(
    int barIndex, {
    required Offset itemOffset,
    required double amount,
    required String date,
  }) {
    selectedIndex = barIndex;
    emit(SelectedBarState(
      amount: amount,
      date: date,
      itemOffset: itemOffset,
      barIndex: barIndex,
      selectedIndex: selectedIndex,

    ));
  }

  void deSelect() {
    selectedIndex = null;
    emit(const NoBarSelectedState());
  }
}
