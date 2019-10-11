import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:reorderables/reorderables.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:taskplus/services/crud.dart';
import 'package:taskplus/singletons/userdata.dart';

import 'package:intl/intl.dart';


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

  CrudMethods crud = CrudMethods();

  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();

  Color _currColor = Color(int.parse('0xffff9aa2'));
  String _currIcon = '0xe800';
  String _currType;
  String _currLength = 'day';
  int _currAmount = 1;
  bool _currNotify = false;

  List<IconData> _iconList = <IconData>[];

  @override
  void initState() {
    super.initState();
    _rows = [TaskCard(key: UniqueKey())];

    _initIcons();
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

                      FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Icon(
                          Icons.add_circle,
                          color: Colors.white,
                          size: 28.0,
                        ),
                        onPressed: () {
                          addTaskPrompt(context);
                        },
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
                top: _height *0.125,
                child: Container(
                  height: _height * _height,
                  width: 26.5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                ),
              ),

              Positioned(
                top: _height * 0.125,
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


  // Dialog for posting a status
  Future<bool> addTaskPrompt(BuildContext context) async {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.width;
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Material(
            color: Colors.transparent,
            child: Center(
              child: Container(
                padding: EdgeInsets.only(
                  top: _height * 0.05,
                  left: _width * 0.05,
                  right: _width * 0.05,
                ),
                height: _height * 1.6,
                width: _width * 0.85,
                decoration: BoxDecoration(
                  color: _currColor,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  boxShadow: [
                    BoxShadow(
                      color: _currColor,
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                      offset: Offset(0.0, 2.5),
                    ),
                  ],
                ),
                child: ListView(
                  children: <Widget>[

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        SizedBox(width: 10.0),

                        Container(
                          height: 60.0,
                          width: 60.0,
                          alignment: Alignment.center,
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
                          child: Stack(
                              children: <Widget>[

                                // icon getting the _currIcon string and parsing it into an int
                                Center(
                                  child: Icon(
                                    IconData(int.parse(_currIcon), fontFamily: 'icons'),
                                    size: 35.0,
                                    color: _currColor,
                                  ),
                                ),

                                Theme(
                                  data: ThemeData(
                                    canvasColor: _currColor,
                                  ),
                                  child: DropdownButton<IconData>(
                                    iconEnabledColor: Colors.transparent,
                                    underline: Text(''),
                                    onChanged: (IconData newIcon) {
                                      setState(() {
                                        _currIcon = '0xe${newIcon.toString().substring(13,16)}';
                                        userData.icon = '0xe${newIcon.toString().substring(13,16)}';
                                        Navigator.of(context).pop();
                                        addTaskPrompt(context);
                                      });
                                    },
                                    items: _iconList.map<DropdownMenuItem<IconData>>((IconData value) {
                                      return DropdownMenuItem<IconData>(
                                        value: value,
                                        child: Center(child: Icon(value, size: 36.0, color: Colors.white)),
                                      );
                                    }).toList(),
                                  ),
                                ),

                              ],
                          ),
                        ),

                        SizedBox(width: 5.0),

                        // container for textfield container
                        Container(
                          width: _width * 0.53,
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.all(
                                  const Radius.circular(10.0))
                          ),
                          // title text box
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: _title,
                            showCursor: false,
                            keyboardType: TextInputType.text,
                            maxLines: 2,
                            maxLength: 27,
                            maxLengthEnforced: true,
                            buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                            ),
                            decoration: InputDecoration.collapsed(
                              fillColor: Colors.transparent,
                              hintText: 'Add a title',
                              hintStyle: TextStyle(color: Colors.white),
                              filled: true,
                            ),
                            onChanged: (value) {
                              setState(() {
                                userData.title = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    // container for description textfield
                    Container(
                      height: _height * 0.253,
                      margin: EdgeInsets.symmetric(horizontal: _width * 0.04),
                      alignment: FractionalOffset.center,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(
                              const Radius.circular(10.0))
                      ),

                      // description text box
                      child: TextField(
                        textAlign: TextAlign.center,
                        controller: _description,
                        keyboardType: TextInputType.text,
                        showCursor: false,
                        maxLines: 3,
                        maxLength: 60,
                        maxLengthEnforced: true,
                        buildCounter: (BuildContext context, { int currentLength, int maxLength, bool isFocused }) => null,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                        decoration: InputDecoration.collapsed(
                          fillColor: Colors.transparent,
                          hintText: 'Give a short description',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                          filled: true,
                        ),
                        onChanged: (value) {
                          setState(() {
                            userData.description = value;
                          });
                        },
                      ),
                    ),

                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: _width * 0.04),
                      child: Theme(
                        data: ThemeData(
                          canvasColor: _currColor,
                        ),
                        child: DropdownButton<String>(
                          value: _currType,
                          icon: Icon(IconData(0xe829, fontFamily: 'icons')),
                          iconEnabledColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontFamily: 'Poppins',
                          ),
                          hint: Text(
                            'Type',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontFamily: 'Poppins',
                            ),
                          ),
                          underline: Container(
                              height: 2.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(Radius.circular(1.0)),
                              ),
                          ),
                          onChanged: (String newValue) {
                            setState(() {
                              _currType = newValue;
                              userData.type = newValue;
                              Navigator.of(context).pop();
                              addTaskPrompt(context);
                            });
                          },
                          items: ['Habit', 'Goal', 'Appointment'].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String> (
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              );
                            })
                            .toList(),
                        ),
                      ),
                    ),

                    // used as padding
                    SizedBox(height: _height * 0.025),

                    _currType == 'Habit'
                      ? userData.title != ''
                        ? Container(
                            height: _height * 0.46,
                            margin: EdgeInsets.symmetric(horizontal: _width * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                AutoSizeText(
                                  '${userData.title}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    height: 1.0,
                                    fontSize: 20.0,
                                  ),
                                  textAlign: TextAlign.start,
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[

                                    Text(
                                      'Every',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20.0,
                                      ),
                                    ),

                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: _width * 0.01),
                                      child: Theme(
                                        data: ThemeData(
                                          canvasColor: _currColor,
                                        ),
                                        child: DropdownButton<String>(
                                          value: _currLength,
                                          icon: Icon(IconData(0xe829, fontFamily: 'icons')),
                                          iconEnabledColor: Colors.white,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontFamily: 'Poppins',
                                          ),
                                          underline: Container(
                                            height: 2.0,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(1.0)),
                                            ),
                                          ),
                                          onChanged: (String newValue) {
                                            setState(() {
                                              _currLength = newValue;
                                              userData.length = newValue;
                                              Navigator.of(context).pop();
                                              addTaskPrompt(context);
                                            });
                                          },
                                          items: ['day', 'week', 'month'].map<DropdownMenuItem<String>>((String value) {
                                            return DropdownMenuItem<String> (
                                              value: value,
                                              child: Text(
                                                value,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  fontFamily: 'Poppins',
                                                ),
                                              ),
                                            );
                                          })
                                              .toList(),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),

                                _currLength == 'week' || _currLength == 'month'
                                  ? Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[

                                        Text(
                                          'As often as',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),

                                        Container(
                                          width: _width * 0.171,
                                          margin: EdgeInsets.symmetric(horizontal: _width * 0.02),
                                          child: Theme(
                                            data: ThemeData(
                                              canvasColor: _currColor,
                                            ),
                                            child: ButtonTheme(
                                              alignedDropdown: true,
                                              child: DropdownButton<int>(
                                                value: _currAmount,
                                                icon: Icon(IconData(0xe829, fontFamily: 'icons')),
                                                iconEnabledColor: Colors.white,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                  fontFamily: 'Poppins',
                                                ),
                                                underline: Container(
                                                  height: 2.0,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(1.0)),
                                                  ),
                                                ),
                                                onChanged: (int newValue) {
                                                  setState(() {
                                                    _currAmount = newValue;
                                                    userData.amount = newValue;
                                                    Navigator.of(context).pop();
                                                    addTaskPrompt(context);
                                                  });
                                                },
                                                items: List<DropdownMenuItem<int>>.generate(50, ((int value) {
                                                  return DropdownMenuItem<int> (
                                                    value: value,
                                                    child: Text(
                                                      '$value',
                                                      style: TextStyle(
                                                        fontSize: 18.0,
                                                        fontFamily: 'Poppins',
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Text(
                                          'times',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),

                                      ],
                                    )
                                  : Container(),

                                // used as padding
                                SizedBox(height: _height * 0.01),

                                Expanded(
                                  child: Stack(
                                    children: <Widget>[

                                      Positioned(
                                        left: 0.0,
                                        child: Text(
                                          'Notify me',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                          ),
                                        ),
                                      ),

                                      Positioned(
                                        right: 0.0,
                                        child: CupertinoSwitch(
                                          value: _currNotify,
                                          onChanged: (bool value) { setState(() { _currNotify = value; }); },
                                        ),
                                      ),

                                  ],
                                ),
                              ),
                            ],
                          )
                        )
                        : Container(
                            height: _height * 0.06,
                            margin: EdgeInsets.symmetric(horizontal: _width * 0.04),
                            child: Text(
                              'Please enter a title',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                              ),
                            ),
                          )
                      : _currType == 'Goal'
                      ? userData.title != ''
                        ? Container(
                          height: _height * 0.4,
                        )
                        : Container(
                          height: _height * 0.06,
                          margin: EdgeInsets.symmetric(horizontal: _width * 0.04),
                          child: Text(
                            'Please enter a title',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      : _currType == 'Appointment'
                      ? userData.title != ''
                        ? Container(
                          height: _height * 0.4,
                        )
                        : Container(
                          height: _height * 0.06,
                          margin: EdgeInsets.symmetric(horizontal: _width * 0.04),
                          child: Text(
                            'Please enter a title',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                        )
                      : Container(),

                    // used for padding
                    SizedBox(height: _height * 0.05),

                    // first row of PASTEL colors
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        _colorButton(context, 0xffff9aa2),
                        _colorButton(context, 0xffffdac1),
                        _colorButton(context, 0xffe2f0cb),
                        _colorButton(context, 0xffb5ead7),
                        _colorButton(context, 0xffc7ceea),
                        _colorButton(context, 0xff957dad),

                      ],
                    ),

                    // second row of VIBRANT colors
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        _colorButton(context, 0xffd81e5b),
                        _colorButton(context, 0xff420039),
                        _colorButton(context, 0xff09814a),
                        _colorButton(context, 0xffffb20f),
                        _colorButton(context, 0xffff7f11),
                        _colorButton(context, 0xff3e6990),

                      ],
                    ),

                    // used as padding
                    SizedBox(height: _height * 0.05),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        FlatButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () {
                            _title.clear();
                            _description.clear();
                            _currIcon = '0xe800';
                            _currColor = Color(int.parse('0xffff9aa2'));
                            _currType = null;
                            _currLength = 'day';
                            _currAmount = 0;
                            _currNotify = false;
                            userData.title = '';
                            userData.description = '';
                            userData.icon = '';
                            userData.color = '';
                            userData.date = '';
                            userData.length = '';
                            userData.amount = null;
                            Navigator.of(context).pop();
                          },
                        ),

                        // used as padding
                        SizedBox(width: _width * 0.15),

                        // When users click Confirm, the firestore database is then updated with the user post
                        FlatButton(
                          child: Text(
                            'Confirm',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: () {

                            // Gets the current date and time to put on the post
                            var now = DateTime.now();
                            userData.date = DateFormat.yMMMMd('en_US').format(now);
                            userData.date = '${userData.date}' ' ${DateFormat.jm().format(now)}';

                            List<String> data = [
                              userData.title,
                              userData.description,
                              userData.icon,
                              userData.date,
                              userData.uid,
                            ];

                            crud.addTaskHabit(data, context);

                            _title.clear();
                            _description.clear();
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }


  void _initIcons() {
    // initialize icons for task card
    List<int> exclude = <int>[1, 9, 16, 17, 21, 24, 27, 28, 29, 33];
    List<String> hexa = ['a', 'b', 'c', 'd', 'e', 'f'];
    for (var i = 0; i < 43; i++) {
      if (exclude.contains(i)) {
        continue;
      }
      else if (i < 16) {
        if (i % 15 == 10) {
          for (var j in hexa) {
            if (j == 'a' || (j == 'b') || (j == 'c') || (j == 'd') || (j == 'e')) { continue; }
            _iconList.add(IconData(int.parse('0xe80$j'), fontFamily: 'icons'));
          }
        }
        else if (i > 10) { continue; }
        else { _iconList.add(IconData(int.parse('0xe80$i'), fontFamily: 'icons')); }
      }
      else {
        if (i % 15 == 10) {
          for (var j in hexa) {
            if ((i ~/ 15 == 1 && j == 'c') || (i ~/ 15 == 1 && j == 'e') || (i ~/ 15 == 2 && j == 'a')) { continue; }
            _iconList.add(IconData(int.parse('0xe8${i ~/ 15}$j'), fontFamily: 'icons'));
          }
        }
        else if (i % 15 > 10) { continue; }
        else { _iconList.add(IconData(int.parse('0xe8$i'), fontFamily: 'icons')); }
      }
    }
  }


  Widget _colorButton(context, color) {
    double _width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: _width * 0.12,
      child: RawMaterialButton(
        constraints: BoxConstraints.tight(Size(_width * 0.1, _width * 0.1)),
        shape: CircleBorder(
            side: BorderSide(width: 2.0, color: Colors.white)
        ),
        elevation: 5.0,
        fillColor: Color(color),
        onPressed: () {
          setState(() {
            _currColor = Color(color);
            userData.color = color.toString();
            Navigator.of(context).pop();
            addTaskPrompt(context);
          });
        },
      ),
    );
  }

  Widget _update() {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data != null) {
              // Get posts from firebase and put it on singleton
              crud.getCrewPosts().then((results) {
                userData.posts = results;
              });
            }
          }
          return Container(height: 0.0, width: 0.0);
        }
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
              actionExtentRatio: 0.16,
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
                  SizedBox(width: 20.0),

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
                                  'Ongoing',
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
                ],
              ),

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
                      gradient: LinearGradient(
                        stops: [0.04, 0.04],
                        colors: [Colors.white, Color(0xff81e979).withOpacity(0.75)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(255, 154, 162, 0.9),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.edit, size: 30.0, color: Colors.white),
                      ],
                    ),
                  ),
                  onTap: () => {},
                ),

                SlideAction(
                  closeOnTap: false,
                  color: Colors.transparent,
                  // child container that will contain the
                  // extra information of the task card.
                  child: Container(
                    height: _height * .30,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        stops: [0.04, 0.04],
                        colors: [Colors.white, Color(0xfff25757).withOpacity(0.75)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(255, 154, 162, 0.9),
                        ),
                      ],
                      borderRadius: BorderRadius.horizontal(right: Radius.circular(20.0)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.delete_outline, size: 35.0, color: Colors.white),
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