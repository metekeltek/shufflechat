import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:flutter/material.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/ui/register6.dart';
import 'package:easy_localization/easy_localization.dart';

class Register5 extends StatefulWidget {
  @override
  _Register5State createState() => _Register5State();
}

class _Register5State extends State<Register5> {
  bool _isVisible = false;

  void showError() {
    setState(() {
      _isVisible = true;
    });
  }

  void hideError() {
    setState(() {
      _isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);

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
                        onTap: () => Navigator.pop(context),
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
              padding: EdgeInsets.only(right: 15),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Text(
                    'yourIntrests'.tr(),
                    style:
                        TextStyle(fontSize: 60.0, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                ),
              ),
            ),
            Container(
              height: 25,
              padding: EdgeInsets.only(left: 5),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'chooseIntrests'.tr(),
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.02,
              height: MediaQuery.of(context).size.height / 2,
              child: CustomCheckBoxGroup(
                buttonTextStyle: ButtonTextStyle(
                  selectedColor: Colors.white,
                  unSelectedColor: Colors.black,
                  textStyle: TextStyle(
                    fontSize: 16,
                  ),
                ),
                unSelectedColor: Theme.of(context).canvasColor,
                unSelectedBorderColor: Colors.black,
                selectedColor: const Color(0xffff9600),
                selectedBorderColor: const Color(0xffff9600),
                checkBoxButtonValues: (values) {
                  userData.interests = values;
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
                enableButtonWrap: false,
                enableShape: true,
                width: 40,
                absoluteZeroSpacing: false,
                padding: 5,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 25,
              child: Center(
                child: Visibility(
                  visible: _isVisible,
                  child: Text(
                    'choose3Intrests'.tr(),
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 17,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.6,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: const Color(0xffff9600),
              ),
              child: MaterialButton(
                textColor: Colors.white,
                onPressed: () {
                  if (userData.interests != null &&
                      userData.interests.length > 2) {
                    hideError();
                    context.read<UserData>().setUserDataModel(userData);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register6(),
                        ));
                  } else {
                    showError();
                  }
                },
                child: Text('next'.tr()),
              ),
            )
          ],
        )),
      ),
    );
  }
}
