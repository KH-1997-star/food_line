import 'package:flutter/material.dart';
import 'package:food_line/utils/consts.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/circular_indicator.dart';

class FastFoodWidget extends StatelessWidget {
  final String groupeTitle;
  final String title;
  final String subTitle;
  final double price;
  final String imagePath;
  final int lenght;
  FastFoodWidget({
    this.lenght,
    this.groupeTitle,
    this.imagePath,
    this.price,
    this.subTitle,
    this.title,
  });
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(
        key: Key('2'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              groupeTitle,
              style: bold,
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () => Navigator.pushNamed(
                      context, '/costum_article_screen',
                      arguments: {'index': i, 'title': groupeTitle}),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                width: 190,
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    title,
                                    style: semiBold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: 230,
                                  child: Text(
                                    subTitle,
                                    style: subsemiBold.copyWith(
                                      height: 1.2,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '$price £',
                                  style: bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: myPhoneWidth(context) - 360,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 80,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: FittedBox(
                                      child: Image.asset(
                                        imagePath,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                FittedBox(child: CircularIndicatorWidget()),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 0.5,
                        color: Colors.grey[600],
                        height: 2.5,
                      ),
                    ],
                  ),
                );
              },
              itemCount: lenght,
            ),
          ),
        ],
      ),
    );
  }
}
