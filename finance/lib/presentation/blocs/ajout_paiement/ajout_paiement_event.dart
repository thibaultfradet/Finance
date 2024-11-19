class AjoutpaiementEvent {
  AjoutpaiementEvent();
}

//APEvent => ajout paiement event
class APEventCreate {
  final String commentaire;
  final DateTime datePaiement;
  final double montant;
  final String motif;
  APEventCreate(this.commentaire, this.datePaiement, this.montant, this.motif);
}
