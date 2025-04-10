import 'package:expense_tracker/app/cubits/category_selection_cubit.dart';
import 'package:expense_tracker/logic/entities/category.dart';
import 'package:expense_tracker/presentation/animations/custom_animated_container.dart';
import 'package:expense_tracker/presentation/components/category_widget.dart';
import 'package:expense_tracker/presentation/components/custom_app_bar.dart';
import 'package:expense_tracker/presentation/components/expense_amount.dart';
import 'package:expense_tracker/presentation/components/expense_widget.dart';
import 'package:expense_tracker/presentation/components/sliver_sized_box.dart';
import 'package:expense_tracker/presentation/resources/image_manger.dart';
import 'package:expense_tracker/presentation/screens/fake_data/category_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});
  static const pageRoute = '/Expenses_page';

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: appLocalizations.expenses,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          slivers: [
            //?add the balance widget here.
            SliverAppBar(
              expandedHeight: 210,
              floating: true,
              //backgroundColor: Theme.of(context).colorScheme.primary,
              flexibleSpace: Container(
                height: 210,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: FlexibleSpaceBar(
                  title: const Align(
                    alignment: Alignment.centerLeft,
                    child: BalanceTextWidget(
                      balance: 515245,
                    ),
                  ),
                  background: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  appLocalizations.balance,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.add_circle_sharp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 120,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              const CustomAnimatedContainer(
                                label: 'Food',
                                endHeight: 100,
                              ),
                              const CustomAnimatedContainer(
                                label: 'Transport',
                                endHeight: 30,
                              ),
                              const CustomAnimatedContainer(
                                label: 'Shopping',
                                endHeight: 50,
                              ),
                              const CustomAnimatedContainer(
                                label: 'Clothes',
                                endHeight: 80,
                              ),
                              ...List.generate(10, (index) {
                                return CustomAnimatedContainer(
                                  label: 'Clothes$index',
                                  endHeight: 5 * double.parse('$index'),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SliverSizedBox(height: 10),
            SliverToBoxAdapter(
              child: BlocBuilder<CategorySelectionCubit, int?>(
                builder: (context, selectedId) {
                  final categories = handleCategories(categoriesList);
                  return SizedBox(
                    height: 35,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final item = categories[index];
                        return CategoryWidget(
                          label: item.title,
                          selected: item.id == selectedId,
                          onTap: () {
                            print(' title:  ${item.title} and id : ${item.id}');
                            context
                                .read<CategorySelectionCubit>()
                                .choseCategory(item.id);
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                height: 15,
                thickness: 1,
              ),
            ),
            const SliverSizedBox(height: 5),
            SliverToBoxAdapter(
              child: Text(
                appLocalizations.expenses,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.black,
                    ),
              ),
            ),
            const SliverSizedBox(height: 10),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return const ExpenseWidget(
                    title: 'buy 1kg apple',
                    category:
                        Category(title: 'Food', imgUrl: ImageManger.appLogo),
                    amount: 15,
                    date: '15/11/2025 03:15',
                  );
                },
                childCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
