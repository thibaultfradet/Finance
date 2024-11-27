import 'package:finance/domain/models/categorie.dart';
import 'package:finance/presentation/blocs/compte/compte_event.dart';
import 'package:finance/presentation/blocs/compte/compte_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompteBloc extends Bloc<CompteEvent, CompteState> {
  CompteBloc() : super(const CompteStateInitial()) {
    //state initial
    on<CompteEvent>((event, emit) async {
      emit(const CompteStateInitial());
    });

    //Event ajout d'une catégorie
    on<CompteEventAjoutCate>((event, emit) async {
      //emit loading le temps de l'enregistrement en base de données
      emit(const CompteStateLoading());

      // On créer la catégorie et on emit le résultat => si rate on emit failure sinon success
      try {
        Categorie categorieCreate = Categorie("", event.libelleCategorie);
        categorieCreate.createCategorie(categorieCreate);
        emit(const CompteStateSuccess());
      } catch (e) {
        emit(const CompteStateFailure());
      }
    });
  }
}
