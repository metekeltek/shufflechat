import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:shufflechat/ui/chat.dart';
import 'package:shufflechat/ui/settings.dart' as Settings;
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class ShuffleScreen extends StatefulWidget {
  @override
  _ShuffleScreenState createState() => _ShuffleScreenState();
}

class _ShuffleScreenState extends State<ShuffleScreen> {
  int selectedGender = 9;
  int selectedMinAge = 18;
  int selectedMaxAge = 60;
  List<dynamic> selectedIntrests = [];

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    final shuffleScreenWidget = this;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 30, right: 15, left: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SafeArea(
                        child: GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Image(
                                height: 42,
                                image: AssetImage(
                                    'assets/images/shuffleCoin+.png'),
                              ),
                              SizedBox(
                                width: 3,
                              ),
                              Text(
                                userData.shuffleCoins.toString(),
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SafeArea(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Settings.Settings(),
                            ),
                          ),
                          child: Icon(
                            Icons.settings,
                            color: Colors.black,
                            size: 35.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.6,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: const Color(0xffff9600),
                        ),
                        child: MaterialButton(
                          textColor: Colors.white,
                          onPressed: () {
                            List<String> filterArray = buildFilterArray(
                                selectedGender,
                                selectedMinAge,
                                selectedMaxAge,
                                selectedIntrests);
                            List<String> userDataArray =
                                buildUserDataArray(userData);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChatScreen(filterArray, userDataArray),
                              ),
                            );
                          },
                          child: Text(
                            'shuffle',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                userData.premium
                    ? SafeArea(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.1,
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0),
                            color: const Color(0xffff9600).withOpacity(0.2),
                          ),
                          child: Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.height / 3.2,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'genderFilter'.tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  Container(
                                    child: CustomRadioButton(
                                      wrapAlignment: WrapAlignment.center,
                                      elevation: 0,
                                      height: 40,
                                      width: 80,
                                      buttonTextStyle: ButtonTextStyle(
                                        selectedColor: Colors.white,
                                        unSelectedColor: Colors.white,
                                        textStyle: TextStyle(
                                          fontSize: 13,
                                        ),
                                      ),
                                      unSelectedColor: const Color(0xffffc069),
                                      unSelectedBorderColor:
                                          const Color(0xffffc069),
                                      selectedColor: const Color(0xffff9600),
                                      selectedBorderColor:
                                          const Color(0xffff9600),
                                      radioButtonValue: (value) {
                                        selectedGender = value;
                                      },
                                      buttonLables: [
                                        'any'.tr(),
                                        'female'.tr(),
                                        'male'.tr(),
                                        'diverse'.tr(),
                                      ],
                                      buttonValues: [
                                        9,
                                        0,
                                        1,
                                        2,
                                      ],
                                      spacing: 0,
                                      defaultSelected: 9,
                                      horizontal: false,
                                      enableButtonWrap: false,
                                      enableShape: true,
                                      absoluteZeroSpacing: false,
                                      padding: 1,
                                    ),
                                  ),
                                  Text(
                                    'ageFilter'.tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: FlutterSlider(
                                      rangeSlider: true,
                                      values: [
                                        selectedMinAge.toDouble(),
                                        selectedMaxAge.toDouble()
                                      ],
                                      min: 18,
                                      max: 60,
                                      onDragCompleted: (handlerIndex,
                                          lowerValue, upperValue) {
                                        selectedMinAge = lowerValue.round();
                                        selectedMaxAge = upperValue.round();
                                      },
                                      trackBar: FlutterSliderTrackBar(
                                          activeTrackBar: BoxDecoration(
                                              color: Color(0xffff9600))),
                                      tooltip: FlutterSliderTooltip(
                                          format: (value) {
                                            if (value == '60.0') {
                                              return '60+';
                                            }
                                            return value.replaceAll('.0', '');
                                          },
                                          positionOffset:
                                              FlutterSliderTooltipPositionOffset(
                                                  top: -10),
                                          textStyle: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17,
                                              color: Colors.white),
                                          boxStyle: FlutterSliderTooltipBox(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
                                                  color: Color(0xffffac38)
                                                      .withOpacity(0.9)))),
                                    ),
                                  ),
                                  Text(
                                    'intrestFilter'.tr(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: selectedIntrests.isEmpty
                                            ? Container()
                                            : Container(
                                                height: 38,
                                                width: 75,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30.0),
                                                  color:
                                                      const Color(0xffff9600),
                                                ),
                                                child: Center(
                                                  child: MaterialButton(
                                                    textColor: Colors.white,
                                                    onPressed: () {
                                                      selectedIntrests = [];
                                                      refresh();
                                                    },
                                                    child: Text(
                                                      'clear'.tr(),
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                      ),
                                      SizedBox(
                                        width: 7,
                                      ),
                                      Container(
                                        height: 38,
                                        width: 75,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                          color: const Color(0xffff9600),
                                        ),
                                        child: Center(
                                          child: MaterialButton(
                                            textColor: Colors.white,
                                            onPressed: () {
                                              _showIntrestsDialog(
                                                  context,
                                                  selectedIntrests,
                                                  shuffleScreenWidget);
                                            },
                                            child: Text(
                                              'edit'.tr(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontSize: 13,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height / 3,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<String> buildFilterArray(int selectedGender, int selectedMinAge,
    int selectedMaxAge, List<dynamic> selectedIntrests) {
  List<String> filterArray = ['any', 'any', 'any'];

  if (selectedGender != 9) {
    filterArray[0] = selectedGender.toString();
  }

  if (selectedMinAge != 18 || selectedMaxAge != 60) {
    filterArray[1] =
        selectedMinAge.toString() + '-' + selectedMaxAge.toString();
  }

  if (selectedIntrests.isNotEmpty) {
    String intrestsString = '';
    for (var selectedIntrest in selectedIntrests) {
      intrestsString += selectedIntrest.toString() + ',';
    }
    intrestsString = intrestsString.substring(0, intrestsString.length - 1);
    filterArray[2] = intrestsString;
  }

  return filterArray;
}

List<String> buildUserDataArray(UserData userData) {
  List<String> userDataArray = [
    userData.gender.toString(),
    calculateAge(userData.birthday).toString(),
    ''
  ];

  String intrestsString = '';
  for (var intrest in userData.interests) {
    intrestsString += intrest.toString() + ',';
  }
  if (intrestsString.length > 2) {
    intrestsString = intrestsString.substring(0, intrestsString.length - 1);
    userDataArray[2] = intrestsString;
  }

  return userDataArray;
}

int calculateAge(Timestamp birthday) {
  if (birthday == null) {
    return 0;
  }
  DateTime birthDate =
      DateTime.fromMillisecondsSinceEpoch(birthday.millisecondsSinceEpoch);
  DateTime currentDate = DateTime.now();
  int age = currentDate.year - birthDate.year;
  int month1 = currentDate.month;
  int month2 = birthDate.month;
  if (month2 > month1) {
    age--;
  } else if (month1 == month2) {
    int day1 = currentDate.day;
    int day2 = birthDate.day;
    if (day2 > day1) {
      age--;
    }
  }
  return age;
}

void _showIntrestsDialog(context, List<dynamic> selectedIntrests,
    _ShuffleScreenState shuffleScreenWidget) {
  List<dynamic> selectedWidgetIntrests = selectedIntrests;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text('chooseMax5'.tr()),
        content: Container(
          width: 100,
          height: 600,
          child: CustomCheckBoxGroup(
            buttonTextStyle: ButtonTextStyle(
              selectedColor: Colors.white,
              unSelectedColor: Colors.black,
              textStyle: TextStyle(
                fontSize: 16,
              ),
            ),
            defaultSelected: selectedIntrests,
            unSelectedColor: Colors.white,
            unSelectedBorderColor: Colors.black,
            selectedColor: const Color(0xffff9600),
            selectedBorderColor: const Color(0xffff9600),
            checkBoxButtonValues: (values) {
              selectedWidgetIntrests = values;
              if (values.length > 5) {
                values.removeLast();
              }
            },
            buttonLables: [
              'music'.tr(),
              'sport'.tr(),
              'fitness'.tr(),
              'jogging'.tr(),
              'cooking'.tr(),
              'baking'.tr(),
              'videogames'.tr(),
              'seriesAndMovies'.tr(),
              'hiking'.tr(),
              'dancing'.tr(),
              'photography'.tr(),
              'technology'.tr(),
              'programming'.tr(),
              'basketball'.tr(),
              'football'.tr(),
              'fashion'.tr(),
              'singing'.tr(),
              'art'.tr(),
              'guitar'.tr(),
              'instruments'.tr(),
              'chess'.tr(),
              'animations'.tr(),
              'fishing'.tr(),
              'martialArts'.tr(),
              'reading'.tr(),
              'writing'.tr(),
              'drawing'.tr(),
              'travel'.tr(),
              'astrologicalSigns'.tr(),
              'yoga'.tr(),
              'meditation'.tr(),
              'vegan'.tr(),
              'vegetarian'.tr(),
              'alcohol'.tr(),
              'politics'.tr(),
              'feminism'.tr(),
              'lgbtq+'.tr(),
              'environmentalism'.tr(),
              'golf'.tr(),
              'skiSnowboard'.tr(),
              'skating'.tr(),
              'dogs'.tr(),
              'cats'.tr(),
              'gardening'.tr(),
              'penPaper'.tr(),
              'boardGames'.tr(),
              'cycling'.tr(),
              'climbing'.tr(),
              'craftsmanship'.tr(),
              'collections'.tr(),
              'extremeSports'.tr(),
            ],
            buttonValuesList: [
              'music',
              'sport',
              'fitness',
              'jogging',
              'cooking',
              'baking',
              'videogames',
              'seriesAndMovies',
              'hiking',
              'dancing',
              'photography',
              'technology',
              'programming',
              'basketball',
              'footballSoccer',
              'fashion',
              'singing',
              'art',
              'guitar',
              'instruments',
              'chess',
              'animations',
              'fishing',
              'martialArts',
              'reading',
              'writing',
              'drawing',
              'travel',
              'astrologicalSigns',
              'yoga',
              'meditation',
              'vegan',
              'vegetarian',
              'alcohol',
              'politics',
              'feminism',
              'lgbtq+',
              'environmentalism',
              'golf',
              'skiSnowboard',
              'skating',
              'dogs',
              'cats',
              'gardening',
              'penPaper',
              'boardGames',
              'cycling',
              'climbing',
              'craftsmanship',
              'collections',
              'extremeSports',
            ],
            spacing: 0,
            horizontal: true,
            enableShape: true,
            width: 80,
            padding: 5,
          ),
        ),
        contentPadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        actions: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
            ),
            width: 90,
            child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  'back'.tr(),
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () async {
                  shuffleScreenWidget.selectedIntrests = selectedWidgetIntrests;
                  shuffleScreenWidget.refresh();
                  Navigator.pop(context);
                }),
          )
        ],
      );
    },
  );
}
