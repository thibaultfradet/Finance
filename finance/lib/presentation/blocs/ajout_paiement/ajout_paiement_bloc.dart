import 'package:finance/domain/models/paiement.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_event.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AjoutPaiementBloc extends Bloc<AjoutpaiementEvent, AjoutpaiementState> {
  AjoutPaiementBloc() : super(const AjoutpaiementStateInitial()) {
    on<AjoutpaiementEvent>((event, emit) {
      emit(const AjoutpaiementStateInitial());
    });
    //Event création d'un paiement
    on<APEventCreate>((event, emit) {
      // on emet un loading le temps du traitement
      emit(const APELoading());

      Paiement paiementTemp = Paiement(
        commentaire: event.commentaire,
        datePaiement: event.datePaiement,
        montant: event.montant,
        motif: event.motif,
      );

      try {
        paiementTemp.createPaiement(paiementTemp);
      } catch (e) {
        emit(const APEFailure());
        return;
      }
      //on emit un success pour push l'utilisateur avec un context
      emit(const APESuccess());
    });
  }
}
