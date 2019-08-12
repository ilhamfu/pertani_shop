import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/transaction.dart';

abstract class TransactionState extends Equatable {
  TransactionState([List props = const []]) : super(props);
}

class TransactionUninitailzed extends TransactionState {
  @override
  String toString() {
    return "Transaction not initialized";
  }
}

class TransactionOnProcess extends TransactionState {
  final int processCode;

  static const int ON_FETCHING = 0;
  static const int ON_CREATING = 1;
  static const int ON_CANCELING = 2;

  TransactionOnProcess({this.processCode}) : super([processCode]);

  @override
  String toString() {
    return "Processing transaction : $processCode";
  }
}

class TransactionInitialized extends TransactionState {
  final List<Transaction> transaction;

  bool get isEmpty => transaction.length == 0;
  int get length => transaction.length;

  TransactionInitialized({this.transaction}) : super([transaction]);

  @override
  String toString() {
    // TODO: implement toString
    return "Transaction fetched : ${this.length}";
  }
}

class TransactionError extends TransactionState {
  final int err;

  TransactionError(this.err) : super([err]);
  @override
  String toString() {
    return "Transaction Error : $err";
  }
}
