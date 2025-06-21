import 'category_enum.dart';
import 'expense.dart';

class ExpensesStatistic {
  final List<Expense> expensesList;
  final CategoryEnum category;

  ExpensesStatistic.initialize(List<Expense> allExpenses, this.category)
      : expensesList = allExpenses
            .where((element) => element.category == category)
            .toList();

  double get totalAmounts {
    return expensesList.fold(
      0,
      (a, b) => a + b.amount,
    );
  }
}
