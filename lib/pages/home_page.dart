import 'package:english_app/values/app_assets.dart';
import 'package:english_app/values/app_colors.dart';
import 'package:english_app/values/app_styles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.secondColor,
        title: Container(
          alignment: AlignmentDirectional.centerStart,
          child: Text('English today',
              style: AppStyle.h3.copyWith(color: AppColor.textColor)),
        ),
        leadingWidth: 40,
        leading: InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10),
              child: Image.asset(AppAssets.menu),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("refresh");
        },
        child: Image.asset(AppAssets.refresh),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            alignment: Alignment.center,
            child: Text(
              '\"It is amazing how complete is the delusion that beauty is goodness\"',
              style: AppStyle.h5.copyWith(
                color: AppColor.textColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
