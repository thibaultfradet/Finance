import 'package:finance/presentation/blocs/tout_paiement/tout_paiement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/presentation/blocs/tout_paiement/tout_paiement_event.dart';
import 'package:finance/domain/models/paiement.dart';

class ToutPaiementBloc extends Bloc<ToutPaiementEvent, ToutPaiementState> {
  ToutPaiementBloc() : super(const ToutPaiementStateInitial([])) {
    //state initial
    on<ToutPaiementEvent>((event, emit) async {
      //En attendant la recuperation des données on emet un loading
      emit(const ToutPaiementLoading());

      //On récupère la liste des paiement
      List<Paiement> collectionPaiement = [];
      collectionPaiement = await Paiement.empty().findAllPaiement();

      emit(ToutPaiementStateInitial(collectionPaiement));
    });
  }
}
