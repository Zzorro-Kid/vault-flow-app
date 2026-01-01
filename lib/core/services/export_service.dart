import 'dart:io';
import 'package:csv/csv.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:test_app/features/transaction/data/models/transaction_data_model.dart';
import 'package:test_app/features/transaction/data/models/financial_summary_data_model.dart';
import 'package:test_app/core/errors/exceptions.dart';

class ExportService {
  final FinancialSummaryDataModel Function(List<TransactionDataModel>)
  calculateFinancialSummary;
  final DateTime Function()? getCurrentTime;

  const ExportService({
    required this.calculateFinancialSummary,
    this.getCurrentTime,
  });

  DateTime get _now => getCurrentTime?.call() ?? DateTime.now();

  Future<String> exportTransactionsToCSV({
    required List<TransactionDataModel> transactions,
    required String filePrefix,
  }) async {
    if (transactions.isEmpty) {
      throw ExportException('No transactions to export');
    }

    final List<List<dynamic>> rows = [
      ['Date', 'Type', 'Category', 'Description', 'Amount'],
    ];

    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    for (final transaction in transactions) {
      rows.add([
        dateFormat.format(transaction.date),
        transaction.type,
        transaction.category.name,
        transaction.description,
        transaction.amount.toStringAsFixed(2),
      ]);
    }

    final csvData = const ListToCsvConverter().convert(rows);
    final filePath = await _writeToFile(
      content: csvData,
      filePrefix: filePrefix,
      extension: 'csv',
    );

    return filePath;
  }

  Future<String> exportTransactionsToPDF({
    required List<TransactionDataModel> transactions,
    required String filePrefix,
  }) async {
    if (transactions.isEmpty) {
      throw ExportException('No transactions to export');
    }

    final pdf = pw.Document();
    final dateFormat = DateFormat('dd.MM.yyyy HH:mm');
    final summary = calculateFinancialSummary(transactions);

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            _buildPdfHeader(),
            pw.SizedBox(height: 20),
            _buildPdfGeneratedDate(dateFormat),
            pw.SizedBox(height: 20),
            _buildPdfSummary(summary),
            pw.SizedBox(height: 20),
            _buildPdfTransactionsTable(transactions, dateFormat),
          ];
        },
      ),
    );

    final bytes = await pdf.save();
    final filePath = await _writeBytesToFile(
      bytes: bytes,
      filePrefix: filePrefix,
      extension: 'pdf',
    );

    return filePath;
  }

  pw.Widget _buildPdfHeader() {
    return pw.Header(
      level: 0,
      child: pw.Text(
        'Transactions Report',
        style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
      ),
    );
  }

  pw.Widget _buildPdfGeneratedDate(DateFormat dateFormat) {
    return pw.Text(
      'Generated: ${dateFormat.format(_now)}',
      style: const pw.TextStyle(fontSize: 12),
    );
  }

  pw.Widget _buildPdfSummary(FinancialSummaryDataModel summary) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(border: pw.Border.all()),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Summary',
            style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold),
          ),
          pw.SizedBox(height: 10),
          pw.Text('Total Income: \$${summary.totalIncome.toStringAsFixed(2)}'),
          pw.Text(
            'Total Expenses: \$${summary.totalExpenses.toStringAsFixed(2)}',
          ),
          pw.Text('Balance: \$${summary.totalBalance.toStringAsFixed(2)}'),
        ],
      ),
    );
  }

  pw.Widget _buildPdfTransactionsTable(
    List<TransactionDataModel> transactions,
    DateFormat dateFormat,
  ) {
    return pw.TableHelper.fromTextArray(
      headers: ['Date', 'Type', 'Category', 'Description', 'Amount'],
      data: transactions.map((transaction) {
        return [
          dateFormat.format(transaction.date),
          transaction.type,
          transaction.category.name,
          transaction.description,
          '\$${transaction.amount.toStringAsFixed(2)}',
        ];
      }).toList(),
      headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      cellAlignment: pw.Alignment.centerLeft,
    );
  }

  Future<String> _writeToFile({
    required String content,
    required String filePrefix,
    required String extension,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(_now);
    final filePath = '${directory.path}/${filePrefix}_$timestamp.$extension';
    final file = File(filePath);
    await file.writeAsString(content);
    return filePath;
  }

  Future<String> _writeBytesToFile({
    required List<int> bytes,
    required String filePrefix,
    required String extension,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final timestamp = DateFormat('yyyyMMdd_HHmmss').format(_now);
    final filePath = '${directory.path}/${filePrefix}_$timestamp.$extension';
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    return filePath;
  }
}
