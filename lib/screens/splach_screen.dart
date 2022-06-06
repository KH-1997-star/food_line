
import 'package:flutter/material.dart'; 
import 'package:food_line/widgets/my_button_widget.dart'; 

class SplachScreen extends StatefulWidget {
  const SplachScreen({Key? key}) : super(key: key);

  @override
  _SplachScreenState createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MyWidgetButton(
          widget: const Text(
            'data',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w800,
            ),
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
