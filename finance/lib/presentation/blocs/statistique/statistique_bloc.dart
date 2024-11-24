import 'package:finance/domain/models/paiement.dart';
import 'package:finance/presentation/blocs/statistique/statistique_event.dart';
import 'package:finance/presentation/blocs/statistique/statistique_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatistiqueBloc extends Bloc<StatistiqueEvent, StatistiqueState> {
  StatistiqueBloc() : super(const StatistiqueStateInitial([], [])) {
    //state initial
    on<StatistiqueEvent>((event, emit) async {
      //on emit un load le temps du chargement des données
      emit(const StatistiqueLoading());
      //on récupère la liste des paiement de ce mois-ci
      List<Paiement> paiementDisponible =
          await Paiement.empty().findAllPaiementThisMonth();
      //dictionnaire key value pair => clé = idCategorie ; value = cumulatif des montant
      List<Map<String, dynamic>> listeCategorieMontant = [];

/* 
  Pour chaque paiement, si la catégorie n'existe pas encore dans la liste, on l'ajoute. 
  Dans tous les cas, on cumule le montant associé à cette catégorie.
*/
      for (Paiement paiement in paiementDisponible) {
        final idCategorie = paiement.categorieAssocier.libelleCategorie;

        Map<String, dynamic>? categorieExistante;

        try {
          // Rechercher l'entrée existante pour la catégorie
          categorieExistante = listeCategorieMontant
              .where((element) => element['genre'] == idCategorie)
              .first;
        } catch (e) {
          // Si aucune catégorie n'est trouvée, on la met à null
          categorieExistante = null;
        }

        if (categorieExistante != null) {
          // Ajouter au montant existant
          categorieExistante['sold'] += paiement.montant;
        } else {
          // Ajouter une nouvelle catégorie
          listeCategorieMontant.add({
            'genre': idCategorie,
            'sold': paiement.montant,
          });
        }
      }

      emit(StatistiqueStateInitial(paiementDisponible, listeCategorieMontant));
    });
  }
}
