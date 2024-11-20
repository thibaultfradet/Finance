import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_bloc.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_event.dart';
import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_state.dart';
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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AjoutPaiementBloc, AjoutpaiementState>(
      builder: (BuildContext context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF151433),
          appBar: AppBar(
            title: const Text("Ajouter un paiement"),
            backgroundColor: const Color(0xFF151433),
          ),
          body: Center(
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
                ),

                const Verticalmargin(ratio: 0.05),
                DatePicker(
                  centerLeadingDate: true,
                  initialDate: DateTime.now(),
                  minDate: DateTime.now().add(const Duration(days: 7)),
                  maxDate: DateTime.now().subtract(const Duration(days: 7)),
                  disabledDayPredicate: (date) {
                    return date.weekday == DateTime.sunday ||
                        date.weekday == DateTime.saturday;
                  },
                  disabledCellsDecoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                ),

                const Verticalmargin(ratio: 0.05),
                InputCustomPL(
                  controllerPL: tecCommentaire,
                  placeholder: "Commentaire",
                ),

                //Bouton validation formulaire
                BoutonCustom(
                  onpressed: () {
                    BlocProvider.of<AjoutPaiementBloc>(context).add(
                      APEventCreate(tecMotif.text, tecMontant.text, date,
                          tecCommentaire.text)!,
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
