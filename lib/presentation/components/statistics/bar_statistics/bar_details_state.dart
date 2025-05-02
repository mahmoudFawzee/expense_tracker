part of 'bar_details_cubit.dart';

sealed class StatisticsItemDetailsState extends Equatable {
  const StatisticsItemDetailsState();
  @override
  List<Object?> get props => [];
}

final class NoBarSelectedState extends StatisticsItemDetailsState {
  const NoBarSelectedState();
}

final class SelectedBarState extends StatisticsItemDetailsState {
  final double amount;
  final String date;
  final Offset itemOffset;
  final int? selectedIndex;
  final int? barIndex;
  const SelectedBarState({
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
