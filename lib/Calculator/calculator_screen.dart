import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class calculator extends StatefulWidget {
  const calculator({super.key});

  @override
  State<calculator> createState() => _calculatorState();
}

class _calculatorState extends State<calculator> {
  String equation = " ";
  String result = " ";
  @override
  void initState() {
    super.initState();
    // Initialize the text in the container.
    _updateText();
  }

  // String expression = "";
  // double equationFontSize = 38.0;
  // double resultFontSize = 48.0;

  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == '=') {
        try {
          result = _calculateResult();
        } catch (e) {
          result = "Error";
        }
        equation = "";
      } else if (buttonText == 'C') {
        equation = "";
        result = "";
      } else if (buttonText == '/') {
        equation += '/';
      } else if (buttonText == '⌫') { // Add this condition for backspace
        if (equation.isNotEmpty) {
          equation = equation.substring(0, equation.length - 1);
          result = "";

        }
      } else {
        equation += buttonText;
      }
      _updateText();
    });
  }
  void _updateText() {
    setState(() {
      if (equation.isEmpty) {
        result = result.isEmpty ? "0" : result;
      } else {
        result = equation;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
            child: Container(
              height: size.height * 0.3,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade600,
              ),
              child: Center(
                child: Text(
                  result,
                  style: TextStyle(
                    fontSize: 48.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: size.height * 0.59,
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcButton('(', Colors.grey, () => buttonPressed('(')),
                    calcButton('√', Colors.white10, () => buttonPressed('√')),
                    calcButton('7', Colors.white10, () => buttonPressed('7')),
                    calcButton('4', Colors.white10, () => buttonPressed('4')),
                    calcButton('1', Colors.white10, () => buttonPressed('1')),
                    calcButton('.', Colors.white10, () => buttonPressed('.')),
                  ],
                ), Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcButton(')', Colors.grey, () => buttonPressed(')')),
                    calcButton('', Colors.white10, () => buttonPressed('')),
                    calcButton('8', Colors.white10, () => buttonPressed('8')),
                    calcButton('5', Colors.white10, () => buttonPressed('5')),
                    calcButton('2', Colors.white10, () => buttonPressed('2')),
                    calcButton('0', Colors.white10, () => buttonPressed('0')),
                  ],
                ), Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcButton('C', Colors.grey, () => buttonPressed('C')),
                    calcButton('⌫', Colors.white10, () => buttonPressed('⌫')),
                    calcButton('9', Colors.white10, () => buttonPressed('9')),
                    calcButton('6', Colors.white10, () => buttonPressed('6')),
                    calcButton('3', Colors.white10, () => buttonPressed('3')),
                    calcButton('%', Colors.white10, () => buttonPressed('%')),
                  ],
                ), Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    calcButton('/', Colors.grey, () => buttonPressed('/')),
                    calcButton('x', Colors.white10, () => buttonPressed('x')),
                    calcButton('+', Colors.white10, () => buttonPressed('+')),
                    calcButton('-', Colors.white10, () => buttonPressed('-')),
                    calcButton('=', Colors.orange, () => buttonPressed('=')),
                  ],
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }

  Widget calcButton(String buttonText,
      Color buttonColor,
      void Function()? buttonPressed) {
    return Container(
      width: 65,
      height: buttonText == '=' ? 140 : 65,
      padding: const EdgeInsets.all(0),
      child: ElevatedButton(
        onPressed: buttonPressed,
        style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            backgroundColor: buttonColor),
        child: Text(buttonText,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
      ),
    );
  }

  String _calculateResult() {
    try {
      Parser parser = Parser();
      Expression expression = parser.parse(equation);
      ContextModel contextModel = ContextModel();
      double result = expression.evaluate(EvaluationType.REAL, contextModel);
      return result.toString();
    } catch (e) {
      return "Error";
    }
  }
}
