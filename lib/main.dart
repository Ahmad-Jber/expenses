import 'package:expenses/widgets/my_expenses/expenses_widget.dart';
import 'package:flutter/material.dart';

void main() {
  var colorScheme = ColorScheme.fromSeed(seedColor: Colors.black12);
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme: colorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: colorScheme.onPrimaryContainer,
          foregroundColor: colorScheme.primaryContainer,
        ),
      ),
      home: const ExpensesWidget(),
    ),
  );
}