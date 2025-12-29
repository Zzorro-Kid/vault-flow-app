import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/themes/app_colors.dart';
import 'package:test_app/core/utils/ui_helpers.dart';
import 'package:test_app/core/widgets/bottom_navigation_bar.dart';
import 'package:test_app/core/widgets/custom_app_bar.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/transaction/domain/entities/transaction_data.dart';
import 'package:test_app/features/transaction/presentation/cubit/transaction_cubit.dart';
import 'package:test_app/features/transaction/presentation/cubit/transaction_state.dart';
import 'package:test_app/features/transaction/presentation/widgets/add_transaction_dialog.dart';
import 'package:test_app/features/transaction/presentation/widgets/empty_transactions_view.dart';
import 'package:test_app/features/transaction/presentation/widgets/transaction_error_view.dart';
import 'package:test_app/features/transaction/presentation/widgets/transaction_item.dart';
import 'package:test_app/features/category/presentation/cubit/category_cubit.dart';
import 'package:test_app/injection_container.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TransactionCubit>()..loadTransactions(),
      child: BlocListener<TransactionCubit, TransactionState>(
        listener: (context, state) {
          switch (state) {
            case TransactionError():
              UiHelpers.showErrorSnackBar(context, state.message);
            case TransactionOperationSuccess():
              _showOperationSnackBar(context, state.message);
            default:
              break;
          }
        },
        child: Scaffold(
          appBar: _buildAppBar(),
          body: Stack(children: [_buildBody(), _buildFloatingActionButton()]),
          bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 1),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(
      height: AppDimensions.appBarHeightOther,
      topPadding: AppDimensions.appBarTopPadding,
      title: Transform.translate(
        offset: const Offset(0, AppDimensions.appBarTitleOffsetY),
        child: const Text(
          'Transactions',
          style: TextStyle(
            fontSize: AppDimensions.fontSizeXXLarge,
            fontWeight: FontWeight.bold,
            color: AppColors.categoryTitleText,
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        return switch (state) {
          TransactionLoading() => const LoadingIndicator(),
          TransactionLoaded() => _buildTransactionList(state.transactions),
          TransactionError() => TransactionErrorView(
            message: state.message,
            onRetry: () => context.read<TransactionCubit>().loadTransactions(),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildTransactionList(List<TransactionData> transactions) {
    if (transactions.isEmpty) {
      return const EmptyTransactionsView();
    }

    final expenseTransactions = _filterTransactionsByType(
      transactions,
      'expense',
    );
    final incomeTransactions = _filterTransactionsByType(
      transactions,
      'income',
    );

    return CustomScrollView(
      slivers: [
        if (expenseTransactions.isNotEmpty)
          ..._buildTransactionSection('Expenses', expenseTransactions),
        if (incomeTransactions.isNotEmpty)
          ..._buildTransactionSection('Income', incomeTransactions),
      ],
    );
  }

  List<TransactionData> _filterTransactionsByType(
    List<TransactionData> transactions,
    String type,
  ) {
    return transactions.where((t) => t.type == type).toList();
  }

  List<Widget> _buildTransactionSection(
    String title,
    List<TransactionData> transactions,
  ) {
    return [
      _buildSectionHeaderSliver(title),
      _buildTransactionListSliver(transactions),
    ];
  }

  Widget _buildSectionHeaderSliver(String title) {
    return SliverPadding(
      padding: const EdgeInsets.fromLTRB(
        AppDimensions.paddingMedium,
        AppDimensions.paddingLarge,
        AppDimensions.paddingMedium,
        AppDimensions.paddingSmall,
      ),
      sliver: SliverToBoxAdapter(child: _buildSectionHeader(title)),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: AppDimensions.fontSizeXLarge,
        fontWeight: FontWeight.bold,
        color: AppColors.sectionHeaderText,
      ),
    );
  }

  Widget _buildTransactionListSliver(List<TransactionData> transactions) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMedium,
      ),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              _buildDismissibleTransactionItem(context, transactions[index]),
          childCount: transactions.length,
        ),
      ),
    );
  }

  Widget _buildDismissibleTransactionItem(
    BuildContext context,
    TransactionData transaction,
  ) {
    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      background: _buildDismissBackground(),
      confirmDismiss: (direction) => _confirmDelete(context, transaction),
      child: TransactionItem(transaction: transaction),
    );
  }

  Widget _buildFloatingActionButton() {
    return Positioned(
      right: AppDimensions.paddingMedium,
      bottom: AppDimensions.paddingMedium,
      child: Builder(
        builder: (builderContext) => FloatingActionButton(
          onPressed: () => _showAddTransactionDialog(builderContext),
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.add, color: Colors.white),
        ),
      ),
    );
  }

  void _showAddTransactionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider(
        create: (_) => sl<CategoryCubit>()..loadCategories(),
        child: AddTransactionDialog(
          onAdd: (transaction) {
            context.read<TransactionCubit>().addTransaction(transaction);
            Navigator.pop(dialogContext);
          },
        ),
      ),
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingMedium),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: AppDimensions.paddingLarge),
      decoration: _buildDismissBackgroundDecoration(),
      child: _buildDeleteIcon(),
    );
  }

  BoxDecoration _buildDismissBackgroundDecoration() {
    return BoxDecoration(
      color: AppColors.error,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
    );
  }

  Widget _buildDeleteIcon() {
    return const Icon(
      Icons.delete_outline,
      color: Colors.white,
      size: AppDimensions.iconLarge,
    );
  }

  Future<bool?> _confirmDelete(
    BuildContext context,
    TransactionData transaction,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: _buildDeleteDialogTitle(),
        content: _buildDeleteDialogContent(transaction.description),
        actions: _buildDeleteDialogActions(
          dialogContext,
          context,
          transaction.id,
        ),
      ),
    );
  }

  Widget _buildDeleteDialogTitle() {
    return const Text(
      'Delete Transaction',
      style: TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildDeleteDialogContent(String transactionTitle) {
    return Text(
      'Are you sure you want to delete "$transactionTitle"?',
      style: const TextStyle(color: AppColors.sectionHeaderText),
    );
  }

  List<Widget> _buildDeleteDialogActions(
    BuildContext dialogContext,
    BuildContext parentContext,
    String transactionId,
  ) {
    return [
      _buildCancelButton(dialogContext),
      _buildDeleteButton(dialogContext, parentContext, transactionId),
    ];
  }

  Widget _buildCancelButton(BuildContext dialogContext) {
    return TextButton(
      onPressed: () => Navigator.pop(dialogContext, false),
      child: const Text('Cancel'),
    );
  }

  Widget _buildDeleteButton(
    BuildContext dialogContext,
    BuildContext parentContext,
    String transactionId,
  ) {
    return TextButton(
      onPressed: () {
        parentContext.read<TransactionCubit>().deleteTransaction(transactionId);
        Navigator.pop(dialogContext, true);
      },
      child: const Text(
        'Delete',
        style: TextStyle(color: AppColors.expensesStart),
      ),
    );
  }

  void _showOperationSnackBar(BuildContext context, String message) {
    final backgroundColor = _getSnackBarColor(message);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: backgroundColor),
    );
  }

  Color _getSnackBarColor(String message) {
    final operationType = _getOperationType(message);

    switch (operationType) {
      case 'deleted':
        return AppColors.error;
      case 'updated':
        return AppColors.primary;
      case 'added':
      default:
        return AppColors.incomeStart;
    }
  }

  String _getOperationType(String message) {
    final lowerMessage = message.toLowerCase();
    if (lowerMessage.contains('deleted')) return 'deleted';
    if (lowerMessage.contains('updated')) return 'updated';
    return 'added';
  }
}
