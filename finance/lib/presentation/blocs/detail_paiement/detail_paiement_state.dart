abstract class DetailPaiementState {
  const DetailPaiementState();
}

class DetailPaiementStateInitial extends DetailPaiementState {
  const DetailPaiementStateInitial() : super();
}

class DetailPaiementStateLoading extends DetailPaiementState {
  const DetailPaiementStateLoading() : super();
}

class DetailPaiementSuccess extends DetailPaiementState {
  const DetailPaiementSuccess() : super();
}

class DetailPaiementFailure extends DetailPaiementState {
  const DetailPaiementFailure() : super();
}
