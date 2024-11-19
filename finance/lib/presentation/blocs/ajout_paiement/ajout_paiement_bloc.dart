import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_event.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AjoutPaiementBloc extends Bloc<AjoutpaiementEvent, AjoutpaiementState> {
  AjoutPaiementBloc() : super(const AjoutpaiementStateInitial()) {
    on<AjoutpaiementEvent>((event, emit) {
      emit(const AjoutpaiementStateInitial());
    });
  }
}
