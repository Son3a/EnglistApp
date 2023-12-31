// ignore_for_file: depend_on_referenced_packages

import 'dart:math';

import 'package:english_app/pages/control_page.dart';
import 'package:english_app/values/app_assets.dart';
import 'package:english_app/values/app_colors.dart';
import 'package:english_app/values/app_styles.dart';
import 'package:english_app/values/share_keys.dart';
import 'package:english_app/widgets/app_button.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/english.dart';
import 'all_words_page.dart';
import 'package:like_button/like_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late PageController _pageController;
  List<EnglishWord> words = [];
  late SharedPreferences _sharedPreferencespre;
  late int _counter;

  List<int> fixedListRandom({int len = 1, int max = 20, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }

    List<int> newLists = [];

    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newLists.contains(val)) {
        continue;
      } else {
        newLists.add(val);
        count++;
      }
    }

    return newLists;
  }

  getEnglishWord(int len) {
    List<String> newLists = [];
    List<int> randoms = fixedListRandom(len: len, max: nouns.length);
    randoms.forEach((index) {
      newLists.add(nouns[index]);
    });

    words = newLists.map((e) => EnglishWord(noun: e)).toList();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  void init() async {
    _pageController = PageController(viewportFraction: 0.9);
    _sharedPreferencespre = await SharedPreferences.getInstance();
    setState(() {
      _counter = _sharedPreferencespre.getInt(ShareKey.AMOUNT_WORD) ?? 5;
      getEnglishWord(_counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColor.secondColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColor.secondColor,
        title: Container(
          alignment: AlignmentDirectional.centerStart,
          child: Text('English today',
              style: AppStyle.h3.copyWith(color: AppColor.textColor)),
        ),
        leadingWidth: 40,
        leading: InkWell(
            onTap: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(left: 10),
              child: Image.asset(AppAssets.menu),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter = _sharedPreferencespre.getInt(ShareKey.AMOUNT_WORD) ?? 5;
            getEnglishWord(_counter);
          });
        },
        backgroundColor: AppColor.primaryColor,
        child: Image.asset(
          AppAssets.refresh,
          color: AppColor.textColor,
          width: 35,
        ),
      ),
      body: Container(
        // margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: size.height * 1 / 10,
              alignment: Alignment.center,
              child: Text(
                '\"It is amazing how complete is the delusion that beauty is goodness\"',
                style: AppStyle.h5.copyWith(
                  color: AppColor.textColor,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 2 / 3,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 6,
                onPageChanged: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  String firstLetter = words[index].noun!.substring(0, 1);
                  String leftLetter = words[index].noun!.substring(1);

                  return Container(
                    margin: const EdgeInsets.only(right: 10, bottom: 8),
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: AppColor.primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(3, 6),
                              blurRadius: 3)
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(24))),
                    child: index == 5
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllWordsPage(words: words)));
                            },
                            splashColor: Colors.black38,
                            child: Center(
                              child: Text(
                                'Show more...',
                                style: AppStyle.h3.copyWith(shadows: [
                                  const BoxShadow(
                                      color: Colors.black38,
                                      offset: Offset(2, 3),
                                      blurRadius: 3)
                                ]),
                              ),
                            ))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: LikeButton(
                                      onTap: (bool isLiked) async {
                                        setState(() {
                                          words[index].isFavorite =
                                              !words[index].isFavorite;
                                        });
                                        return words[index].isFavorite;
                                      },
                                      size: 70,
                                      isLiked: words[index].isFavorite,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      circleColor: const CircleColor(
                                          start: Color(0xff00ddff),
                                          end: Color(0xff0099cc)),
                                      bubblesColor: const BubblesColor(
                                        dotPrimaryColor: Color(0xff33b5e5),
                                        dotSecondaryColor: Color(0xff0099cc),
                                      ),
                                      likeBuilder: (bool isLiked) {
                                        return ImageIcon(
                                          const AssetImage(AppAssets.favorite),
                                          color: isLiked
                                              ? Colors.red
                                              : AppColor.lightBlue,
                                        );
                                      },
                                    ),
                                  )),
                              Expanded(
                                flex: 2,
                                child: RichText(
                                    maxLines: 1,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                        text: firstLetter,
                                        style: const TextStyle(
                                            fontFamily: FontFamily.sen,
                                            fontSize: 90,
                                            fontWeight: FontWeight.bold,
                                            shadows: [
                                              BoxShadow(
                                                  color: Colors.black38,
                                                  offset: Offset(2, 6),
                                                  blurRadius: 6)
                                            ]),
                                        children: [
                                          TextSpan(
                                            text: leftLetter,
                                            style: const TextStyle(
                                                fontFamily: FontFamily.sen,
                                                fontSize: 60,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  BoxShadow(
                                                      color: Colors.black38,
                                                      offset: Offset(2, 6),
                                                      blurRadius: 6)
                                                ]),
                                          )
                                        ])),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  margin: const EdgeInsets.only(top: 20),
                                  child: Text(
                                    '\"Think of all the beauty still left around you and be happy\"',
                                    style: AppStyle.h3.copyWith(
                                      color: AppColor.textColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                  );
                },
              ),
            ),
            //indicator
            Container(
              // color: Colors.red,
              height: 12,
              margin: const EdgeInsets.only(top: 14, left: 20, right: 20),
              alignment: AlignmentDirectional.centerStart,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return buildIndicator(index == _currentIndex, size);
                  }),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          color: AppColor.lightBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(top: 50, bottom: 30),
                child: Text(
                  'Your mind',
                  style: AppStyle.h3.copyWith(color: AppColor.textColor),
                ),
              ),
              AppButton(
                  label: 'Favorites',
                  onTap: () {
                    //   ScaffoldMessenger.of(context).showSnackBar(
                    //       const SnackBar(content: Text('Favorite')));
                    // }
                    print("favorite");
                  }),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: AppButton(
                    label: 'Your control',
                    onTap: () {
                      print("your control");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ControlPage()));
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text('Your control')));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      // height: 20,
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(right: 20),
      width: isActive ? size.width * 1 / 5 : 24,
      decoration: BoxDecoration(
          color: isActive ? AppColor.lightBlue : AppColor.lightGrey,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }

  Widget buildShowMore() {
    return Container(
      alignment: AlignmentDirectional.centerStart,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        color: AppColor.primaryColor,
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AllWordsPage(words: words)));
            },
            splashColor: Colors.black38,
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                'Show more',
                style: AppStyle.h4
                    .copyWith(color: AppColor.textColor, fontSize: 20),
              ),
            )),
      ),
    );
  }
}
