import 'dart:math';

import 'package:flutter/material.dart';
//import '../../constants/values/egmValues.dart';

class GameScreen extends StatefulWidget {
  // const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  GameModel gameModel = GameModel.getGameData();

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.blue[100],
        width: screenWidth,
        height: screenHeight,
        child: ListView.separated(
            itemBuilder: ((context, index) {
              return LevelWidget(index, gameModel);
            }),
            separatorBuilder: ((context, index) {
              return SizedBox(
                height: screenHeight * 0.01,
              );
            }),
            itemCount: gameModel.quizData!.length),
      ),
    );
  }
}

// class GameScreen extends StatelessWidget {
//   // const DummyScreen({super.key});

//   GameModel gameModel = GameModel.getGameData();

//   @override
//   Widget build(BuildContext context) {
//     final screenHeight = MediaQuery.of(context).size.height;
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         color: Colors.blue[100],
//         width: screenWidth,
//         height: screenHeight,
//         child: ListView.separated(
//             itemBuilder: ((context, index) {
//               return LevelWidget(index, gameModel);
//             }),
//             separatorBuilder: ((context, index) {
//               return SizedBox(
//                 height: screenHeight * 0.01,
//               );
//             }),
//             itemCount: gameModel.quizData!.length),
//       ),
//     );
//   }
// }

class LevelWidget extends StatelessWidget {
  final int index;
  final GameModel gameData;
  LevelWidget(this.index, this.gameData);
  @override
  Widget build(BuildContext context) {
    final quizData = gameData.quizData![index];
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        if (index <= gameData.completedCount!) {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => QuizScreen(quizData)));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Complete the previous quiz to unlock this"),
          ));
        }
      },
      child: Container(
          margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
          padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            // color: Colors.amber[100],
            gradient: LinearGradient(
                colors: [Colors.purple[200]!, Colors.amber],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          ),
          // width: screenWidth * 0.95,
          height: screenHeight * 0.18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                index < gameData.completedCount!
                    ? "assets/images/checkmark.png"
                    : (index == gameData.completedCount!
                        ? "assets/images/play.png"
                        : "assets/images/lock.png"),
                scale: 2,
              ),
              Text(
                "level ${quizData.id.toString()}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                    fontSize: 15),
              ),
              Text(
                quizData.name.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
              )
            ],
          )),
    );
  }
}

