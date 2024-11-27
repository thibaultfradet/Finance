import 'package:finance/domain/models/paiement.dart';
import 'package:finance/presentation/blocs/detail_paiement/detail_paiement_bloc.dart';
import 'package:finance/presentation/blocs/detail_paiement/detail_paiement_state.dart';
import 'package:finance/presentation/widgets/custom_options_dialog.dart';
import 'package:finance/presentation/widgets/input_custom_pl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPaiement extends StatefulWidget {
  final Paiement paiementConcerner;
  const DetailPaiement({super.key, required this.paiementConcerner});

  @override
  State<DetailPaiement> createState() => _DetailPaiementState();
}

class _DetailPaiementState extends State<DetailPaiement> {
  /* Fonction affichage pop-up */
  Future<void> temp() async {
    showDialog(
      context: context,
      builder: (context) {
        //TODO : rajouter les fonctions voidCallBack pour la suppresion et la modification
        return CustomOptionsDialog([
          {"Modifier le paiement", () {}},
          {"Supprimer le paiement", () {}},
        ]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailPaiementBloc, DetailPaiementState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF151433),
          appBar: AppBar(
            backgroundColor: const Color(0xFF151433),
            title: const Text(
              "Détail du paiement",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              //Bouton pour les options => modifier / supprimer un paiement => on affiche la pop-up
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.keyboard_arrow_down),
              ),
            ],
          ),
          body:
              //colonne de la page
              Column(
            children: [
              //Categorie du paiement
              InputCustomPL(
                controllerPL: TextEditingController(),
                placeholder:
                    widget.paiementConcerner.categorieAssocier.libelleCategorie,
                enable: false,
              ),
              //Commentaire
              InputCustomPL(
                controllerPL: TextEditingController(),
                placeholder: widget.paiementConcerner.commentaire,
                enable: false,
              ),
              //montant
              InputCustomPL(
                controllerPL: TextEditingController(),
                placeholder: "${widget.paiementConcerner.montant} €",
                enable: false,
              ),
              //date paiement
              InputCustomPL(
                controllerPL: TextEditingController(),
                placeholder: widget.paiementConcerner.datePaiement.toString(),
                enable: false,
              ),
            ],
          ),
        );
      },
    );
  }
}
