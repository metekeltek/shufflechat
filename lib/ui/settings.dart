import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:shufflechat/services/dbProvider.dart';
import 'package:shufflechat/ui/settingsInterests.dart';
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
  UserData userData;

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
    final databaseProvider = Provider.of<DatabaseProvider>(context);
    Stream<UserData> userDataStream = databaseProvider.userDataStream;
    var settingsWidget = this;

    return StreamBuilder<UserData>(
        stream: userDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.profilePictureURL != null) {
              profileImage =
                  CachedNetworkImageProvider(snapshot.data.profilePictureURL);
            }
            userData = snapshot.data;
            _nameController.text = snapshot.data.name;
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
                          padding: const EdgeInsets.only(
                              left: 15.0, top: 30.0, right: 15),
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
                                if (snapshot.data.profilePictureURL != null) {
                                  return GestureDetector(
                                    onTap: () async {
                                      await showDialog(
                                          context: context,
                                          builder: (_) =>
                                              ImageDialog(profileImage));
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
                                snapshot.data.name,
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w600),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                ', ' +
                                    calculateAge(snapshot.data.birthday)
                                        .toString(),
                                style: TextStyle(
                                    fontSize: 40, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 13,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'premium till: ' +
                                    snapshot.data.premiumTill
                                        .toDate()
                                        .toString()
                                        .substring(0, 10),
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.1,
                        height: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: const Color(0xffff9600).withOpacity(0.2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'messages Sent (' +
                                  (snapshot.data.messagesSent > 50
                                      ? '50'
                                      : snapshot.data.messagesSent.toString()) +
                                  '/50)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            SizedBox(
                              height: 30,
                              child: FlutterSlider(
                                disabled: true,
                                values: [snapshot.data.messagesSent.toDouble()],
                                min: 0,
                                max: 50,
                                trackBar: FlutterSliderTrackBar(
                                    activeDisabledTrackBarColor:
                                        const Color(0xffff9600)),
                                handler: FlutterSliderHandler(
                                  decoration: BoxDecoration(),
                                  disabled: true,
                                  child: Container(),
                                ),
                              ),
                            ),
                            Text(
                              'messages Received (' +
                                  (snapshot.data.messagesReceived > 50
                                      ? '50'
                                      : snapshot.data.messagesReceived
                                          .toString()) +
                                  '/50)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            SizedBox(
                              height: 30,
                              child: FlutterSlider(
                                disabled: true,
                                values: [
                                  snapshot.data.messagesReceived.toDouble()
                                ],
                                min: 0,
                                max: 50,
                                trackBar: FlutterSliderTrackBar(
                                    activeDisabledTrackBarColor:
                                        const Color(0xffff9600)),
                                handler: FlutterSliderHandler(
                                  decoration: BoxDecoration(),
                                  disabled: true,
                                  child: Container(),
                                ),
                              ),
                            ),
                            Text(
                              'Talked to people (' +
                                  (snapshot.data.peopleTalkedTo > 30
                                      ? '30'
                                      : snapshot.data.peopleTalkedTo
                                          .toString()) +
                                  '/50)',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 18),
                            ),
                            SizedBox(
                              height: 30,
                              child: FlutterSlider(
                                disabled: true,
                                values: [
                                  snapshot.data.peopleTalkedTo.toDouble()
                                ],
                                min: 0,
                                max: 30,
                                trackBar: FlutterSliderTrackBar(
                                    activeDisabledTrackBarColor:
                                        const Color(0xffff9600)),
                                handler: FlutterSliderHandler(
                                  decoration: BoxDecoration(),
                                  disabled: true,
                                  child: Container(),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2.1,
                              height: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: const Color(0xffff9600),
                              ),
                              child: MaterialButton(
                                textColor: Colors.white,
                                onPressed: () {},
                                child: Text(
                                  'claim reward',
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
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width / 2.1,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: const Color(0xffff9600),
                        ),
                        child: MaterialButton(
                          textColor: Colors.white,
                          onPressed: () {
                            final databaseProvider =
                                context.read<DatabaseProvider>();
                            _showBottomSheet(
                                context, databaseProvider, settingsWidget);
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
                        margin: const EdgeInsets.only(top: 30),
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
                        margin: const EdgeInsets.only(top: 30),
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
          } else {
            return Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(const Color(0xffff9600)),
                strokeWidth: 4,
              ),
            );
          }
        });
  }
}

Future saveName(UserData userData, DatabaseProvider databaseProvider) async {
  await databaseProvider.setUser(userData);
}

Future uploadPicture(_SettingsState settingsWidget,
    DatabaseProvider databaseProvider, File file) async {
  await databaseProvider.uploadFile(file);
  settingsWidget.userData.profilePictureURL = await databaseProvider.getFile();
  await databaseProvider.setUser(settingsWidget.userData);
}

Future<File> compressFile(File file) async {
  File compressedFile = await FlutterNativeImage.compressImage(
    file.path,
    quality: 0,
  );
  return compressedFile;
}

class ImageDialog extends StatelessWidget {
  final profileImage;

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

void _showBottomSheet(
    context, DatabaseProvider databaseProvider, _SettingsState settingsWidget) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10)),
    ),
    context: context,
    builder: (builder) {
      return new Container(
        height: MediaQuery.of(context).size.height / 4,
        padding: const EdgeInsets.only(
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
                    context, databaseProvider, settingsWidget)),
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
                _showNameDialog(context, databaseProvider, settingsWidget);
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
                'changeInterests'.tr(),
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SettingsInterests(settingsWidget.userData.interests),
                  )),
            ),
          ],
        ),
      );
    },
  );
}

void _showImageBottomSheet(
    context, DatabaseProvider databaseProvider, _SettingsState settingsWidget) {
  ImagePicker picker = ImagePicker();
  PickedFile pickedFile;

  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    context: context,
    builder: (builder) {
      return Container(
        padding: const EdgeInsets.only(
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
                  final imageFile = await compressFile(File(pickedFile.path));
                  await uploadPicture(
                      settingsWidget, databaseProvider, imageFile);
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
                  final imageFile = await compressFile(File(pickedFile.path));
                  await uploadPicture(
                      settingsWidget, databaseProvider, imageFile);
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

void _showNameDialog(
    context, DatabaseProvider databaseProvider, _SettingsState settingsWidget) {
  TextEditingController _nameController = TextEditingController();
  _nameController.text = settingsWidget.userData.name;
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
                    settingsWidget.userData.name = _nameController.text;
                    await saveName(settingsWidget.userData, databaseProvider);
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
        contentPadding: const EdgeInsets.only(left: 21, right: 20, top: 20),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: MaterialButton(
              child: Text(
                'yesDelete'.tr(),
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                context.read<DatabaseProvider>().deleteFile();
                context.read<DatabaseProvider>().deleteUserData();
                context.read<AuthProvider>().deleteUser();
                Phoenix.rebirth(context);
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
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
