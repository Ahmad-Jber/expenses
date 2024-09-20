import 'package:expenses/models/expense.dart';
import 'package:expenses/widgets/bottom_sheet/bottom_sheet_form.dart';
import 'package:flutter/material.dart';

class BottomSheetWidget extends StatelessWidget {
  const BottomSheetWidget({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ),
      body: BottomSheetForm(
        onAddExpense: onAddExpense,
        parentContext: context,
      ),
    );
  }
}
