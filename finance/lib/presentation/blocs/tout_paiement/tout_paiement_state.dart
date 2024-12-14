import 'package:finance/domain/models/paiement.dart';

abstract class ToutPaiementState {
  const ToutPaiementState();
}

class ToutPaiementStateInitial extends ToutPaiementState {
  final List<Paiement> collectionPaiement;
  const ToutPaiementStateInitial(this.collectionPaiement) : super();
}

class ToutPaiementLoading extends ToutPaiementState {
  const ToutPaiementLoading();
}
