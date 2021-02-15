import 'package:flutter/material.dart';
import 'package:quiz_app/views/signin.dart';
import 'package:quiz_app/views/home.dart';
import 'package:quiz_app/widgets/widgets.dart';
import 'package:quiz_app/services/auth.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey=GlobalKey<FormState>();
  String email,password,name;
  AuthService authService=new AuthService();
  bool isLoading=false;
  signUp()async{
    if(_formKey.currentState.validate()){
      setState(() {
        isLoading=true;
      });
      await authService.signUpWithEmailAndPassword(email, password).then((value){
        if(value!=null){
          setState(() {
            isLoading=false;
          });
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Home()
          ));
        }
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
      body:  isLoading ? Container(
        child: Center(child: CircularProgressIndicator()),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            Spacer(),
            TextFormField(

              validator: (val){
                return val.isEmpty ? "Enter Name":null;
              },
              decoration: InputDecoration(hintText: 'Enter Your Name'),
              onChanged: (val){
                name=val;
              },
            ),
            SizedBox(height: 6,),
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
                signUp();
              },
              child: blueButton(
                  context:context,
                  label:"Signup"),
            ),
            SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already Have an Account? ",style:TextStyle(fontSize: 16.0) ,),
                GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                          builder: (context) => SignIn()
                      ),
                      );
                    },
                    child: Text("Signin",style: TextStyle(fontSize: 16.0,decoration: TextDecoration.underline),)),
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