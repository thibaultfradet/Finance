import 'package:finance/presentation/blocs/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/presentation/blocs/home/home_event.dart';
import 'package:finance/domain/models/paiement.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(const HomeStateInitial([], 0)) {
    //state initial
    on<HomeEvent>((event, emit) async {
      //En attendant la recuperation des données on emet un loading
      emit(const HomeLoading());

      //On récupère la liste des paiement
      List<Paiement> collectionPaiement = [];
      // collectionPaiement = await Paiement.empty().findAllPaiementThisMonth();
      collectionPaiement = await Paiement.empty().findAllPaiementThisMonth();
      //Calcul du montant depenser ce mois-ci
      double totalMois = 0;
      //pour chaque paiement du mois dans la collection on accumule le montant
      for (var paiement in collectionPaiement) {
        totalMois += paiement.montant;
      }
      emit(HomeStateInitial(collectionPaiement, totalMois));
    });
  }
}
