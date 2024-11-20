class AjoutpaiementEvent {
  AjoutpaiementEvent();
}

//APEvent => ajout paiement event
class APEventCreate extends AjoutpaiementEvent {
  final String motif;
  final double montant;
  final DateTime datePaiement;
  final String commentaire;

  APEventCreate(
    this.motif,
    this.montant,
    this.datePaiement,
    this.commentaire,
  ) : super();
}
