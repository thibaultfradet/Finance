import 'package:finance/domain/models/paiement.dart';
import 'package:finance/presentation/blocs/detail_paiement/detail_paiement_bloc.dart';
import 'package:finance/presentation/blocs/detail_paiement/detail_paiement_event.dart';
import 'package:finance/presentation/blocs/detail_paiement/detail_paiement_state.dart';
import 'package:finance/presentation/pages/ajout_paiement.dart';
import 'package:finance/presentation/pages/home.dart';
import 'package:finance/presentation/widgets/custom_options_dialog.dart';
import 'package:finance/presentation/widgets/item_valider.dart';
import 'package:finance/presentation/widgets/vertical_margin.dart';
import 'package:flutter/cupertino.dart';
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
  Future<void> afficherOptions() async {
    showDialog(
      context: context,
      builder: (context) {
        return CustomOptionsDialog(
          listeBoutons: [
            // modifier paiement on push l'utilisateur vers ajout paiement avec l'item en paramètre
            {
              "Modifier le paiement": () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AjoutPaiement(
                      paiementAModifier: widget.paiementConcerner,
                    ),
                  ),
                );
              }
            },
            // supprimer paiement on récupère l'item et on déclenche l'event dans bloc
            {
              "Supprimer le paiement": () {
                BlocProvider.of<DetailPaiementBloc>(context).add(
                  DetailPaiementDelete(
                    widget.paiementConcerner.idPaiement!,
                  ),
                );
              }
            },
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailPaiementBloc, DetailPaiementState>(
      builder: (BuildContext context, state) {
        //success on push l'utilisateur sur home
        if (state is DetailPaiementSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const Home()),
              (Route<dynamic> route) => false,
            );
          });
        }
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xFF151433),
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: const Color(0xFF151433),
            title: const Text(
              "Détail du paiement",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              //Bouton pour les options => modifier / supprimer un paiement => on affiche la pop-up
              IconButton(
                onPressed: () {
                  afficherOptions();
                },
                icon: const Icon(
                  CupertinoIcons.ellipsis_vertical,
                ),
              ),
            ],
          ),
          body:
              //colonne de la page
              Stack(
            children: [
              if (state is! DetailPaiementStateLoading)
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Categorie du paiement
                      ItemValider(
                        titre: "Catégorie du paiement",
                        valeur: widget.paiementConcerner.categorieAssocier
                            .libelleCategorie,
                      ),
                      const Verticalmargin(ratio: 0.05),
                      //Commentaire
                      ItemValider(
                        titre: "Commentaire du paiement",
                        valeur: widget.paiementConcerner.commentaire,
                      ),

                      const Verticalmargin(ratio: 0.05),
                      //montant
                      ItemValider(
                        titre: "Montant du paiement",
                        valeur: widget.paiementConcerner.montant.toString(),
                      ),

                      const Verticalmargin(ratio: 0.05),
                      //date paiement
                      ItemValider(
                        titre: "Date du paiement",
                        valeur:
                            '${widget.paiementConcerner.datePaiement.year}-${widget.paiementConcerner.datePaiement.month.toString().padLeft(2, '0')}-${widget.paiementConcerner.datePaiement.day.toString().padLeft(2, '0')}',
                      ),
                    ],
                  ),
                ),
              if (state is DetailPaiementStateLoading)
                const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