class QuizScreen extends StatefulWidget {
  // const QuizScreen({super.key});
  final QuizModel quizData;
  QuizScreen(this.quizData);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // final images = ["woman1.png", "woman2.jpg", "woman4.webp"];
  int pageNumber = 0;
  bool showAnswers = false;
  bool correctTapped = false;
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final question = widget.quizData.questionModels?[pageNumber];
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            // borderRadius: BorderRadius.all(Radius.circular(12)),
            // color: Colors.amber[100],
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 225, 209, 226)!,
              Colors.blue[300]!
            ], begin: Alignment.bottomLeft, end: Alignment.topRight),
          ),
          width: screenWidth,
          height: screenHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: Image.asset(
                      // "assets/images/${images[Random().nextInt(images.length)]}"
                      "assets/images/woman1.png",
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Question ${question!.id.toString()} out of ${widget.quizData.questionModels?.length}",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w200,
                      fontSize: 13),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  question.question.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20),
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: question.answers?.length,
                  itemBuilder: ((context, index) {
                    // return ElevatedButton(
                    //     onPressed: () {
                    //       setState(() {
                    //         question.selectedAnswer = index;
                    //       });
                    //       print(question.selectedAnswer);
                    //     },
                    //     style: ElevatedButton.styleFrom(
                    //       backgroundColor: (question.selectedAnswer == index)
                    //           ? Colors.red
                    //           : Colors.grey, // This is what you need!
                    //     ),
                    //     child: Text(question.answers![index]));
                    return OptionButton(question, () {
                      setState(() {
                        question.selectedAnswer = index;
                        if (question.selectedAnswer == question.correctAnswer) {
                          correctTapped = true;
                        }
                      });
                    }, index, showAnswers);
                  })),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // print(widget.quizData.questionModels!.length);
                      // print(pageNumber);
                      setState(() {
                        // if (pageNumber <=
                        //     widget.quizData.questionModels!.length - 2) {
                        if (question.selectedAnswer != null) {
                          if (correctTapped) {
                            if (pageNumber <=
                                widget.quizData.questionModels!.length - 2) {
                              pageNumber++;
                              showAnswers = false;
                              correctTapped = false;
                            } else {
                              ///
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SuccessScreen()));

                              ///
                            }
                          } else {
                            setState(() {
                              correctTapped = true;
                              showAnswers = true;
                            });
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("Please select an answer"),
                          ));
                        }
                        // }
                      });
                      print("next");
                    },
                    child: Text(
                      "NEXT",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // This is what you need!
                    ),
                  ),
                  SizedBox(
                    width: screenWidth * 0.05,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  // const OptionButton({super.key});
  final bool showAnswers;
  final int index;
  final QuestionModel questionModel;
  final VoidCallback callback;
  OptionButton(this.questionModel, this.callback, this.index, this.showAnswers);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Container(
          height: screenHeight * 0.07,
          margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: showAnswers
                ? (questionModel.correctAnswer == index
                    ? Color.fromARGB(255, 119, 191, 43)
                    : (questionModel.selectedAnswer == index)
                        ? Colors.red
                        : Colors.white)
                : ((questionModel.selectedAnswer == index)
                    ? Color.fromARGB(255, 119, 191, 43)
                    : Colors.white),
          ),
          child: Center(
              child: Text(
            questionModel.answers![index],
            style: TextStyle(
                color: (questionModel.selectedAnswer == index)
                    ? Colors.white
                    : Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600),
          ))),
    );

    //  ElevatedButton(
    //     onPressed: () {
    //       callback();
    //       // print(question.selectedAnswer);
    //     },
    //     style: ElevatedButton.styleFrom(
    //       backgroundColor: (questionModel.selectedAnswer == index)
    //           ? Colors.red
    //           : Colors.grey, // This is what you need!
    //     ),
    //     child: Text(questionModel.answers![index]));
  }
}

class SuccessScreen extends StatelessWidget {
  // const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: screenWidth,
        height: screenHeight,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: screenHeight * 0.1,
          ),
          // Text("YAAAAYY!!!!!"),
          Image.asset("assets/images/success.gif"),
          Text(
            "You have completed this quiz!!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: screenHeight * 0.1,
          ),
          GestureDetector(
            onTap: () {
              int count = GameModel.getGameData().completedCount!;
              GameModel.getGameData().completedCount = count + 1;
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Container(
                height: screenHeight * 0.07,
                width: screenWidth * 0.3,
                margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color.fromARGB(255, 233, 138, 4)),
                child: Center(
                    child: Text(
                  "Go Home",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ))),
          )
        ]),
      ),
    );
  }
}

class GameModel {
  int? completedCount;
  List<QuizModel>? quizData;
  GameModel(this.completedCount, this.quizData);

  static GameModel getGameData() {
    return GameModel(0, [
      QuizModel(1, "Level One Name", false, [
        QuestionModel(
            1, "How are you", ["I am good", "Go away", "I wanna die"], 2, null),
        QuestionModel(2, "Where are you",
            ["I am here", "I dont know", "I am everywhere"], 0, null),
        QuestionModel(3, " What are you",
            ["uhhu", "Ninte thantha", "aarkkariyam"], 1, null)
      ]),
      //
      QuizModel(2, "Level Two Name", false, [
        QuestionModel(
            1, "How are you", ["I am good", "Go away", "I wanna die"], 2, null),
        QuestionModel(2, "Where are you",
            ["I am good", "Go away", "I wanna die"], 0, null),
        QuestionModel(3, " What are you",
            ["I am good", "Go away", "I wanna die"], 1, null)
      ])
    ]);
  }
}

class QuizModel {
  int? id;
  String? name;
  bool? completed;
  List<QuestionModel>? questionModels;

  QuizModel(this.id, this.name, this.completed, this.questionModels);
}

class QuestionModel {
  int? id;
  String? question;
  List<String>? answers;
  int? correctAnswer;
  int? selectedAnswer;

  QuestionModel(this.id, this.question, this.answers, this.correctAnswer,
      this.selectedAnswer);
}
