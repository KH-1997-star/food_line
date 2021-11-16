import 'dart:async';
import 'package:flutter/material.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/utils/my_colors.dart';
import 'package:food_line/widgets/fast_food_widget.dart';
import 'package:food_line/widgets/my_first_animated_menu_widget.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // cette widget ce trouve dans le fichier my_first_animated_menu_widget.dart
  Widget myWidget = MyFirstAnimatedMenuWidget();
  int currentIndex = 1;
  int index;
  bool noAppBar;
  final burgerKey = new GlobalKey();
  final pizzaKey = new GlobalKey();
  final paniniKey = new GlobalKey();
  final saladeKey = new GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
    noAppBar = false;
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(milliseconds: 3000),
        () => setState(() {
              // cette widget ce trouve dans le fichier my_second_animated_menu_widget.dart
              myWidget = SizedBox(
                key: burgerKey,
                child: FastFoodWidget(
                  groupeTitle: 'Burgers',
                  title: 'Menu Burger Chiken',
                  imagePath: 'assets/images/13_burgers.png',
                  subTitle:
                      '1 SUB15 Bœuf pastrami(chiffonade de bœuf au poivre)+ 1 boisson 50 c',
                  price: 4.1,
                  lenght: 3,
                ),
              );
              noAppBar = true;
            }));
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: !noAppBar
            ? null
            : AppBar(
                toolbarHeight: 150,
                actions: [
                  IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/images/Menu.png'))
                ],
                backgroundColor: Colors.white,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          index = 0;
                          scrollToSpecificPos(burgerKey);
                        });
                      },
                      child: Tab(
                        child: Container(
                          color: index == 0 ? yellowPrincipal : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Burgers',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index = 1;
                          scrollToSpecificPos(pizzaKey);
                        });
                      },
                      child: Tab(
                        child: Container(
                          color: index == 1 ? yellowPrincipal : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Pizzas',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index = 2;
                          scrollToSpecificPos(paniniKey);
                        });
                      },
                      child: Tab(
                        child: Container(
                          color: index == 2 ? yellowPrincipal : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Paninis',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          index = 3;
                          scrollToSpecificPos(saladeKey);
                        });
                      },
                      child: Tab(
                        child: Container(
                          color: index == 3 ? yellowPrincipal : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Saldes',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
        backgroundColor: Color(0xffE9E9E9),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                color: Colors.white,
              ),
              AnimatedSwitcher(
                duration: Duration(
                  milliseconds: 1000,
                ),
                child: myWidget,
              ),
              !noAppBar
                  ? SizedBox(
                      key: burgerKey,
                      child: FastFoodWidget(
                        groupeTitle: 'Burgers',
                        title: 'Menu Burger Chiken',
                        imagePath: 'assets/images/13_burgers.png',
                        subTitle:
                            '1 SUB15 Bœuf pastrami(chiffonade de bœuf au poivre)+ 1 boisson 50 c',
                        price: 4.1,
                        lenght: 3,
                      ),
                    )
                  : Container(
                      height: 0,
                    ),
              SizedBox(
                key: pizzaKey,
                child: FastFoodWidget(
                  groupeTitle: 'Pizza',
                  title: 'Menu Burger Chiken',
                  imagePath: 'assets/images/pizza.png',
                  subTitle:
                      '1 SUB15 Bœuf pastrami(chiffonade de bœuf au poivre)+ 1 boisson 50 c',
                  price: 4.1,
                  lenght: 3,
                ),
              ),
              SizedBox(
                key: saladeKey,
                child: FastFoodWidget(
                  groupeTitle: 'Salades',
                  title: 'Menu Burger Chiken',
                  imagePath: 'assets/images/salade.png',
                  subTitle:
                      '1 SUB15 Bœuf pastrami(chiffonade de bœuf au poivre)+ 1 boisson 50 c',
                  price: 4.1,
                  lenght: 3,
                ),
              ),
              SizedBox(
                key: paniniKey,
                child: FastFoodWidget(
                  groupeTitle: 'Panini',
                  title: 'Menu Burger Chiken',
                  imagePath: 'assets/images/panini.jfif',
                  subTitle:
                      '1 SUB15 Bœuf pastrami(chiffonade de bœuf au poivre)+ 1 boisson 50 c',
                  price: 4.1,
                  lenght: 3,
                ),
              ),
              SizedBox(
                height: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
