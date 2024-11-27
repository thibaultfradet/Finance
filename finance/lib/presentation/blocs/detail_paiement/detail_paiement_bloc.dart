import 'package:finance/domain/models/paiement.dart';
import 'package:finance/presentation/blocs/detail_paiement/detail_paiement_event.dart';
import 'package:finance/presentation/blocs/detail_paiement/detail_paiement_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPaiementBloc
    extends Bloc<DetailPaiementEvent, DetailPaiementState> {
  DetailPaiementBloc() : super(const DetailPaiementStateInitial()) {
    //State initial
    on<DetailPaiementEvent>((event, emit) async {
      emit(const DetailPaiementStateInitial());
    });

    //L'utilisateur supprime le paiement en cours de consultation
    on<DetailPaiementDelete>((event, emit) async {
      //on emit le loading le temps de la suppresion qui peux prendre un certains temps
      emit(const DetailPaiementStateLoading());

      /* on appel la suppresion de l'item paiement 
       * Si réussi on emit success qui push l'utilisateur sur home
       * sinon on emit un failure
      */
      try {
        Paiement.empty().deletePaiement(event.idPaiement);
        emit(const DetailPaiementSuccess());
      } catch (e) {
        emit(const DetailPaiementFailure());
      }
    });
  }
}
