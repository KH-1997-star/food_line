import 'package:flutter/material.dart';

import 'package:food_line/utils/functions.dart';
import 'package:food_line/utils/my_colors.dart';
import 'package:food_line/widgets/my_list_tile_widget.dart';

class PlusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowPrincipal,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: myPhoneHeight(context) / 6, horizontal: 10),
            child: Column(
              children: [
                ListTile(
                  leading: Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      color: Colors.white,
                    ),
                    child: Image.asset('assets/images/apic.png'),
                  ),
                  title: Text('Iheb Sassi'),
                  subtitle: Text('Details du Compte'),
                  trailing: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close,
                      size: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: myPhoneHeight(context) / 12,
                ),
                MyListTileWidget(
                  svgIconPath: 'assets/images/icon.svg',
                  title: 'Acuille',
                  myFunction: () {},
                ),
                MyListTileWidget(
                  svgIconPath: 'assets/images/chariot.svg',
                  title: 'Mes Commandes',
                  myFunction: () {},
                ),
                MyListTileWidget(
                  svgIconPath: 'assets/images/pocket.svg',
                  title: 'Moyens de Paiement',
                  myFunction: () {},
                ),
                MyListTileWidget(
                  svgIconPath: 'assets/images/Settings.svg',
                  title: 'Réglage',
                  myFunction: () {},
                ),
                MyListTileWidget(
                  svgIconPath: 'assets/images/Location.svg',
                  title: 'Adresses Enregistrées',
                  myFunction: () {},
                ),
                MyListTileWidget(
                  svgIconPath: 'assets/images/propos.svg',
                  title: 'A propos de',
                  myFunction: () {},
                ),
              ],
            ),
          ),
          Positioned(
            left: myPhoneWidth(context) / 1.5,
            top: myPhoneHeight(context) / 4,
            child: Image.asset('assets/images/phone.png'),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Se Deconnecter',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
