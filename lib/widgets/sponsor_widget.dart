import 'package:flutter/material.dart';
import 'package:food_line/utils/my_colors.dart';

class SponsorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 5, top: 0, right: 5, bottom: 20),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            color: Colors.grey[300],
            offset: Offset(5, 20.0),
            blurRadius: 5.0,
            spreadRadius: 5)
      ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Beff & Salad'),
                  Text('par Beffy & Joins'),
                  SizedBox(
                    height: 50,
                  ),
                  Text('£ 25.5'),
                  SizedBox(
                    height: 7,
                  ),
                  Container(
                    height: 31,
                    width: 130,
                    color: yellowPrincipal,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Ajouter au panier',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Image.asset('assets/images/Food5.png'),
            ),
          )
        ],
      ),
    );
  }
}
