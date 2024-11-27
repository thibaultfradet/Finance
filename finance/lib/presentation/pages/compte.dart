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
  Future<void> temp() async {
    showDialog(
      context: context,
      builder: (context) {
        return CustomDialog(
          tecCate: tecCategorie,
          textTitre: "Ajouter une catégorie",
        );
      },
    ).then(
      (nomCategorie) {
        BlocProvider.of<CompteBloc>(context).add(
          CompteEventAjoutCate(nomCategorie),
        );
      },
    );
  }

  TextEditingController tecCategorie = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompteBloc, CompteState>(
      builder: (BuildContext context, state) {
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
              if (state != CompteStateLoading)
                //colonne de l'app
                Column(
                  children: [
                    const Verticalmargin(ratio: 0.05),
                    //Bouton rajout categorie
                    Boutoncustomcompte(
                      onpressed: temp,
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
