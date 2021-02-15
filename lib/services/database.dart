import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map quizData, String quizID) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizID)
        .setData(quizData)
        .catchError((e) {
      print(e.toString());
    });
  }

  Future<void> addQuestionData(Map questionData, String quizID) async {
    await Firestore.instance
        .collection("Quiz")
        .document(quizID)
        .collection("QNA")
        .add(questionData)
        .catchError((e) {
      print(e.toString());
    });
  }
  getQuizHomeData()async{
    return await Firestore.instance.collection("Quiz").snapshots();
  }
  getQuizData(String quizId)async{
    return await Firestore.instance.collection("Quiz").document(quizId).collection("QNA").getDocuments();
  }
}
