import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// the home page that gets called from the
// main file. This contains all the task
// cards for the user to interact with.
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.width;
    return Column(
        children: <Widget>[
          // using an expanded widget to contain
          // the ListView within  the screen.
          Expanded(
            child: Container(
              child: ListView(
                children: <Widget>[

                    Container(
                      height: _height * 0.09,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(255, 74, 187, 0.35),
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 5.0),
                          ),
                        ],
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: gradients,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add_circle,
                            color: Colors.white,
                            size: 28.0,
                          ),
                        ],
                      ),
                    ),

                  SizedBox(height: 20.0),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    height: _height * .30,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(255, 154, 162, 0.9),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color.fromRGBO(255, 154, 162, 1.0),
                    ),
                    child: Row(
                      children: <Widget>[

                        SizedBox(width: 20.0),

                        Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 10.0),
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(60.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.work,
                              size: 40.0,
                              color: Color.fromRGBO(255, 154, 162, 1.0),
                            )
                          ),
                        ),

                        SizedBox(width: 30.0),

                        Column(
                          children: <Widget>[

                            SizedBox(height: 15.0),

                            Container(
                              width: _width * .45,
                              height: _height * .1,
                              child: Center(
                                child: AutoSizeText(
                                  'Practice for Internship Interview',
                                  style: TextStyle(
                                    color: Colors.white,
                                    height: 1.0,
                                    fontSize: 20.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            SizedBox(height: 25.0),


                            Container(
                              width: _width * .25,
                              height: _height * .06,
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.timer,
                                    color: Colors.white,
                                  ),

                                  SizedBox(width: _width * 0.01),

                                  Text(
                                    "Ongoing",
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                    )
                                  ),
                                ],
                              )
                            ),
                          ],
                        )

                      ],
                    )
                  ),

                  SizedBox(height: 20.0),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    height: _height * .30,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(255, 218, 193, 0.9),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color.fromRGBO(255, 218, 193, 1.0),
                    ),
                    child: Row(
                      children: <Widget>[

                        SizedBox(width: 20.0),

                        Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 10.0),
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(60.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                              child: Icon(
                                Icons.phone_android,
                                size: 40.0,
                                color: Color.fromRGBO(255, 218, 193, 1.0),
                              )
                          ),
                        ),

                        SizedBox(width: 30.0),

                        Column(
                          children: <Widget>[

                            SizedBox(height: 15.0),

                            Container(
                              width: _width * .45,
                              height: _height * .1,
                              child: Center(
                                child: AutoSizeText(
                                  'Work on Task+',
                                  style: TextStyle(
                                    color: Colors.white,
                                    height: 1.0,
                                    fontSize: 20.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            SizedBox(height: 25.0),


                            Container(
                                height: _height * .06,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.timer,
                                      color: Colors.white,
                                    ),

                                    SizedBox(width: _width * 0.01),

                                    Text(
                                        "Ongoing",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        )
                                    ),
                                  ],
                                )
                            ),
                          ],
                        )

                      ],
                    )
                  ),

                  SizedBox(height: 20.0),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    height: _height * .30,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(199, 206, 234, 0.9),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color.fromRGBO(226, 240, 203, 1.0),
                    ),
                    child: Row(
                      children: <Widget>[

                        SizedBox(width: 20.0),

                        Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 10.0),
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(60.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                              child: Icon(
                                Icons.laptop,
                                size: 40.0,
                                color: Color.fromRGBO(226, 240, 203, 1.0),
                              )
                          ),
                        ),

                        SizedBox(width: 30.0),

                        Column(
                          children: <Widget>[

                            SizedBox(height: 15.0),

                            Container(
                              width: _width * .45,
                              height: _height * .1,
                              child: Center(
                                child: AutoSizeText(
                                  'IEEEX Hackathon',
                                  style: TextStyle(
                                    color: Colors.white,
                                    height: 1.0,
                                    fontSize: 20.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            SizedBox(height: 25.0),


                            Container(
                                width: _width * .25,
                                height: _height * .06,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.timer,
                                      color: Colors.white,
                                    ),

                                    SizedBox(width: _width * 0.01),

                                    Text(
                                        "21 days",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        )
                                    ),
                                  ],
                                )
                            ),
                          ],
                        )

                      ],
                    )
                  ),

                  SizedBox(height: 20.0),

                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 30.0),
                    height: _height * .30,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(181, 234, 215, 0.9),
                          blurRadius: 10.0,
                          spreadRadius: 1.0,
                          offset: Offset(0.0, 5.0),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color.fromRGBO(181, 234, 215, 1.0),
                    ),
                    child: Row(
                      children: <Widget>[

                        SizedBox(width: 20.0),

                        Container(
                          height: 70.0,
                          width: 70.0,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0.0, 10.0),
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                              ),
                            ],
                            borderRadius: BorderRadius.all(Radius.circular(60.0)),
                            color: Colors.white,
                          ),
                          child: Center(
                              child: Icon(
                                Icons.favorite_border,
                                size: 40.0,
                                color: Color.fromRGBO(181, 234, 215, 1.0),
                              )
                          ),
                        ),

                        SizedBox(width: 30.0),

                        Column(
                          children: <Widget>[

                            SizedBox(height: 15.0),

                            Container(
                              width: _width * .45,
                              height: _height * .1,
                              child: Center(
                                child: AutoSizeText(
                                  'Loving my baby',
                                  style: TextStyle(
                                    color: Colors.white,
                                    height: 1.0,
                                    fontSize: 20.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                            SizedBox(height: 25.0),


                            Container(
                                width: _width * .25,
                                height: _height * .06,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.timer,
                                      color: Colors.white,
                                    ),

                                    SizedBox(width: _width * 0.01),

                                    Text(
                                        "Ongoing",
                                        style: TextStyle(
                                          fontSize: 15.0,
                                          color: Colors.white,
                                        )
                                    ),
                                  ],
                                )
                            ),
                          ],
                        )

                      ],
                    )
                  ),

                  SizedBox(height: 20.0),

                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      height: _height * .30,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(199, 206, 234, 0.9),
                            blurRadius: 10.0,
                            spreadRadius: 1.0,
                            offset: Offset(0.0, 5.0),
                          ),
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Color.fromRGBO(199, 206, 234, 1.0),
                      ),
                      child: Row(
                        children: <Widget>[

                          SizedBox(width: 20.0),

                          Container(
                            height: 70.0,
                            width: 70.0,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  offset: Offset(0.0, 10.0),
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                ),
                              ],
                              borderRadius: BorderRadius.all(Radius.circular(60.0)),
                              color: Colors.white,
                            ),
                            child: Center(
                                child: Icon(
                                  Icons.laptop,
                                  size: 40.0,
                                  color: Color.fromRGBO(199, 206, 234, 1.0),
                                )
                            ),
                          ),

                          SizedBox(width: 30.0),

                          Column(
                            children: <Widget>[

                              SizedBox(height: 15.0),

                              Container(
                                width: _width * .45,
                                height: _height * .1,
                                child: Center(
                                  child: AutoSizeText(
                                    'Google Kickstart Hackathon',
                                    style: TextStyle(
                                      color: Colors.white,
                                      height: 1.0,
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),

                              SizedBox(height: 25.0),


                              Container(
                                  width: _width * .25,
                                  height: _height * .06,
                                  child: Row(
                                    children: <Widget>[
                                      Icon(
                                        Icons.timer,
                                        color: Colors.white,
                                      ),

                                      SizedBox(width: _width * 0.01),

                                      Text(
                                          "2 days",
                                          style: TextStyle(
                                            fontSize: 15.0,
                                            color: Colors.white,
                                          )
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          )

                        ],
                      )
                  ),

                ],
              )
            ),
          ),
       ],
    );
  }
}

List<Color> gradients = [
  Color.fromRGBO(255, 0, 159, 0.65),
  Color.fromRGBO(255, 74, 187, 0.65),
  Color.fromRGBO(255, 217, 89, 0.65),
];