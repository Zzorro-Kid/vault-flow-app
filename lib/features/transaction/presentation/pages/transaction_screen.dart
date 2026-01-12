import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/constants/app_dimensions.dart';
import 'package:test_app/core/constants/app_colors.dart';
import 'package:test_app/core/utils/list_helpers.dart';
import 'package:test_app/core/widgets/bottom_navigation_bar.dart';
import 'package:test_app/core/widgets/custom_app_bar.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/category/presentation/cubit/category_cubit.dart';
import 'package:test_app/features/transaction/domain/entities/transaction_data.dart';
import 'package:test_app/features/transaction/presentation/cubit/transaction_cubit.dart';
import 'package:test_app/features/transaction/presentation/cubit/transaction_state.dart';
import 'package:test_app/features/transaction/presentation/widgets/add_transaction_dialog.dart';
import 'package:test_app/features/transaction/presentation/widgets/edit_transaction_dialog.dart';
import 'package:test_app/features/transaction/presentation/widgets/empty_transactions_view.dart';
import 'package:test_app/features/transaction/presentation/widgets/transaction_error_view.dart';
import 'package:test_app/features/transaction/presentation/widgets/transaction_item.dart';
import 'package:test_app/injection_container.dart';
import 'package:test_app/l10n/app_localizations.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TransactionCubit>()..loadTransactions(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Stack(
          children: [_buildBody(), _buildFloatingActionButton(context)],
        ),
        bottomNavigationBar: const AppBottomNavigationBar(currentIndex: 1),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return CustomAppBar(title: _buildAppBarTitle());
  }

  Widget _buildAppBarTitle() {
    return Builder(
      builder: (context) {
        final l10n = AppLocalizations.of(context)!;
        return Text(
          l10n.transactions,
          style: const TextStyle(
            fontSize: AppDimensions.fontSizeXXLarge,
            fontWeight: FontWeight.bold,
            color: AppColors.categoryTitleText,
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        return switch (state) {
          TransactionLoading() => const LoadingIndicator(),
          TransactionLoaded() => _buildLoadedView(context, state.transactions),
          TransactionError() => TransactionErrorView(
            message: state.message,
            onRetry: () => context.read<TransactionCubit>().loadTransactions(),
          ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  Widget _buildLoadedView(
    BuildContext context,
    List<TransactionData> transactions,
  ) {
    if (transactions.isEmpty) {
      return const EmptyTransactionsView();
    }

    return _buildTransactionsScrollView(context, transactions);
  }

  Widget _buildTransactionsScrollView(
    BuildContext context,
    List<TransactionData> transactions,
  ) {
    final expenseTransactions = _getExpenseTransactions(transactions);
    final incomeTransactions = _getIncomeTransactions(transactions);

    return CustomScrollView(
      slivers: _buildTransactionSlivers(
        context,
        expenseTransactions,
        incomeTransactions,
      ),
    );
  }

  List<TransactionData> _getExpenseTransactions(
    List<TransactionData> transactions,
  ) {
    return _filterTransactionsByType(transactions, 'expense');
  }

  List<TransactionData> _getIncomeTransactions(
    List<TransactionData> transactions,
  ) {
    return _filterTransactionsByType(transactions, 'income');
  }

  List<Widget> _buildTransactionSlivers(
    BuildContext context,
    List<TransactionData> expenseTransactions,
    List<TransactionData> incomeTransactions,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return [
      if (expenseTransactions.isNotEmpty)
        ..._buildTransactionSection(
          context,
          l10n.expense_plural,
          expenseTransactions,
        ),
      if (incomeTransactions.isNotEmpty)
        ..._buildTransactionSection(
          context,
          l10n.income_plural,
          incomeTransactions,
        ),
    ];
  }

  List<TransactionData> _filterTransactionsByType(
    List<TransactionData> transactions,
    String type,
  ) {
    return ListHelpers.filterByType(
      items: transactions,
      type: type,
      getType: (transaction) => transaction.type,
    );
  }

  List<Widget> _buildTransactionSection(
    BuildContext context,
    String title,
    List<TransactionData> transactions,
  ) {
    return [
      _buildSectionHeaderSliver(title),
      _buildTransactionListSliver(context, transactions),
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

  Widget _buildTransactionListSliver(
    BuildContext context,
    List<TransactionData> transactions,
  ) {
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
      child: TransactionItem(
        transaction: transaction,
        onTap: () => _showEditTransactionDialog(context, transaction),
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
    final l10n = AppLocalizations.of(context)!;
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.surfaceDark,
        title: _buildDeleteDialogTitle(l10n),
        content: _buildDeleteDialogContent(l10n, transaction.description),
        actions: _buildDeleteDialogActions(
          dialogContext,
          context,
          transaction.id,
        ),
      ),
    );
  }

  Widget _buildDeleteDialogTitle(AppLocalizations l10n) {
    return Text(
      l10n.deleteTransaction,
      style: const TextStyle(color: AppColors.categoryTitleText),
    );
  }

  Widget _buildDeleteDialogContent(
    AppLocalizations l10n,
    String transactionTitle,
  ) {
    return Text(
      l10n.confirmDeleteTransaction(transactionTitle),
      style: const TextStyle(color: AppColors.sectionHeaderText),
    );
  }

  List<Widget> _buildDeleteDialogActions(
    BuildContext dialogContext,
    BuildContext parentContext,
    String transactionId,
  ) {
    final l10n = AppLocalizations.of(parentContext)!;
    return [
      _buildCancelButton(dialogContext, l10n),
      _buildDeleteButton(dialogContext, parentContext, transactionId, l10n),
    ];
  }

  Widget _buildCancelButton(BuildContext dialogContext, AppLocalizations l10n) {
    return TextButton(
      onPressed: () => Navigator.pop(dialogContext, false),
      child: Text(l10n.cancel),
    );
  }

  Widget _buildDeleteButton(
    BuildContext dialogContext,
    BuildContext parentContext,
    String transactionId,
    AppLocalizations l10n,
  ) {
    return TextButton(
      onPressed: () {
        parentContext.read<TransactionCubit>().deleteTransaction(transactionId);
        Navigator.pop(dialogContext, true);
      },
      child: Text(
        l10n.delete,
        style: const TextStyle(color: AppColors.expensesStart),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
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

  void _showEditTransactionDialog(
    BuildContext context,
    TransactionData transaction,
  ) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider(
        create: (_) => sl<CategoryCubit>()..loadCategories(),
        child: EditTransactionDialog(
          transaction: transaction,
          onSave: (updatedTransaction) {
            context.read<TransactionCubit>().updateTransaction(
              updatedTransaction,
            );
            Navigator.pop(dialogContext);
          },
        ),
      ),
    );
  }
}
