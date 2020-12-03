import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Calculator(),
  ));
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';

  Widget btn(btnText, Color color) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: RaisedButton(
        child: Text(
          btnText,
          style: TextStyle(fontSize: 30),
        ),
        onPressed: () {
          calculation(btnText);
        },
        color: color,
        padding: EdgeInsets.all(22.0),
        shape: CircleBorder(),
      ),
    );
  }

  Widget btnZero(btnText, Color color) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: RaisedButton(
        child: Text(
          btnText,
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        onPressed: () {
          calculation(btnText);
        },
        color: color,
        padding: EdgeInsets.only(
          left: 81,
          top: 20,
          right: 81,
          bottom: 20,
        ),
        shape: StadiumBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 60.0, color: Colors.white),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('C', Color(0xffa5a5a5)),
                btn('+/-', Color(0xffa5a5a5)),
                btn('%', Color(0xffa5a5a5)),
                btn('/', Colors.orange),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('7', Color(0xff333333)),
                btn('8', Color(0xff333333)),
                btn('9', Color(0xff333333)),
                btn('x', Colors.orange),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('4', Color(0xff333333)),
                btn('5', Color(0xff333333)),
                btn('6', Color(0xff333333)),
                btn('-', Colors.orange),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('1', Color(0xff333333)),
                btn('2', Color(0xff333333)),
                btn('3', Color(0xff333333)),
                btn('+', Colors.orange),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                btn('0', Color(0xff333333)),
                btn('.', Color(0xff333333)),
                btn('=', Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  } // end of state class

  void calculation(btnText) {
    if (btnText == 'C') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '';
      opr = '';
      preOpr = '';
    } else if (opr == '=' && btnText == '=') {
      if (preOpr == '+') {
        finalResult = add();
      } else if (preOpr == '-') {
        finalResult = sub();
      } else if (preOpr == 'x') {
        finalResult = mul();
      } else if (preOpr == '/') {
        finalResult = div();
      }
    } else if (btnText == '+' ||
        btnText == '-' ||
        btnText == 'x' ||
        btnText == '/' ||
        btnText == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }
      if (opr == '+') {
        finalResult = add();
      } else if (opr == '-') {
        finalResult = sub();
      } else if (opr == 'x') {
        finalResult = mul();
      } else if (opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    } else if (btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if (btnText == '.') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalResult = result;
    } else if (btnText == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
      finalResult = result;
    } else {
      result = result + btnText;
      finalResult = result;
    }
    setState(() {
      text = finalResult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String doesContainDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) >= 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }
}
