class Paiement {
  final int id;
  final double montant;
  final String motif;
  final String commentaire;
  final DateTime datePaiement;

  Paiement({
    required this.id,
    required this.montant,
    required this.motif,
    required this.commentaire,
    required this.datePaiement,
  });
}
