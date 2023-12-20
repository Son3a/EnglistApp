// ignore_for_file: depend_on_referenced_packages

import 'package:english_app/values/app_assets.dart';
import 'package:english_app/values/app_colors.dart';
import 'package:english_app/values/app_styles.dart';
import 'package:english_app/values/share_keys.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  late int sliderValue;
  late SharedPreferences sharedPreferences;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  void init() async {
    sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      sliderValue = sharedPreferences.getInt(ShareKey.AMOUNT_WORD) ?? 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.secondColor,
        leading: Container(
          margin: const EdgeInsets.only(top: 30, left: 10),
          child: InkWell(
            onTap: () async {
              await sharedPreferences.setInt(
                  ShareKey.AMOUNT_WORD, sliderValue.toInt());
              Navigator.pop(context);
            },
            child: Image.asset(
              AppAssets.back,
              color: AppColor.textColor,
            ),
          ),
        ),
        leadingWidth: 40,
        title: Container(
            margin: const EdgeInsets.only(top: 30),
            child: Text(
              'Your control',
              style: AppStyle.h3.copyWith(color: AppColor.textColor),
            )),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 30, right: 30, top: 50),
            child: Text(
              'How much a number word at onece',
              style:
              AppStyle.h5.copyWith(color: AppColor.greyText, fontSize: 20),
            ),
          ),
          Text(
            '${sliderValue.toInt()}',
            style: AppStyle.h1.copyWith(
                color: AppColor.primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 150),
          ),
          Slider(
              activeColor: AppColor.primaryColor,
              inactiveColor: AppColor.primaryColor,
              value: sliderValue.toDouble(),
              max: 100,
              min: 5,
              divisions: 95,
              onChanged: (value) {
                setState(() {
                  sliderValue = value.toInt();
                });
              })
        ],
      ),
    );
  }
}
