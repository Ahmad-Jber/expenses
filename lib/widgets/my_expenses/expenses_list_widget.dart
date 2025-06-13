import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/my_expenses/expense_item_widget.dart';
import 'package:flutter/material.dart';

class ExpensesListWidget extends StatelessWidget {
  const ExpensesListWidget({
    super.key,
    required this.expenses,
    required this.onRemoveExpense,
  });

  final List<Expense> expenses;
  final void Function(String id) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: ListView.builder(
        itemBuilder: (context, int index) => Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Dismissible(
              key: ValueKey(
                expenses[index].id,
              ),
              child: ExpenseItemWidget(
                expense: expenses[index],
              ),
              onDismissed: (direction) => onRemoveExpense(expenses[index].id),
            ),
          ],
        ),
        itemCount: expenses.length,
      ),
    );
  }
}
