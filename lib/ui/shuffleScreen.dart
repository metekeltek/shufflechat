import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:shufflechat/Packages/CustomRadioButtonFixed.dart';
import 'package:shufflechat/ui/chat.dart';
import 'package:shufflechat/ui/settings.dart';
import 'package:easy_localization/easy_localization.dart';

class ShuffleScreen extends StatefulWidget {
  @override
  _ShuffleScreenState createState() => _ShuffleScreenState();
}

class _ShuffleScreenState extends State<ShuffleScreen> {
  int selectedGender = 9;
  int selectedMinAge = 0;
  int selectedMaxAge = 80;
  List<String> selectedIntrests;

  @override
  Widget build(BuildContext context) {
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
                  margin: EdgeInsets.only(top: 30, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SafeArea(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Settings(),
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatScreen(),
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
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            Container(
                              child: CustomRadioButton(
                                wrapAlignment: WrapAlignment.center,
                                elevation: 0,
                                height: 40,
                                width: 80,
                                buttonTextStyle: ButtonTextStyle(
                                  selectedColor: Colors.white,
                                  unSelectedColor: Colors.black,
                                  textStyle: TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                unSelectedColor: Theme.of(context).canvasColor,
                                unSelectedBorderColor:
                                    Theme.of(context).canvasColor,
                                selectedColor: const Color(0xffff9600),
                                selectedBorderColor: const Color(0xffff9600),
                                radioButtonValue: (value) {
                                  selectedGender = value;
                                },
                                buttonLables: [
                                  'any'.tr(),
                                  'female'.tr(),
                                  'male'.tr(),
                                  'others'.tr(),
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
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            SizedBox(
                              height: 40,
                              child: FlutterSlider(
                                rangeSlider: true,
                                values: [18, 60],
                                min: 18,
                                max: 60,
                                onDragCompleted:
                                    (handlerIndex, lowerValue, upperValue) {
                                  selectedMinAge = lowerValue;
                                  selectedMaxAge = upperValue;
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
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 38,
                                  width: 75,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: const Color(0xffff9600),
                                  ),
                                  child: Center(
                                    child: MaterialButton(
                                      textColor: Colors.white,
                                      onPressed: () {},
                                      child: Text(
                                        'edit',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
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
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: const Color(0xffff9600),
                                  ),
                                  child: Center(
                                    child: MaterialButton(
                                      textColor: Colors.white,
                                      onPressed: () {},
                                      child: Text(
                                        'clear',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
