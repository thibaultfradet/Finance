import 'package:finance/presentation/blocs/home/home_event.dart';
import 'package:finance/presentation/widgets/PaiemntItem.dart';
import 'package:finance/presentation/widgets/VerticalMargin.dart';
import 'package:finance/presentation/widgets/HorizontalMargin.dart';
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
          if (state is HomeStateInitial) {
            return Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                //Row de l'AppBar
                title: const Row(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 20,
                        child: Icon(Icons.person, size: 30)),
                    HorizontalMargin(ratio: 0.04),
                    Text("Bienvenue Tibo",
                        style: const TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
              ),
              body: Center(
                //Colonne du reste de l'app
                child: Column(
                  children: [
                    //Stat argent depasser ce mois-ci
                    Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 150,
                            child: Text(state.totalMois.toString() + " €",
                                style: const TextStyle(
                                  fontSize: 26,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                )))),
                    //espace entre les deux
                    VerticalMargin(ratio: 0.02),
                    //Colonne détail des transaction
                    Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: Column(
                        children: [
                          const Text("Listes des transactions ce mois",
                              style: const TextStyle(
                                fontSize: 26,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )),
                          VerticalMargin(ratio: 0.02),
                          //Si la liste des transactions est vide on préviens l'utilisateur sinon on affiche la liste
                          //Pour chaque paiement on affiche un items custom avec un items paiement en paramètre
                          state.collectionPaiement.length == 0
                              ? Text(
                                  "Aucun paiement n'a été trouver pour ce mois-ci",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ))
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.collectionPaiement.length,
                                  itemBuilder: (context, index) {
                                    return PaiementItem(
                                        item: state.collectionPaiement[index]);
                                  })
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text("Une erreur est survenue."));
          }
        }));
  }
}
