import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  DateTimeRange? selectedDateRange;
  List<Map<String, dynamic>> transactions = [
    {'date': '2024-12-01', 'amount': 50.0, 'description': 'Groceries'},
    {'date': '2024-12-02', 'amount': 30.0, 'description': 'Transport'},
    {'date': '2024-12-03', 'amount': 70.0, 'description': 'Shopping'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                final pickedDateRange = await showDateRangePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                );
                setState(() {
                  selectedDateRange = pickedDateRange;
                });
              },
              child: const Text('Filter by Date'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                final transactionDate = DateTime.parse(transaction['date']);
                if (selectedDateRange != null &&
                    (transactionDate.isBefore(selectedDateRange!.start) ||
                        transactionDate.isAfter(selectedDateRange!.end))) {
                  return const SizedBox.shrink();
                }
                return ListTile(
                  title: Text(transaction['description']),
                  subtitle: Text(transaction['date']),
                  trailing: Text('\$${transaction['amount']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
