import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:shufflechat/services/dbProvider.dart';
import 'package:shufflechat/ui/settingsIntrests.dart';
import 'package:shufflechat/ui/support.dart';
import 'package:easy_localization/easy_localization.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  TextEditingController _nameController = TextEditingController();
  var profileImage;
  bool isLoading = false;

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

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var userData = context.watch<UserData>();
    _nameController.text = userData.name;
    var settingsWidget = this;

    if (userData.profilePictureURL != null) {
      profileImage = CachedNetworkImageProvider(userData.profilePictureURL);
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 6,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, top: 30.0, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SafeArea(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 35.0,
                          ),
                        ),
                      ),
                      SafeArea(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Support()));
                          },
                          child: Icon(
                            Icons.help_outline,
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
                height: MediaQuery.of(context).size.height / 13,
              ),
              isLoading
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              const Color(0xffff9600)),
                          strokeWidth: 4,
                        ),
                      ),
                    )
                  : Center(
                      child: (() {
                        if (userData.profilePictureURL != null) {
                          return GestureDetector(
                            onTap: () async {
                              await showDialog(
                                  context: context,
                                  builder: (_) => ImageDialog(profileImage));
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: profileImage,
                              radius: 80.0,
                            ),
                          );
                        } else {
                          return SizedBox(height: 90);
                        }
                      }()),
                    ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.05,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userData.name,
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        ', ' + calculateAge(userData.birthday).toString(),
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                width: MediaQuery.of(context).size.width / 2.1,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xffff9600),
                ),
                child: MaterialButton(
                  textColor: Colors.white,
                  onPressed: () {
                    var authProvider = context.read<AuthProvider>();
                    var databaseProvider = context.read<DatabaseProvider>();
                    var userDataProvider = context.read<UserData>();
                    _showBottomSheet(context, userData, authProvider,
                        databaseProvider, userDataProvider, settingsWidget);
                  },
                  child: Text(
                    'editProfile'.tr(),
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width / 2.1,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: const Color(0xffff9600),
                ),
                child: MaterialButton(
                  textColor: Colors.white,
                  onPressed: () async {
                    context.read<AuthProvider>().logout();
                    Phoenix.rebirth(context);
                  },
                  child: Text(
                    'logout'.tr(),
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width / 2.1,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Color(0xffed441a),
                ),
                child: MaterialButton(
                  textColor: Colors.white,
                  onPressed: () {
                    _showDeleteDialog(context);
                  },
                  child: Text(
                    'deleteAccount'.tr(),
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Future saveName(
    userData, authProvider, databaseProvider, userDataProvider) async {
  final uid = authProvider.getUID();
  userDataProvider.setUserDataModel(userData);
  await databaseProvider.setUser(uid, userData);
}

Future uploadPicture(
    userData, authProvider, databaseProvider, userDataProvider, file) async {
  final uid = authProvider.getUID();
  userDataProvider.setUserDataModel(userData);
  await databaseProvider.uploadFile(uid, file);
  userDataProvider.profilePictureURL = await databaseProvider.getFile(uid);
  await databaseProvider.setUser(uid, userData);
}

Future<File> compressFile(File file) async {
  File compressedFile = await FlutterNativeImage.compressImage(
    file.path,
    quality: 0,
  );
  return compressedFile;
}

class ImageDialog extends StatelessWidget {
  var profileImage;

  ImageDialog(this.profileImage);
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(500.0),
      ),
      child: AspectRatio(
        aspectRatio: 1 / 1,
        child: Container(
          width: 500,
          height: 500,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(500.0),
              image: DecorationImage(
                image: profileImage,
                fit: BoxFit.cover,
                alignment: FractionalOffset.center,
              )),
        ),
      ),
    );
  }
}

