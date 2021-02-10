import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:shufflechat/services/dbProvider.dart';
import 'package:shufflechat/ui/chat.dart';
import 'package:shufflechat/ui/settings.dart' as Settings;
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:true_time/true_time.dart';

class ShuffleScreen extends StatefulWidget {
  @override
  _ShuffleScreenState createState() => _ShuffleScreenState();
}

class _ShuffleScreenState extends State<ShuffleScreen> {
  int selectedGender = 9;
  int selectedMinAge = 18;
  int selectedMaxAge = 60;
  List<dynamic> selectedIntrests = [];
  UserData userData;

  bool premium = false;
  bool _initialized = false;
  DateTime _currentTime;

  void refresh() {
    setState(() {});
  }

  @override
  initState() {
    super.initState();
    _initPlatformState();
  }

  _initPlatformState() async {
    bool initialized = await TrueTime.init();
    setState(() {
      _initialized = initialized;
    });
    _updateCurrentTime();
  }

  _updateCurrentTime() async {
    DateTime now = await TrueTime.now();
    setState(() {
      _currentTime = now;
    });
  }

  @override
  Widget build(BuildContext context) {
    userData = Provider.of<UserData>(context);
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    final uid = Provider.of<AuthProvider>(context).getUID();

    final shuffleScreenWidget = this;

    if (userData.premiumTill != null) {
      if (_currentTime.millisecondsSinceEpoch <
          userData.premiumTill.millisecondsSinceEpoch) {
        premium = true;
      }
    }

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
                          onTap: () => _showGetShuffleCoinsDialog(context,
                              shuffleScreenWidget, databaseProvider, uid),
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
                                    fontSize: 25, fontWeight: FontWeight.w600),
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
                SafeArea(
                  child: GestureDetector(
                    onTap: () {
                      if (!premium) {
                        _showGetPremiumFunctionsDialog(context,
                            shuffleScreenWidget, uid, databaseProvider);
                      }
                    },
                    child: AbsorbPointer(
                      absorbing: premium ? false : true,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                    onDragCompleted:
                                        (handlerIndex, lowerValue, upperValue) {
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
                                                    BorderRadius.circular(50.0),
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
                                                    BorderRadius.circular(15.0),
                                                color: const Color(0xffff9600),
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
                                                    textAlign: TextAlign.center,
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
                                            BorderRadius.circular(15.0),
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
                    ),
                  ),
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

void _showGetPremiumFunctionsDialog(
    context,
    _ShuffleScreenState shuffleScreenWidget,
    String uid,
    DatabaseProvider databaseProvider) {
  final image = Image(
    height: 30,
    image: AssetImage('assets/images/shuffleCoin.png'),
  );
  bool sureQuestion = false;
  int premiumDays = 0;
  int price = 0;
  String weekMontYear = '';
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(builder: (context, setState) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: Text(sureQuestion ? 'Are you sure?' : 'Premium Functions',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500)),
          ),
          contentPadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          content: sureQuestion
              ? Container(
                  height: 130,
                  width: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Buy '),
                          Text(
                            '1 ' + weekMontYear,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(' premium, for '),
                          Text(
                            price.toString(),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          image
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            width: 90,
                            child: Center(
                              child: MaterialButton(
                                height: 50,
                                shape: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xffff9600), width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                ),
                                textColor: const Color(0xffff9600),
                                onPressed: () {
                                  setState(() {
                                    sureQuestion = false;
                                  });
                                },
                                child: Text(
                                  'back',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            width: 90,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: const Color(0xffff9600),
                            ),
                            child: Center(
                              child: MaterialButton(
                                textColor: Colors.white,
                                onPressed: () {
                                  if (shuffleScreenWidget.premium) {
                                    final premiumTill = Timestamp.fromDate(
                                        shuffleScreenWidget.userData.premiumTill
                                            .toDate()
                                            .add(Duration(days: premiumDays)));
                                    databaseProvider.setPremiumTill(
                                        uid, premiumTill);
                                    shuffleScreenWidget.userData.premiumTill =
                                        premiumTill;
                                  } else {
                                    final premiumTill = Timestamp.fromDate(
                                        shuffleScreenWidget._currentTime
                                            .add(Duration(days: premiumDays)));
                                    databaseProvider.setPremiumTill(
                                        uid, premiumTill);
                                    shuffleScreenWidget.userData.premiumTill =
                                        premiumTill;
                                  }
                                  databaseProvider.setShuffleCoins(
                                      uid,
                                      shuffleScreenWidget
                                              .userData.shuffleCoins -
                                          price);
                                  shuffleScreenWidget.userData.shuffleCoins -=
                                      price;
                                  shuffleScreenWidget.refresh();
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'yes',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              : Container(
                  height: 270,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 50,
                              width: 320,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: const Color(0xffff9600),
                              ),
                              child: Center(
                                child: MaterialButton(
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (shuffleScreenWidget
                                            .userData.shuffleCoins <
                                        4) {
                                      _showGetShuffleCoinsDialog(
                                          context,
                                          shuffleScreenWidget,
                                          databaseProvider,
                                          uid);
                                      return;
                                    } else {
                                      setState(() {
                                        weekMontYear = 'week';
                                        premiumDays = 7;
                                        price = 4;
                                        sureQuestion = true;
                                      });
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('1 week',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500)),
                                      Text(' / ',
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.w400)),
                                      Text('4',
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w600)),
                                      image,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 8),
                            Container(
                              height: 50,
                              width: 320,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: const Color(0xffff9600),
                              ),
                              child: Center(
                                child: MaterialButton(
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (shuffleScreenWidget
                                            .userData.shuffleCoins <
                                        9) {
                                      _showGetShuffleCoinsDialog(
                                          context,
                                          shuffleScreenWidget,
                                          databaseProvider,
                                          uid);
                                      return;
                                    } else {
                                      setState(() {
                                        weekMontYear = 'month';
                                        premiumDays = 31;
                                        price = 9;
                                        sureQuestion = true;
                                      });
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('1 month',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500)),
                                      Text(' / ',
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.w400)),
                                      Text('9',
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w600)),
                                      image,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 8),
                            Container(
                              height: 50,
                              width: 320,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: const Color(0xffff9600),
                              ),
                              child: Center(
                                child: MaterialButton(
                                  textColor: Colors.white,
                                  onPressed: () {
                                    if (shuffleScreenWidget
                                            .userData.shuffleCoins <
                                        59) {
                                      _showGetShuffleCoinsDialog(
                                          context,
                                          shuffleScreenWidget,
                                          databaseProvider,
                                          uid);
                                      return;
                                    } else {
                                      setState(() {
                                        weekMontYear = 'year';
                                        premiumDays = 365;
                                        price = 59;
                                        sureQuestion = true;
                                      });
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('1 year',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w500)),
                                      Text(' / ',
                                          style: TextStyle(
                                              fontSize: 21,
                                              fontWeight: FontWeight.w400)),
                                      Text('59',
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.w600)),
                                      image,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        );
      });
    },
  );
}

void _showGetShuffleCoinsDialog(
    context,
    _ShuffleScreenState shuffleScreenWidget,
    DatabaseProvider databaseProvider,
    String uid) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Center(
            child: Text('Shuffle Coins',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500))),
        content: Container(
          height: 220,
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    height: 90,
                    image: AssetImage('assets/images/5shuffleCoins.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '5 ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'ShuffleCoins',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 38,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color(0xffff9600),
                    ),
                    child: Center(
                      child: MaterialButton(
                        textColor: Colors.white,
                        onPressed: () {
                          databaseProvider.setShuffleCoins(uid,
                              shuffleScreenWidget.userData.shuffleCoins + 5);
                          shuffleScreenWidget.userData.shuffleCoins += 5;
                          shuffleScreenWidget.refresh();
                          Navigator.pop(context);
                        },
                        child: Center(
                          child: Text(
                            'get',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    height: 90,
                    image: AssetImage('assets/images/10shuffleCoins.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '10 ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'ShuffleCoins',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 38,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color(0xffff9600),
                    ),
                    child: Center(
                      child: MaterialButton(
                        textColor: Colors.white,
                        onPressed: () {
                          databaseProvider.setShuffleCoins(uid,
                              shuffleScreenWidget.userData.shuffleCoins + 10);
                          shuffleScreenWidget.userData.shuffleCoins += 10;

                          shuffleScreenWidget.refresh();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'get',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    height: 90,
                    image: AssetImage('assets/images/60shuffleCoins.png'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '60 ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    'ShuffleCoins',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 38,
                    width: 75,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: const Color(0xffff9600),
                    ),
                    child: Center(
                      child: MaterialButton(
                        textColor: Colors.white,
                        onPressed: () {
                          databaseProvider.setShuffleCoins(uid,
                              shuffleScreenWidget.userData.shuffleCoins + 60);
                          shuffleScreenWidget.userData.shuffleCoins += 60;

                          shuffleScreenWidget.refresh();
                          Navigator.pop(context);
                        },
                        child: Text(
                          'get',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
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
        contentPadding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      );
    },
  );
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
                  'save'.tr(),
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
