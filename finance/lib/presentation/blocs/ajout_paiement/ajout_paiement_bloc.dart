import 'package:finance/domain/models/categorie.dart';
import 'package:finance/domain/models/paiement.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_event.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AjoutPaiementBloc extends Bloc<AjoutpaiementEvent, AjoutpaiementState> {
  AjoutPaiementBloc() : super(const AjoutpaiementStateInitial([])) {
    //State initial
    on<AjoutpaiementEvent>((event, emit) async {
      //on emit un load le temps du chargement des données
      emit(const APELoading());
      //on récupère la liste des catégorie dispo
      List<Categorie> categorieDisponible =
          await Categorie.empty().findAllCategorie();
      emit(AjoutpaiementStateInitial(categorieDisponible));
    });

    //Event création d'un paiement
    on<APEventCreate>((event, emit) async {
      // on emet un loading le temps du traitement
      emit(const APELoading());

      Paiement paiementTemp = Paiement(
        commentaire: event.commentaire,
        datePaiement: event.datePaiement,
        montant: event.montant,
        categorieAssocier:
            await Categorie.empty().retrieveCategorie(event.categorie),
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
