import 'package:flutter/material.dart';
import 'DBHelper.dart';
import 'TBLTransaction.dart';
import 'package:intl/intl.dart';

class Bank extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BankBody();
  }
}

class BankBody extends State<Bank> {
  DatabaseHelper db = DatabaseHelper.instance;
  late List<MyTransaction> transaction;
  int count = 0;

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

  @override
  Widget build(BuildContext context) {
    updateListView();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
        theme: theme,
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: ListView.builder(
                itemCount: count,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: Colors.black12,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.black12,
                        child: getTransactionMode(
                            this.transaction[index].TransactionMode),
                      ),
                      title: Text(
                        this.transaction[index].TransactionTitle,
                        style: styleBody,
                      ),
                      subtitle: Text(
                        this.transaction[index].TransactionDescription,
                        style: style,
                      ),
                      trailing: Text(
                        this.transaction[index].TransactionAmount.toString(),
                        style: textStyle,
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
                                    "${DateFormat("dd-MM-yyyy HH:mm").format(DateTime.parse(transaction[index].TransactionDateTime))}",
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
                            });
                      },
                    ),
                  );
                })),
      ),
    );
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

  void updateListView() {
    DatabaseHelper db = DatabaseHelper.instance;
    Future<List<MyTransaction>> list = db.getOnlineTransaction();
    list.then((value) {
      setState(() {
        this.transaction = value;
        this.count = value.length;
      });
    });
  }
}
