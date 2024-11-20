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
  const AjoutPaiement({super.key});

  @override
  State<AjoutPaiement> createState() => _AjoutPaiementState();
}

class _AjoutPaiementState extends State<AjoutPaiement> {
  TextEditingController tecMotif = TextEditingController();
  TextEditingController tecMontant = TextEditingController();
  TextEditingController tecCommentaire = TextEditingController();

  DateTime datePaiementSelectionner = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AjoutPaiementBloc, AjoutpaiementState>(
      builder: (BuildContext context, state) {
        if (state is APESuccess) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
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
          body: SingleChildScrollView(
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
                  InputCustomPL(
                    controllerPL: tecMotif,
                    placeholder: "Motif",
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
                    enabledCellsTextStyle: const TextStyle(color: Colors.white),
                    selectedCellTextStyle: const TextStyle(color: Colors.white),
                    currentDateTextStyle: const TextStyle(color: Colors.white),
                    leadingDateTextStyle: const TextStyle(color: Colors.white),
                    centerLeadingDate: true,
                    initialDate: DateTime.now(),
                    minDate:
                        DateTime(DateTime.now().year, DateTime.now().month, 1),
                    maxDate: DateTime(
                        DateTime.now().year, DateTime.now().month + 1, 0),
                    onDateSelected: (valueDate) {
                      setState(
                        () {
                          datePaiementSelectionner = valueDate;
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
                  //Bouton validation formulaire
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: BoutonCustom(
                      onpressed: () {
                        BlocProvider.of<AjoutPaiementBloc>(context).add(
                          APEventCreate(
                            tecMotif.text,
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
        );
      },
    );
  }
}
