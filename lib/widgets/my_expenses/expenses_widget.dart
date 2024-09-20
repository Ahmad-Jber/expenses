import 'package:expenses/models/category_enum.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:expenses/widgets/general_widgets/app_bar_base.dart';
import 'package:expenses/widgets/my_expenses/expenses_list_widget.dart';
import 'package:flutter/material.dart';

class ExpensesWidget extends StatefulWidget {
  const ExpensesWidget({super.key});

  @override
  State<ExpensesWidget> createState() => _ExpensesWidgetState();
}

class _ExpensesWidgetState extends State<ExpensesWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late final List<Expense> _registeredExpenses;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _registeredExpenses = [
      Expense(
        title: "University",
        amount: 12.3456789,
        date: DateTime.now(),
        category: CategoryEnum.education,
      ),
      Expense(
        title: "Cheque",
        amount: 23.4567891,
        date: DateTime.now(),
        category: CategoryEnum.work,
      ),
    ];
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarBase(
        centeredTitle: "Expenses",
        leading: IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10.0),
                  ),
                ),
                builder: (context) {
                  return BottomSheetWidget(
                    onAddExpense: _addExpense,
                  );
                },
              );
            },
            icon: const Icon(Icons.add)),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ExpensesListWidget(expenses: _registeredExpenses),
          )
        ],
      ),
    );
  }
}
