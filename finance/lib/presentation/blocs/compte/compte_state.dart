abstract class CompteState {
  const CompteState();
}

class CompteStateInitial extends CompteState {
  const CompteStateInitial() : super();
}

class CompteStateLoading extends CompteState {
  const CompteStateLoading() : super();
}

class CompteStateSuccess extends CompteState {
  const CompteStateSuccess() : super();
}

class CompteStateFailure extends CompteState {
  const CompteStateFailure() : super();
}
