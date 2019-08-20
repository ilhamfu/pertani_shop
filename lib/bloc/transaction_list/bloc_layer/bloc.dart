import 'package:pertani_shop/bloc/transaction_list/bloc_layer/index.dart';
import 'package:bloc/bloc.dart';

class TransactionListBloc extends Bloc<TransactionListEvent, TransactionListState> {
  @override
  TransactionListState get initialState => TransactionListUninitailzed();

  @override
  Stream<TransactionListState> mapEventToState(TransactionListEvent event) async* {
    try {
      if (event is TransactionListFetch) {
        if (!event.initialDispatch || (currentState is TransactionListUninitailzed)) {
          yield TransactionListOnProcess(
              processCode: TransactionListOnProcess.ON_FETCHING);
          await Future.delayed(Duration(seconds: 10));
          yield TransactionListInitialized(transaction: []);
          return;
        }
      }
      if (event is TransactionListCreate) {
        yield TransactionListOnProcess(
            processCode: TransactionListOnProcess.ON_CREATING);
        await Future.delayed(Duration(seconds: 10));
        dispatch(TransactionListFetch(initialDispatch: false));
        return;
      }
    } catch (e) {
      yield TransactionListError(0);
    }
  }
}
