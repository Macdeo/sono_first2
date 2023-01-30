import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../notes/note.dart';
import 'contact_carthera.dart';
import 'contact_pi.dart';
import 'coordinator.dart';
import 'ecrf_rando.dart';
import 'guideline.dart';
import 'protocole.dart';
import 'sae_declaration.dart';
import 'website.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 100,
        flexibleSpace: Image.asset(
          'images/Sonofirst3.jpeg',
          height: 220,
          fit: BoxFit.contain,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 40.0, left: 15.0, right: 15.0),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 95, right: 95.0),
            child: ElevatedButton(
              onPressed: () async {
                final url =
                    'https://drive.google.com/file/d/16373tuFGqshxwqTX9XgTDZd_qPoHsDWk/view?usp=sharing';

                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: true,
                    forceWebView: true,
                    enableJavaScript: true,
                  );
                }
              },
              child: const Text(
                "GuideLines",
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 0, 191, 255),
                elevation: 5,
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 95, right: 95.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const EcrfRando();
                }));
              },
              child: const Text(
                "ECRF Rando",
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 0, 191, 255),
                elevation: 5,
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 95, right: 95.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Protocole();
                }));
              },
              child: const Text(
                "clinicaltrial.gov",
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 0, 191, 255),
                elevation: 5,
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              ),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SaeDeclaration();
                }));
              },
              child: const Text(
                "SAE Declaration",
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 76, 126, 246),
                  elevation: 5,
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 50, right: 50.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ContactCarthera();
                }));
              },
              child: const Text(
                "Contact CarThera",
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 76, 126, 246),
                  elevation: 5,
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 50, right: 50.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Coordinator();
                }));
              },
              child: const Text(
                "Contact Coordinator",
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 76, 126, 246),
                  elevation: 5,
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 50, right: 50.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ContactPi();
                }));
              },
              child: const Text(
                "Contact PI",
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 76, 126, 246),
                  elevation: 5,
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0)),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const Website();
                }));
              },
              child: const Text(
                "Web Site",
                style: TextStyle(fontSize: 17),
              ),
              style: ElevatedButton.styleFrom(
                  primary: const Color.fromARGB(255, 49, 4, 172), elevation: 5),
            ),
          ),
        ],
      ),
      floatingActionButton: Wrap(
        direction: Axis.vertical,
        children: [
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            child: FloatingActionButton(
              child: const Icon(Icons.picture_as_pdf),
              onPressed: () async {
                final url =
                    'https://drive.google.com/file/d/1tJDFsKVkAZjiCKuF5qpnM9UMtm732hbM/view?usp=sharing';

                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: true,
                    forceWebView: true,
                    enableJavaScript: true,
                  );
                }
              },
              backgroundColor: Colors.red,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            child: FloatingActionButton(
              child: const Icon(
                Icons.sticky_note_2,
                size: 30,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Notes();
                }));
              },
              heroTag: null,
              backgroundColor: Colors.blue,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
    );
  }

  void onSelected(BuildContext context, int item) {
    switch (item) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const SaeDeclaration();
        }));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ContactCarthera();
        }));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const Coordinator();
        }));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ContactPi();
        }));
        break;
    }
  }
}
