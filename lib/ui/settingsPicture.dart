import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:shufflechat/services/dbProvider.dart';
import 'package:shufflechat/ui/shuffleScreen.dart';

class SettingsPicture extends StatefulWidget {
  @override
  _SettingsPictureState createState() => _SettingsPictureState();
}

class _SettingsPictureState extends State<SettingsPicture> {
  File _toUploadFile;
  bool pictureChanges = false;
  bool registering;

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);

    Future getImage(bool gallery) async {
      ImagePicker picker = ImagePicker();
      PickedFile pickedFile;
      // Let user select photo from gallery
      if (gallery) {
        pickedFile = await picker.getImage(
          source: ImageSource.gallery,
          imageQuality: 1,
        );
      }
      // Otherwise open camera to get new photo
      else {
        pickedFile = await picker.getImage(
          source: ImageSource.camera,
          imageQuality: 1,
        );
      }

      setState(() {
        if (pickedFile != null) {
          _toUploadFile = File(pickedFile.path);
          pictureChanges = true;
        } else {
          print('No image selected.');
        }
      });
    }

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
                          if (pictureChanges) {
                            final uid = context.read<AuthProvider>().getUID();
                            context.read<UserData>().setUserDataModel(userData);
                            await context
                                .read<DatabaseProvider>()
                                .uploadFile(uid, _toUploadFile);
                            context.read<UserData>().profilePictureURL =
                                await context
                                    .read<DatabaseProvider>()
                                    .getFile(uid);
                            await context
                                .read<DatabaseProvider>()
                                .setUser(uid, userData);
                          }
                          Navigator.pop(context);
                        },
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
              height: 60,
              padding: EdgeInsets.only(right: 10),
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  'Profile Picture',
                  style: TextStyle(fontSize: 55.0, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Container(
              height: 27,
              padding: EdgeInsets.only(left: 25),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Choose a profile picture',
                style: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: 300,
              child: Center(
                child: GestureDetector(
                  onTap: () => getImage(true),
                  child: (() {
                    if (userData.profilePictureURL != null) {
                      return CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            new NetworkImage(userData.profilePictureURL),
                        radius: 75.0,
                      );
                    } else if (_toUploadFile != null) {
                      return CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: new FileImage(_toUploadFile),
                        radius: 75.0,
                      );
                    } else {
                      return Icon(
                        Icons.supervised_user_circle_rounded,
                        color: Colors.black,
                        size: 150,
                        semanticLabel: 'Picture',
                      );
                    }
                  }()),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
