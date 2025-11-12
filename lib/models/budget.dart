class Budget {
  final String id;
  final String title;
  final String description;
  final double allocatedAmount;
  final double spentAmount;
  final DateTime allocationDate;
  final String allocatedBy;
  final List<Expense> expenses;
  final BudgetType type;

  Budget({
    required this.id,
    required this.title,
    required this.description,
    required this.allocatedAmount,
    this.spentAmount = 0.0,
    required this.allocationDate,
    required this.allocatedBy,
    this.expenses = const [],
    required this.type,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    var expensesList = json['expenses'] as List? ?? [];
    List<Expense> expenses = expensesList.map((e) => Expense.fromJson(e)).toList();

    return Budget(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      allocatedAmount: json['allocatedAmount'].toDouble(),
      spentAmount: json['spentAmount'].toDouble(),
      allocationDate: DateTime.parse(json['allocationDate']),
      allocatedBy: json['allocatedBy'],
      expenses: expenses,
      type: BudgetType.values.firstWhere(
        (e) => e.toString() == 'BudgetType.${json['type']}',
        orElse: () => BudgetType.college,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'allocatedAmount': allocatedAmount,
      'spentAmount': spentAmount,
      'allocationDate': allocationDate.toIso8601String(),
      'allocatedBy': allocatedBy,
      'expenses': expenses.map((e) => e.toJson()).toList(),
      'type': type.toString().split('.').last,
    };
  }

  double get remainingAmount => allocatedAmount - spentAmount;
  double get utilizationPercentage => 
      allocatedAmount > 0 ? (spentAmount / allocatedAmount) * 100 : 0;
}

class Expense {
  final String id;
  final String description;
  final double amount;
  final DateTime expenseDate;
  final String receiptUrl; // URL to receipt image
  final String approvedBy;
  final String budgetId;

  Expense({
    required this.id,
    required this.description,
    required this.amount,
    required this.expenseDate,
    required this.receiptUrl,
    required this.approvedBy,
    required this.budgetId,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      id: json['id'],
      description: json['description'],
      amount: json['amount'].toDouble(),
      expenseDate: DateTime.parse(json['expenseDate']),
      receiptUrl: json['receiptUrl'],
      approvedBy: json['approvedBy'],
      budgetId: json['budgetId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'expenseDate': expenseDate.toIso8601String(),
      'receiptUrl': receiptUrl,
      'approvedBy': approvedBy,
      'budgetId': budgetId,
    };
  }
}

enum BudgetType {
  college,
  department,
  event,
  mess,
}