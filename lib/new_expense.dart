import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/model/expense_item.dart';

class NewExpense extends StatefulWidget {
  final void Function(ExpenseItem item) onAddExpense;
  const NewExpense({super.key, required this.onAddExpense});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();
  DateTime? _pickedDate;
  ExpenseCategory _selectedCategory = ExpenseCategory.leisure;

  @override
  void dispose() {
    _titleEditingController.dispose();
    _amountEditingController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountEditingController.text);
    widget.onAddExpense(
      ExpenseItem(
        title: _titleEditingController.text,
        amount: enteredAmount ?? 0,
        category: _selectedCategory,
        date: _pickedDate!,
      ),
    );
    Navigator.pop(context);
  }

  void _showDatePopup() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _pickedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMd();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleEditingController,
            decoration: const InputDecoration(labelText: 'Title'),
            keyboardType: TextInputType.text,
            maxLength: 50,
          ),
          TextField(
            controller: _amountEditingController,
            decoration: InputDecoration(labelText: 'Amount', prefixText: '\$'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              _showDatePopup();
            },
            label: Text(
              _pickedDate == null
                  ? "please select a date"
                  : formatter.format(_pickedDate!),
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.white),
            ),
            icon: const Icon(Icons.calendar_today),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ),
          const SizedBox(height: 20),
          DropdownButton<ExpenseCategory>(
            value: _selectedCategory,
            items: ExpenseCategory.values
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  ),
                )
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedCategory = value;
                });
              }
            },
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _submitExpenseData();
                },
                child: const Text('Add Expense'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
