import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return loginView();
  }
}

class loginView extends State<Login> {
  TextEditingController pin = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.black,
          backgroundColor: Colors.black,
          indicatorColor: const Color(0xff0E1D36),
          buttonColor: const Color(0xff3B3B3B),
          hintColor: const Color(0xff280C0B),
          highlightColor: const Color(0xff372901),
          hoverColor: const Color(0xff3A3A3B),
          focusColor:const Color(0xff0B2512),
          disabledColor: Colors.grey,
          brightness: Brightness.dark,
        ),
        home: Scaffold(
          body: Center(
            child: Expanded(
              child: ListView(
                children: [
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: const Text(
                        "Welcome to Expanses Application",
                        textScaleFactor: 1.5,
                        style: TextStyle(
                          fontFamily: "Rockwell",
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset("Assets/images/author.jpg"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Center(
                      child: Text(
                        "Enter PIN To Enter Into Application",
                        style: TextStyle(
                          fontFamily: "Rockwell",
                        ),
                        textScaleFactor: 1.2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: TextField(
                      obscureText: true,
                      controller: pin,
                      style: const TextStyle(
                          fontFamily: "Rockwell",
                          color: Colors.red
                      ),
                      textAlign: TextAlign.center,
                      maxLength: 6,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: "******",
                          hintStyle: const TextStyle(
                              fontFamily: "Rockwell",
                              color: Colors.red
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(width: 3,color: Colors.red),
                              borderRadius: BorderRadius.circular(50.0)
                          )
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0, left: 20.0),
                    child: ElevatedButton(
                      onPressed: (){
                        if(pin.text == "722145"){
                          pin.text = "";
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                        }
                        else if(pin.text.length <= 5){
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                title: Row(
                                    children:[
                                      Text("Invalid PIN", style: TextStyle(
                                          fontFamily:  "MyFont",
                                          fontSize: 25.0,
                                          color: Colors.white,
                                          decoration: TextDecoration.underline
                                      ),),
                                      Container(width: 10.0,),
                                      Icon(Icons.warning, color: Colors.yellow,),
                                    ]
                                ),
                                content: Text("Entered PIN Should 6 Character Long", style: TextStyle(
                                    fontFamily:  "MyFont",
                                    fontSize: 25.0,
                                    color: Colors.white
                                ),),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        else{
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                title: Row(
                                  children:[
                                    Text("Invalid PIN", style: TextStyle(
                                        fontFamily:  "MyFont",
                                        fontSize: 25.0,
                                        color: Colors.white,
                                        decoration: TextDecoration.underline
                                    ),),
                                    Container(width: 10.0,),
                                    Icon(Icons.warning, color: Colors.yellow,),
                                  ]
                                ),
                                content: Text("Entered PIN is Wrong!", style: TextStyle(
                                    fontFamily:  "MyFont",
                                    fontSize: 25.0,
                                    color: Colors.white
                                ),),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('OK', style: TextStyle(
                                      fontFamily:  "MyFont",
                                      fontSize: 25.0,
                                      color: Colors.white
                                    ),),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child:const Text(
                        "Enter",
                        style: TextStyle(
                          fontFamily: "Rockwell",
                        ),
                        textScaleFactor: 1.2,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0)
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
