import 'package:myexpanses/AddNew.dart';
import '/DBHelper.dart';
import '/AllTransactions.dart';
import '/GetCalendar.dart';
import 'loginPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  DatabaseHelper db = DatabaseHelper.instance;

  int? TotalSum;
  int? todayTotal;
  int? TotalCash;
  int? TotalBank;
  @override
  Widget build(BuildContext context) {
    convertNumber();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: mainBody(context)),
    );
  }

  void convertNumber() async {
    this.TotalSum = await db.getTotalExpanse();
    this.todayTotal = await db.getTodayExpanse();
    this.TotalCash = await db.getTotalCashTransaction();
    this.TotalBank = await db.getTotalBankTransaction();
  }

  Scaffold mainBody(BuildContext context) {
    TextEditingController total = TextEditingController();
    TextEditingController today = TextEditingController();
    TextEditingController totalCash = TextEditingController();
    TextEditingController totalBank = TextEditingController();

    return Scaffold(
        appBar: myAppBar(context),
        drawer: myDrawer(context),
        bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add,
                  ),
                  label: "Add New",
                  tooltip: "Add New"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    color: Colors.white,
                  ),
                  label: "All Transactions",
                  tooltip: "All Transactions"),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  label: "Go to Date",
                  tooltip: "Go to Date"),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: 0,
            selectedItemColor: Colors.white,
            onTap: (value) {
              if (value == 0) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainSection()));
              } else if (value == 2) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => JumpOnDate()));
              } else if (value == 1) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListTransaction()));
              }
            },
            elevation: 3),
        body: Container(
          decoration: BoxDecoration(
              border:
                  BorderDirectional(
                      bottom: BorderSide(color: Colors.white),
                      top: BorderSide(color: Colors.white),
                      start: BorderSide(color: Colors.white),
                      end: BorderSide(color: Colors.white)
                  )),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(100.0, 20.0, 100.0, 10.0),
                  child: TextField(
                    enabled: false,
                    controller: total,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        labelText: "Total Expanse",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        alignLabelWithHint: true),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(100.0, 10.0, 100.0, 10.0),
                  child: TextField(
                    enabled: false,
                    controller: today,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        labelText: "Expanse of Today",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        alignLabelWithHint: true),
                  ),
                ),
                Divider(),
                Padding(
                  padding: EdgeInsets.fromLTRB(60.0, 20.0, 60.0, 10.0),
                  child: TextField(
                    enabled: false,
                    controller: totalCash,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        labelText: "Total Amount of Cash Transaction",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        alignLabelWithHint: true),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 10.0),
                  child: TextField(
                    enabled: false,
                    controller: totalBank,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        labelText: "Total Amount of Bank Transaction",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        alignLabelWithHint: true),
                  ),
                ),
                Divider(),

                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      print(await db.getTotalBankTransaction());
                      convertNumber();
                      total.text = TotalSum.toString();
                      today.text = todayTotal.toString();
                      totalCash.text = TotalCash.toString();
                      totalBank.text = TotalBank.toString();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(left: 50.0, right: 50.0, top: 20.0, bottom: 20.0),
                      child: Text(
                        "Get Information",
                        style: styleBody,
                      ),
                    ),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) => Colors.indigo),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                          side: BorderSide(color: Colors.white),
                        ),
                      )
                    ),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

  AppBar myAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        "Home Page",
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
            if (value == "goto") {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => JumpOnDate()));
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
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
              value: 'goto',
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      "Go to Date",
                      style: TextStyle(color: Colors.white),
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

// MAIN DRAWER OF APPLICATION
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
}
