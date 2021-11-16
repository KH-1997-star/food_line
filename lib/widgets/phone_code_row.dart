import 'package:flutter/material.dart';
import 'package:food_line/utils/consts.dart';

class PhoneCodeRow extends StatefulWidget {
  final Function(String) onFirstContainer;
  final Function(String) onSecondContainer;
  final Function(String) onThirdContainer;
  final Function(String) onFourthContainer;

  PhoneCodeRow({
    this.onFirstContainer,
    this.onFourthContainer,
    this.onSecondContainer,
    this.onThirdContainer,
  });

  @override
  _PhoneCodeRowState createState() => _PhoneCodeRowState();
}

class _PhoneCodeRowState extends State<PhoneCodeRow> {
  bool firstautoFocused = true;
  bool secondautoFocused = false;
  bool thirdautoFocused = false;
  bool fourthautoFocused = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 51,
          child: TextFormField(
            autofocus: firstautoFocused,
            validator: (val) => val.isEmpty ? 'champ vide' : null,
            keyboardType: TextInputType.number,
            onChanged: (val) {
              widget.onFirstContainer(val);
            },
            onFieldSubmitted: (val) {
              if (val != '') {
                setState(() {
                  secondautoFocused = true;
                });
              }
            },
            maxLength: 1,
            decoration: InputDecoration(
                fillColor: Color(0xffeeeeee),
                filled: true,
                counterText: '',
                enabledBorder: UnderlineInputBorder(
                  borderSide: myBorderSide,
                )),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 51,
          child: TextFormField(
            autofocus: secondautoFocused,
            validator: (val) => val.isEmpty ? 'champ vide' : null,
            keyboardType: TextInputType.number,
            onChanged: (val) {
              widget.onSecondContainer(val);
            },
            onFieldSubmitted: (val) {
              if (val != '') {
                setState(() {
                  thirdautoFocused = true;
                });
              }
            },
            maxLength: 1,
            decoration: InputDecoration(
                fillColor: Color(0xffeeeeee),
                filled: true,
                counterText: '',
                enabledBorder: UnderlineInputBorder(
                  borderSide: myBorderSide,
                )),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 51,
          child: TextFormField(
            autofocus: thirdautoFocused,
            keyboardType: TextInputType.number,
            onFieldSubmitted: (val) {
              if (val != '') {
                setState(() {
                  fourthautoFocused = true;
                });
              }
            },
            validator: (val) => val.isEmpty ? 'champ vide' : null,
            onChanged: (val) {
              widget.onThirdContainer(val);
            },
            maxLength: 1,
            decoration: InputDecoration(
                fillColor: Color(0xffeeeeee),
                filled: true,
                counterText: '',
                enabledBorder: UnderlineInputBorder(
                  borderSide: myBorderSide,
                )),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        SizedBox(
          width: 51,
          child: TextFormField(
            autofocus: fourthautoFocused,
            validator: (val) => val.isEmpty ? 'champ vide' : null,
            keyboardType: TextInputType.number,
            onChanged: (val) {
              widget.onFourthContainer(val);
            },
            maxLength: 1,
            decoration: InputDecoration(
              fillColor: Color(0xffeeeeee),
              filled: true,
              counterText: '',
              enabledBorder: UnderlineInputBorder(
                borderSide: myBorderSide,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
