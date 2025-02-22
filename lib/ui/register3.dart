import 'package:flutter/material.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/ui/register4.dart';
import 'package:easy_localization/easy_localization.dart';

class Register3 extends StatefulWidget {
  @override
  _Register3State createState() => _Register3State();
}

class _Register3State extends State<Register3> {
  TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData>(context);
    _nameController.text = userData.name;

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
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
                              Navigator.pop(context);
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
                      'name'.tr(),
                      style: TextStyle(
                          fontSize: 60.0, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  height: 25,
                  padding: const EdgeInsets.only(right: 10),
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Text(
                      'enterName'.tr(),
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.w400),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 350,
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Center(
                    child: TextFormField(
                      maxLength: 20,
                      controller: _nameController,
                      onChanged: (name) {
                        userData.name = name;
                      },
                      decoration: InputDecoration(
                        hintText: 'type'.tr(),
                        hintStyle: TextStyle(
                          color: Colors.black,
                        ),
                        fillColor: Colors.black,
                      ),
                    ),
                  ),
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
                      userData.setUserDataModel(userData);
                      _nameController.text = '';
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Register4(),
                          ));
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
