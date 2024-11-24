import 'package:finance/domain/models/paiement.dart';

abstract class StatistiqueState {
  const StatistiqueState();
}

class StatistiqueStateInitial extends StatistiqueState {
  final List<Paiement> paiementDisponible;
  final List<Map<String, dynamic>> dictionnaireCategorieMontant;
  const StatistiqueStateInitial(
      this.paiementDisponible, this.dictionnaireCategorieMontant)
      : super();
}

class StatistiqueLoading extends StatistiqueState {
  const StatistiqueLoading() : super();
}
