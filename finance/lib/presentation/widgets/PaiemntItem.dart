import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:finance/domain/Paiement.dart';

class PaiementItem extends StatefulWidget {
  final Paiement item;
  const PaiementItem({super.key, required this.item});

  @override
  State<PaiementItem> createState() => _PaiementItemState();
}

class _PaiementItemState extends State<PaiementItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.1,
        child: Row(
          children: [
            //Colonne titre/date
            Column(children: [
              Text(widget.item.motif,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
              Text(widget.item.datePaiement.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ))
            ]),
            //Container montant
            Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.item.montant.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
          ],
        ));
  }
}
