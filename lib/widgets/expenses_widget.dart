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
      Expense(
        title: "England",
        amount: 34.5678901,
        date: DateTime.now(),
        category: CategoryEnum.travel,
      ),
      Expense(
        title: "School",
        amount: 45.6789012,
        date: DateTime.now(),
        category: CategoryEnum.education,
      ),
      Expense(
        title: "Windows 10",
        amount: 56.7890123,
        date: DateTime.now(),
        category: CategoryEnum.license,
      ),
      Expense(
        title: "Driving",
        amount: 67.8901234,
        date: DateTime.now(),
        category: CategoryEnum.realLicense,
      ),
      Expense(
        title: "Pizza",
        amount: 78.9012345,
        date: DateTime.now(),
        category: CategoryEnum.food,
      ),
      Expense(
        title: "University",
        amount: 89.0123456,
        date: DateTime.now(),
        category: CategoryEnum.education,
      ),
      Expense(
        title: "Cheque",
        amount: 90.1234567,
        date: DateTime.now(),
        category: CategoryEnum.work,
      ),
      Expense(
        title: "England",
        amount: 1.2345678,
        date: DateTime.now(),
        category: CategoryEnum.travel,
      ),
      Expense(
        title: "School",
        amount: 2.3456789,
        date: DateTime.now(),
        category: CategoryEnum.education,
      ),
      Expense(
        title: "Windows 10",
        amount: 3.4567891,
        date: DateTime.now(),
        category: CategoryEnum.license,
      ),
      Expense(
        title: "Driving",
        amount: 4.5678902,
        date: DateTime.now(),
        category: CategoryEnum.realLicense,
      ),
      Expense(
        title: "Pizza",
        amount: 5.6789013,
        date: DateTime.now(),
        category: CategoryEnum.food,
      ),
      Expense(
        title: "University",
        amount: 6.7890124,
        date: DateTime.now(),
        category: CategoryEnum.education,
      ),
      Expense(
        title: "Cheque",
        amount: 7.8901235,
        date: DateTime.now(),
        category: CategoryEnum.work,
      ),
      Expense(
        title: "England",
        amount: 8.9012346,
        date: DateTime.now(),
        category: CategoryEnum.travel,
      ),
      Expense(
        title: "School",
        amount: 9.0123457,
        date: DateTime.now(),
        category: CategoryEnum.education,
      ),
      Expense(
        title: "Windows 10",
        amount: 10.1234568,
        date: DateTime.now(),
        category: CategoryEnum.license,
      ),
      Expense(
        title: "Driving",
        amount: 11.2345679,
        date: DateTime.now(),
        category: CategoryEnum.realLicense,
      ),
      Expense(
        title: "Pizza",
        amount: 12.3456781,
        date: DateTime.now(),
        category: CategoryEnum.food,
      ),
      Expense(
        title: "University",
        amount: 13.4567892,
        date: DateTime.now(),
        category: CategoryEnum.education,
      ),
      Expense(
        title: "Cheque",
        amount: 14.5678903,
        date: DateTime.now(),
        category: CategoryEnum.work,
      ),
      Expense(
        title: "England",
        amount: 15.6789014,
        date: DateTime.now(),
        category: CategoryEnum.travel,
      ),
      Expense(
        title: "School",
        amount: 16.7890125,
        date: DateTime.now(),
        category: CategoryEnum.education,
      ),
      Expense(
        title: "Windows 10",
        amount: 17.8901236,
        date: DateTime.now(),
        category: CategoryEnum.license,
      ),
      Expense(
        title: "Driving",
        amount: 18.9012347,
        date: DateTime.now(),
        category: CategoryEnum.realLicense,
      ),
      Expense(
        title: "Pizza",
        amount: 19.0123458,
        date: DateTime.now(),
        category: CategoryEnum.food,
      ),
    ];
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
        leading: IconButton(onPressed: (){
          showModalBottomSheet(context: context, builder: (context){
            return const BottomSheetWidget();
          });
        }, icon: const Icon(Icons.add)),
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