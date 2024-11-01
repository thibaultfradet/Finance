import 'package:finance/domain/Paiement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<Paiement>> FindAllPaiement() async {
  List<Paiement> collectionPaiement = [];

  // Référence à la collection "paiements"
  CollectionReference paiementsRef =
      FirebaseFirestore.instance.collection('paiements');

  //requete pour recuperer touts les items
  QuerySnapshot snapshot = await paiementsRef.get();

  // pour chaque items => on créer un objet paiement avec les données recuperer et on l'ajoute a la collection
  for (var doc in snapshot.docs) {
    Paiement paiement = Paiement(
      id: int.parse(doc.id),
      montant: doc['montant'],
      motif: doc['motif'],
      commentaire: doc['commentaire'],
      datePaiement: DateTime.parse(doc['date_paiement']),
    );
    collectionPaiement.add(paiement);
  }
  return collectionPaiement;
}

Future<List<Paiement>> FindAllPaiementCeMois() async {
  List<Paiement> collectionPaiement = [];

  // Référence à la collection "paiements"
  CollectionReference paiementsRef =
      FirebaseFirestore.instance.collection('paiements');

  // Obtenir la date actuelle
  DateTime now = DateTime.now();
  int currentYear = now.year;
  int currentMonth = now.month;

  // Requête pour récupérer uniquement les paiements du mois et de l'année actuels
  QuerySnapshot snapshot = await paiementsRef
      .where('datePaiement',
          isGreaterThanOrEqualTo: DateTime(currentYear, currentMonth, 1))
      .where('datePaiement',
          isLessThan: DateTime(currentYear, currentMonth + 1, 1))
      .get();

  // Pour chaque item, créer un objet paiement avec les données récupérées et l'ajouter à la collection
  for (var doc in snapshot.docs) {
    Paiement paiement = Paiement(
      id: int.parse(doc.id),
      montant: doc['montant'],
      motif: doc['motif'],
      commentaire: doc['commentaire'],
      datePaiement: DateTime.parse(doc['datePaiement']),
    );
    collectionPaiement.add(paiement);
  }
  return collectionPaiement;
}

Future<List<Paiement>> FindAllPaiementByMonthAndYear(
    int month, int year) async {
  List<Paiement> collectionPaiement = [];

  // Référence à la collection "paiements"
  CollectionReference paiementsRef =
      FirebaseFirestore.instance.collection('paiements');

  // Validation des paramètres
  if (month < 1 || month > 12) {
    throw Exception("Le mois doit être compris entre 1 et 12.");
  }

  if (year < 2000 || year > DateTime.now().year) {
    throw Exception("L'année doit être valide.");
  }

  // Requête pour récupérer uniquement les paiements du mois et de l'année spécifiés
  QuerySnapshot snapshot = await paiementsRef
      .where('datePaiement', isGreaterThanOrEqualTo: DateTime(year, month, 1))
      .where('datePaiement', isLessThan: DateTime(year, month + 1, 1))
      .get();

  // Pour chaque item, créer un objet paiement avec les données récupérées et l'ajouter à la collection
  for (var doc in snapshot.docs) {
    Paiement paiement = Paiement(
      id: int.parse(doc.id),
      montant: doc['montant'],
      motif: doc['motif'],
      commentaire: doc['commentaire'],
      datePaiement: DateTime.parse(doc['datePaiement']),
    );
    collectionPaiement.add(paiement);
  }
  return collectionPaiement;
}
