import 'package:finance/presentation/blocs/ajout_paiement/ajout_paiement_bloc.dart';
import 'package:finance/presentation/blocs/compte/compte_bloc.dart';
import 'package:finance/presentation/blocs/detail_paiement/detail_paiement_bloc.dart';
import 'package:finance/presentation/blocs/statistique/statistique_bloc.dart';
import 'package:finance/presentation/blocs/tout_paiement/tout_paiement_bloc.dart';
import 'package:finance/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:finance/firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/presentation/blocs/home/home_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (_) => HomeBloc(),
        ),
        BlocProvider<AjoutPaiementBloc>(
          create: (_) => AjoutPaiementBloc(),
        ),
        BlocProvider<StatistiqueBloc>(
          create: (_) => StatistiqueBloc(),
        ),
        BlocProvider<CompteBloc>(
          create: (_) => CompteBloc(),
        ),
        BlocProvider<DetailPaiementBloc>(
          create: (_) => DetailPaiementBloc(),
        ),
        BlocProvider<ToutPaiementBloc>(
          create: (_) => ToutPaiementBloc(),
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'finance',
      home: Home(),
    );
  }
}
