import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/themes/app_colors.dart';
import 'package:test_app/core/utils/ui_helpers.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/category/presentation/cubit/category_cubit.dart';
import 'package:test_app/features/transaction/presentation/cubit/transaction_cubit.dart';
import 'package:test_app/features/transaction/presentation/cubit/transaction_state.dart';
import 'package:test_app/features/transaction/presentation/widgets/add_transaction_dialog.dart';
import 'package:test_app/features/transaction/presentation/widgets/transaction_app_bar.dart';
import 'package:test_app/features/transaction/presentation/widgets/transaction_error_view.dart';
import 'package:test_app/features/transaction/presentation/widgets/transaction_loaded_view.dart';
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
          appBar: const TransactionAppBar(),
          body: _buildBody(),
          floatingActionButton: _buildFAB(context),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        return switch (state) {
          TransactionLoading() => const LoadingIndicator(),
          TransactionLoaded() =>
            TransactionLoadedView(transactions: state.transactions),
          TransactionError() => TransactionErrorView(
              message: state.message,
              onRetry: () => context.read<TransactionCubit>().loadTransactions(),
            ),
          _ => const SizedBox.shrink(),
        };
      },
    );
  }

  void _showOperationSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: UiHelpers.getOperationSnackBarColor(message),
      ),
    );
  }

  Widget _buildFAB(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _showAddTransactionDialog(context),
      backgroundColor: AppColors.primary,
      child: const Icon(Icons.add, color: Colors.white),
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
}