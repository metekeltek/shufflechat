import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class Legal extends StatefulWidget {
  @override
  _LegalState createState() => _LegalState();
}

class _LegalState extends State<Legal> {
  bool isEnglish;

  @override
  Widget build(BuildContext context) {
    if (EasyLocalization.of(context).locale == Locale('en')) {
      isEnglish = true;
    } else {
      isEnglish = false;
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
              height: 150,
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
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.2,
              child: ListView(
                padding: const EdgeInsets.only(top: 5),
                children: [
                  ExpansionTile(
                    tilePadding:
                        const EdgeInsets.only(left: 15, right: 15, bottom: 10),
                    title: Text(
                      'terms'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        child: Text(
                          isEnglish ? termsTextEnglish : termsTextGerman,
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
                    title: Text(
                      'privacy'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
                        child: Text(
                          isEnglish ? privacyTextEnglish : privacyTextGerman,
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
                    title: Text(
                      'communityGuidlines'.tr(),
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 23.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, bottom: 10),
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
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}

const String termsTextGerman = """
    Deutsch blablabla
    Zuletzt überarbeitet am 0.1.08.2020

Wichtige Änderungen in dieser Version: Wir haben für Mitglieder mit Wohnsitz in Japan unseren Firmennamen in MG Japan Services GK geändert.

Für eine Zusammenfassung unserer Nutzungsbedingungen gehen Sie bitte zur Zusammenfassung der Bedingungen.

Willkommen bei Tinder. Wenn Sie in der Europäischen Union leben, sind diese Nutzungsbedingungen zwischen Ihnen und:

MTCH Technology Services Limited ("MTCH Technology")
WeWork Charlemont Exchange
Charlemont Street
Dublin 2 D02 VN88
Irland

Wenn Sie in Japan leben, gelten diese Nutzungsbedingungen zwischen Ihnen und:

MG Japan Services GK ("MG Japan") 4F Sumitomo Fudosan Azabu Bldg 1-4-1 Mita Minato-ku, Tokyo 108-0073 Japan

Wenn Sie außerhalb der Europäischen Union und Japan leben, sind diese Nutzungsbedingungen zwischen Ihnen und:

Match Group, LLC ("Match Group")
8750 North Central Expressway, Suite 1400
Dallas, TX 75231, USA

Die Begriffe ("uns", "wir", "Unternehmen" oder "Tinder") beziehen sich je nach Wohnsitz auf MTCH Technology, MG Japan oder Match Group.
 
 1. Annahme des Vertrags über die Nutzungsbedingungen.
Durch das Erstellen eines Tinder-Kontos, sei es mit einem Mobilgerät, einer mobilen Anwendung oder einem Computer (zusammenfassend der "Dienst" genannt) erklären Sie sich einverstanden, an (i) diese Nutzungsbedingungen, (ii) unsere Datenschutzrichtlinie, unsere Cookie-Richtlinie, unsere Schlichtungsverfahren (falls dies auf Sie zutrifft) und an die Sicherheitstipps, wobei jeder Punkt durch Bezugnahme in diesem Vertrag aufgenommen ist, sowie an (iii) sämtliche Bedingungen, die von Ihnen offengelegt werden und denen Sie zugestimmt haben, wenn Sie zusätzliche Funktionen, Produkte oder Dienste erwerben, die wir im Rahmen des Dienstes anbieten (zusammenfassend dieser "Vertrag" genannt), gebunden zu sein. Wenn Sie nicht alle Bedingungen dieses Vertrags annehmen und sich mit diesen nicht einverstanden erklären, bitten wir Sie, den Dienst nicht zu nutzen.

Wir sind berechtigt, von Zeit zu Zeit Änderungen an diesem Vertrag und an dem Dienst vorzunehmen. Diese können wir aus verschiedenen Gründen vornehmen, z. B. um Gesetzesänderungen oder veränderte gesetzliche Anforderungen, neue Funktionen oder Änderungen von Geschäftspraktiken widerzuspiegeln. Die aktuellste Version dieses Vertrags wird im Rahmen des Dienstes in den Einstellungen und auf gotinder.com gepostet, und Sie sollten regelmäßig die aktuellste Version lesen. Die aktuellste Version ist immer die Version, die Gültigkeit hat. Wenn die Änderungen bedeutende Änderungen umfassen, die Ihre Rechte oder Pflichten betreffen, werden wir Sie auf angemessene Weise über diese Änderungen informieren, z. B. per Mitteilungen über den Dienst oder per E-Mail. Wenn Sie den Dienst weiterhin nutzen, nachdem die Änderungen wirksam werden, stimmen Sie dem überarbeiteten Vertrag zu.

2. Berechtigung.
Sie müssen mindestens 18 Jahre alt sein, um ein Konto auf Tinder erstellen und den Dienst nutzen zu können. Durch das Erstellen eines Kontos und durch die Nutzung des Dienstes erklären und gewährleisten Sie, dass:

Sie einen verbindlichen Vertrag mit Tinder schließen können;
Sie nicht zu einem Personenkreis gehören, der von der Nutzung des Dienstes gemäß den Gesetzen der Vereinigten Staaten oder einer anderen geltenden Gerichtsbarkeit ausgeschlossen ist – d. h. Sie nicht auf der Liste des US-amerikanischen Finanzministeriums für besonders gekennzeichnete Staatsangehörige (Specially Designated Nationals) geführt werden oder einem anderen ähnlichen Verbot unterliegen;
Sie diesen Vertrag und alle geltenden lokalen, staatlichen, nationalen und internationalen Gesetze, Regeln und Vorschriften einhalten werden; und
Sie zu keinem Zeitpunkt ein *Schwerverbrechen* oder eine Straftat (oder ein Verbrechen von ähnlichem Ausmaß), ein Sexualverbrechen oder eine Straftat mit Gewalt begangen haben, und dass Sie in keinem staatlichen, bundesstaatlichen oder lokalen Sexualstraftäterregister als Sexualstraftäter geführt werden.
3. Ihr Konto.
Um Tinder zu verwenden, können Sie sich mit Ihrem Facebook-Login anmelden. Wenn Sie das tun, berechtigen Sie uns in Bezug auf den Zugriff auf bzw. die Verwendung bestimmter Facebook-Konto-Informationen, einschließlich, aber nicht beschränkt auf Ihr öffentliches Facebook-Profil. Für weitere Informationen bezüglich der Informationen, die wir von Ihnen erheben und über die Art und Weise, wie wir diese nutzen, ziehen Sie bitte unsere Datenschutzrichtlinie zu Rate.

Sie sind dafür verantwortlich, die Zugangsdaten, die Sie zur Anmeldung bei Tinder verwenden, vertraulich zu behandeln, und tragen die alleinige Verantwortung für sämtliche Aktivitäten, die unter diesen Zugangsdaten auftreten. Wenn Sie denken, dass sich jemand Zugriff auf Ihr Konto verschafft hat, kontaktieren Sie uns bitte unverzüglich über unser Kontaktformular.
    """;

const String termsTextEnglish = """
    Englisch blablabla
    Zuletzt überarbeitet am 0.1.08.2020

Wichtige Änderungen in dieser Version: Wir haben für Mitglieder mit Wohnsitz in Japan unseren Firmennamen in MG Japan Services GK geändert.

Für eine Zusammenfassung unserer Nutzungsbedingungen gehen Sie bitte zur Zusammenfassung der Bedingungen.

Willkommen bei Tinder. Wenn Sie in der Europäischen Union leben, sind diese Nutzungsbedingungen zwischen Ihnen und:

MTCH Technology Services Limited ("MTCH Technology")
WeWork Charlemont Exchange
Charlemont Street
Dublin 2 D02 VN88
Irland

Wenn Sie in Japan leben, gelten diese Nutzungsbedingungen zwischen Ihnen und:

MG Japan Services GK ("MG Japan") 4F Sumitomo Fudosan Azabu Bldg 1-4-1 Mita Minato-ku, Tokyo 108-0073 Japan

Wenn Sie außerhalb der Europäischen Union und Japan leben, sind diese Nutzungsbedingungen zwischen Ihnen und:

Match Group, LLC ("Match Group")
8750 North Central Expressway, Suite 1400
Dallas, TX 75231, USA

Die Begriffe ("uns", "wir", "Unternehmen" oder "Tinder") beziehen sich je nach Wohnsitz auf MTCH Technology, MG Japan oder Match Group.
 
 1. Annahme des Vertrags über die Nutzungsbedingungen.
Durch das Erstellen eines Tinder-Kontos, sei es mit einem Mobilgerät, einer mobilen Anwendung oder einem Computer (zusammenfassend der "Dienst" genannt) erklären Sie sich einverstanden, an (i) diese Nutzungsbedingungen, (ii) unsere Datenschutzrichtlinie, unsere Cookie-Richtlinie, unsere Schlichtungsverfahren (falls dies auf Sie zutrifft) und an die Sicherheitstipps, wobei jeder Punkt durch Bezugnahme in diesem Vertrag aufgenommen ist, sowie an (iii) sämtliche Bedingungen, die von Ihnen offengelegt werden und denen Sie zugestimmt haben, wenn Sie zusätzliche Funktionen, Produkte oder Dienste erwerben, die wir im Rahmen des Dienstes anbieten (zusammenfassend dieser "Vertrag" genannt), gebunden zu sein. Wenn Sie nicht alle Bedingungen dieses Vertrags annehmen und sich mit diesen nicht einverstanden erklären, bitten wir Sie, den Dienst nicht zu nutzen.

Wir sind berechtigt, von Zeit zu Zeit Änderungen an diesem Vertrag und an dem Dienst vorzunehmen. Diese können wir aus verschiedenen Gründen vornehmen, z. B. um Gesetzesänderungen oder veränderte gesetzliche Anforderungen, neue Funktionen oder Änderungen von Geschäftspraktiken widerzuspiegeln. Die aktuellste Version dieses Vertrags wird im Rahmen des Dienstes in den Einstellungen und auf gotinder.com gepostet, und Sie sollten regelmäßig die aktuellste Version lesen. Die aktuellste Version ist immer die Version, die Gültigkeit hat. Wenn die Änderungen bedeutende Änderungen umfassen, die Ihre Rechte oder Pflichten betreffen, werden wir Sie auf angemessene Weise über diese Änderungen informieren, z. B. per Mitteilungen über den Dienst oder per E-Mail. Wenn Sie den Dienst weiterhin nutzen, nachdem die Änderungen wirksam werden, stimmen Sie dem überarbeiteten Vertrag zu.

2. Berechtigung.
Sie müssen mindestens 18 Jahre alt sein, um ein Konto auf Tinder erstellen und den Dienst nutzen zu können. Durch das Erstellen eines Kontos und durch die Nutzung des Dienstes erklären und gewährleisten Sie, dass:

Sie einen verbindlichen Vertrag mit Tinder schließen können;
Sie nicht zu einem Personenkreis gehören, der von der Nutzung des Dienstes gemäß den Gesetzen der Vereinigten Staaten oder einer anderen geltenden Gerichtsbarkeit ausgeschlossen ist – d. h. Sie nicht auf der Liste des US-amerikanischen Finanzministeriums für besonders gekennzeichnete Staatsangehörige (Specially Designated Nationals) geführt werden oder einem anderen ähnlichen Verbot unterliegen;
Sie diesen Vertrag und alle geltenden lokalen, staatlichen, nationalen und internationalen Gesetze, Regeln und Vorschriften einhalten werden; und
Sie zu keinem Zeitpunkt ein *Schwerverbrechen* oder eine Straftat (oder ein Verbrechen von ähnlichem Ausmaß), ein Sexualverbrechen oder eine Straftat mit Gewalt begangen haben, und dass Sie in keinem staatlichen, bundesstaatlichen oder lokalen Sexualstraftäterregister als Sexualstraftäter geführt werden.
3. Ihr Konto.
Um Tinder zu verwenden, können Sie sich mit Ihrem Facebook-Login anmelden. Wenn Sie das tun, berechtigen Sie uns in Bezug auf den Zugriff auf bzw. die Verwendung bestimmter Facebook-Konto-Informationen, einschließlich, aber nicht beschränkt auf Ihr öffentliches Facebook-Profil. Für weitere Informationen bezüglich der Informationen, die wir von Ihnen erheben und über die Art und Weise, wie wir diese nutzen, ziehen Sie bitte unsere Datenschutzrichtlinie zu Rate.

Sie sind dafür verantwortlich, die Zugangsdaten, die Sie zur Anmeldung bei Tinder verwenden, vertraulich zu behandeln, und tragen die alleinige Verantwortung für sämtliche Aktivitäten, die unter diesen Zugangsdaten auftreten. Wenn Sie denken, dass sich jemand Zugriff auf Ihr Konto verschafft hat, kontaktieren Sie uns bitte unverzüglich über unser Kontaktformular.
    """;

final String privacyTextGerman = """
    Deutsch blablabla

    Bei der Tinder ist Ihre Privatsphäre höchste Priorität. Ihre Privatsphäre steht bei der Konzipierung und Entwicklung der Dienste und Produkte, die Sie kennen und lieben, im Mittelpunkt, so dass Sie ihnen Ihr vollstes Vertrauen schenken und sich auf die Etablierung bedeutungsvoller Verbindungen konzentrieren können.

Wir schätzen das Vertrauen, das Sie in uns setzen, wenn Sie uns Ihre persönlichen Daten übertragen und nehmen dies nicht auf die leichte Schulter.

Wir kompromittieren Ihre Privatsphäre nicht. Bei der Entwicklung all unsere Produkte und Dienste denken wir stets an Ihre Privatsphäre. Wir arbeiten mit Experten aus verschiedenen Fachbereichen zusammen, unter anderem mit der Rechts- und Sicherheitsbranche, dem Ingenieurwesen und der Produktentwicklung, um sicherzustellen, dass keinerlei Entscheidungen ohne Berücksichtigung Ihrer Privatsphäre getroffen werden.

Wir bemühen uns, bei der Verarbeitung Ihrer Daten transparent zu sein. Da wir viele der Online-Dienste nutzen, die Sie ebenfalls verwenden, wissen wir, dass unzureichende Informationen und eine übermäßig komplizierte Wortwahl häufige Schwierigkeiten der Datenschutzbestimmungen sind. Daher verfolgen wir einen genau umgekehrten Ansatz: wir haben unsere Datenschutzbestimmungen und alle zugehörigen Dokumente in einer verständlichen Sprache verfasst. Wir möchten, dass Sie unsere Datenschutzbestimmungen lesen und verstehen!

Wir unternehmen große Anstrengungen, um Ihre Daten zu schützen. Wir verfügen über Teams, die dafür sorgen, dass Ihre Daten sicher und geschützt sind. Wir aktualisieren unsere Sicherheitsverfahren kontinuierlich und investieren in unsere Sicherheitsbemühungen, um den Schutz Ihrer Daten zu verstärken.

DATENSCHUTZBESTIMMUNGEN
Herzlich willkommen zu den Datenschutzbestimmungen von Tinder. Vielen Dank, dass Sie sich die Zeit nehmen, um sich mit ihnen vertraut zu machen.

Wir schätzen, dass Sie uns Ihre Daten anvertrauen und versuchen, Ihrem Vertrauen stets gerecht zu werden. Dies beginnt damit, sicherzustellen, dass Sie verstehen, welche Daten wir erfassen, warum wir sie erfassen, wie wir sie verwenden und welche Wahlmöglichkeiten Ihnen hinsichtlich dieser Daten zur Verfügung stehen. Die vorliegenden Bestimmungen beschreiben unsere Datenschutzpraktiken in verständlicher Sprache, wobei Rechtssprache und Fachjargon auf ein Minimum reduziert sind.

Die vorliegenden Datenschutzbestimmungen gelten ab dem 25. Mai 2018. Bis dahin gilt die bisherige Version der vorliegenden Datenschutzbestimmungen, die Sie hier finden.

DATUM DES INKRAFTTRETENS : 25. Mai 2018

Wer wir sind
Wo diese Datenschutzrichtlinie gültig ist
Daten, die wir erfassen
Cookies und vergleichbare Datenerfassungstechnologien
Wie wir Ihre Daten verwenden
Wie wir Ihre Daten teilen
Landesübergreifende Datenübermittlung
Ihre Rechte
Einwohner von Kalifornien
Wie wir Ihre Daten schützen
Wie lang wir Ihre Daten vorhalten
Die Privatsphäre von Kindern
Änderungen der Datenschutzrichtlinie
Wie Sie uns kontaktieren können
Für kalifornische Nutzer

Lesen Sie bitte unseren Datenschutzhinweis, der für Kalifornien gilt, um sich über die Datenschutzrechte in Kalifornien zu informieren.

1. Wer wir sind

Falls Sie in der Europäischen Union ansässig sind, ist das Unternehmen, das im Rahmen der vorliegenden Datenschutzbestimmungen für Ihre Daten verantwortlich ist (der „Datenverantwortliche“):

MTCH Technology Services Limited

Tinder

WeWork Charlemont Exchange

42 Charlemont Street

Dublin 2, D02 R593

Irland
Falls Sie in Japan ansässig sind, ist das Unternehmen, das für Ihre Daten verantwortlich ist:

MG Japan Services GK

4F Sumitomo Fudosan Azabu Bldg

1-4-1 Mita

Minato-ku,Tokyo 108-0073

Japan
Falls Sie außerhalb der Europäischen Union und Japan ansässig sind, ist das Unternehmen, das für Ihre Daten verantwortlich ist:

Match Group, LLC

8750 North Central Expressway

Suite 1400

Dallas, TX 75231, USA

United States
       """;

final String privacyTextEnglish = """
    Englisch blablabla

    Bei der Tinder ist Ihre Privatsphäre höchste Priorität. Ihre Privatsphäre steht bei der Konzipierung und Entwicklung der Dienste und Produkte, die Sie kennen und lieben, im Mittelpunkt, so dass Sie ihnen Ihr vollstes Vertrauen schenken und sich auf die Etablierung bedeutungsvoller Verbindungen konzentrieren können.

Wir schätzen das Vertrauen, das Sie in uns setzen, wenn Sie uns Ihre persönlichen Daten übertragen und nehmen dies nicht auf die leichte Schulter.

Wir kompromittieren Ihre Privatsphäre nicht. Bei der Entwicklung all unsere Produkte und Dienste denken wir stets an Ihre Privatsphäre. Wir arbeiten mit Experten aus verschiedenen Fachbereichen zusammen, unter anderem mit der Rechts- und Sicherheitsbranche, dem Ingenieurwesen und der Produktentwicklung, um sicherzustellen, dass keinerlei Entscheidungen ohne Berücksichtigung Ihrer Privatsphäre getroffen werden.

Wir bemühen uns, bei der Verarbeitung Ihrer Daten transparent zu sein. Da wir viele der Online-Dienste nutzen, die Sie ebenfalls verwenden, wissen wir, dass unzureichende Informationen und eine übermäßig komplizierte Wortwahl häufige Schwierigkeiten der Datenschutzbestimmungen sind. Daher verfolgen wir einen genau umgekehrten Ansatz: wir haben unsere Datenschutzbestimmungen und alle zugehörigen Dokumente in einer verständlichen Sprache verfasst. Wir möchten, dass Sie unsere Datenschutzbestimmungen lesen und verstehen!

Wir unternehmen große Anstrengungen, um Ihre Daten zu schützen. Wir verfügen über Teams, die dafür sorgen, dass Ihre Daten sicher und geschützt sind. Wir aktualisieren unsere Sicherheitsverfahren kontinuierlich und investieren in unsere Sicherheitsbemühungen, um den Schutz Ihrer Daten zu verstärken.

DATENSCHUTZBESTIMMUNGEN
Herzlich willkommen zu den Datenschutzbestimmungen von Tinder. Vielen Dank, dass Sie sich die Zeit nehmen, um sich mit ihnen vertraut zu machen.

Wir schätzen, dass Sie uns Ihre Daten anvertrauen und versuchen, Ihrem Vertrauen stets gerecht zu werden. Dies beginnt damit, sicherzustellen, dass Sie verstehen, welche Daten wir erfassen, warum wir sie erfassen, wie wir sie verwenden und welche Wahlmöglichkeiten Ihnen hinsichtlich dieser Daten zur Verfügung stehen. Die vorliegenden Bestimmungen beschreiben unsere Datenschutzpraktiken in verständlicher Sprache, wobei Rechtssprache und Fachjargon auf ein Minimum reduziert sind.

Die vorliegenden Datenschutzbestimmungen gelten ab dem 25. Mai 2018. Bis dahin gilt die bisherige Version der vorliegenden Datenschutzbestimmungen, die Sie hier finden.

DATUM DES INKRAFTTRETENS : 25. Mai 2018

Wer wir sind
Wo diese Datenschutzrichtlinie gültig ist
Daten, die wir erfassen
Cookies und vergleichbare Datenerfassungstechnologien
Wie wir Ihre Daten verwenden
Wie wir Ihre Daten teilen
Landesübergreifende Datenübermittlung
Ihre Rechte
Einwohner von Kalifornien
Wie wir Ihre Daten schützen
Wie lang wir Ihre Daten vorhalten
Die Privatsphäre von Kindern
Änderungen der Datenschutzrichtlinie
Wie Sie uns kontaktieren können
Für kalifornische Nutzer

Lesen Sie bitte unseren Datenschutzhinweis, der für Kalifornien gilt, um sich über die Datenschutzrechte in Kalifornien zu informieren.

1. Wer wir sind

Falls Sie in der Europäischen Union ansässig sind, ist das Unternehmen, das im Rahmen der vorliegenden Datenschutzbestimmungen für Ihre Daten verantwortlich ist (der „Datenverantwortliche“):

MTCH Technology Services Limited

Tinder

WeWork Charlemont Exchange

42 Charlemont Street

Dublin 2, D02 R593

Irland
Falls Sie in Japan ansässig sind, ist das Unternehmen, das für Ihre Daten verantwortlich ist:

MG Japan Services GK

4F Sumitomo Fudosan Azabu Bldg

1-4-1 Mita

Minato-ku,Tokyo 108-0073

Japan
Falls Sie außerhalb der Europäischen Union und Japan ansässig sind, ist das Unternehmen, das für Ihre Daten verantwortlich ist:

Match Group, LLC

8750 North Central Expressway

Suite 1400

Dallas, TX 75231, USA

United States
       """;
