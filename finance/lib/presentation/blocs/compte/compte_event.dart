class CompteEvent {
  CompteEvent();
}

class CompteEventAjoutCate extends CompteEvent {
  final String libelleCategorie;
  CompteEventAjoutCate(this.libelleCategorie);
}

class CompteEventCategorieEmpty extends CompteEvent {
  CompteEventCategorieEmpty();
}
