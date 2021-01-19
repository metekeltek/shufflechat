import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomCheckBoxGroup.dart';
import 'package:flutter/material.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/ui/register6.dart';

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
                          semanticLabel: 'go back',
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
                child: Text(
                  'Your Intrests',
                  style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              height: 25,
              padding: EdgeInsets.only(left: 30),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Choose 3 to 5 Intrests',
                style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.02,
              height: MediaQuery.of(context).size.height / 1.6,
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
                selectedColor: Colors.amberAccent[700],
                selectedBorderColor: Colors.amberAccent[700],
                checkBoxButtonValues: (values) {
                  userData.interests = values;
                  if (values.length > 5) {
                    values.removeLast();
                  }
                },
                buttonLables: [
                  "Music",
                  "Sport",
                  "Fitness",
                  "Jogging",
                  "Cooking",
                  "Baking",
                  "Videogames",
                  "Series / Movies",
                  "Hiking",
                  "Dancing",
                  "Photography",
                  "Technology",
                  "Programming",
                  "Basketball",
                  "Football / Soccer",
                  "Fashion",
                  "Singing",
                  "Art",
                  "Guitar",
                  "Playing Instrument",
                  "Chess",
                  "Animations",
                  "Fishing",
                  "Martial arts",
                  "Reading",
                  "Writing",
                  "Drawing",
                  "Travel",
                  "Astrological signs",
                  "Yoga",
                  "Meditation",
                  "Vegan",
                  "Vegetarian",
                  "Alcohol",
                  "Politics",
                  "Feminism",
                  "LGBTQ+",
                  "Environmentalism",
                  "Golf",
                  "Ski / Snowboard",
                  "Snowboarding",
                  "Skating",
                  "Dogs",
                  "Cats",
                  "Gardening",
                  "Pen&Paper",
                  "Board Games",
                  "Cycling",
                  "Climbing",
                  "Craftsmanship",
                  "Collections",
                  "Extreme sports",
                ],
                buttonValuesList: [
                  "Music",
                  "Sport",
                  "Fitness",
                  "Jogging",
                  "Cooking",
                  "Baking",
                  "Videogames",
                  "Series / Movies",
                  "Hiking",
                  "Dancing",
                  "Photography",
                  "Technology",
                  "Programming",
                  "Basketball",
                  "Football / Soccer",
                  "Fashion",
                  "Singing",
                  "Art",
                  "Guitar",
                  "Playing Instrument",
                  "Chess",
                  "Animations",
                  "Fishing",
                  "Martial arts",
                  "Reading",
                  "Writing",
                  "Drawing",
                  "Travel",
                  "Astrological signs",
                  "Yoga",
                  "Meditation",
                  "Vegan",
                  "Vegetarian",
                  "Alcohol",
                  "Politics",
                  "Feminism",
                  "LGBTQ+",
                  "Environmentalism",
                  "Golf",
                  "Ski / Snowboard",
                  "Snowboarding",
                  "Skating",
                  "Dogs",
                  "Cats",
                  "Gardening",
                  "Pen&Paper",
                  "Board Games",
                  "Cycling",
                  "Climbing",
                  "Craftsmanship",
                  "Collections",
                  "Extreme sports",
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
            Container(
              height: 25,
              child: Center(
                child: Visibility(
                  visible: _isVisible,
                  child: Text(
                    'Choose at least 3 Intrests',
                    style: TextStyle(color: Colors.red, fontSize: 17),
                  ),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.6,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.amberAccent[700],
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
                child: Text('next'),
              ),
            )
          ],
        )),
      ),
    );
  }
}
