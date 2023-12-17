import 'package:english_app/pages/home_page.dart';
import 'package:english_app/values/app_assets.dart';
import 'package:english_app/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../values/app_styles.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return Scaffold(
        backgroundColor: AppColor.primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Welcome to',
                        style: AppStyle.h2,
                        textAlign: TextAlign.center,
                      ))),
              Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(bottom: 100),
                        child: Text(
                          'English',
                          style: AppStyle.h2.copyWith(
                              color: AppColor.blackGrey,
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 10),
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Quotes"',
                            style: AppStyle.h3,
                          )),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: RawMaterialButton(
                      shape: const CircleBorder(),
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                            (route) => false);
                      },
                      fillColor: AppColor.lightBlue,
                      child: Image.asset(
                        AppAssets.next,
                        width: 50,
                      ),
                    ),
                  ))
            ],
          ),
        ));
  }
}
