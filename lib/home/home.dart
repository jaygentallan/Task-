import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reorderables/reorderables.dart';

double globalHeight;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// the home page that gets called from the
// main file. This contains all the task
// cards for the user to interact with.
class _HomePageState extends State<HomePage> {
  List<Widget> _rows;
  TaskCard _taskCard;

  @override
  void initState() {
    super.initState();
    _rows = [TaskCard(key: UniqueKey()),TaskCard(key: UniqueKey()),TaskCard(key: UniqueKey()),
             TaskCard(key: UniqueKey()),TaskCard(key: UniqueKey()),TaskCard(key: UniqueKey())];
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.width;

    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _rows.removeAt(oldIndex);
        _rows.insert(newIndex, row);
      });
    }

    ScrollController _scrollController = PrimaryScrollController.of(context) ?? ScrollController();

    return Column(
      children: <Widget>[
        // using an expanded widget to contain
        // the ListView within  the screen.
        Expanded(
          // stack widget so that the two white containers
          // can overlay the content when sliding to the left.
          child: Stack(
            children: <Widget>[
              Container(
            color: Colors.white,
            child: ListView(
              children: <Widget>[

                // container at the top used to store all
                // the functions (i.e add)
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

                // used as padding.
                SizedBox(height: 10.0),

                ReorderableColumn(
                  scrollController: _scrollController,
                  needsLongPressDraggable: true,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _rows,
                  onReorder: _onReorder,
                ),

                /*
                LongPressDraggable(
                  axis: Axis.vertical,
                  // task card container.
                  child: _taskCard(context),
                  feedback: _taskCard(context),
                  childWhenDragging: Container(),
                ),
                */

                    /*
                    // two white containers on both sides of the screen
                    // to act as a screen to cover the slide action.
                    Container(
                      height: _height * 0.3,
                      width: 26.5,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: _width * 0.0001,
                      child: Container(
                        height: _height * 0.3,
                        width: 26.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                    ),

                  ],
                ),
                     */

                // used as padding.
                SizedBox(height: 20.0),

              ],
            ),
          ),
              // two white containers on both sides of the screen
              // to act as a screen to cover the slide action.
              Positioned(
                top: _height *0.13,
                child: Container(
                  height: _height * _height,
                  width: 26.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),

              Positioned(
                top: _height * 0.13,
                right: _width * 0.0001,
                child: Container(
                  height: _height * _height,
                  width: 26.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TaskCard extends StatefulWidget {
  TaskCard({Key key}) : super(key: key);
  @override
  TaskCardState createState() => TaskCardState();
}

class TaskCardState extends State<TaskCard> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.width;
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: <Widget>[

          SizedBox(height: 5.0),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 30.0),
            height: _height * .30,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(255, 154, 162, 0.9),
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                  offset: Offset(0.0, 2.5),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Color.fromRGBO(255, 154, 162, 1.0),
            ),

            // Slidable widget as child for the sliding
            // functionality of the task container.
            child: Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 1.0,
              closeOnScroll: false,
              child: Row(
                children: <Widget>[

                  // used as padding.
                  SizedBox(width: 20.0),

                  // circle icon that represents what
                  // type of task it is.
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

                  // used as padding
                  SizedBox(width: 10.0),

                  Column(
                    children: <Widget>[

                      // used as padding.
                      SizedBox(height: 15.0),

                      // contains the title of the card.
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

                      // used as padding.
                      SizedBox(height: 25.0),

                      // shows the remaining time.
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
                  ),

                  SizedBox(width: _width * 0.04),

                  Icon(
                    Icons.arrow_forward_ios,
                    size: 17.5,
                    color: Colors.white,
                  ),

                ],
              ),

              // for delete button
              actions: <Widget>[
                SlideAction(
                  closeOnTap: false,
                  color: Colors.transparent,
                  // child container that will contain the
                  // extra information of the task card.
                  child: Container(
                    height: _height * .30,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(255, 154, 162, 0.9),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white70,
                    ),
                    child: Row(
                      children: <Widget>[

                        SizedBox(width: _width * 0.015),

                        Icon(
                          Icons.arrow_back_ios,
                          size: 17.5,
                          color: Color.fromRGBO(255, 154, 162, 1.0),
                        ),

                        SizedBox(width: _width * 0.01),

                        Column(
                          children: <Widget>[

                            SizedBox(height: 10.0),
                            // contains the title of the card.
                            Container(
                              width: _width * 0.75,
                              height: _height * .1,
                              child: Center(
                                child: AutoSizeText(
                                  'Practice for Internship Interview',
                                  style: TextStyle(
                                    color: Color.fromRGBO(235, 134, 142, 1.0),
                                    height: 1.0,
                                    fontSize: 15.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                          ],
                        )

                      ],
                    ),
                  ),
                  onTap: () => {},
                ),
              ],
              // contains the widget that appears when
              // the user slides to the left.
              secondaryActions: <Widget>[
                SlideAction(
                  closeOnTap: false,
                  color: Colors.transparent,
                  // child container that will contain the
                  // extra information of the task card.
                  child: Container(
                    height: _height * .30,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(255, 154, 162, 0.9),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Colors.white70,
                    ),
                    child: Row(
                      children: <Widget>[

                        SizedBox(width: _width * 0.015),

                        Icon(
                          Icons.arrow_back_ios,
                          size: 17.5,
                          color: Color.fromRGBO(255, 154, 162, 1.0),
                        ),

                        SizedBox(width: _width * 0.01),

                        Column(
                          children: <Widget>[

                            SizedBox(height: 10.0),
                            // contains the title of the card.
                            Container(
                              width: _width * 0.75,
                              height: _height * .1,
                              child: Center(
                                child: AutoSizeText(
                                  'Practice for Internship Interview',
                                  style: TextStyle(
                                    color: Color.fromRGBO(235, 134, 142, 1.0),
                                    height: 1.0,
                                    fontSize: 15.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),

                          ],
                        )

                      ],
                    ),
                  ),
                  onTap: () => {},
                ),
              ],
            ),
          ),

          SizedBox(height: 5.0),
        ],
      ),
    );
  }
}

// list of gradient colors.
List<Color> gradients = [
  Color.fromRGBO(255, 0, 159, 0.65),
  Color.fromRGBO(255, 74, 187, 0.65),
  Color.fromRGBO(255, 217, 89, 0.65),
];