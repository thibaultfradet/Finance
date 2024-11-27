import 'package:finance/presentation/blocs/detail_paiement/detail_paiement_event.dart';
import 'package:finance/presentation/blocs/detail_paiement/detail_paiement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPaiementBloc
    extends Bloc<DetailPaiementEvent, DetailPaiementState> {
  DetailPaiementBloc() : super(const DetailPaiementStateInitial()) {
    //state initial
    on<DetailPaiementEvent>((event, emit) async {
      emit(const DetailPaiementStateInitial());
    });
  }
}
