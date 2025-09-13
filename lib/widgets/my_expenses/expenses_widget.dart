import 'package:expenses/models/category_enum.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/bottom_sheet/bottom_sheet_widget.dart';
import 'package:expenses/widgets/charts/chart.dart';
import 'package:expenses/widgets/charts/pie_chart_widget.dart';
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
  late List<Widget> widgetChildren;

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
        description: '',
      ),
      Expense(
        title: "Cheque",
        amount: 23.4567891,
        date: DateTime.now(),
        category: CategoryEnum.work,
        description: '',
      ),
      Expense(
        title: "Driving License",
        amount: 10.3456789,
        date: DateTime.now(),
        category: CategoryEnum.realLicense,
        description: '',
      ),
      Expense(
        title: "Windows Activation Key",
        amount: 28.4567891,
        date: DateTime.now(),
        category: CategoryEnum.license,
        description: '',
      ),
      Expense(
        title: "Jordan",
        amount: 40.4567891,
        date: DateTime.now(),
        category: CategoryEnum.travel,
        description: '',
      ),
      Expense(
        title: "Burger",
        amount: 10.4567891,
        date: DateTime.now(),
        category: CategoryEnum.food,
        description: '',
      ),
      Expense(
        title: "Meat",
        amount: 20.4567891,
        date: DateTime.now(),
        category: CategoryEnum.food,
        description: '',
      ),
    ];
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(String id) {
    setState(
      () => _registeredExpenses.removeWhere(
        (element) => element.id == id,
      ),
    );
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
      body: MediaQuery.of(context).size.width < 800
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: ChartWidget(
                  expensesList: _registeredExpenses,
                ),
              ),
              Expanded(
                child: ExpensesListWidget(
                  expenses: _registeredExpenses,
                  onRemoveExpense: _removeExpense,
                ),
              )
            ])
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: PieChartWidget(
                          expensesList: _registeredExpenses,
                        ),
                      ),
                      SizedBox(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 20,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withValues(alpha: 0.4),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ChartWidget(
                          expensesList: _registeredExpenses,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ExpensesListWidget(
                    expenses: _registeredExpenses,
                    onRemoveExpense: _removeExpense,
                  ),
                )
              ],
            ),
    );
  }
}
