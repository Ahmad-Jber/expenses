import 'package:expenses/models/category_enum.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget({super.key, required this.expensesList});

  final List<Expense> expensesList;

  @override
  Widget build(BuildContext context) {
    var dataMap = {
      for (var e in CategoryEnum.values)
        e.name: expensesList.where((z) => z.category == e)
            .fold(0.0, (a, b) => a + b.amount)
    };
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.primary.withValues(alpha: 0.4),
          ],
        ),
      ),
      child: PieChart(
        dataMap: dataMap,
        baseChartColor: Theme.of(context).colorScheme.primary,
          legendOptions: LegendOptions(
            showLegends: true,
            legendPosition: LegendPosition.right,
            legendTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onTertiary
            ),
          )
      ),
    );
  }
}
