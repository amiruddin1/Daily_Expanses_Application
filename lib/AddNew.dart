import 'package:flutter/material.dart';
import 'package:myexpanses/home_page.dart';
import '/DBHelper.dart';
import '/AllTransactions.dart';
import '/GetCalendar.dart';
import 'TBLTransaction.dart';
import 'loginPage.dart';

class MainSection extends StatefulWidget {
  @override
  State<MainSection> createState() => _MainSectionState();
}

class _MainSectionState extends State<MainSection> {
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

  List<String> type = ["Cash","Bank"];
  String? dropvalue = "Cash";

  TextEditingController title = TextEditingController();
  TextEditingController Description = TextEditingController();
  TextEditingController Amount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false, theme: theme, home: mainBody()),
    );
  }

  //MAIN APP BAR OF APPLICATION
  AppBar myAppBar() {
    return AppBar(
      title: Text(
        "Insert New Transaction",
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
            if(value=="allexp"){
              Navigator.push(context, MaterialPageRoute(builder: (context) => ListTransaction()));
            }
            if(value=="goto"){
              Navigator.push(context, MaterialPageRoute(builder: (context) => JumpOnDate()));
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
  Drawer myDrawer() {
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

  // DROP-DOWN OF BODY (CASH - BANK)
  Widget DropDownType() {
    return DropdownButton<String>(
      value: dropvalue,
      onChanged: (newValue) {
        setState(() {
          dropvalue = newValue;
        });
      },
      items: type.map<DropdownMenuItem<String>>((String value) {
        IconData? iconData2;
        Color? iconcolor2;
        TextStyle? tx;
        if (value == type[1]) {
          iconData2 = Icons.book_online;
          iconcolor2 = Colors.blue;
          tx = TextStyle(color: Colors.blue);
        } else if (value == type[0]) {
          iconData2 = Icons.offline_pin;
          iconcolor2 = Colors.green;
          tx = TextStyle(color: Colors.green);
        }
        return DropdownMenuItem<String>(
          value: value,
          child: Row(
            children: [
              Icon(
                iconData2,
                color: iconcolor2,
              ),
              Container(
                width: 10.0,
              ),
              Text(
                value,
                style: tx,
              )
            ],
          ),
        );
      }).toList(),
    );
  }

  Scaffold mainBody() {
    return Scaffold(
      appBar: myAppBar(),
      drawer: myDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home Page",
              tooltip: "Home Page"),
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
        onTap: (value){
          if(value==0){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
          }
          else if(value==2){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>JumpOnDate()));
          }
          else if(value==1){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>ListTransaction()));
          }
        },
        elevation: 3
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Form(
          child: ListView(
            children: [
              Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Center(
                      child: Text(
                    "Enter Transaction Detail To Insert",
                    style: styleBody,
                  ))),
              Divider(),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Text(
                    "Enter Title of Transaction*",
                    style: style,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)
                    )
                  ),
                  textAlign: TextAlign.center,
                  style: textStyle,
                  controller: title,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Text(
                    "Enter Description of Transaction",
                    style: style,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  maxLines: 2,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                  textAlign: TextAlign.center,
                  style: textStyle,
                  controller: Description,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25.0),
                child: Center(
                  child: Text(
                    "Enter Amount of Transaction*",
                    style: style,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)
                      )
                  ),
                  textAlign: TextAlign.center,
                  style: textStyle,
                  controller: Amount,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(children: [
                  Expanded(
                      child: Text(
                        "Transaction Made Using*",
                        style: style,
                      )),
                  Expanded(child: DropDownType()),
                ]),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (title.text == "" ||
                        Amount.text == "") {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.black,
                              title: Row(children: [
                                Text(
                                  "Empty Data",
                                  style: TextStyle(
                                      fontFamily: "MyFont",
                                      fontSize: 25.0,
                                      color: Colors.white,
                                      decoration: TextDecoration.underline),
                                ),
                                Container(
                                  width: 10.0,
                                ),
                                Icon(
                                  Icons.warning,
                                  color: Colors.yellow,
                                ),
                              ]),
                              content: Text(
                                "Required Fields are Mandatory to fill..",
                                style: TextStyle(
                                    fontFamily: "MyFont",
                                    fontSize: 25.0,
                                    color: Colors.white),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          });
                    } else {
                      DateTime now = DateTime.now();
                      MyTransaction tr = MyTransaction(
                          TransactionID_PK: 0,
                          TransactionTitle: title.text,
                          TransactionDescription: Description.text,
                          TransactionAmount: int.parse(Amount.text),
                          TransactionMode: dropvalue!,
                          TransactionDateTime: ""
                        );
                      DatabaseHelper db = DatabaseHelper.instance;
                      int result = await db.insertData(tr);
                      if(result>0)
                        {
                          title.text="";
                          Description.text = "";
                          Amount.text = "";
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                title: Row(
                                    children:[
                                      Text("Inserted", style: TextStyle(
                                          fontFamily:  "MyFont",
                                          fontSize: 25.0,
                                          color: Colors.white,
                                          decoration: TextDecoration.underline
                                      ),),
                                      Container(width: 10.0,),
                                      Icon(Icons.cloud_done, color: Colors.green,),
                                    ]
                                ),
                                content: Text("Data Inserted Successfully", style: TextStyle(
                                    fontFamily:  "MyFont",
                                    fontSize: 25.0,
                                    color: Colors.white
                                ),),
                                actions: <Widget>[
                                  Row(
                                    children:[
                                      TextButton(
                                        child: Text('OK'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                          onPressed: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => ListTransaction()));
                                          },
                                          child: Text("Go to All Transaction")
                                      )
                                    ]
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      else {
                        print("Error");
                      }
                    }
                  },
                  child: Text(
                    "Insert Data",
                    style: styleBody,
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.only(
                            top: 20.0,
                            right: 100.0,
                            left: 100.0,
                            bottom: 20.0)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        side: BorderSide(color: Colors.red, width: 2),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
          decoration: BoxDecoration(
              border: BorderDirectional(bottom:BorderSide(color: Colors.white))
          )
      ),
    );
  }
}
