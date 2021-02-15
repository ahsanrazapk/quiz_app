import 'package:flutter/material.dart';
import 'package:quiz_app/views/create_quiz.dart';
import 'package:quiz_app/views/credit_card.dart';
import 'package:quiz_app/views/signup.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/widgets/widgets.dart';
import 'package:quiz_app/services/auth.dart';


class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey=GlobalKey<FormState>();
  String email,password;
  AuthService authService=new AuthService();
  bool isLoading=false;
  signIn()async{
    if(_formKey.currentState.validate()){
      setState(() {
        isLoading=true;
      });
        await authService.signInEmailAndPassword(email, password).then((value) {
          if(value!=null){
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Home(),
            ));
          }
        });
        setState(() {
          isLoading=false;
        });

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: appBar(context),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        brightness: Brightness.light,
      ),
      body: isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            Spacer(),
            TextFormField(
              validator: (val){
                return val.isEmpty ? "Enter Email":null;
              },
              decoration: InputDecoration(hintText: 'Enter Your Email'),
              onChanged: (val){
                email=val;
              },
            ),
            SizedBox(height: 6,),
            TextFormField(
              obscureText: true,
              validator: (val){
                return val.isEmpty ? "Enter Password":null;
              },
              decoration: InputDecoration(hintText: 'Enter Your Password'),
              onChanged: (val){
                password=val;
              },
            ),
            SizedBox(height: 24,),
            GestureDetector(
              onTap: (){
                signIn();
              },
              child: blueButton(
                  context:context,
                  label:"Signin"),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't Have an Account? ",style:TextStyle(fontSize: 16.0) ,),
                GestureDetector(
                    onTap: (){
                      // Navigator.pushReplacement(context, MaterialPageRoute(
                      //     builder: (context) => SignUp()
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => CreditCard(),
                      ),
                      );
                    },
                    child: Text("Signup",style: TextStyle(fontSize: 16.0,decoration: TextDecoration.underline),)),
              ],
            ),
            SizedBox(height: 80,),
          ],
          ),
        ),
      ),
    );
  }
}