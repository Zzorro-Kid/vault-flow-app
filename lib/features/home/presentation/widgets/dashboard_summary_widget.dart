import 'package:flutter/material.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/features/home/domain/entities/dashboard_summary_data.dart';

class DashboardSummary extends StatelessWidget {
  final DashboardSummaryData summary;

  const DashboardSummary({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Dashboard', style: Theme.of(context).textTheme.headlineMedium),
        const SizedBox(height: AppDimensions.paddingMedium),
        Text('Balance: \$${summary.totalBalance}'),
        Text('Income: \$${summary.totalIncome}'),
        Text('Expenses: \$${summary.totalExpenses}'),
      ],
    );
  }
}
