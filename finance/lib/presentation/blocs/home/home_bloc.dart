import 'package:finance/presentation/blocs/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/presentation/blocs/home/home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeStateInitial()) {
    //Chaque fois que notre HomeEvent est appeler
    on<HomeEvent>((event, emit) async {
      emit(HomeStateInitial());
    });
  }
}
