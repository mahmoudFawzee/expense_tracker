import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'statistics_item_details_state.dart';

class StatisticsItemDetailsCubit extends Cubit<StatisticsItemDetailsState> {
  StatisticsItemDetailsCubit() : super(const NoItemSelectedState());
  int? _selectedIndex;
  void select(
    int itemIndex, {
    required Offset itemOffset,
    required double amount,
    required String date,
  }) {
    _selectedIndex = itemIndex;
    emit(SelectedItemState(
      amount: amount,
      date: date,
      itemOffset: itemOffset,
      barIndex: itemIndex,
      selectedIndex: _selectedIndex,
    ));
  }

  void deSelect() {
    _selectedIndex = null;
    emit(const NoItemSelectedState());
  }
}
