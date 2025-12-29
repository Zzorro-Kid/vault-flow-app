import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/utils/ui_helpers.dart';
import 'package:test_app/core/widgets/loading_indicator.dart';
import 'package:test_app/features/transaction/presentation/cubit/transaction_cubit.dart';
import 'package:test_app/features/transaction/presentation/cubit/transaction_state.dart';
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
}