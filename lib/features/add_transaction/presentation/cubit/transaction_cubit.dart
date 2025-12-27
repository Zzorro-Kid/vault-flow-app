import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_app/core/usecases/usecase.dart';
import 'package:test_app/features/add_transaction/domain/entities/transaction_data.dart';
import 'package:test_app/features/add_transaction/domain/usecases/add_transaction_usecase.dart';
import 'package:test_app/features/add_transaction/domain/usecases/delete_transaction_usecase.dart';
import 'package:test_app/features/add_transaction/domain/usecases/get_all_transactions_usecase.dart';
import 'package:test_app/features/add_transaction/domain/usecases/update_transaction_usecase.dart';
import 'package:test_app/features/add_transaction/presentation/cubit/transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final GetAllTransactionsUseCase getAllTransactionsUseCase;
  final AddTransactionUseCase addTransactionUseCase;
  final UpdateTransactionUseCase updateTransactionUseCase;
  final DeleteTransactionUseCase deleteTransactionUseCase;

  TransactionCubit({
    required this.getAllTransactionsUseCase,
    required this.addTransactionUseCase,
    required this.updateTransactionUseCase,
    required this.deleteTransactionUseCase,
  }) : super(const TransactionInitial());

  Future<void> loadTransactions() async {
    emit(const TransactionLoading());

    final result = await getAllTransactionsUseCase(NoParams());

    result.fold(
      (failure) => emit(TransactionError(failure.message)),
      (transactions) => emit(TransactionLoaded(transactions)),
    );
  }

  Future<void> addTransaction(TransactionData transaction) async {
    final result = await addTransactionUseCase(transaction);

    result.fold(
      (failure) {
        emit(TransactionError(failure.message));
      },
      (_) {
        emit(
          const TransactionOperationSuccess('Transaction added successfully!'),
        );
        loadTransactions();
      },
    );
  }

  Future<void> updateTransaction(TransactionData transaction) async {
    final result = await updateTransactionUseCase(transaction);

    result.fold((failure) => emit(TransactionError(failure.message)), (_) {
      emit(
        const TransactionOperationSuccess('Transaction updated successfully!'),
      );
      loadTransactions();
    });
  }

  Future<void> deleteTransaction(String transactionId) async {
    final result = await deleteTransactionUseCase(transactionId);

    result.fold((failure) => emit(TransactionError(failure.message)), (_) {
      emit(const TransactionOperationSuccess('Transaction deleted'));
      loadTransactions();
    });
  }
}
