import 'package:finance/domain/models/categorie.dart';

abstract class AjoutpaiementState {
  const AjoutpaiementState();
}

class AjoutpaiementStateInitial extends AjoutpaiementState {
  const AjoutpaiementStateInitial();
}

class AjoutpaiementStateData extends AjoutpaiementState {
  final List<Categorie> categorieDisponible;
  const AjoutpaiementStateData(this.categorieDisponible) : super();
}

class APELoading extends AjoutpaiementState {
  const APELoading() : super();
}

class APESuccess extends AjoutpaiementState {
  const APESuccess() : super();
}

class APEFailure extends AjoutpaiementState {
  const APEFailure() : super();
}
