import 'package:expenses/models/category_enum.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/models/expenses_statistic.dart';
import 'package:expenses/widgets/charts/chart_bar.dart';
import 'package:flutter/material.dart';

class ChartWidget extends StatelessWidget {
  const ChartWidget({super.key, required this.expensesList});

  final List<Expense> expensesList;

  List<ExpensesStatistic> get expenseStatistics {
    return [
      ExpensesStatistic.initialize(expensesList, CategoryEnum.food),
      ExpensesStatistic.initialize(expensesList, CategoryEnum.education),
      ExpensesStatistic.initialize(expensesList, CategoryEnum.license),
      ExpensesStatistic.initialize(expensesList, CategoryEnum.realLicense),
      ExpensesStatistic.initialize(expensesList, CategoryEnum.travel),
      ExpensesStatistic.initialize(expensesList, CategoryEnum.work),
    ];
  }

  double get maxTotalAmounts {
    var max = 0.0;
    for (var element in expenseStatistics) {
      if (element.totalAmounts > max) {
        max = element.totalAmounts;
      }
    }
    return max;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
          ],
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(
            5,
          ),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                for (var element in expenseStatistics)
                  ChartBarWidget(
                    expensesStatistic: element,
                    percentage: maxTotalAmounts != 0
                        ? element.totalAmounts / maxTotalAmounts
                        : 0,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
