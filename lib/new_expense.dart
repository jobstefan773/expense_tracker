import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleEditingController = TextEditingController();
  String _pickedDate = 'Please select a date';

  @override
  void dispose() {
    _titleEditingController.dispose();
    super.dispose();
  }

  void _showDatePopup() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      final formatter = DateFormat.yMd();
      setState(() {
        _pickedDate = formatter.format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          const TextField(
            decoration: InputDecoration(labelText: 'Amount', prefixText: '\$'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () {
              _showDatePopup();
            },
            label: Text(
              _pickedDate,
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
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  print(_titleEditingController.text);
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
