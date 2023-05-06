import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myexpanses/AddNew.dart';
import '/DBHelper.dart';
import '/AllTransactions.dart';
import 'TBLTransaction.dart';
import 'home_page.dart';
import 'loginPage.dart';

class JumpOnDate extends StatefulWidget {
  @override
  State<JumpOnDate> createState() => _JumpOnDateState();
}

class _JumpOnDateState extends State<JumpOnDate> {
  TextEditingController tcs = TextEditingController();
  late DateTime pickDate;
  String datemessage="";
  String countmessage="";

  var style = TextStyle(
    fontFamily: "Rockwell",
    fontSize: 20.0,
  );

  var styleBody = TextStyle(
      fontFamily: "MyFont",
      fontSize: 25.0,
      decoration: TextDecoration.underline);

  var textStyle = TextStyle(
    fontFamily: "MyFont",
    fontSize: 20.0,
  );

  var theme = ThemeData(
    primaryColor: Colors.black,
    indicatorColor: const Color(0xff0E1D36),
    hintColor: const Color(0xff280C0B),
    highlightColor: const Color(0xff372901),
    hoverColor: const Color(0xff3A3A3B),
    focusColor: const Color(0xff0B2512),
    disabledColor: Colors.grey,
    brightness: Brightness.dark,
  );

