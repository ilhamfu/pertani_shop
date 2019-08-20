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
  final Transaction transaction;

  TransactionInitialized({this.transaction}) : super([transaction]);

  int get id => transaction.id;

  @override
  String toString() {
    
    return "Transaction fetched : ${transaction.id}";
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
