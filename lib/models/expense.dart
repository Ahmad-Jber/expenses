import 'package:expenses/models/category_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

DateFormat formatter = DateFormat.yMMMMd();
const categoryItem = {
  CategoryEnum.food: Icons.lunch_dining_outlined,
  CategoryEnum.license: Icons.card_membership_outlined,
  CategoryEnum.realLicense: Icons.credit_card_outlined,
  CategoryEnum.education: Icons.school_outlined,
  CategoryEnum.travel: Icons.flight_takeoff_outlined,
  CategoryEnum.work: Icons.work_outline
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final CategoryEnum category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = const Uuid().v8g();

  String get formattedDate {
    return formatter.format(date);
  }
}
