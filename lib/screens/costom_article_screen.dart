import 'package:flutter/material.dart';

class CostumArticleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map data = ModalRoute.of(context).settings.arguments;
    print(data);
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
