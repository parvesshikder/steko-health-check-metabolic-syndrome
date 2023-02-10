

import 'package:flutter/material.dart';

import '../constraints.dart';

class QuizQuestion extends StatefulWidget {
  final String question;
  final Widget btn1;
  final Widget btn2;
  final String text1;
  final String text2;
  
  const QuizQuestion(
      {Key key, this.question, this.btn1 , this.btn2, this.text1 = 'Yes', this.text2 = 'No' })
      : super(key: key);

  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
 
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        gradient: kGreenGradientColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Card(
            color: Colors.white.withOpacity(0.5),
            child: ListTile(
              iconColor: Colors.white,
              style: ListTileStyle.list,
              leading: const Text(
                '',
                style: TextStyle(fontSize: 30),
              ),
              title: Text(
                widget.text1,
                style: TextStyle(color: Colors.white),
              ),
              trailing: widget.btn1,
            ),
          ),
          Card(
            color: Colors.white.withOpacity(0.5),
            child: ListTile(
              iconColor: Colors.white,
              style: ListTileStyle.list,
              leading: const Text(
                '',
                style: TextStyle(fontSize: 30),
              ),
              title: Text(
                widget.text2,
                style: TextStyle(color: Colors.white),
              ),
              trailing:  widget.btn2,
            ),
          ),
        ],
      ),
    );
  }
}
