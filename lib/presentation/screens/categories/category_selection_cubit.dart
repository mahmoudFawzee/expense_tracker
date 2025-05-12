import 'package:flutter_bloc/flutter_bloc.dart';

final class CategorySelectionCubit extends Cubit<int?> {
  //?in case of null show all and decorate all category button
  CategorySelectionCubit() : super(null);

  choseCategory(int? index) => emit(index);
}
