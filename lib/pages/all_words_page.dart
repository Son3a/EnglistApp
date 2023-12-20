// ignore_for_file: depend_on_referenced_packages

import 'package:english_app/models/english.dart';
import 'package:flutter/material.dart';

import '../values/app_assets.dart';
import '../values/app_colors.dart';
import '../values/app_styles.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AllWordsPage extends StatelessWidget {
  final List<EnglishWord> words;

  const AllWordsPage({Key? key, required this.words}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.secondColor,
        title: Container(
          margin: const EdgeInsets.only(top: 16),
          alignment: AlignmentDirectional.centerStart,
          child: Text('English today',
              style: AppStyle.h3.copyWith(color: AppColor.textColor)),
        ),
        leadingWidth: 40,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10, top: 16),
              child: Image.asset(AppAssets.back),
            )),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 16),
        child: ListView.builder(
            itemCount: words.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  words[index].noun ?? '',
                  style: AppStyle.h4.copyWith(color: AppColor.textColor),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
                subtitle: Text(
                  '\"Think of all the beauty still left around you and be happy\"',
                  style: AppStyle.h5.copyWith(color: AppColor.greyText),
                ),
                leading: Image.asset(
                  AppAssets.favorite,
                  color: words[index].isFavorite
                      ? Colors.red
                      : AppColor.primaryColor,
                ),
              );
            }),
      ),
    );
  }
}
