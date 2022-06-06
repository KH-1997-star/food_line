import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toast/toast.dart';

class Affiche_grille extends StatefulWidget {
  final Function(
    String,
    bool,
  )? onMenuChoose;
  final bool Function() onChecked;
  bool? checked;
  String? prix;
  final String? supp;
  final String? qtmax;
  final String? qtSelected;
  final Function(int v)? onSelect;
  bool stopChecking;
  Affiche_grille(
      {Key? key,
      this.prix,
      this.qtSelected,
      this.onSelect,
      this.stopChecking = false,
      required this.onMenuChoose,
      this.qtmax,
      this.checked = false,
      this.supp,
      required this.onChecked})
      : super(key: key);

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

int? selectedRadio;
int _groupValue = -1;

class _QuestionWidgetState extends State<Affiche_grille> {
  late bool checked;
  get my_black => null;

  @override
  void initState() {
    super.initState();
    checked = widget.checked!;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.stopChecking) {
          //setState(() => checked = !checked);
          setState(() {
            checked = widget.onChecked();
          });
          print("hellloooo======>  $checked");
          if (checked) {
            widget.onMenuChoose!(widget.supp!, true);

            widget.onSelect!(1);
          } else {
            widget.onMenuChoose!(widget.supp!, false);
            widget.onSelect!(-1);
          }
        } else if (checked) {
          setState(() => checked = false);
          widget.onMenuChoose!(widget.supp!, false);
          widget.onSelect!(-1);
        } else {
          Toast.show("Vous avez dépssé le nombre max", context,
              duration: 1,
              gravity: 1,
              backgroundColor: Colors.grey.withOpacity(0.5));
        }
      },
      child: Container(
          height: 30.h,
          child: Row(
            children: [
              widget.checked!
                  ? Icon(
                      Icons.radio_button_checked,
                      size: 20.w,
                      color: my_black,
                    )
                  : Icon(
                      Icons.radio_button_unchecked,
                      size: 20.w,
                      color: my_black,
                    ),
              SizedBox(width: 15.w),
              SizedBox(
                  width: 200.w,
                  child: Text(
                    widget.supp!,
                    maxLines: 1,
                  )),
              Text(widget.prix == "0" || widget.prix == null
                  ? ""
                  : "+${widget.prix}€")
            ],
          )),
    );
  }
}
