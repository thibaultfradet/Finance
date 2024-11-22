import 'package:finance/presentation/blocs/home/home_event.dart';
import 'package:finance/presentation/pages/ajout_paiement.dart';
import 'package:finance/presentation/widgets/paiement_item.dart';
import 'package:finance/presentation/widgets/vertical_margin.dart';
import 'package:finance/presentation/widgets/horizontal_margin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/presentation/blocs/home/home_bloc.dart';
import 'package:finance/presentation/blocs/home/home_state.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc()..add(HomeEvent()),
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFF151433),
            appBar: AppBar(
              backgroundColor: const Color(0xFF151433),
              title: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20,
                    child: Icon(Icons.person, size: 30),
                  ),
                  Horirontalmargin(ratio: 0.02),
                  Text(
                    "Bienvenue Tibo",
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.chart_bar_alt_fill,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    //Envoie vers l'utilisateur sur la page ajout d'un paiement
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AjoutPaiement(),
                      ),
                    );
                  },
                ),
                //Bouton ajout paiement
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white, size: 30),
                  onPressed: () {
                    //Envoie vers l'utilisateur sur la page ajout d'un paiement
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AjoutPaiement(),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: Stack(
              children: [
                // Contenu principal
                if (state is HomeStateInitial)
                  Center(
                    //Colonne de l'app
                    child: Column(
                      children: [
                        const Verticalmargin(ratio: 0.02),
                        //partie haute avec cercle info générale de ce mois-ci
                        Container(
                          color: const Color(0xFF151433),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.30,
                          child: Center(
                            // Centrer le cercle
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  //diametre externe
                                  width: 250,
                                  height: 250,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.grey.withOpacity(0.1),
                                        Colors.grey.withOpacity(0.5),
                                      ],
                                    ),
                                  ),
                                ),
                                // Cercle intérieur blanc
                                CircleAvatar(
                                  backgroundColor: const Color(0xFF151433),
                                  radius: 100,
                                  child: Text(
                                    '${state.totalMois.toStringAsFixed(2)} €',
                                    style: const TextStyle(
                                      fontSize: 26,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const Verticalmargin(ratio: 0.03),

                        // Partie basse avec la liste des transactions
                        Container(
                          color: const Color(0xFF221F4A),
                          height: MediaQuery.of(context).size.height * 0.541,
                          child: Column(
                            children: [
                              const Verticalmargin(ratio: 0.03),
                              const Text(
                                "Listes des transactions ce mois",
                                style: TextStyle(
                                  fontSize: 26,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Verticalmargin(ratio: 0.02),
                              state.collectionPaiement.isEmpty
                                  ? const Text(
                                      "Aucun paiement n'a été trouvé pour ce mois-ci",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    )
                                  : SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount:
                                            state.collectionPaiement.length,
                                        itemBuilder: (context, index) {
                                          return SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.90,
                                            child: Column(
                                              children: [
                                                PaiementItem(
                                                  item:
                                                      state.collectionPaiement[
                                                          index],
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                // Loader superposé
                if (state is HomeLoading)
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
