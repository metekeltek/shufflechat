import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:shufflechat/services/dbProvider.dart';
import 'package:shufflechat/ui/register3.dart';
import 'package:easy_localization/easy_localization.dart';

class Register2 extends StatefulWidget {
  @override
  _Register2State createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  DateTime birthdate;

  bool isNotAdult(DateTime birthdate) {
    final now = DateTime.now();
    final adultDate = DateTime(
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
    final userData = Provider.of<UserData>(context);

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
                            onTap: () async {
                              final uid = context.read<User>().uid;
                              context
                                  .read<DatabaseProvider>()
                                  .deleteUserData(uid);
                              await context.read<AuthProvider>().deleteUser();
                              Phoenix.rebirth(context);
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 14,
                ),
                Container(
                  height: 70,
                  padding: const EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      'birthdate'.tr(),
                      style: TextStyle(
                          fontSize: 60.0, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  height: 25,
                  padding: const EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      'enterBirthdate'.tr(),
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 110),
                  height: 350,
                  child: DatePicker((birthDateValue) {
                    birthdate = birthDateValue;
                  }),
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
                    onPressed: () async {
                      if (birthdate != null) {
                        if (isNotAdult(birthdate)) {
                          _showDialog(context);
                        } else {
                          userData.birthday =
                              Timestamp.fromMillisecondsSinceEpoch(
                                  birthdate.millisecondsSinceEpoch);
                          userData.setUserDataModel(userData);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Register3(),
                              ));
                        }
                      }
                    },
                    child: Text('next'.tr()),
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
          'over18'.tr(),
          textAlign: TextAlign.center,
        ),
      );
    },
  );
}

class DatePicker extends StatefulWidget {
  final void Function(DateTime birthDate) onDateCallback;

  DatePicker(this.onDateCallback);

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

  bool _errorVisible = false;

  bool _dayFormatError = false;
  bool _monthFormatError = false;
  bool _yearFormatError = false;

  void showError() {
    setState(() {
      _errorVisible = true;
    });
  }

  void hideError() {
    if (!_dayFormatError && !_monthFormatError && !_yearFormatError) {
      setState(() {
        _errorVisible = false;
      });
    }
  }

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

  void focusInput() {
    if (_day1Controller.text.isEmpty) {
      day1FocusNode.requestFocus();
    } else if (_day2Controller.text.isEmpty) {
      day1FocusNode.requestFocus();
    } else if (_month1Controller.text.isEmpty) {
      month1FocusNode.requestFocus();
    } else if (_month2Controller.text.isEmpty) {
      month2FocusNode.requestFocus();
    } else if (_year1Controller.text.isEmpty) {
      year1FocusNode.requestFocus();
    } else if (_year2Controller.text.isEmpty) {
      year2FocusNode.requestFocus();
    } else if (_year3Controller.text.isEmpty) {
      year3FocusNode.requestFocus();
    } else if (_year4Controller.text.isEmpty) {
      year4FocusNode.requestFocus();
    }
  }

  void changeFocusAndValidateValues(String field, String value) {
    switch (field) {
      case 'd1':
        if (value == '') {
          dayNumber = null;
        } else {
          day2FocusNode.requestFocus();
          if (_day2Controller.text.isNotEmpty) {
            dayNumber = int.parse(_day1Controller.text + _day2Controller.text);
            validateDay();
            validateDate();
          }
        }
        break;
      case 'd2':
        if (value == '') {
          day1FocusNode.requestFocus();
          dayNumber = null;
        } else {
          month1FocusNode.requestFocus();
          if (_day1Controller.text.isNotEmpty) {
            dayNumber = int.parse(_day1Controller.text + _day2Controller.text);
            validateDay();
            validateDate();
          }
        }
        break;
      case 'm1':
        if (value == '') {
          day2FocusNode.requestFocus();
          monthNumber = null;
        } else {
          month2FocusNode.requestFocus();
          if (_month2Controller.text.isNotEmpty) {
            monthNumber =
                int.parse(_month1Controller.text + _month2Controller.text);
            validateMonth();
            validateDate();
          }
        }
        break;
      case 'm2':
        if (value == '') {
          month1FocusNode.requestFocus();
          monthNumber = null;
        } else {
          year1FocusNode.requestFocus();

          if (_month1Controller.text.isNotEmpty) {
            monthNumber =
                int.parse(_month1Controller.text + _month2Controller.text);
            validateMonth();
            validateDate();
          }
        }
        break;
      case 'y1':
        if (value == '') {
          month2FocusNode.requestFocus();
          yearNumber = null;
        } else {
          year2FocusNode.requestFocus();
          if (_year2Controller.text.isNotEmpty &&
              _year3Controller.text.isNotEmpty &&
              _year4Controller.text.isNotEmpty) {
            yearNumber = int.parse(_year1Controller.text +
                _year2Controller.text +
                _year3Controller.text +
                _year4Controller.text);
            validateYear();
            validateDate();
          }
        }
        break;
      case 'y2':
        if (value == '') {
          year1FocusNode.requestFocus();
          yearNumber = null;
        } else {
          year3FocusNode.requestFocus();
          if (_year1Controller.text.isNotEmpty &&
              _year3Controller.text.isNotEmpty &&
              _year4Controller.text.isNotEmpty) {
            yearNumber = int.parse(_year1Controller.text +
                _year2Controller.text +
                _year3Controller.text +
                _year4Controller.text);
            validateYear();
            validateDate();
          }
        }
        break;
      case 'y3':
        if (value == '') {
          year2FocusNode.requestFocus();
          yearNumber = null;
        } else {
          year4FocusNode.requestFocus();
          if (_year1Controller.text.isNotEmpty &&
              _year2Controller.text.isNotEmpty &&
              _year4Controller.text.isNotEmpty) {
            yearNumber = int.parse(_year1Controller.text +
                _year2Controller.text +
                _year3Controller.text +
                _year4Controller.text);
            validateYear();
            validateDate();
          }
        }
        break;
      case 'y4':
        if (value == '') {
          year3FocusNode.requestFocus();
          yearNumber = null;
        } else {
          if (_year1Controller.text.isNotEmpty &&
              _year2Controller.text.isNotEmpty &&
              _year3Controller.text.isNotEmpty) {
            yearNumber = int.parse(_year1Controller.text +
                _year2Controller.text +
                _year3Controller.text +
                _year4Controller.text);
            validateYear();
            validateDate();
          }
        }
        break;
    }
  }

