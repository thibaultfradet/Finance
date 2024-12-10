// ignore_for_file: use_build_context_synchronously

import 'package:finance/presentation/blocs/compte/compte_bloc.dart';
import 'package:finance/presentation/blocs/compte/compte_event.dart';
import 'package:finance/presentation/blocs/compte/compte_state.dart';
import 'package:finance/presentation/widgets/bouton_custom_compte.dart';
import 'package:finance/presentation/widgets/custom_dialog.dart';
import 'package:finance/presentation/widgets/vertical_margin.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Compte extends StatefulWidget {
  const Compte({super.key});

  @override
  State<Compte> createState() => _CompteState();
}

class _CompteState extends State<Compte> {
  /* Fonction affichage pop-up */
  Future<void> afficherModalAjout() async {
    final result = await showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          tecCate: tecCategorie,
          textTitre: "Ajouter une catégorie",
        );
      },
    );

    //Si il y a bien un résultat => on créer en base la catégorie et on reset le texte
    if (result != null && result.trim() != "") {
      setState(() {
        tecCategorie.text = "";
      });
      // On déclenche la création
      BlocProvider.of<CompteBloc>(context).add(
        CompteEventAjoutCate(result),
      );
    }
    //Réponse vide on déclenche une erreur pour que le bloc emit un failure = reset contenu
    else {
      setState(() {
        tecCategorie.text = "";
      });
      BlocProvider.of<CompteBloc>(context).add(
        CompteEventCategorieEmpty(),
      );
    }
  }

  TextEditingController tecCategorie = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompteBloc, CompteState>(
      builder: (BuildContext context, state) {
        if (state is CompteStateSuccess) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Center(
                    child: Text(
                      'Création réussie.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          );
        }
        if (state is CompteStateFailure) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.red,
                  content: Center(
                    child: Text(
                      'Une erreur est survenue lors de la création.',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              );
            },
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFF151433),
          appBar: AppBar(
            backgroundColor: const Color(0xFF151433),
            title: const Text(
              "Information du compte",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          body: Stack(
            children: [
              if (state is! CompteStateLoading)
                //colonne de l'app
                Column(
                  children: [
                    const Verticalmargin(ratio: 0.05),
                    //Bouton rajout categorie
                    Boutoncustomcompte(
                      onpressed: afficherModalAjout,
                      texteValeur: "Ajouter une catégorie",
                    ),
                  ],
                ),
              if (state is CompteStateLoading)
                const CircularProgressIndicator(),
            ],
          ),
        );
      },
    );
  }
}
