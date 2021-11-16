import 'package:flutter/material.dart';

String shiftEmail(String str) {
  List listEmail = str.split('');
  for (int i = 0; i < 4; i++) {
    listEmail[i] = '*';
  }
  str = listEmail.join();
  return str;
}

double myPhoneWidth(context) {
  return MediaQuery.of(context).size.width;
}

double myPhoneHeight(context) {
  return MediaQuery.of(context).size.height;
}

void scrollToSpecificPos(GlobalKey myKey) {
  Scrollable.ensureVisible(myKey.currentContext);
}
