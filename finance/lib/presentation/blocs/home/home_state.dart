import 'package:finance/domain/Paiement.dart';

abstract class HomeState {
  const HomeState();
}

class HomeStateInitial extends HomeState {
  final List<Paiement> collectionPaiement;
  final double totalMois;
  const HomeStateInitial(this.collectionPaiement, this.totalMois) : super();
}
