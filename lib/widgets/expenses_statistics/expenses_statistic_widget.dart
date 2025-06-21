import 'package:expenses/models/category_enum.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/models/expenses_statistic.dart';
import 'package:flutter/widgets.dart';

class ExpensesStatisticWidget extends StatelessWidget {
  final List<Expense> expensesList;

  const ExpensesStatisticWidget({
    super.key,
    required this.expensesList,
  });

  List<ExpensesStatistic> get statistics => CategoryEnum.values
      .map(
        (category) => ExpensesStatistic.initialize(
          expensesList,
          category,
        ),
      ).toList();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
