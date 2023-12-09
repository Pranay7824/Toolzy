import 'package:flutter/material.dart';



//This class is responsible for creating calculator page
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}


class _CalculatorState extends State<Calculator> {
  String _output = '0';
  double _num1 = 0;
  double _num2 = 0;
  String _operation = '';



  //This function handles click events of buttons
  void _handleButtonClick(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '0';
        _num1 = 0;
        _num2 = 0;
        _operation = '';
      } else if (buttonText == '+' ||
          buttonText == '-' ||
          buttonText == 'x' ||
          buttonText == '/') {
        _num1 = double.parse(_output);
        _operation = buttonText;
        _output = '0';
      } else if (buttonText == '=') {
        _num2 = double.parse(_output);
        switch (_operation) {
          case '+':
            _output = (_num1 + _num2).toString();
            break;
          case '-':
            _output = (_num1 - _num2).toString();
            break;
          case 'x':
            _output = (_num1 * _num2).toString();
            break;
          case '/':
            if (_num2 != 0) {
              _output = (_num1 / _num2).toString();
            } else {
              _output = 'Error';
            }
            break;
          default:
            _output = 'Error';
        }
        _operation = '';
        _num1 = 0;
        _num2 = 0;
      } else {
        if (_output == '0' || _output == 'Error') {
          _output = buttonText;
        } else {
          _output += buttonText;
        }
      }
    });
  }

  //This function is return button to use multiple times
  Widget _buildButton(String buttonText, {Color? color}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => _handleButtonClick(buttonText),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24),
          ),
          style: ElevatedButton.styleFrom(
            primary: color ?? Colors.grey[300],
            padding: EdgeInsets.all(20),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: TextStyle(fontSize: 48),
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('/', color: Colors.orange),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('x', color: Colors.orange),
            ],
          ),
          Row(
            children: [
              _buildButton('1'),
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('-', color: Colors.orange),
            ],
          ),
          Row(
            children: [
              _buildButton('0'),
              _buildButton('C'),
              _buildButton('='),
              _buildButton('+', color: Colors.orange),
            ],
          ),
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.all(10)
              ),
              onPressed: () {
                //using navigator to replace this page with Homepage
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Text("Back to home"),
            ),
          ),
        ],
      ),
    );
  }
}
