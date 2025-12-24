import 'package:flutter/material.dart';
import 'package:test_app/core/domain/entities/transaction_data.dart';

class TransactionsList extends StatelessWidget {
  final List<TransactionData> transactions;

  const TransactionsList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final tx = transactions[index];
        return ListTile(
          title: Text(tx.description),
          subtitle: Text(tx.category.name),
          trailing: Text('\$${tx.amount}'),
        );
      }, childCount: transactions.length),
    );
  }
}
