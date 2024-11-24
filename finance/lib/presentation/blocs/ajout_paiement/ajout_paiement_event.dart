class AjoutpaiementEvent {
  AjoutpaiementEvent();
}

//APEvent => ajout paiement event
class APEventCreate extends AjoutpaiementEvent {
  final String categorie;
  final double montant;
  final DateTime datePaiement;
  final String commentaire;

  APEventCreate(
    this.categorie,
    this.montant,
    this.datePaiement,
    this.commentaire,
  ) : super();
}
