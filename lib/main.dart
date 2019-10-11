import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:taskplus/login/login.dart';
import 'package:taskplus/home/home.dart';

import 'package:gradient_app_bar/gradient_app_bar.dart';

// runs the app
void main() => runApp(App());

// this class sets the appropriate app
// settings and runs the Main() class.
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: removeScrollGlow(),
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Task+',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      home: Main(),
      routes: <String, WidgetBuilder> {
        '/login': (BuildContext context) => App(),
        '/homepage': (BuildContext context) => Header(),
      }
    );
  }
}

// the main class containing the stack
// that runs the login page.
class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: <Widget> [
          LoginPage(),
          LoginButton(),
      ],
    );
  }
}

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool init = true;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    init = true;
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final _children = <Widget>[
    HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    //final GlobalKey<FormState> _loginFormKey =
    //new GlobalKey<FormState>(debugLabel: '_loginFormKey');
    return Stack(
      children: <Widget>[
        // UI Scaffold
        Scaffold(
          //key: _loginFormKey,
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(40.0),
            child: GradientAppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              title: Text('Task+',style: TextStyle(fontFamily: 'Poppins',fontWeight: prefix0.FontWeight.w600)),
              gradient: LinearGradient(colors: gradients),
            ),
          ),
          endDrawer: SideDrawer(),
          body: _children[_currentIndex],
        ),
      ],
    );
  }
}

class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: sideGradients,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            ListTile(
                leading: Icon(
                  Icons.build,
                  //IconData(0xe810,fontFamily: 'line_icons'),
                  color: Colors.white,
                ),
                title: Text(
                  'Settings',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  /*
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage())
                  );
                   */
                }
            ),
            ListTile(
                leading: Icon(
                  Icons.settings_power,
                  //IconData(0xe820,fontFamily: 'line_icons'),
                  color: Colors.white,
                ),
                title: Text(
                  'Logout',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                }
            ),
          ],
        ),
      ),
    );
  }
}

// removes listview scroll glow
class removeScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

List<Color> gradients = [
  Color.fromRGBO(255, 0, 159, 1.0),
  Color.fromRGBO(255, 74, 187, 1.0),
  Color.fromRGBO(255, 217, 89, 1.0),
];

List<Color> sideGradients = [
  Color.fromRGBO(255, 0, 159, 0.75),
  Color.fromRGBO(255, 74, 187, 0.75),
  Color.fromRGBO(255, 217, 89, 0.75),
];

