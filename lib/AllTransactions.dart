import 'package:flutter/material.dart';
import '/CashTransaction.dart';
import '/OnlineTransaction.dart';
import '/AddNew.dart';
import '/loginPage.dart';
import '/GetCalendar.dart';
import 'home_page.dart';

class ListTransaction extends StatefulWidget{
  @override
  State<ListTransaction> createState() => _ListTransactionState();
}

class _ListTransactionState extends State<ListTransaction> {
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        return true;
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false, theme: theme,
          home: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: myAppBar(),
              drawer: myDrawer(context),
              body: Container(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 50.0,top: 0),
                  child: TabBarView(
                    children: [
                      Cash(),
                      Bank()
                    ],
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add, color: Colors.white,),
                backgroundColor: Colors.black,
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainSection()));
                },
                tooltip: "Enter New Transaction",
              ),
            ),
          )
      ),
    );
  }

  AppBar myAppBar() {
    return AppBar(
      title: Text(
        "All Transactions",
        style: TextStyle(
          fontFamily: "Rockwell",
        ),
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (String value) {
            if (value=="logout") {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            }
            if(value=="addnew"){
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainSection()));
            }
            if(value=="goto"){
              Navigator.push(context, MaterialPageRoute(builder: (context) => JumpOnDate()));
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
      bottom: TabBar(
        indicatorColor: Colors.white,
        tabs: [
          Tab(
              icon: Icon(
                Icons.offline_pin,
                color: Colors.green,
              ),
              text: "Cash Transaction"
          ),
          Tab(
              icon: Icon(
                Icons.book_online,
                color: Colors.blue,
              ),
              text: "Bank Transaction")
        ],
      ),
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
            },
          )
        ],
      ),
    );
  }
}
