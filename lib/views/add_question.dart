import 'package:flutter/material.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/widgets/widgets.dart';

class AddQuestion extends StatefulWidget {
  final String quizId;
  AddQuestion(this.quizId);
  @override
  _AddQuestionState createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _formKey = GlobalKey<FormState>();
  String question,option1, option2,option3,option4;
  bool isLoading=false;
  DatabaseService databaseService=new DatabaseService();
  upLoadQuizData()async{
    if(_formKey.currentState.validate()){
      setState(() {
        isLoading=true;
      });
      Map<String,String> questionMap={
        "question":question,
        "option1":option1,
        "option2":option2,
        "option3":option3,
        "option4":option4
      };

      await databaseService.addQuestionData(questionMap, widget.quizId).then((value){
        isLoading=false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backwardsCompatibility: true,
        title: appBar(context),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.transparent,
      ),
      body: isLoading ?Container(
        child: Center(child: CircularProgressIndicator()),
      ) : Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(hintText: 'Question'),
                onChanged: (val) {
                  question = val;
                },
                validator: (val) {
                  return val.isEmpty ? "Enter Question" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(hintText: 'Option 1'),
                onChanged: (val) {
                  option1 = val;
                },
                validator: (val) {
                  return val.isEmpty ? "Enter Option 1 (Correct Answer)" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(hintText: 'Option 2'),
                onChanged: (val) {
                  option2 = val;
                },
                validator: (val) {
                  return val.isEmpty ? "Enter Option 2" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(hintText: 'Option 3'),
                onChanged: (val) {
                  option3 = val;
                },
                validator: (val) {
                  return val.isEmpty ? "Enter Option 3" : null;
                },
              ),
              SizedBox(height: 6,),
              TextFormField(
                decoration: InputDecoration(hintText: 'Option 4'),
                onChanged: (val) {
                  option4 = val;
                },
                validator: (val) {
                  return val.isEmpty ? "Enter Option 4" : null;
                },
              ),
              Spacer(),
              Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: blueButton(
                      context: context,
                      label: "Submit",
                      buttonWidth: MediaQuery.of(context).size.width/2-36
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  GestureDetector(
                    onTap: (){
                      upLoadQuizData();
                    },
                    child: blueButton(
                        context: context,
                        label: "Add Question",
                        buttonWidth: MediaQuery.of(context).size.width/2-36
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
