import 'package:finance/presentation/blocs/statistique/statistique_bloc.dart';
import 'package:finance/presentation/blocs/statistique/statistique_event.dart';
import 'package:finance/presentation/blocs/statistique/statistique_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphic/graphic.dart';

class Statistique extends StatefulWidget {
  const Statistique({super.key});

  @override
  State<Statistique> createState() => _StatistiqueState();
}

class _StatistiqueState extends State<Statistique> {
  String? selectedStat;
  List<String> statPossible = [
    "Par catégorie ce mois-ci",
    "stat € total touts les mois"
  ];

  //démarrage de l'app => option de graph
  @override
  void initState() {
    super.initState();

    selectedStat =
        statPossible[0]; // Valeur par défaut: première valeur de la liste
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatistiqueBloc()..add(StatistiqueEvent()),
      child: BlocBuilder<StatistiqueBloc, StatistiqueState>(
        builder: (BuildContext context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: const Color(0xFF151433),
            appBar: AppBar(
              iconTheme: const IconThemeData(
                color: Colors.white,
              ),
              backgroundColor: const Color(0xFF151433),
              title: const Text(
                "Statistiques des paiements",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: Stack(
              children: [
                if (state is StatistiqueStateInitial)
                  Center(
                    child: Column(
                      children: [
                        //Drop down pour choisir la stat
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              dropdownColor: Colors.grey,
                              //par défaut premier élément possible
                              value: selectedStat,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              style: const TextStyle(color: Colors.white),
                              onChanged: (String? newValue) {
                                setState(
                                  () {
                                    selectedStat = newValue!;
                                  },
                                );
                              },
                              items: statPossible.map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color(0xFF221F4A), width: 3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width * 0.95,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Chart(
                              data: state.dictionnaireCategorieMontant,
                              variables: {
                                'genre': Variable(
                                  accessor: (Map map) => map['genre'] as String,
                                ),
                                'sold': Variable(
                                  accessor: (Map map) => map['sold'] as num,
                                ),
                              },
                              marks: [IntervalMark()],
                              axes: [
                                // Configuration des axes avec des labels personnalisés
                                AxisGuide(
                                  label: LabelStyle(
                                      textStyle: const TextStyle(fontSize: 16)),
                                ), // Axe horizontal
                                AxisGuide(
                                  label: LabelStyle(
                                      textStyle: const TextStyle(fontSize: 16)),
                                  grid: PaintStyle(
                                    strokeColor: Colors
                                        .white, // Couleur des lignes de la grille
                                  ),
                                ), // Axe vertical
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (state is StatistiqueLoading)
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
