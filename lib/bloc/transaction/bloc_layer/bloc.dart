import 'package:pertani_shop/bloc/transaction/bloc_layer/index.dart';
import 'package:bloc/bloc.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  @override
  TransactionState get initialState => TransactionUninitailzed();

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    try {
      if (event is TransactionFetch) {
        if (!event.initialDispatch || (currentState is TransactionUninitailzed)) {
          yield TransactionOnProcess(
              processCode: TransactionOnProcess.ON_FETCHING);
          await Future.delayed(Duration(seconds: 10));
          yield TransactionInitialized();
          return;
        }
      }
      if (event is TransactionCreate) {
        yield TransactionOnProcess(
            processCode: TransactionOnProcess.ON_CREATING);
        await Future.delayed(Duration(seconds: 10));
        dispatch(TransactionFetch(initialDispatch: false));
        return;
      }
      if (event is TransactionCancel){
        yield TransactionOnProcess(
            processCode: TransactionOnProcess.ON_CANCELING);
        await Future.delayed(Duration(seconds: 10));
        dispatch(TransactionFetch(initialDispatch: true));
        return;
      }
    } catch (e) {
      yield TransactionError(0);
    }
  }
}
