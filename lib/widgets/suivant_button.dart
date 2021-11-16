import 'package:flutter/material.dart';

class SuivantButton extends StatelessWidget {
  final VoidCallback onSuivantPressed;
  SuivantButton({this.onSuivantPressed});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: TextButton(
            onPressed: () {
              onSuivantPressed();
            },
            child: Text(
              'Suivant',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(
                  0xffFFC529,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