  void validateDay() {
    if (dayNumber > 0 && dayNumber < 32) {
      _dayFormatError = false;
      hideError();
    } else {
      _dayFormatError = true;
      showError();
    }
  }

  void validateMonth() {
    if (monthNumber < 1 || monthNumber > 12) {
      _monthFormatError = true;
      showError();
      return;
    }

    if (monthNumber == 2 && dayNumber > 28) {
      _monthFormatError = true;
      showError();
      return;
    }

    if ((monthNumber == 4 ||
            monthNumber == 6 ||
            monthNumber == 9 ||
            monthNumber == 11) &&
        dayNumber > 30) {
      _monthFormatError = true;
      showError();
      return;
    }

    _monthFormatError = false;
    hideError();
  }

  void validateYear() {
    if (yearNumber < 1900 || yearNumber > DateTime.now().year) {
      _yearFormatError = true;
      showError();
    } else {
      _yearFormatError = false;
      hideError();
    }
  }

  void validateDate() {
    if (dayNumber != null &&
        monthNumber != null &&
        yearNumber != null &&
        !_errorVisible) {
      var birthdate = DateTime.utc(yearNumber, monthNumber, dayNumber);
      widget.onDateCallback(birthdate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 30),
                child: Column(
                  children: [
                    Text('day'.tr()),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //*d1
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 8),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                            onChanged: (value) {
                              changeFocusAndValidateValues('d1', value);
                            },
                            focusNode: day1FocusNode,
                            enableInteractiveSelection: false,
                            maxLength: 1,
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            controller: _day1Controller,
                            decoration: InputDecoration(
                              counterText: '',
                            ),
                          ),
                        ),
                        //*d2
                        Container(
                          width: 30,
                          height: 30,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                            onChanged: (value) {
                              changeFocusAndValidateValues('d2', value);
                            },
                            focusNode: day2FocusNode,
                            enableInteractiveSelection: false,
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            controller: _day2Controller,
                            decoration: InputDecoration(
                              counterText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 28),
                child: Column(
                  children: [
                    Text('month'.tr()),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        //*m1
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 8),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                            onChanged: (value) {
                              changeFocusAndValidateValues('m1', value);
                            },
                            focusNode: month1FocusNode,
                            enableInteractiveSelection: false,
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            controller: _month1Controller,
                            decoration: InputDecoration(
                              counterText: '',
                            ),
                          ),
                        ),
                        //*m2
                        Container(
                          width: 30,
                          height: 30,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                            onChanged: (value) {
                              changeFocusAndValidateValues('m2', value);
                            },
                            focusNode: month2FocusNode,
                            enableInteractiveSelection: false,
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            controller: _month2Controller,
                            decoration: InputDecoration(
                              counterText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Text('year'.tr()),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        //*y1
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 8),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                            onChanged: (value) {
                              changeFocusAndValidateValues('y1', value);
                            },
                            focusNode: year1FocusNode,
                            enableInteractiveSelection: false,
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            controller: _year1Controller,
                            decoration: InputDecoration(
                              counterText: '',
                            ),
                          ),
                        ),
                        //*y2
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 8),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                            onChanged: (value) {
                              changeFocusAndValidateValues('y2', value);
                            },
                            focusNode: year2FocusNode,
                            enableInteractiveSelection: false,
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            controller: _year2Controller,
                            decoration: InputDecoration(
                              counterText: '',
                            ),
                          ),
                        ),
                        //*y3
                        Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(right: 8),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                            onChanged: (value) {
                              changeFocusAndValidateValues('y3', value);
                            },
                            focusNode: year3FocusNode,
                            enableInteractiveSelection: false,
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            controller: _year3Controller,
                            decoration: InputDecoration(
                              counterText: '',
                            ),
                          ),
                        ),
                        //*y4
                        Container(
                          width: 30,
                          height: 30,
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 25),
                            onChanged: (value) {
                              changeFocusAndValidateValues('y4', value);
                            },
                            focusNode: year4FocusNode,
                            enableInteractiveSelection: false,
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]')),
                            ],
                            controller: _year4Controller,
                            decoration: InputDecoration(
                              counterText: '',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: Visibility(
                visible: _errorVisible,
                child: Text(
                  'dateFormatError'.tr(),
                  style: TextStyle(color: Colors.red, fontSize: 17),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
