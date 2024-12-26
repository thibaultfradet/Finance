import 'package:finance/domain/models/categorie.dart';
import 'package:finance/domain/models/paiement.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_bloc.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_event.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_state.dart';
import 'package:finance/presentation/pages/home.dart';

import 'package:finance/presentation/widgets/bouton_custom.dart';
import 'package:finance/presentation/widgets/custom_dropdown_item.dart';
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

//Au chargement de la page
  @override
  void initState() {
    //Si il s'agit bien d'une modification et non d'une création on va initialiser les champs avec les valeurs du paiement
    if (widget.paiementAModifier != null) {
      categorieSelected =
          widget.paiementAModifier!.categorieAssocier.libelleCategorie;
      tecMontant = TextEditingController(
          text: widget.paiementAModifier!.montant.toString());
      tecCommentaire =
          TextEditingController(text: widget.paiementAModifier!.commentaire);

      datePaiementSelectionner = widget.paiementAModifier!.datePaiement;
    }

    super.initState();
  }

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
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                    (Route route) => false);
              },
            );
          }

          return Scaffold(
            resizeToAvoidBottomInset: false,
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
                if (state is AjoutpaiementStateData)
                  SingleChildScrollView(
                    child: Center(
                      //Formualaire
                      child: Column(
                        children: [
                          const Text(
                            "Ajouter un paiement",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                              color: Colors.white,
                            ),
                          ),
                          const Verticalmargin(ratio: 0.05),

                          //ComboBox avec liste des categorie
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: Colors.grey,
                              //par défaut premier élément possible
                              value: state.categorieDisponible.isNotEmpty
                                  ? state.categorieDisponible.first
                                      .libelleCategorie
                                  : null,
                              // Down Arrow Icon
                              icon: const Icon(Icons.keyboard_arrow_down),
                              style: const TextStyle(color: Colors.white),
                              onChanged: (String? valeur) {
                                setState(
                                  () {
                                    categorieSelected = valeur!;
                                  },
                                );
                              },
                              items: state.categorieDisponible.map(
                                (Categorie items) {
                                  return DropdownMenuItem<String>(
                                    value: items.libelleCategorie,
                                    child: CustomDropdownItem(
                                      valeur: items.libelleCategorie,
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
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
                                //avant de valider on vérifie que la catégorie sélectionner n'est pas null sinon on envoie un show dialog
                                if (categorieSelected.isEmpty ||
                                    double.tryParse(tecMontant.text) == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Center(
                                        child: Text(
                                          'Problème dans les informations renseignées.',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  );
                                } else {
                                  BlocProvider.of<AjoutPaiementBloc>(context)
                                      .add(
                                    APEventCreate(
                                      state.categorieDisponible
                                          .where((item) =>
                                              item.libelleCategorie ==
                                              categorieSelected)
                                          .first,
                                      double.parse(tecMontant.text),
                                      datePaiementSelectionner,
                                      tecCommentaire.text,
                                      widget.paiementAModifier?.idPaiement,
                                    ),
                                  );
                                }
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
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
