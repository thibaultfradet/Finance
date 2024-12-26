import 'package:finance/domain/models/categorie.dart';

class AjoutpaiementEvent {
  AjoutpaiementEvent();
}

//APEvent => ajout paiement event
class APEventCreate extends AjoutpaiementEvent {
  final Categorie categorie;
  final double montant;
  final DateTime datePaiement;
  final String commentaire;
  final String? idPaiementUpdate;

  APEventCreate(
    this.categorie,
    this.montant,
    this.datePaiement,
    this.commentaire,
    this.idPaiementUpdate,
  ) : super();
}
