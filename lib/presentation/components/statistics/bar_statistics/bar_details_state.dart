part of 'bar_details_cubit.dart';

sealed class BarDetailsState extends Equatable {
  const BarDetailsState();
  @override
  List<Object?> get props => [];
}

final class NoBarSelectedState extends BarDetailsState {
  const NoBarSelectedState();
}

final class SelectedBarState extends BarDetailsState {
  final double amount;
  final String date;
  final int? selectedIndex;
  final int? barIndex;
  const SelectedBarState({
    required this.amount,
    required this.date,
    required this.selectedIndex,
    required this.barIndex,
  });

  @override
  List<Object?> get props => [date, amount, selectedIndex,barIndex];
}
