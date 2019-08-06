import 'package:bloc/bloc.dart';
import 'package:pertani_shop/bloc/filter/bloc_layer/index.dart';
import 'package:rxdart/rxdart.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  @override
  FilterState get initialState => FilterSet();

  @override
  Stream<FilterState> transform(Stream<FilterEvent> events,
      Stream<FilterState> Function(FilterEvent event) next) {
    return super.transform(
        (events as Observable<FilterEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }

  @override
  Stream<FilterState> mapEventToState(FilterEvent event) async* {
    if (event is UpdateStar){
      yield FilterSet.copyFrom(currentState,star:event.star);
    }
    if (event is UpdateCategory){
      yield FilterSet.copyFrom(currentState,productCategory: event.category);
    }
    if (event is UpdatePrice){
      yield FilterSet.copyFrom(currentState,price: {"max":event.max,"min":event.min});
    }
    if (event is UpdateSearch){
      yield FilterSet.copyFrom(currentState,search: event.term);
    }
  }
}
