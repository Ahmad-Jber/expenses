import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItemWidget extends StatelessWidget {
  const ExpenseItemWidget({
    super.key,
    required this.expense,
  });

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 1,
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(categoryItem[expense.category]),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    expense.title,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Icon(Icons.alarm_rounded),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(expense.formattedDate),
                  const Spacer(),
                  const Icon(Icons.attach_money_outlined),
                  Text(expense.amount.toStringAsFixed(2))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
