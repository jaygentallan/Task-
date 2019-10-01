import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taskplus/authorization/auth.dart';

// the log-in page will inherit from Stateful
// widget because it contains animations and
// data that will dynamically change.
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // _profile will be used to contain the
  //
  Map<String, dynamic> _profile;
  bool _loading = false;

  @override
  initState() {
    super.initState();

    if (this.mounted) {
      authService.profile
          .listen((state) => setState(() => _profile = state));

      authService.loading
          .listen((state) => setState(() => _loading = state));
    }
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
          children: <Widget>[

            Container(
              height: _height,
              child: Stack(
                children: <Widget>[

                  Center(
                    child: AspectRatio(
                      aspectRatio: 16.0 / 9.0,
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/logos/task+.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                    ),
                  ),
                  ),

              //WavyHeader(),

              ],
            ),
            ),

            SizedBox(height: 0.0),
            //WavyFooter(),

            /*
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              padding: EdgeInsets.all(20),
              child: Text(_profile.toString()
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              padding: EdgeInsets.all(20),
              child: Text(_loading.toString()),
            )
             */
          ],
        ),
    );
  }
}


// Login Button for signing up with Google.
class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // returns StreamBuilder, which takes in
    // the user as input and outputs a snapshot
    // that can be used to extract information.
    return StreamBuilder(
        stream: authService.user,
        builder: (context, snapshot) {
          // checks if the snapshot has data
          // and then displays the sign-out
          // button once signed in.
          // else display the actual log-in button.
          return Column(
            children: <Widget>[
              SizedBox(height: 400),
              _signInGoogle(context),
              SizedBox(height: 10),
              _signInFacebook()
            ],
          );
        }
    );
  }
}

Widget _signInGoogle(context) {
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: () => authService.googleSignIn().then((user) { Navigator.of(context).pushReplacementNamed('/homepage'); }),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Color.fromRGBO(255, 74, 187, 1.0)),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(IconData(0xf30f, fontFamily: 'google'), color: Color.fromRGBO(255, 0, 159, 1.0),),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color.fromRGBO(255, 0, 159, 1.0),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

Widget _signInFacebook() {
  return OutlineButton(
    splashColor: Colors.grey,
    onPressed: () => authService.googleSignIn(),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
    highlightElevation: 0,
    borderSide: BorderSide(color: Color.fromRGBO(36, 114, 240, 1.0)),
    child: Padding(
      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(IconData(0xf30c, fontFamily: 'facebook'), color: Color.fromRGBO(36, 114, 240, 1.0),),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Sign in with Facebook',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
                fontSize: 15,
                color: Color.fromRGBO(36, 114, 240, 1.0),
              ),
            ),
          )
        ],
      ),
    ),
  );
}

/*
class WavyHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: TopWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: pinkGradients,
              begin: Alignment.topLeft,
              end: Alignment.center),
        ),
        height: MediaQuery.of(context).size.height / 2.5,
      ),
    );
  }
}

class TopWaveClipper extends CustomClipper<Path> {

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }

  @override
  Path getClip(Size size) {
    // This is where we decide what part of our image is going to be visible.
    var path = Path();
    path.lineTo(0.0, size.height);

    //creating first curver near bottom left corner
    var firstControlPoint = new Offset(size.width / 7, size.height - 30);
    var firstEndPoint = new Offset(size.width / 6, size.height / 1.5);

    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstEndPoint.dx, firstEndPoint.dy);

    //creating second curver near center
    var secondControlPoint = Offset(size.width / 5, size.height / 4);
    var secondEndPoint = Offset(size.width / 1.5, size.height / 5);

    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    //creating third curver near top right corner
    var thirdControlPoint = Offset(size.width - (size.width / 9), size.height / 6);
    var thirdEndPoint = Offset(size.width, 0.0);

    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdEndPoint.dx, thirdEndPoint.dy);

    ///move to top right corner
    path.lineTo(size.width, 0.0);

    ///finally close the path by reaching start point from top right corner
    path.close();
    return path;
  }
}
class WavyFooter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: FooterWaveClipper(),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: pinkGradients,
              begin: Alignment.center,
              end: Alignment.bottomRight),
        ),
        height: MediaQuery.of(context).size.height / 3,
      ),
    );
  }
}

class FooterWaveClipper extends CustomClipper<Path> {
  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return null;
  }

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height - 60);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }
}
List<Color> pinkGradients = [
  Color.fromRGBO(255, 0, 159, 1.0),
  Color.fromRGBO(255, 74, 187, 1.0),
  Color.fromRGBO(255, 217, 89, 1.0),
];
*/