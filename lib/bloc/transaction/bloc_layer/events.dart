import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/transaction.dart';

abstract class TransactionEvent extends Equatable {
  TransactionEvent([List props = const []]) : super(props);
}

class TransactionFetch extends TransactionEvent {
  final bool initialDispatch;

  TransactionFetch({this.initialDispatch=true}):super([initialDispatch]);
  @override
  String toString() {
    return "Transaction fetching";
  }
}

class TransactionCancel extends TransactionEvent {
  final Transaction transaction;

  TransactionCancel({this.transaction}) : super([transaction]);

  @override
  String toString() {
    return "Deleting transaction : ${transaction.id}";
  }
}

class TransactionCreate extends TransactionEvent{
  final List<int> detail;

  TransactionCreate({this.detail}) : super([detail]);

  @override
  String toString() {
    return "Creating transaction";
  }
}