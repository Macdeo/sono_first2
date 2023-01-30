import 'package:flutter/material.dart';
import 'package:sono_first/ui/chats_page.dart';
import 'package:sono_first/ui/home.dart';
// import 'package:sono_first/ui/users_page.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int myIndex = 0;
  List<Widget> widgetList = [const Home(), ChatsPage()];
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetList[myIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedIconTheme: const IconThemeData(
              color: Color.fromARGB(255, 49, 4, 172), size: 25),
          selectedItemColor: const Color.fromARGB(255, 49, 4, 172),
          selectedLabelStyle: const TextStyle(fontSize: 13),
          unselectedIconTheme: const IconThemeData(color: Colors.indigo),
          unselectedLabelStyle: const TextStyle(fontSize: 13),
          unselectedItemColor: Colors.indigo[300],
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
          ],
          currentIndex: myIndex,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          }),
    );
  }
}
