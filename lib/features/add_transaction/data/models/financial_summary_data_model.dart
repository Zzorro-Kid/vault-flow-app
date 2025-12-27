import 'package:test_app/features/add_transaction/domain/entities/financial_summary_data.dart';

class FinancialSummaryDataModel extends FinancialSummaryData {
  const FinancialSummaryDataModel({
    required super.totalBalance,
    required super.totalIncome,
    required super.totalExpenses,
  });
}
