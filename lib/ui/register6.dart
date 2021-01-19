import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shufflechat/models/UserData.dart';
import 'package:provider/provider.dart';
import 'package:shufflechat/services/authProvider.dart';
import 'package:shufflechat/services/dbProvider.dart';
import 'package:shufflechat/ui/shuffleScreen.dart';

File _toUploadFile;

class Register6 extends StatefulWidget {
  @override
  _Register6State createState() => _Register6State();
}

class _Register6State extends State<Register6> {
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<UserData>(context);
    var register6Widget = this;

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
              padding: EdgeInsets.only(left: 24),
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Click on the Image to choose a profile picture',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              height: 300,
              child: Center(
                child: GestureDetector(
                  onTap: () => _showImageBottomSheet(context, register6Widget),
                  child: (() {
                    if (_toUploadFile != null) {
                      return CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: new FileImage(_toUploadFile),
                        radius: 75.0,
                      );
                    } else {
                      return Icon(
                        Icons.add_photo_alternate_outlined,
                        color: Colors.black,
                        size: 110,
                        semanticLabel: 'Picture',
                      );
                    }
                  }()),
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
                onPressed: () async {
                  final uid = context.read<AuthProvider>().getUID();
                  if (_toUploadFile != null) {
                    context.read<UserData>().setUserDataModel(userData);
                    await context
                        .read<DatabaseProvider>()
                        .uploadFile(uid, _toUploadFile);
                    context.read<UserData>().profilePictureURL =
                        await context.read<DatabaseProvider>().getFile(uid);
                  }
                  await context.read<DatabaseProvider>().setUser(uid, userData);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShuffleScreen(),
                      ));
                },
                child: Text('Complete Registration'),
              ),
            )
          ],
        )),
      ),
    );
  }
}

void _showImageBottomSheet(context, _Register6State settingsWidget) {
  ImagePicker picker = ImagePicker();
  PickedFile pickedFile;

  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
    context: context,
    builder: (builder) {
      return new Container(
        padding: EdgeInsets.only(
          left: 5.0,
          right: 5.0,
          top: 5.0,
          bottom: 5.0,
        ),
        height: MediaQuery.of(context).size.height / 6,
        decoration: new BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(50)),
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
              title: const Text(
                'Take Image',
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
                _toUploadFile = File(pickedFile.path);
                settingsWidget.refresh();
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
              title: const Text(
                'Choose from Gallery',
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
                _toUploadFile = File(pickedFile.path);
                settingsWidget.refresh();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    },
  );
}
