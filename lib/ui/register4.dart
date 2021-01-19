import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'package:flutter/material.dart';
import 'package:shufflechat/Packages/CustomRadioButtonFixed.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/ui/register5.dart';

class Register4 extends StatefulWidget {
  @override
  _Register4State createState() => _Register4State();
}

class _Register4State extends State<Register4> {
  int selected;

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
            SizedBox(
              height: MediaQuery.of(context).size.height / 14,
            ),
            Container(
              height: 70,
              padding: EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width / 1.06,
              child: Text(
                'You are...',
                style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: 25,
              padding: EdgeInsets.only(left: 20),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Choose your gender',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 10),
              height: 350,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: CustomRadioButtonFixed(
                      elevation: 0,
                      buttonTextStyle: ButtonTextStyle(
                        selectedColor: Colors.white,
                        unSelectedColor: Colors.black,
                        textStyle: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      unSelectedColor: Theme.of(context).canvasColor,
                      unSelectedBorderColor: Colors.black,
                      selectedColor: Colors.amberAccent[700],
                      selectedBorderColor: Colors.amberAccent[700],
                      radioButtonValue: (value) {
                        selected = value;
                      },
                      buttonLables: [
                        "Female",
                        "Male",
                        "Others",
                      ],
                      buttonValues: [
                        0,
                        1,
                        2,
                      ],
                      spacing: 0,
                      horizontal: true,
                      enableButtonWrap: false,
                      enableShape: true,
                      height: 70,
                      absoluteZeroSpacing: false,
                      padding: 3,
                    ),
                  ),
                ],
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
                onPressed: () async {
                  if (selected != null) {
                    userData.gender = selected;
                    context.read<UserData>().setUserDataModel(userData);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register5(),
                        ));
                  }
                },
                child: Text(
                  'next',
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
