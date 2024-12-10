import 'package:finance/domain/models/paiement.dart';
import 'package:finance/presentation/blocs/statistique/statistique_event.dart';
import 'package:finance/presentation/blocs/statistique/statistique_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatistiqueBloc extends Bloc<StatistiqueEvent, StatistiqueState> {
  StatistiqueBloc() : super(const StatistiqueStateInitial([], [])) {
    //state initial
    /* 
    * Pour chaque paiement, si la catégorie n'existe pas encore dans la liste, on l'ajoute. 
    * Dans tous les cas, on cumule le montant associé à cette catégorie.
    */
    on<StatistiqueEvent>((event, emit) async {
      //on emit un load le temps du chargement des données
      emit(const StatistiqueLoading());
      //on récupère la liste des paiement de ce mois-ci
      List<Paiement> paiementDisponible =
          await Paiement.empty().findAllPaiementThisMonth();
      //dictionnaire key value pair => clé = idCategorie ; value = cumulatif des montant
      List<Map<String, dynamic>> listeCategorieMontant = [];

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
          categorieExistante['sold'] =
              (double.parse(categorieExistante['sold']) + paiement.montant)
                  .toStringAsFixed(2);
        } else {
          // Ajouter une nouvelle catégorie
          listeCategorieMontant.add({
            'genre': idCategorie,
            'sold': paiement.montant.toStringAsFixed(2),
          });
        }
      }

      emit(StatistiqueStateInitial(paiementDisponible, listeCategorieMontant));
    });
  }
}
