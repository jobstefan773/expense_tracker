import 'package:expense_tracker/widgets/expense_item_widget.dart';
import 'package:flutter/material.dart';
import 'model/expense_item.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
  @override
  Widget build(BuildContext context) {
    List<ExpenseItem> expenseItems = [
      ExpenseItem(
        title: 'Lunch',
        amount: 15.99,
        category: ExpenseCategory.food,
        date: DateTime.now(),
      ),
      ExpenseItem(
        title: 'Train Ticket',
        amount: 45.0,
        category: ExpenseCategory.travel,
        date: DateTime.now(),
      ),
      ExpenseItem(
        title: 'Movie',
        amount: 12.0,
        category: ExpenseCategory.leisure,
        date: DateTime.now(),
      ),
      ExpenseItem(
        title: 'Office Supplies',
        amount: 30.0,
        category: ExpenseCategory.work,
        date: DateTime.now(),
      ),
    ];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Expense Tracker',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
          backgroundColor: Colors.amber,
        ),
        body: Column(
          children: [
            const Text("Chart"),
            Expanded(
              child: ListView.builder(
                itemCount: expenseItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpenseItemWidget(expenseItems[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
