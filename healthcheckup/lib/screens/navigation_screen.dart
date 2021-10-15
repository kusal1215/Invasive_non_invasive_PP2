
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:healthcheckup/screens/home_page.dart';

class NavigationScreen extends StatefulWidget {
  final FirebaseApp app;
  const NavigationScreen({Key key,this.app}) : super(key: key);

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 3,
        centerTitle: true,
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: SvgPicture.asset(
                  "images/back_arrow_icon.svg",
                  width: 17,
                  height: 17,
                  color: Color(0xff7B7B7B),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Image.asset(
                    "images/app_bar_icon.png",
                width: MediaQuery.of(context).size.width-60,
                    height: 70,),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: SvgPicture.asset(
                  "images/notifications_icon.svg",
                  color: Colors.black,
                  width: 17,
                  height: 17,
                ),
              ),
            ],
          ),
        ),
      ),
      body: HomePage(widget.app),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: setSVGIcon(1, seletedColor(0)),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: setSVGIcon(2, seletedColor(1)),
            ),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: setSVGIcon(3, seletedColor(2)),
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: setSVGIcon(4, seletedColor(3)),
            ),
            label: 'Mobile',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: setSVGIcon(5, seletedColor(4)),
            ),
            label: 'Wearable',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: setSVGIcon(6, seletedColor(5)),
            ),
            label: 'Social',
          ),
        ],
        currentIndex: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        unselectedItemColor: Color(0xffA7A7A7),
        selectedItemColor: Color(0xff5A72FF),
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontSize: 12),
        onTap: _onItemTapped,
      ),
    );
  }


  Color seletedColor(position) {
    if (_selectedIndex == position)
      return Color(0xff5A72FF);
    else
      return Color(0xffA7A7A7);
  }

  Widget setSVGIcon(position, color) {
    switch (position) {
      case 1:
        return SvgPicture.asset(
          "images/home_icon.svg",
          color: color,
        );
        break;

      case 2:
        return SvgPicture.asset(
          "images/camera_icon.svg",
          color: color,
        );
        break;

      case 3:
        return SvgPicture.asset(
          "images/message_icon.svg",
          color: color,
        );
        break;

      case 4:
        return SvgPicture.asset(
          "images/phone_icon.svg",
          color: color,
        );
        break;

      case 5:
        return SvgPicture.asset(
          "images/smartwatch.svg",
          color: color,
        );
        break;

      case 6:
        return SvgPicture.asset(
          "images/twitter_icon.svg",
          color: color,
        );
        break;
    }
  }

}
