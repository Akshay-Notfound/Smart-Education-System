import 'package:flutter/material.dart';
import 'package:smart_education_system/models/app_state.dart';
import 'package:smart_education_system/models/budget.dart';

class BudgetScreen extends StatelessWidget {
  final AppState appState;

  const BudgetScreen({super.key, required this.appState});

  @override
  Widget build(BuildContext context) {
    final budgets = appState.approvedBudgets;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Budget & Sponsorship Tracking'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: budgets.isEmpty
          ? const Center(
              child: Text(
                'No budgets available',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: budgets.length,
              itemBuilder: (context, index) {
                final budget = budgets[index];
                final utilization = budget.utilizationPercentage;
                
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              budget.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: _getBudgetColor(budget.type),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                budget.type.toString().split('.').last.toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(budget.description),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Allocated Amount:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '₹${budget.allocatedAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Spent Amount:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '₹${budget.spentAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Remaining:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '₹${budget.remainingAmount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Utilization:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        LinearProgressIndicator(
                          value: utilization / 100,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            utilization > 80 ? Colors.red : 
                            utilization > 60 ? Colors.orange : Colors.green,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text('${utilization.toStringAsFixed(1)}% used'),
                        const SizedBox(height: 16),
                        const Text(
                          'Recent Expenses:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (budget.expenses.isEmpty)
                          const Text(
                            'No expenses recorded yet',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          )
                        else
                          ...budget.expenses.map((expense) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          expense.description,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Approved by: ${expense.approvedBy}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '₹${expense.amount.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
  
  Color _getBudgetColor(BudgetType type) {
    switch (type) {
      case BudgetType.college:
        return Colors.blue;
      case BudgetType.department:
        return Colors.green;
      case BudgetType.event:
        return Colors.orange;
      case BudgetType.mess:
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }
}