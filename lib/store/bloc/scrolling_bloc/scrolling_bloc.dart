import 'package:bloc/bloc.dart';

import 'scrolling_state.dart';

class ScrollingBloc extends Bloc<bool, ScrollingState> {
  ScrollingBloc() : super(HideScrollToTopButton()) {
    on<bool>((event, emit) {
      emit(event ? ShowScrollToTopButton() : HideScrollToTopButton());
    });
  }
}
