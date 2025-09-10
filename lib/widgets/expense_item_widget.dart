import 'package:expense_tracker/expense.dart';
import 'package:expense_tracker/model/expense_item.dart';
import 'package:flutter/material.dart';

class ExpenseItemWidget extends StatelessWidget {
  const ExpenseItemWidget(this.expenseItem, {super.key});

  final ExpenseItem expenseItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseItem.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(expenseItem.amount.toString()),
                Spacer(),
                Icon(categoryIcons[expenseItem.category]),
                SizedBox(width: 5),
                Text(expenseItem.formattedDate),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
