import 'package:flutter/material.dart';
import 'package:food_line/utils/consts.dart';

class MenuHorizentaleWidget extends StatelessWidget {
  final Map myMenuInfo = {
    'imagePathList': [
      'assets/images/menu_food_one.png',
      'assets/images/menu_food_two.png',
    ],
    'titleList': [
      'Burger Factory',
      'Montluel Kebab',
    ],
    'subTitleList': [
      'Burgers /Pizzas/ Panini',
      'Burgers /Fast Food/ Salades',
    ]
  };

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/menu_screen'),
      
      child: SizedBox(
        height: 250,
        width: 100,
        child: ListView.builder(
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(myMenuInfo['imagePathList'][i]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          myMenuInfo['titleList'][i],
                          style: semiBold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 5, left: 10),
                        child: Text(
                          myMenuInfo['subTitleList'][i],
                          style: subsemiBold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: 2,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
