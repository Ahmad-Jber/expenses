import 'package:expenses/models/expense.dart';
import 'package:expenses/models/expenses_statistic.dart';
import 'package:flutter/material.dart';

class ChartBarWidget extends StatelessWidget {
  const ChartBarWidget({
    super.key,
    required this.expensesStatistic,
    required this.percentage,
  });

  final ExpensesStatistic expensesStatistic;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FractionallySizedBox(
                  widthFactor: 1,
                  heightFactor: percentage,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(5),
                      ),
                      color: Theme.of(context).colorScheme.tertiaryContainer,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Icon(
            categoryItem[expensesStatistic.category],
            color: Theme.of(context).colorScheme.tertiaryContainer,
          )
        ],
      ),
    );
  }
}
