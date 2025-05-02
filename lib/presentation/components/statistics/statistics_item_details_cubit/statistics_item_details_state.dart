part of 'statistics_item_details_cubit.dart';

sealed class StatisticsItemDetailsState extends Equatable {
  const StatisticsItemDetailsState();
  @override
  List<Object?> get props => [];
}

final class NoItemSelectedState extends StatisticsItemDetailsState {
  const NoItemSelectedState();
}

final class SelectedItemState extends StatisticsItemDetailsState {
  final double amount;
  final String date;
  final Offset itemOffset;
  final int? selectedIndex;
  final int? barIndex;
  const SelectedItemState({
    required this.amount,
    required this.date,
    required this.itemOffset,
    required this.selectedIndex,
    required this.barIndex,
  });

  @override
  List<Object?> get props => [
        date,
        amount,
        itemOffset,
        selectedIndex,
        barIndex,
      ];
}