void _showBottomSheet(context, UserData userData, authProvider,
    databaseProvider, userDataProvider, _SettingsState settingsWidget) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
    context: context,
    builder: (builder) {
      return new Container(
        height: MediaQuery.of(context).size.height / 4,
        padding: EdgeInsets.only(
          left: 5.0,
          right: 5.0,
          top: 5.0,
          bottom: 10.0,
        ),
        decoration: new BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
        child: Wrap(
          runAlignment: WrapAlignment.spaceEvenly,
          children: [
            ListTile(
                leading: Container(
                  width: 4.0,
                  child: Icon(
                    Icons.photo,
                    color: const Color(0xffff9600),
                    size: 24.0,
                  ),
                ),
                title: Text(
                  'changePicture'.tr(),
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onTap: () => _showImageBottomSheet(
                    context,
                    userData,
                    authProvider,
                    databaseProvider,
                    userDataProvider,
                    settingsWidget)),
            Divider(
              height: 2.0,
              thickness: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: Container(
                width: 4.0,
                child: Icon(
                  Icons.text_fields_outlined,
                  color: const Color(0xffff9600),
                  size: 24.0,
                ),
              ),
              title: Text(
                'changeName'.tr(),
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                _showNameDialog(context, userData, authProvider,
                    databaseProvider, userDataProvider, settingsWidget);
              },
            ),
            Divider(
              height: 2.0,
              thickness: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: Container(
                width: 4.0,
                child: Icon(
                  Icons.sports_tennis,
                  color: const Color(0xffff9600),
                  size: 24.0,
                ),
              ),
              title: Text(
                'changeIntrests'.tr(),
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsIntrests(),
                  )),
            ),
          ],
        ),
      );
    },
  );
}

void _showImageBottomSheet(context, UserData userData, authProvider,
    databaseProvider, userDataProvider, _SettingsState settingsWidget) {
  ImagePicker picker = ImagePicker();
  PickedFile pickedFile;

  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    context: context,
    builder: (builder) {
      return Container(
        padding: EdgeInsets.only(
          left: 5.0,
          right: 5.0,
          top: 5.0,
          bottom: 5.0,
        ),
        height: MediaQuery.of(context).size.height / 6,
        decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        child: Wrap(
          runAlignment: WrapAlignment.spaceEvenly,
          children: [
            ListTile(
              leading: Container(
                width: 4.0,
                child: Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                  size: 24.0,
                ),
              ),
              title: Text(
                'takeImage'.tr(),
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () async {
                pickedFile = await picker.getImage(
                  source: ImageSource.camera,
                  imageQuality: 0,
                );
                if (pickedFile != null) {
                  settingsWidget.isLoading = true;
                  settingsWidget.refresh();
                  var imageFile = await compressFile(File(pickedFile.path));
                  await uploadPicture(userData, authProvider, databaseProvider,
                      userDataProvider, imageFile);
                  settingsWidget.isLoading = false;
                  settingsWidget.refresh();
                }

                Navigator.of(context).pop();
              },
            ),
            Divider(
              height: 2.0,
              thickness: 1,
              color: Colors.grey,
            ),
            ListTile(
              leading: Container(
                width: 4.0,
                child: Icon(
                  Icons.photo,
                  color: Colors.black,
                  size: 24.0,
                ),
              ),
              title: Text(
                'chooseGallery'.tr(),
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              onTap: () async {
                pickedFile = await picker.getImage(
                  source: ImageSource.gallery,
                  imageQuality: 0,
                );
                if (pickedFile != null) {
                  settingsWidget.isLoading = true;
                  settingsWidget.refresh();
                  var imageFile = await compressFile(File(pickedFile.path));
                  await uploadPicture(userData, authProvider, databaseProvider,
                      userDataProvider, imageFile);
                  settingsWidget.isLoading = false;
                  settingsWidget.refresh();
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}

void _showNameDialog(context, userData, authProvider, databaseProvider,
    userDataProvider, _SettingsState settingsWidget) {
  TextEditingController _nameController = TextEditingController();
  _nameController.text = userData.name;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          content: TextField(
            decoration: InputDecoration(
                counterText: '',
                focusColor: Colors.black,
                fillColor: Colors.black,
                border: InputBorder.none),
            autofocus: true,
            controller: _nameController,
            maxLength: 20,
          ),
          contentPadding: EdgeInsets.only(top: 20, left: 20, right: 20),
          actions: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              width: 80,
              child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    'save'.tr(),
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    userData.name = _nameController.text;
                    await saveName(userData, authProvider, databaseProvider,
                        userDataProvider);
                    settingsWidget.refresh();
                    Navigator.pop(context);
                  }),
            )
          ],
        ),
      );
    },
  );
}

void _showDeleteDialog(context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text(
          'sure?'.tr(),
          textAlign: TextAlign.center,
        ),
        content: Text(
          'dontGo'.tr(),
          style: TextStyle(fontSize: 18),
        ),
        contentPadding: EdgeInsets.only(left: 21, right: 20, top: 20),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20),
            child: MaterialButton(
              child: Text(
                'yesDelete'.tr(),
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                final uid = context.read<User>().uid;
                context.read<DatabaseProvider>().deleteUserData(uid);
                await context.read<AuthProvider>().deleteUser();
                Phoenix.rebirth(context);
              },
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 20),
            child: MaterialButton(
              child: new Text('goBack'.tr()),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      );
    },
  );
}
