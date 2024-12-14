import 'package:finance/presentation/blocs/tout_paiement/tout_paiement_bloc.dart';
import 'package:finance/presentation/blocs/tout_paiement/tout_paiement_event.dart';
import 'package:finance/presentation/blocs/tout_paiement/tout_paiement_state.dart';
import 'package:finance/presentation/widgets/paiement_item.dart';
import 'package:finance/presentation/widgets/vertical_margin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToutPaiement extends StatefulWidget {
  const ToutPaiement({super.key});

  @override
  State<ToutPaiement> createState() => _ToutPaiementState();
}

class _ToutPaiementState extends State<ToutPaiement> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToutPaiementBloc()..add(ToutPaiementEvent()),
      child: BlocBuilder<ToutPaiementBloc, ToutPaiementState>(
        builder: (BuildContext context, state) {
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
                // Contenu principal
                if (state is ToutPaiementStateInitial)
                  Center(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.collectionPaiement.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: Column(
                            children: [
                              PaiementItem(
                                item: state.collectionPaiement[index],
                              ),
                              const Verticalmargin(
                                ratio: 0.02,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                // Loader superposé
                if (state is ToutPaiementLoading)
                  const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
