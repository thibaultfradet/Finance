import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/domain/models/categorie.dart';

class Paiement {
  final String? idPaiement;
  final double montant;
  final Categorie categorieAssocier;
  final String commentaire;
  final DateTime datePaiement;

  /* Constructeur vide */
  Paiement.empty()
      : idPaiement = "",
        montant = 0.0,
        categorieAssocier = Categorie.empty(),
        commentaire = '',
        datePaiement = DateTime.now();

  /* Constructeur surcharger */
  Paiement({
    this.idPaiement,
    required this.montant,
    required this.categorieAssocier,
    required this.commentaire,
    required this.datePaiement,
  });

  /* FONCTION DE CONVERSION */

  Map<String, dynamic> toFirestore() {
    return {
      'commentaire': commentaire,
      'datePaiement': datePaiement,
      'idPaiement': idPaiement,
      'montant': montant,
      'idCategorie': categorieAssocier.idCategorie,
    };
  }

  Future<Paiement> paiementFromJSON(Map<String, dynamic> json) async {
    return Paiement(
      idPaiement: json["idPaiement"],
      montant: json["montant"],
      categorieAssocier:
          await Categorie.empty().retrieveCategorie(json["idCategorie"]),
      commentaire: json["commentaire"],
      datePaiement: (json['datePaiement'] as Timestamp).toDate(),
    );
  }

  /* CRUD ET AUTRE */

  Future<void> createPaiement(Paiement paiementCreate) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    // DocumentReference doc = await db.collection("paiments").doc();

    // doc.set()

    DocumentReference docRef =
        await db.collection("paiements").add(paiementCreate.toFirestore());
    await docRef.update({'idPaiement': docRef.id});
  }

  /* Fonction findAllPaiement qui retourne la liste de touts les paiements existant dans la base de données */
  Future<List<Paiement>> findAllPaiement() async {
    List<Paiement> collectionPaiement = [];
    CollectionReference paiementsRef =
        FirebaseFirestore.instance.collection('paiements');

    QuerySnapshot snapshot = await paiementsRef.get();
    for (var doc in snapshot.docs) {
      Paiement paiement =
          await paiementFromJSON(doc.data() as Map<String, dynamic>);
      collectionPaiement.add(paiement);
    }
    return collectionPaiement;
  }

  /* Fonction findAllPaiementThisMont qui se base sur le mois actuelle et retourne la liste des paiements lier ce mois-ci dans la base de données */
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
      Paiement paiement =
          await paiementFromJSON(doc.data() as Map<String, dynamic>);
      collectionPaiement.add(paiement);
    }
    return collectionPaiement;
  }

  /* 
  Fonction findAllPaiementByMonthandYear qui prend en paramètre deux int qui sont les mois et l'année et retourne la 
  liste de paiement associer à ces deux informations depuis la base de donénes 
  */
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
      Paiement paiement =
          await paiementFromJSON(doc.data() as Map<String, dynamic>);
      collectionPaiement.add(paiement);
    }
    return collectionPaiement;
  }

  Future<void> deletePaiement(String idPaiement) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    await db.collection('paiements').doc(idPaiement).delete();
  }
}
