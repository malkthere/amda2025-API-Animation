import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order the Letters Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OrderLettersGame(),
    );
  }
}

class OrderLettersGame extends StatefulWidget {
  const OrderLettersGame({super.key});

  @override
  State<OrderLettersGame> createState() => _OrderLettersGameState();
}

class _OrderLettersGameState extends State<OrderLettersGame> {
  final String _wordToOrder = 'Dr.Mazin';
  late List<String> _shuffledLetters;
  late List<String?> _placedLetters;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _shuffleWord();
  }

  void _shuffleWord() {
    final List<String> letters = _wordToOrder.split('');
    letters.shuffle(Random());
    _shuffledLetters = letters;
    _placedLetters = List.filled(_wordToOrder.length, null);
    _isCorrect = false;
  }

  void _checkIfCorrect() {
    if (_placedLetters.join('') == _wordToOrder) {
      setState(() {
        _isCorrect = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order the Letters'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Unscramble: ${_shuffledLetters.join(' ')}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_wordToOrder.length, (index) {
                return DragTarget<String>(
                  builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                      ) {
                    return Container(
                      width: 40.0,
                      height: 40.0,
                      margin: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: _placedLetters[index] == null
                            ? Colors.grey[300]
                            : Colors.blue[200],
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          _placedLetters[index] ?? '',
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  },
                  onAccept: (String letter) {
                    setState(() {
                      if (_placedLetters[index] == null) {
                        _placedLetters[index] = letter;
                        _shuffledLetters.remove(letter);
                        _checkIfCorrect();
                      }
                    });
                  },
                  onWillAccept: (String? letter) =>
                  letter != null && _placedLetters[index] == null,
                );
              }),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 8.0,
              children: _shuffledLetters.map((letter) {
                return Draggable<String>(
                  data: letter,
                  feedback: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        letter,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                  childWhenDragging: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        letter,
                        style: const TextStyle(fontSize: 20, color: Colors.grey),
                      ),
                    ),
                  ),
                  child: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        letter,
                        style: const TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            if (_isCorrect)
              const Text(
                'Correct!',
                style: TextStyle(fontSize: 24, color: Colors.green),
              ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _shuffleWord();
                });
              },
              child: const Text('New Word'),
            ),
          ],
        ),
      ),
    );
  }
}