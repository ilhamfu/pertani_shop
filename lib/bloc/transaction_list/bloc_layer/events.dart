import 'package:equatable/equatable.dart';
import 'package:pertani_shop/models/transaction.dart';

abstract class TransactionListEvent extends Equatable {
  TransactionListEvent([List props = const []]) : super(props);
}

class TransactionListFetch extends TransactionListEvent {
  final bool initialDispatch;

  TransactionListFetch({this.initialDispatch=true}):super([initialDispatch]);
  @override
  String toString() {
    return "Transaction fetching";
  }
}

class TransactionListCreate extends TransactionListEvent{
  final List<int> detail;

  TransactionListCreate({this.detail}) : super([detail]);

  @override
  String toString() {
    return "Creating transaction";
  }
}