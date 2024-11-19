import 'package:cloud_firestore/cloud_firestore.dart';

class Paiement {
  final int id;
  final double montant;
  final String motif;
  final String commentaire;
  final DateTime datePaiement;

  Paiement.empty()
      : id = 0,
        montant = 0.0,
        motif = '',
        commentaire = '',
        datePaiement = DateTime.now();

  Paiement({
    required this.id,
    required this.montant,
    required this.motif,
    required this.commentaire,
    required this.datePaiement,
  });

  Future<List<Paiement>> findAllPaiement() async {
    List<Paiement> collectionPaiement = [];
    CollectionReference paiementsRef =
        FirebaseFirestore.instance.collection('paiements');

    QuerySnapshot snapshot = await paiementsRef.get();
    for (var doc in snapshot.docs) {
      Paiement paiement = Paiement(
        id: int.tryParse(doc.id) ?? 0,
        montant: doc['montant'],
        motif: doc['motif'],
        commentaire: doc['commentaire'],
        datePaiement: (doc['datePaiement'] as Timestamp).toDate(),
      );
      collectionPaiement.add(paiement);
    }
    return collectionPaiement;
  }

  Future<List<Paiement>> findAllPaiementThisMonth() async {
    List<Paiement> collectionPaiement = [];
    CollectionReference paiementsRef =
        FirebaseFirestore.instance.collection('paiements');

    DateTime now = DateTime.now();
    DateTime startDate = DateTime(now.year, now.month, 1);
    DateTime endDate = DateTime(now.year, now.month + 1, 1)
        .subtract(const Duration(seconds: 1));

    QuerySnapshot snapshot = await paiementsRef
        .where('datePaiement', isGreaterThanOrEqualTo: startDate)
        .where('datePaiement', isLessThan: endDate)
        .get();

    for (var doc in snapshot.docs) {
      Paiement paiement = Paiement(
        id: int.tryParse(doc.id) ?? 0,
        montant: doc['montant'],
        motif: doc['motif'],
        commentaire: doc['commentaire'],
        datePaiement: (doc['datePaiement'] as Timestamp).toDate(),
      );
      collectionPaiement.add(paiement);
    }
    return collectionPaiement;
  }

  Future<List<Paiement>> findAllPaiementByMonthAndYear(
      int month, int year) async {
    List<Paiement> collectionPaiement = [];
    CollectionReference paiementsRef =
        FirebaseFirestore.instance.collection('paiements');

    if (month < 1 || month > 12) {
      throw Exception("Le mois doit être compris entre 1 et 12.");
    }
    if (year < 2000 || year > DateTime.now().year) {
      throw Exception("L'année doit être valide.");
    }

    DateTime startDate = DateTime(year, month, 1);
    DateTime endDate =
        DateTime(year, month + 1, 1).subtract(const Duration(seconds: 1));

    QuerySnapshot snapshot = await paiementsRef
        .where('datePaiement', isGreaterThanOrEqualTo: startDate)
        .where('datePaiement', isLessThan: endDate)
        .get();

    for (var doc in snapshot.docs) {
      Paiement paiement = Paiement(
        id: int.tryParse(doc.id) ?? 0,
        montant: doc['montant'],
        motif: doc['motif'],
        commentaire: doc['commentaire'],
        datePaiement: (doc['datePaiement'] as Timestamp).toDate(),
      );
      collectionPaiement.add(paiement);
    }
    return collectionPaiement;
  }
}
