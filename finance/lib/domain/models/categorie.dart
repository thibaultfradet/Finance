import 'package:cloud_firestore/cloud_firestore.dart';

class Categorie {
  final String? idCategorie;
  final String libelleCategorie;

  Categorie.empty()
      : idCategorie = null,
        libelleCategorie = "";

  Categorie(this.idCategorie, this.libelleCategorie);

  /* FONCTION DE CONVERSION */

  Map<String, dynamic> toFirestore() {
    return {
      'idCategorie': idCategorie,
      'LibelleCategorie': libelleCategorie,
    };
  }

  factory Categorie.fromJSON(Map<String, dynamic> json) {
    return Categorie(
      json["idCategorie"],
      json["LibelleCategorie"],
    );
  }

  /* CRUD ET AUTRE */
  Future<List<Categorie>> findAllCategorie() async {
    List<Categorie> collectionCategorie = [];
    CollectionReference paiementsRef =
        FirebaseFirestore.instance.collection('categories');

    QuerySnapshot snapshot = await paiementsRef.get();
    for (var doc in snapshot.docs) {
      Categorie categorieTemp =
          Categorie.fromJSON(doc.data() as Map<String, dynamic>);
      collectionCategorie.add(categorieTemp);
    }
    return collectionCategorie;
  }

  Future<Categorie> retrieveCategorie(String idCategorie) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    final docCategorie = db.collection("categories").doc(idCategorie);

    var getDataCategorie = await docCategorie.get();
    Map<String, dynamic>? dataInstrument = getDataCategorie.data();

    return Categorie.fromJSON(dataInstrument!);
  }

  Future<void> createCategorie(Categorie categorieCreate) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    DocumentReference docRef =
        await db.collection("categories").add(categorieCreate.toFirestore());
    await docRef.update({'idCategorie': docRef.id});
  }
}
