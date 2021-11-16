import 'package:flutter/material.dart';

class PlatWidget extends StatelessWidget {
  final Map myPlatList;
  PlatWidget({@required this.myPlatList});
  @override
  Widget build(BuildContext context) {
    List myLenght = myPlatList['images'];
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 26,
      ),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          itemBuilder: (context, i) {
            return Row(
              children: [
                Column(
                  children: [
                    Container(
                      height: 66,
                      width: 65,
                      child: Image.asset(
                        myPlatList['images'][i],
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    myPlatList['names'] != null
                        ? Text(
                            myPlatList['names'][i],
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        : Text(''),
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            );
          },
          itemCount: myLenght.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
