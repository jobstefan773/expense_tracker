import 'package:expense_tracker/expense.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum ExpenseCategory {
  food,
  travel,
  leisure,
  work,
}

const categoryIcons = {
  ExpenseCategory.food: Icons.fastfood,
  ExpenseCategory.travel: Icons.flight,
  ExpenseCategory.leisure: Icons.movie,
  ExpenseCategory.work: Icons.work,
};

class ExpenseItem {
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;

  ExpenseItem({
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
  });

  String get formattedDate {
    final formatter = DateFormat.yMd();
    return formatter.format(date);
  }
}

class ExpenseBucket {
  final Category category;
  final List<ExpenseItem> expenses;

  ExpenseBucket({required this.category, required this.expenses});

  ExpenseBucket.forCategory(List<ExpenseItem> allExpenses, this.category)
    : expenses = allExpenses
          .where((expense) => expense.category == category)
          .toList();

  double get totalExpenses {
    double sum = 0;
    for (final expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
