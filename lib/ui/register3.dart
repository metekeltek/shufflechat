import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_number/date_picker_number.dart';
import 'package:date_picker_number/date_picker_number_settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:shufflechat/services/dbProvider.dart';
import 'package:shufflechat/ui/register4.dart';

class Register3 extends StatefulWidget {
  @override
  _Register3State createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  var dayNumber;
  DateTime birthdate;

  bool isNotAdult(DateTime birthdate) {
    DateTime now = DateTime.now();
    DateTime adultDate = DateTime(
      now.year - 18,
      now.month,
      now.day,
    );
    if (birthdate.day == adultDate.day &&
        birthdate.month == adultDate.month &&
        birthdate.year == adultDate.year) {
      return false;
    }

    return birthdate.isAfter(adultDate) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      'Birthdate',
                      style: TextStyle(
                          fontSize: 60.0, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  height: 25,
                  padding: EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      'Enter your birthdate',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 110),
                  height: 350,
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
                      FocusScope.of(context).unfocus();
                      if (birthdate != null) {
                        userData.birthday =
                            Timestamp.fromMillisecondsSinceEpoch(
                                birthdate.millisecondsSinceEpoch);
                        context.read<UserData>().setUserDataModel(userData);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register4(),
                            ));
                      }
                    },
                    child: Text('next'),
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

void _showDialog(context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          "You must be 18 or over to use this app",
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}

class DatePicker extends StatefulWidget {
  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  TextEditingController _day1Controller = TextEditingController();
  FocusNode day1FocusNode;
  TextEditingController _day2Controller = TextEditingController();
  FocusNode day2FocusNode;

  TextEditingController _month1Controller = TextEditingController();
  FocusNode month1FocusNode;
  TextEditingController _month2Controller = TextEditingController();

  FocusNode month2FocusNode;

  TextEditingController _year1Controller = TextEditingController();
  FocusNode year1FocusNode;

  TextEditingController _year2Controller = TextEditingController();

  FocusNode year2FocusNode;
  TextEditingController _year3Controller = TextEditingController();

  FocusNode year3FocusNode;
  TextEditingController _year4Controller = TextEditingController();
  FocusNode year4FocusNode;

  int dayNumber;
  int monthNumber;
  int yearNumber;

  String dayNumberText;
  String monthNumberText;
  String yearNumberText;

  DateTime birthdate;

  @override
  void initState() {
    super.initState();
    day1FocusNode = FocusNode();
    day2FocusNode = FocusNode();
    month1FocusNode = FocusNode();
    month2FocusNode = FocusNode();
    year1FocusNode = FocusNode();
    year2FocusNode = FocusNode();
    year3FocusNode = FocusNode();
    year4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    day1FocusNode.dispose();
    day2FocusNode.dispose();
    month1FocusNode.dispose();
    month2FocusNode.dispose();
    year1FocusNode.dispose();
    year2FocusNode.dispose();
    year3FocusNode.dispose();
    year4FocusNode.dispose();

    super.dispose();
  }

  void focusNext(String field) {
    switch (field) {
      case 'd1':
        break;
      case 'd2':
        break;
      case 'm1':
        break;
      case 'm2':
        break;
      case 'y1':
        break;
      case 'y2':
        break;
      case 'y3':
        break;
      case 'y4':
        break;
    }
  }

  void changeFocus(String field, String value) {
    switch (field) {
      case 'd1':
        if (value != '') {
          day2FocusNode.requestFocus();
        }
        break;
      case 'd2':
        if (value == '') {
          day1FocusNode.requestFocus();
        } else {
          month1FocusNode.requestFocus();
        }
        break;
      case 'm1':
        if (value == '') {
          day2FocusNode.requestFocus();
        } else {
          month2FocusNode.requestFocus();
        }
        break;
      case 'm2':
        if (value == '') {
          month1FocusNode.requestFocus();
        } else {
          year1FocusNode.requestFocus();
        }
        break;
      case 'y1':
        if (value == '') {
          month2FocusNode.requestFocus();
        } else {
          year2FocusNode.requestFocus();
        }
        break;
      case 'y2':
        if (value == '') {
          year1FocusNode.requestFocus();
        } else {
          year3FocusNode.requestFocus();
        }
        break;
      case 'y3':
        if (value == '') {
          year2FocusNode.requestFocus();
        } else {
          year4FocusNode.requestFocus();
        }
        break;
      case 'y4':
        if (value == '') {
          year2FocusNode.requestFocus();
        } else {
          FocusScope.of(context).unfocus();
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Row(
        children: [
          //*d1
          TextFormField(
            onChanged: (value) {
              changeFocus('d1', value);
            },
            focusNode: day1FocusNode,
            enableInteractiveSelection: false,
            maxLength: 1,
            autofocus: true,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            controller: _day1Controller,
            decoration: InputDecoration(
              counterText: '',
            ),
          ),
          //*d2
          TextFormField(
            onChanged: (value) {},
            focusNode: day2FocusNode,
            enableInteractiveSelection: false,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            controller: _day2Controller,
            decoration: InputDecoration(
              counterText: '',
            ),
          ),
          //*m1
          TextFormField(
            onChanged: (value) {
              if (value == '') {
                month1FocusNode.requestFocus();
              } else {}
              month2FocusNode.requestFocus();
            },
            focusNode: month1FocusNode,
            enableInteractiveSelection: false,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            controller: _month1Controller,
            decoration: InputDecoration(
              counterText: '',
            ),
          ),
          //*m2
          TextFormField(
            onChanged: (value) {
              if (value == '') {
                month1FocusNode.requestFocus();
              } else {}
              year1FocusNode.requestFocus();
            },
            focusNode: month2FocusNode,
            enableInteractiveSelection: false,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            controller: _month2Controller,
            decoration: InputDecoration(
              counterText: '',
            ),
          ),
          //*y1
          TextFormField(
            onChanged: (value) {
              if (value == '') {
                month2FocusNode.requestFocus();
              } else {}
              year2FocusNode.requestFocus();
            },
            focusNode: year1FocusNode,
            enableInteractiveSelection: false,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            controller: _year1Controller,
            decoration: InputDecoration(
              counterText: '',
            ),
          ),
          //*y2
          TextFormField(
            onChanged: (value) {
              if (value == '') {
                year1FocusNode.requestFocus();
              } else {}
              year3FocusNode.requestFocus();
            },
            focusNode: year2FocusNode,
            enableInteractiveSelection: false,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            controller: _year2Controller,
            decoration: InputDecoration(
              counterText: '',
            ),
          ),
          //*y3
          TextFormField(
            onChanged: (value) {
              if (value == '') {
                year2FocusNode.requestFocus();
              } else {}
              year4FocusNode.requestFocus();
            },
            focusNode: year3FocusNode,
            enableInteractiveSelection: false,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            controller: _year3Controller,
            decoration: InputDecoration(
              counterText: '',
            ),
          ),
          //*y4
          TextFormField(
            onChanged: (value) {
              if (value == '') {
                year3FocusNode.requestFocus();
              } else {}
            },
            focusNode: year4FocusNode,
            enableInteractiveSelection: false,
            maxLength: 1,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            controller: _year4Controller,
            decoration: InputDecoration(
              counterText: '',
            ),
          ),
        ],
      ),
    );
  }
}

bool validDay(int day) {
  if (day > 0 && day < 32) {
    return true;
  } else {
    return false;
  }
}

void validMonth() {}

void validYear() {}

void validateDate() {}

void focusNext() {}
