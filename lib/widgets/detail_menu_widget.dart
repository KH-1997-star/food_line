// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:food_line/models/detail_menu.dart';
// import 'package:food_line/models/liste_resto_model.dart';
// import 'package:food_line/screens/DetailsPlat/list_radio.dart';
// import 'package:food_line/screens/listeresto_repo.dart';
// import 'package:food_line/utils/colors.dart';
// import 'package:loading_indicator/loading_indicator.dart';
// import 'other_food_widget.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// final signInModelSignIn = ChangeNotifierProvider<RestoNotifier>(
//   (ref) => RestoNotifier(),
// );

// class DetailMenuWidget extends ConsumerStatefulWidget {
//   final id;
//   List<Taille>? listegar;
//   String? name;
//   //final FoodListWidget? foodlist;
//   DetailMenuWidget({this.id, this.listegar, this.name, Key? key})
//       : super(key: key);

//   @override
//   _DetailMenuWidgetState createState() => _DetailMenuWidgetState();
// }

// class _DetailMenuWidgetState extends ConsumerState<DetailMenuWidget> {
//   List menuList = [];
//   Map groupedList = Map<String, String>();
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Column(
//       children: [
//         Container(
//           height: 40,
//           color: my_white_grey,
//           width: size.width,
//           child: Row(
//             children: [
//               SizedBox(width: 36.w),
//               Text("Le burger de votre 1er menu :",
//                   style: TextStyle(
//                       color: my_black,
//                       fontFamily: "Roboto",
//                       fontSize: 13.sp,
//                       fontWeight: FontWeight.bold)),
//             ],
//           ),
//         ),
//         SizedBox(height: 10.h),
//         SizedBox(
//           width: 303.w,
//           child: ListView.builder(
//             padding: EdgeInsets.zero,

//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return Affiche_grille(
//                 onChecked: () {
                  
//                 },
//                 supp: "burger",
//                 onMenuChoose: (burger, add) {
//                   if (add) {
//                     menuList.add(burger);
//                   } else {
//                     menuList.remove(burger);
//                   }
//                   print(menuList.join(','));
//                 },
//               );
//             },
//             itemCount: 5,
//             // scrollDirection: Axis.vertical,
//             physics: NeverScrollableScrollPhysics(),
//           ),
//         ),
//       ],
//     );
//   }
// }
