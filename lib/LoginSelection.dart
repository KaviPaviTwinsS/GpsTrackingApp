import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterlocationupdate/CustomButton.dart';
import 'package:flutterlocationupdate/CustomTextSpan.dart';
import 'package:flutterlocationupdate/colors.dart';
import 'package:flutterlocationupdate/login/UserSignInRequestData.dart';
import 'package:flutterlocationupdate/login/UserSignInResponseData.dart';
import 'package:flutterlocationupdate/login/loginRepository.dart';
import 'package:flutterlocationupdate/strings.dart';
import 'package:fluttertoast/fluttertoast.dart';


class LoginSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Loggin Page',
      theme: ThemeData(
        // This is the theme of your application.
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginSelection(),);
  }

}

class LoginSelection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginSelectionState();
  }
}

abstract class buttonClick {
  void buttonclick(String type);
}

class LoginSelectionState extends State<LoginSelection> implements buttonClick {

  TextEditingController userEmailController = new TextEditingController();
  TextEditingController userPasswordController = new TextEditingController();

  String _userEmail, _userPassword;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          /*Container(
           alignment: Alignment.topCenter,
           child: new Image.asset(
             'images/welcome.png',
             fit: BoxFit.cover,
           ),
         )*/
          SizedBox(height: 50),
          Container(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/welcome.png',
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
          Text(welcome_back,
            style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
          Text(login_use),
          SizedBox(height: 30,),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
//              child:customTextFieldWthRectangleBorder(false,user_email, TextInputType.emailAddress,Icons.email)
            child: TextField(
              obscureText: false,
              controller: userEmailController,
              onChanged: (userEmail) {
                _userEmail = userEmail;
              },
              decoration: customTextFieldWthRectangleBorder(
                  false, user_email, TextInputType.emailAddress, Icons.email),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          SizedBox(height: 10,),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
                controller: userPasswordController,
                obscureText: true,
                decoration: customTextFieldWthRectangleBorder(
                    false, user_password, TextInputType.number, Icons.lock),
                keyboardType: TextInputType.numberWithOptions(),
                onChanged: (userPassword) {
                  _userPassword = userPassword;
                }
            ),
//              child:customTextFieldWthRectangleBorder(true,user_password, TextInputType.number,Icons.lock)
          ),
          SizedBox(height: 5,),
          Container(
            margin: const EdgeInsets.only(left: 20.0, right: 20.0),
            alignment: Alignment.topRight,
            child: Text(forgot_password,
              style: new TextStyle(fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 10,),
          ButtonTheme(
              minWidth: 150.0,
              height: 40.0,
              child: customWidgetWithRoundedBorder(log_in, this)),
          SizedBox(height: 30,),
          Text(connect_with),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CustomButton(facebook, 'assets/images/facebook.png', this),
              CustomButton(google, 'assets/images/google.png', this)
            ],
          ),
          Align(
            child: customTextSpan(dont_have_acc, sign_up),
          )
        ]
        ,
      )
      ,
    );
  }

  @override
  Future buttonclick(String type) async {
    print('buttonclick $_userEmail ___pass $_userPassword');
    if (type == "Login") {
      UserSignInRequestData userSignInRequestData = UserSignInRequestData(
          deviceId: "fbbf8e3a3a846e18",
          deviceToken: "eYpPct4VYbc:APA91bFPX5Em1T4Jrc78rKhJSrRK98CHHfNkda-oZkazBB-EpkdL2o6H_7L7oc9HXtoYNMdqaLthSpBWT8dDXlOIrJlaoMPyBK9X4GO-nl45qp5ujlC-SNWsE1TWdYH7NpedtEHPFfr4",
          deviceType: 2,
          language: "1",
          password: _userPassword,
          email: _userEmail);
      UserSignInResponseData p = await createPost(userSignInRequestData);
      print(p.mDetail.userEmail);
      Fluttertoast.showToast(msg: p.message);
    }
  }
}
