import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/transaction.dart';

abstract class TransactionListState extends Equatable {
  TransactionListState([List props = const []]) : super(props);
}

class TransactionListUninitailzed extends TransactionListState {
  @override
  String toString() {
    return "Transaction not initialized";
  }
}

class TransactionListOnProcess extends TransactionListState {
  final int processCode;

  static const int ON_FETCHING = 0;
  static const int ON_CREATING = 1;
  static const int ON_CANCELING = 2;

  TransactionListOnProcess({this.processCode}) : super([processCode]);

  @override
  String toString() {
    return "Processing transaction : $processCode";
  }
}

class TransactionListInitialized extends TransactionListState {
  final List<Transaction> transaction;

  bool get isEmpty => transaction.length == 0;
  int get length => transaction.length;

  TransactionListInitialized({this.transaction}) : super([transaction]);

  @override
  String toString() {
    return "Transaction fetched : ${this.length}";
  }
}

class TransactionListError extends TransactionListState {
  final int err;

  TransactionListError(this.err) : super([err]);
  @override
  String toString() {
    return "Transaction Error : $err";
  }
}
