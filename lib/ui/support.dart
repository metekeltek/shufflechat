import 'package:flutter/material.dart';

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
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: FittedBox(
                        child: Text(
                          'FAQ',
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
                        'If you have Questions, Problems or Feedback, send a email to:',
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
                      'Was ist Shufflechat?',
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
                          'Shufflechat ist eine App mit der du neue Leute kennen lernen kannst oder mit Leuten die du noch nicht kennst die Möglichkeit hast zu chatten.',
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
                      'Kann ich Shufflechat überall in der Welt benutzen?',
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
                          'Ja solange du Internet hast, kannst du Shufflechat von wo du willst benutzten. Momentan gibt es Shufflechat in 2 Sprachen, aber weitere kommen noch hinzu.',
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
                      'Wo kann ich über Neuigkeiten und zukünftige Updates von Shufflechat erfahren?',
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
                          'Auf Instagram unter dem Account Shufflechat und bald auch auf der Shufflechat Webseite.',
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
                      'Welche Daten werden von mir gespeichert?',
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
                          'Nur die Daten die du bei deinem Account angegeben hast! Und diesen kannst du jederzeit löschen.',
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
                      'Werden meine Daten an dritte weitergegeben?',
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
                          'Nein. Shufflechat gibt deine Daten an niemanden weiter.',
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
                      'Wie kann ich meine Daten löschen lassen?',
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
                          'Auf dem großen roten Knopf auf deiner Profil Seite.',
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
                      'Ist Shuffle Chat kostenlos?',
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
                          'Ja, die Hauptfunktion ist komplett kostenlos, du kannst mit so vielen Leuten chatten wie du willst ohne einen Cent auszugeben. Nur die Premiumfunktion kosten was.',
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
                      'Was beinhaltet das Premium Abo?',
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
                          'Das Premiumabo beinhaltet momentan 3 Filter (Alter, Geschlecht und Intressen) und weitere Filter werden dazu kommen, wie z.B. der Filter, "Region". Damit kannst du mit Leuten aus deinem Wunschland reden und schonmal deren Sprache und Kultur kennenlernen.',
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
                      'Wie kann ich mein Abo kündigen?',
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
                          'Dein Abo kannst du jederzeit kündigen. \n\nIOS:\nÖffne die Einstellungen-App.\nTippe auf deinen Namen.\nTippe auf "Abonnements".\nTippe auf das Abonnement, das du verwalten möchtest\nTippe auf "Abo kündigen". Wenn du "Abo kündigen" nicht siehst, wurde das Abonnement bereits gekündigt und wird nicht verlängert.\n\nAndroid:\nÖffnen Sie auf Ihrem Smartphone oder Tablet den Google Play Store .\nPrüfen Sie, ob Sie im richtigen Google-Konto angemeldet sind.\nTippen Sie auf das Dreistrich-Menü Abos.\nWählen Sie das Abo aus, das Sie kündigen möchten.\nTippen Sie auf Abo kündigen.\n',
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
                      'Ich bin unzufrieden, wie kriege ich mein Geld zurück?',
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
                          'Schreib eine Email an support@shufflechat.com, mit passendem Betreff und dem Grund warum du den Kauf stornieren willst. Wir werden dann auf dich zuück kommen.',
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
                      'Kommen noch neue Features für diese App?',
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
                          'Ja jede Menge sind geplant, falls du Ideen hast gerne an die oben angegebene Email schicken.',
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
                      'Was sollte ich bei meinem Foto beachten?',
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
                          'Das Foto muss den Nutzungsrichtlinien entsprechen.\nAccounts mit sexuellen, rassistischen oder Hass-erfüllten Bild oder Namen werden gesperrt.',
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
                      'Wer darf alles Shuffle Chat benutzen?',
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
                          'Jeder der über 18 Jahre alt ist',
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
                      'Was soll ich tun wenn ich technische Probleme mit der App habe?',
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
                          'An die oben angebene Email eine Nachicht mit dem passenden Betreff schicken schicken.\nIn der Nachricht beschreiben was das Problem ist und welches Gerät du benutzt (z.B. "Iphone 11").',
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
