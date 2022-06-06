import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_line/models/favoris.dart';
import 'package:food_line/services/favoris_repo.dart';
import 'package:food_line/utils/colors.dart';
import 'package:food_line/utils/functions.dart';
import 'package:food_line/widgets/full_screen_widget.dart';
import 'package:food_line/widgets/my_button_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavorisScreen extends StatefulWidget {
  const FavorisScreen({Key? key}) : super(key: key);

  @override
  State<FavorisScreen> createState() => _FavorisScreenState();
}

class _FavorisScreenState extends State<FavorisScreen> {
  FavorisRepo favorisRepo = FavorisRepo();
  bool done = false;
  bool? result;
  Favoris? favoris;
  getFavoris() async {
    var data = await favorisRepo.getFavoris();
    result = data['result'];
    if (result!) {
      favoris = data['data'];
    }

    setState(() {
      done = true;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getFavoris();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: !done
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  const FullScreenForStackWidget(),
                  Positioned(
                    top: 44.h,
                    left: 158.w,
                    child: Text(
                      'Favoris',
                      style: TextStyle(
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  !result!
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'icons/love_grey.svg',
                                height: 51.62.h,
                                width: 58.82.w,
                              ),
                              SizedBox(
                                height: 22.4.h,
                              ),
                              Text(
                                'Vous n\'avez aucun favoris',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xffAFAFAF),
                                ),
                              )
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.only(
                              top: 120.h, left: 32.w, right: 12.w),
                          itemCount: favoris?.results?.length ?? 0,
                          itemBuilder: (context, index) => ListTile(
                            trailing: Padding(
                              padding: EdgeInsets.only(top: 12.h),
                              child: Column(
                                children: [
                                  Text(
                                      '${favoris!.results?[index].restaurant?[0].ville}'),
                                  Text(
                                      '${favoris!.results?[index].restaurant?[0].pays}')
                                ],
                              ),
                            ),
                            subtitle: Text(
                              '${favoris!.results?[index].restaurant?[0].description}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            title: Text(
                                '${favoris!.results?[index].restaurant?[0].titre}'),
                            leading: Image.network(
                              favoris!.results?[index].restaurant?[0].logo ??
                                  '',
                              height: 50.h,
                              width: 50.w,
                            ),
                          ),
                        ),
                  Positioned(
                    top: 36.h,
                    left: 36.w,
                    child: MyWidgetButton(
                        widget: const Center(
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        }),
                  ),
                ],
              ),
      ),
    );
  }
}
