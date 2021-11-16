import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/screens/glam_you_app.dart';
import 'package:food_line/utils/consts.dart';
import 'package:food_line/widgets/carousel.dart';
import 'package:food_line/widgets/menu_horizental_widget.dart';
import 'package:food_line/widgets/menu_vertical_widget.dart';
import 'package:food_line/widgets/plats_widget.dart';
import 'package:food_line/widgets/promos_widget.dart';
import 'package:food_line/widgets/search_widget.dart';
import 'package:food_line/widgets/sponsor_widget.dart';

class RestoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/images/notification.svg'),
          ),
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/plus_screen'),
            icon: SvgPicture.asset('assets/images/Menu.svg'),
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          //le code de cette widget ce trouve dans le fichier search_widget.dart
          SearchWidget(
            hintText: 'Plats,restaurants ou, type de cuisine',
            prefixIcon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset('assets/images/Search.svg'),
            ),
            sufixIcon: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/images/Groupe.svg',
              ),
            ),
            onSearchTap: () =>
                Navigator.pushNamed(context, '/the_searching_screen'),
          ),
          SizedBox(
            height: 20,
          ),
          //le code de cette widget ce trouve dans le fichier plats_widget.dart
          PlatWidget(
            myPlatList: myListViewMap,
          ),
          //le code de cette widget ce trouve dans le fichier promos_widget.dart
          PromosWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 26,
            ),
            child: Text('Promos', style: bold),
          ),
          //le code de cette widget ce trouve dans le fichier carousel.dart
          MyCarousel(
            myWidget: InkWell(
              child: SponsorWidget(),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GlamYouApp(),
                ),
              ),
            ), //le code de cette widget ce trouve dans le fichier sponsor_widget.dart
            rep: 4,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 26,
            ),
            child: Text(
              'Espace sponsorisé',
              style: bold,
            ),
          ),
          //le code de cette widget ce trouve dans le fichier menu_horizantal_widget.dart
          MenuHorizentaleWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 26,
            ),
            child: Text(
              'Les resto',
              style: bold,
            ),
          ),
          //le code de cette widget ce trouve dans le fichier menu_vertical_widget.dart
          MenuVerticaleWidget(
            i: 0,
          ),
          MenuVerticaleWidget(
            i: 1,
          ),
          SizedBox(
            height: 300,
          ),
        ],
      ),
    );
  }
}
