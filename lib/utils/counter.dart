import 'package:flutter/foundation.dart';

class MyCounter with ChangeNotifier {
  List myTagsList = [];

  List get myList => myTagsList;

  void addTags(String tag) {
    myTagsList.add(tag);
    print(myTagsList);
    notifyListeners();
  }

  void removeTags(String tag) {
    myTagsList.remove(tag);
    notifyListeners();
  }

  void clearTagList() {
    myTagsList = [];
    notifyListeners();
  }

  List getMList() {
    notifyListeners();
    print('€€€€€€€€€€€€€€€€€€€€€€€€');
    print(myTagsList);
    print('€€€€€€€€€€€€€€€€€€€€€€€€');
    return myTagsList;
  }
}
