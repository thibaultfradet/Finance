import 'package:finance/domain/models/categorie.dart';
import 'package:finance/domain/models/paiement.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_bloc.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_event.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_state.dart';
import 'package:finance/presentation/pages/home.dart';

import 'package:finance/presentation/widgets/bouton_custom.dart';
import 'package:finance/presentation/widgets/input_custom_pl.dart';
import 'package:finance/presentation/widgets/vertical_margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_picker_plus/date_picker_plus.dart';

class AjoutPaiement extends StatefulWidget {
  final Paiement? paiementAModifier;
  const AjoutPaiement({super.key, this.paiementAModifier});

  @override
  State<AjoutPaiement> createState() => _AjoutPaiementState();
}

class _AjoutPaiementState extends State<AjoutPaiement> {
  String categorieSelected = "";
  String idCategorieSelectionner = "";
  TextEditingController tecMontant = TextEditingController();
  TextEditingController tecCommentaire = TextEditingController();

  DateTime datePaiementSelectionner = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AjoutPaiementBloc()..add(AjoutpaiementEvent()),
      child: BlocBuilder<AjoutPaiementBloc, AjoutpaiementState>(
        builder: (BuildContext context, state) {
          if (state is APESuccess) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const Home()),
                    (Route route) => false);
              },
            );
          }

          return Scaffold(
            backgroundColor: const Color(0xFF151433),
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              title: const Text(
                "Ajouter un paiement",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF151433),
            ),
            body: Stack(
              children: [
                if (state is AjoutpaiementStateInitial)
                  SingleChildScrollView(
                    child: Center(
                      //Formualaire
                      child: Column(
                        children: [
                          const Text(
                            "AJOUTER UN PAIEMENT",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                          const Verticalmargin(ratio: 0.05),
                          //ComboBox avec liste des categorie
                          DropdownButton(
                            // Initial Value
                            value: state.categorieDisponible[0],

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: state.categorieDisponible
                                .map((Categorie items) {
                              return DropdownMenuItem(
                                value: items.libelleCategorie,
                                child: Text(items.libelleCategorie),
                              );
                            }).toList(),
                            onChanged: (valeur) {
                              setState(
                                () {
                                  categorieSelected = valeur.toString();
                                },
                              );
                            },
                          ),
                          const Verticalmargin(ratio: 0.05),
                          InputCustomPL(
                            controllerPL: tecCommentaire,
                            placeholder: "Commentaire",
                          ),

                          const Verticalmargin(ratio: 0.05),
                          InputCustomPL(
                            controllerPL: tecMontant,
                            placeholder: "Montant",
                            isDouble: true,
                          ),

                          const Verticalmargin(ratio: 0.05),
                          // Date picker pour la date de paiement
                          DatePicker(
                            daysOfTheWeekTextStyle:
                                const TextStyle(color: Colors.white),
                            enabledCellsTextStyle:
                                const TextStyle(color: Colors.white),
                            selectedCellTextStyle:
                                const TextStyle(color: Colors.white),
                            currentDateTextStyle:
                                const TextStyle(color: Colors.white),
                            leadingDateTextStyle:
                                const TextStyle(color: Colors.white),
                            centerLeadingDate: true,
                            initialDate: DateTime.now(),
                            minDate: DateTime(
                                DateTime.now().year, DateTime.now().month, 1),
                            maxDate: DateTime(DateTime.now().year,
                                DateTime.now().month + 1, 0),
                            onDateSelected: (valueDate) {
                              setState(
                                () {
                                  datePaiementSelectionner = valueDate;
                                },
                              );
                            },
                          ),

                          //Bouton validation formulaire
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: BoutonCustom(
                              onpressed: () {
                                BlocProvider.of<AjoutPaiementBloc>(context).add(
                                  APEventCreate(
                                    categorieSelected,
                                    double.parse(tecMontant.text),
                                    datePaiementSelectionner,
                                    tecCommentaire.text,
                                  ),
                                );
                              },
                              texteValeur: "VALIDER",
                            ),
                          ),

                          const Verticalmargin(ratio: 0.05)
                        ],
                      ),
                    ),
                  ),
                if (state is APELoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }
}
