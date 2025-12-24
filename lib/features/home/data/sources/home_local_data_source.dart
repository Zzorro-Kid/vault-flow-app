import 'package:test_app/core/data/models/transaction_data_model.dart';
import 'package:test_app/core/data/sources/base_local_data_source.dart';
import 'package:test_app/features/home/data/models/dashboard_summary_data_model.dart';

abstract class HomeLocalDataSource {
  Future<DashboardSummaryDataModel> getDashboardSummary();
  Future<List<TransactionDataModel>> getRecentTransactions({int limit = 10});
}

class HomeLocalDataSourceImpl extends BaseLocalDataSource
    implements HomeLocalDataSource {
  HomeLocalDataSourceImpl();

  @override
  Future<DashboardSummaryDataModel> getDashboardSummary() async {
    return executeStorageRead(() async {
      // todo: Implement reading from encrypted local storage
      return DashboardSummaryDataModel.initial();
    }, errorMessage: 'Failed to get dashboard summary');
  }

  @override
  Future<List<TransactionDataModel>> getRecentTransactions({
    int limit = 10,
  }) async {
    return executeStorageRead(() async {
      // todo: Implement reading from encrypted local storage
      return <TransactionDataModel>[];
    }, errorMessage: 'Failed to get recent transactions');
  }
}
