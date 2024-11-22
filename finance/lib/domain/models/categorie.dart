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
        FirebaseFirestore.instance.collection('paiements');

    QuerySnapshot snapshot = await paiementsRef.get();
    for (var doc in snapshot.docs) {
      Categorie categorieTemp =
          Categorie.fromJSON(doc.data() as Map<String, dynamic>);
      collectionCategorie.add(categorieTemp);
    }
    return collectionCategorie;
  }
}
