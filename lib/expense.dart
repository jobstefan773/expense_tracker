import 'package:expense_tracker/new_expense.dart';
import 'package:expense_tracker/widgets/expense_item_widget.dart';
import 'package:flutter/material.dart';
import 'model/expense_item.dart';
import 'package:expense_tracker/widgets/chart/chart.dart';

class Expense extends StatefulWidget {
  const Expense({super.key});

  @override
  State<Expense> createState() => _ExpenseState();
}

class _ExpenseState extends State<Expense> {
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

  void _showExpense() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addExpenseItem),
    );
  }

  void _addExpenseItem(ExpenseItem expense) {
    setState(() {
      expenseItems.add(expense);
    });
  }

  void onRemoveExpense(ExpenseItem expense) {
    final index = expenseItems.indexOf(expense);
    setState(() {
      expenseItems.remove(expense);
    });
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(
      SnackBar(
        content: Text("expense deleted"),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              expenseItems.insert(index, expense);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showExpense();
            },
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Chart(
            expenses: expenseItems,
          ),
          expenseItems.isEmpty
              ? const Center(child: Text("No expenses yet, add some!"))
              : Expanded(
                  child: ListView.builder(
                    itemCount: expenseItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        key: ValueKey(expenseItems[index]),
                        child: ExpenseItemWidget(expenseItems[index]),
                        onDismissed: (direction) {
                          onRemoveExpense(expenseItems[index]);
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
