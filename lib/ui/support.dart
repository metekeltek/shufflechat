import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  var backgroundColor = const Color(0xffffe8c9);
  final mail = 'support@shufflechat.com';
  TextEditingController mailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 3,
              child: Column(
                children: [
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Container(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          'FAQ'.tr(),
                          style: TextStyle(
                              fontSize: 60.0, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'anyQuestions'.tr(),
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                            fontSize: 19.0, fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: SelectableText(
                        'support@shufflechat.com',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xffff9600)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.5,
              child: ListView(
                padding: const EdgeInsets.only(top: 5),
                children: [
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'whatIsShufflechatQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'whatIsShufflechatAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'shuffleChatWorldWideQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'shuffleChatWorldWideAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'shuffleChatNewsQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'shuffleChatNewsAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'dataQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'dataAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'dataThirdPartyQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'dataThirdPartyAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'dataDeleteQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'dataDeleteAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'freeQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'freeAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'premiumQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'premiumAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'cancelQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'cancelAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'moneyBackQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'moneyBackAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'newUpdatesQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'newUpdatesAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'photoQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'photoAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'userQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 10),
                        child: Text(
                          'userAnswer'.tr(),
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 20),
                    backgroundColor: backgroundColor,
                    title: Text(
                      'technicalQuestion'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 15, right: 15, bottom: 30),
                        child: Text(
                          'technicalAnswer'.tr(),
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                    trailing: Icon(
                      Icons.arrow_downward,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
