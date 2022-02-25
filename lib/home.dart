// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  String equation = '0';
  String result = "";
  String expression = "";
  double equationfontsize = 28.0;
  double resultfontsize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "";
        equationfontsize = 28.0;
        resultfontsize = 48.0;
      } else if (buttonText == "C") {
        equationfontsize = 48.0;
        resultfontsize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "=") {
        if(result == '.0'){
          var best = int.parse(result);
          var go = best.toString();
          result = go;
        }
        equationfontsize = 28.0;
        resultfontsize = 48.0;

        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          var tempResult = '${exp.evaluate(EvaluationType.REAL, cm)}';
          var conv = int.parse(tempResult.split(".")[1]);
          conv>0?result = tempResult: result = tempResult.split(".")[0];
        } catch (e) {
          result = "Error";
        }
      } else {
        equationfontsize = 48.0;
        resultfontsize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        }else{
          equation = equation + buttonText;

        }
      
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(10.0),
        child: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15.0),
                    child: Icon(
                      Icons.record_voice_over_sharp,
                      color: Colors.black54,
                    ),
                  ),
                  Container(
                    child: Icon(
                      Icons.settings,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.fromLTRB(0, 0, 10.0, 5.0),
              child: Text(
                equation,
                style: TextStyle(
                  fontSize: equationfontsize,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 10.0),
              child: Text(
                result,
                style: TextStyle(
                  fontSize: resultfontsize,
                ),
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .65,
                    child: Table(
                      children: [
                        TableRow(
                          children: [
                            buttonbuild('C', 0.9),
                            buttonbuild('AC', 0.9),
                            buttonbuild('%', 0.9),
                          ],
                        ),
                        TableRow(
                          children: [
                            buttonbuild('7', 0.9),
                            buttonbuild('8', 0.9),
                            buttonbuild('9', 0.9),
                          ],
                        ),
                        TableRow(
                          children: [
                            buttonbuild('4', 0.9),
                            buttonbuild('5', 0.9),
                            buttonbuild('6', 0.9),
                          ],
                        ),
                        TableRow(
                          children: [
                            buttonbuild('1', 0.9),
                            buttonbuild('2', 0.9),
                            buttonbuild('3', 0.9),
                          ],
                        ),
                        TableRow(
                          children: [
                            buttonbuild('00', 0.9),
                            buttonbuild('0', 0.9),
                            buttonfill('.', 0.9),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.20,
                    child: Table(
                      children: [
                        TableRow(children: [buttonfill('×', 0.9)]),
                        TableRow(children: [buttonfill('+', 0.9)]),
                        TableRow(children: [buttonfill('-', 0.9)]),
                        TableRow(children: [buttonfill('÷', 0.9)]),
                        TableRow(children: [
                          equalbutton('=', Colors.deepPurple.shade900, 0.9)
                        ]),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buttonbuild(String buttonText, double buttonheight) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey.shade200,
      ),
      margin: EdgeInsets.fromLTRB(0, 15, 15, 15),
      height: MediaQuery.of(context).size.height * 0.1 * buttonheight,
      child: FlatButton(
        onPressed: () => buttonPressed(buttonText),
        padding: EdgeInsets.all(10.0),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 25,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget buttonfill(String buttonText, double buttonheight) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
      height: MediaQuery.of(context).size.height * 0.1 * buttonheight,
      child: FlatButton(
        onPressed: () => buttonPressed(buttonText),
        padding: EdgeInsets.all(10.0),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget equalbutton(String buttonText, Color myColor, double buttonheight) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: myColor,
      ),
      margin: EdgeInsets.fromLTRB(0, 15, 15, 15),
      height: MediaQuery.of(context).size.height * 0.1 * buttonheight,
      child: FlatButton(
        onPressed: () => buttonPressed(buttonText),
        padding: EdgeInsets.all(10.0),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
