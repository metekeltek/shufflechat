import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/services/dbProvider.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsInterests extends StatefulWidget {
  final List<dynamic> interests;

  SettingsInterests(this.interests);
  @override
  _SettingsInterestsState createState() => _SettingsInterestsState();
}

class _SettingsInterestsState extends State<SettingsInterests> {
  TextEditingController _intrestField = TextEditingController();
  bool _isError = false;
  bool _isVisible = true;
  bool _interestsChanged = false;

  void showField() {
    setState(() {
      _isVisible = true;
    });
  }

  void hideField() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _intrestField.text = '';
    List<dynamic> interests = widget.interests;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SafeArea(
                      child: GestureDetector(
                        onTap: () async {
                          if (interests != null && interests.length > 2) {
                            if (_interestsChanged) {
                              _isError = false;
                              await context
                                  .read<DatabaseProvider>()
                                  .setInterests(interests);
                            }
                            Navigator.pop(context);
                          } else {
                            _isError = true;
                            showField();
                          }
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 35.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 65,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'yourInterests'.tr(),
                    style:
                        TextStyle(fontSize: 60.0, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Container(
              height: 25,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    'chooseInterests'.tr(),
                    style:
                        TextStyle(fontSize: 23.0, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            GestureDetector(
              dragStartBehavior: DragStartBehavior.start,
              onTapDown: (_) => hideField(),
              child: Container(
                width: MediaQuery.of(context).size.width / 1.1,
                height: MediaQuery.of(context).size.height / 1.6,
                child: CustomCheckBoxGroup(
                  buttonTextStyle: ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Colors.black,
                    textStyle: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  defaultSelected: interests,
                  unSelectedColor: Theme.of(context).canvasColor,
                  unSelectedBorderColor: Colors.black,
                  selectedColor: const Color(0xffff9600),
                  selectedBorderColor: const Color(0xffff9600),
                  checkBoxButtonValues: (values) {
                    interests = values;
                    if (values.length > 5) {
                      values.removeLast();
                    }
                    _interestsChanged = true;
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
                  enableButtonWrap: false,
                  enableShape: true,
                  width: 40,
                  absoluteZeroSpacing: false,
                  padding: 5,
                ),
              ),
            ),
            Container(
              height: 25,
              child: Center(
                child: Visibility(
                  visible: _isVisible,
                  child: Text(
                    _isError ? 'choose3Interests'.tr() : 'scroll'.tr(),
                    style: TextStyle(
                        color: _isError ? Colors.red : Color(0xffff9600),
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