  late List<MyTransaction> transaction;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        return true;
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: Scaffold(
              appBar: myAppBar(context),
              drawer: myDrawer(context),
              body: Center(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                                    controller: tcs,
                                    decoration: InputDecoration(
                                        icon: Icon(Icons.calendar_today,color: Colors.white,),
                                        labelText: "Select Date",
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5.0)
                                        ),
                                        labelStyle: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "MyFont",
                                        )),
                                    readOnly: true,
                                    onTap: () async {

                                      DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2022),
                                          lastDate: DateTime.now());

                                      if (pickedDate != null) {
                                        this.pickDate = pickedDate;
                          //
                                         String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pickedDate);

                                        tcs.text = formattedDate.toString();

                                        SnackBar snackBar = SnackBar(
                                          content: Text(formattedDate),
                                          duration: const Duration(seconds: 5),
                                          backgroundColor: Colors.black,
                                          action: SnackBarAction(
                                            label: 'Undo',
                                            onPressed: () {},
                                          ),
                                        );

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    })),
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateColor.resolveWith((states) => Colors.white54)
                                ),
                              child: Text("Go to Date", style: style,),
                              onPressed: () {
                                  print(tcs.text);
                                  datemessage= "Transaction of ${tcs.text}";
                                  updateListView(pickDate.toString());
                              },
                              ),
                            )
                          ],
                        )),
                    Divider(),
                    Container(
                      child: Text(datemessage,style: TextStyle(
                        fontFamily: "MyFont",
                        fontSize: 25.0,
                        decoration: TextDecoration.underline
                      ),),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(20.0),
                        child: ListView.builder(
                            itemCount: count,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: Colors.white,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.black12,
                                    child: getTransactionMode(
                                        this.transaction[index].TransactionMode),
                                  ),
                                  title: Text(
                                    this.transaction[index].TransactionTitle,
                                    style: TextStyle(
                                        fontFamily: "MyFont",
                                        fontSize: 25.0,
                                        decoration: TextDecoration.underline,
                                        color: Colors.black
                                    ),
                                  ),
                                  subtitle: Text(
                                    this.transaction[index].TransactionDescription,
                                    style: TextStyle(
                                        fontFamily: "MyFont",
                                        fontSize: 15.0,
                                        color: Colors.black
                                    ),
                                  ),
                                  trailing: Text(
                                    this.transaction[index].TransactionAmount.toString(),
                                    style: TextStyle(
                                        fontFamily: "MyFont",
                                        fontSize: 20.0,
                                        color: Colors.black
                                    ),
                                  ),
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor: Colors.black,
                                          title: Column(children: [
                                            Text(
                                              "Title: ",
                                              style: TextStyle(
                                                fontFamily: "MyFont",
                                                fontSize: 25.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "${transaction[index].TransactionTitle}",
                                              style: TextStyle(
                                                fontFamily: "Rockwell",
                                                fontSize: 20.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Container(
                                              height: 30.0,
                                            ),
                                            Text(
                                              "Description: ",
                                              style: TextStyle(
                                                fontFamily: "MyFont",
                                                fontSize: 25.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "${transaction[index].TransactionDescription}",
                                              style: TextStyle(
                                                fontFamily: "Rockwell",
                                                fontSize: 20.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Container(
                                              height: 30.0,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Amount:   ",
                                                  style: TextStyle(
                                                    fontFamily: "MyFont",
                                                    fontSize: 25.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "${transaction[index].TransactionAmount}",
                                                  style: TextStyle(
                                                    fontFamily: "Rockwell",
                                                    fontSize: 25.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 10.0,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "Mode of Payment:   ",
                                                  style: TextStyle(
                                                    fontFamily: "MyFont",
                                                    fontSize: 25.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  "${transaction[index].TransactionMode}",
                                                  style: TextStyle(
                                                    fontFamily: "Rockwell",
                                                    fontSize: 25.0,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 30.0,
                                            ),
                                            Text(
                                              "Date and Time: ",
                                              style: TextStyle(
                                                fontFamily: "MyFont",
                                                fontSize: 25.0,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "${
                                                  DateFormat("dd-MM-yyyy HH:mm").format(DateTime.parse(transaction[index].TransactionDateTime))
                                              }",
                                              style: TextStyle(
                                                fontFamily: "Rockwell",
                                                fontSize: 20.0,
                                                color: Colors.white,
                                              ),
                                            ),

                                          ]),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(
                                                'OK',
                                                style: TextStyle(
                                                    fontFamily: "MyFont",
                                                    fontSize: 25.0,
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            }),
                      ),
                    ),
                    Divider(),
                    Container(
                      child: Text("Total Counts: $count",textAlign: TextAlign.left,style: TextStyle(
                          fontFamily: "MyFont",
                          fontSize: 20.0,
                          decoration: TextDecoration.underline
                      ),),
                    ),
                  ],
                ),
              ))),
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Jump on Date",
        style: TextStyle(
          fontFamily: "Rockwell",
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String value) {
            if (value == "logout") {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            }
            if (value == "allexp") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ListTransaction()));
            }
            if (value == "addnew") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MainSection()));
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: 'addnew',
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.yellow,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Add Transaction",
                      style: TextStyle(color: Colors.yellow),
                    ),
                  )
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'allexp',
              child: Row(
                children: [
                  Icon(
                    Icons.list,
                    color: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "All Transaction",
                      style: TextStyle(color: Colors.green),
                    ),
                  )
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'report',
              child: Row(
                children: [
                  Icon(
                    Icons.report,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Reports",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'logout',
              child: Row(children: [
                Icon(Icons.logout, color: Colors.red),
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.red),
                    ))
              ]),
            ),
          ],
        ),
      ],
    );
  }

  Drawer myDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black12),
            accountName: Text(
              'Amiruddin Samlayawala',
              style: style,
            ),
            accountEmail: Text(
              'samalayawalaamiruddin@gmail.com',
              style: TextStyle(
                fontFamily: "Rockwell",
                fontSize: 12.0,
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('Assets/images/author.jpg'),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
            title: Text('Settings'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.report,
              color: Colors.orange,
            ),
            title: Text('Reports'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.help,
            ),
            title: Text('Help'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.info,
              color: Colors.green,
            ),
            title: Text('About'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: Text("Logout"),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
      ),
    );
  }

  void updateListView(String Date) {
    DatabaseHelper db = DatabaseHelper.instance;
    Future<List<MyTransaction>> list = db.getSpecificDateData(DateTime.parse(Date));
    list.then((value) {
      setState(() {
        this.transaction = value;
        this.count = value.length;
      });
    });
  }

  Icon getTransactionMode(String type) {
    if (type != "Cash") {
      return Icon(
        Icons.book_online,
        color: Colors.blue,
      );
    } else
      return Icon(
        Icons.offline_pin,
        color: Colors.green,
      );
  }
}
