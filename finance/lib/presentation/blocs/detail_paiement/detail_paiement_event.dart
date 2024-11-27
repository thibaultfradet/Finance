class DetailPaiementEvent {
  DetailPaiementEvent();
}

class DetailPaiementDelete extends DetailPaiementEvent {
  final String idPaiement;
  DetailPaiementDelete(this.idPaiement) : super();
}
