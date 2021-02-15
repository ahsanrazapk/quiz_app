import 'package:flutter/material.dart';
import 'package:quiz_app/services/database.dart';
import 'package:quiz_app/widgets/widgets.dart';
import 'package:random_string/random_string.dart';

import 'add_question.dart';

class CreateQuiz extends StatefulWidget {
  @override
  _CreateQuizState createState() => _CreateQuizState();
}

class _CreateQuizState extends State<CreateQuiz> {
  final _formKey = GlobalKey<FormState>();
  String imageURL, title, description, quizID;
  DatabaseService databaseService = new DatabaseService();
  bool isLoading = false;

  createQuizOnline() async {
    if (_formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      quizID = randomAlphaNumeric(16);
      Map<String, String> quizMap = {
        "quizId": quizID,
        "quizImageUrl": imageURL,
        "quizTitle": title,
        "quizDescripition": description,
      };
      await databaseService.addQuizData(quizMap, quizID).then((value) {
        setState(() {
          isLoading = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => AddQuestion(quizID),
            ),
          );
        });
      });
      // databaseService.addQuizData(quizData, quizID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backwardsCompatibility: true,
        title: appBar(context),
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.transparent,
      ),
      body: isLoading
          ? Container(
              child: Center(child: CircularProgressIndicator()),
            )
          : Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Quiz Image URL'),
                      onChanged: (val) {
                        imageURL = val;
                      },
                      validator: (val) {
                        return val.isEmpty ? "Enter Image Url" : null;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(hintText: 'Quiz Title'),
                      onChanged: (val) {
                        title = val;
                      },
                      validator: (val) {
                        return val.isEmpty ? "Enter Title" : null;
                      },
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(hintText: 'Quiz Descripition'),
                      onChanged: (val) {
                        description = val;
                      },
                      validator: (val) {
                        return val.isEmpty ? "Enter Descripition" : null;
                      },
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        // signIn();
                      },
                      child: GestureDetector(
                        onTap: (){
                          createQuizOnline();
                        },
                        child: blueButton(
                            context:context,
                            label:"Create Quiz"),
                      ),
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
