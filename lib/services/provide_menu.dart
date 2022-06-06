import 'package:flutter/foundation.dart';

class MyCounter with ChangeNotifier {
  List mymenuList = [];

  List get myList => mymenuList;

  void addTags(String tag) {
    mymenuList.add(tag);
    print(mymenuList);
    notifyListeners();
  }

  void removeTags(String tag) {
    mymenuList.remove(tag);
    notifyListeners();
  }

  void clearTagList() {
    mymenuList = [];
    notifyListeners();
  }

  List getMList() {
    notifyListeners();
    print('€€€€€€€€€€€€€€€€€€€€€€€€');
    print(mymenuList);
    print('€€€€€€€€€€€€€€€€€€€€€€€€');
    return mymenuList;
  }
}
