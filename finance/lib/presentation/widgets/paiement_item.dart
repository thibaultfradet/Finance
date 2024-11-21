import 'package:finance/presentation/widgets/horizontal_margin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:finance/domain/models/paiement.dart';

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
      width: MediaQuery.of(context).size.width * 0.89,
      decoration: BoxDecoration(
        // color: Colors.white,
        color: const Color(0xFF151433),
        border: Border.all(width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      //Row de tout l'item
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: 50,
            height: 50,
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
              child: Icon(CupertinoIcons.cart, size: 30),
            ),
          ),
          const Horirontalmargin(ratio: 0.025),
          //Colonne titre/date
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  widget.item.motif,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${widget.item.datePaiement.year}/${widget.item.datePaiement.month.toString().padLeft(2, '0')}/${widget.item.datePaiement.day.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          const Horirontalmargin(ratio: 0.1),

          //Container montant
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.height * 0.05,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.5),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${widget.item.montant} €",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
