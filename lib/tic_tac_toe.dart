import 'package:flutter/material.dart';

class TicTacToe extends StatefulWidget {
  const TicTacToe({super.key});

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  @override
  late List<List<String>> _board;
  late String _currentPlayer;
  late bool _gameOver;

  @override
  void initState() {
    super.initState();
    _initializeBoard();
  }

  void _initializeBoard() {
    _board = List.generate(3, (_) => List.generate(3, (_) => ''));
    _currentPlayer = 'X';
    _gameOver = false;
  }

  void _makeMove(int row, int col) {
    if (_board[row][col] == '' && !_gameOver) {
      setState(() {
        _board[row][col] = _currentPlayer;
        _checkWinner(row, col);
        _togglePlayer();
      });
    }
  }

  void _togglePlayer() {
    _currentPlayer = (_currentPlayer == 'X') ? 'O' : 'X';
  }

  void _checkWinner(int row, int col) {
    // Check rows
    if (_board[row].every((element) => element == _currentPlayer)) {
      _endGame();
      return;
    }

    // Check columns
    if (_board.every((element) => element[col] == _currentPlayer)) {
      _endGame();
      return;
    }

    // Check diagonals
    if ((row == col || (row + col == _board.length - 1)) && _checkDiagonals()) {
      _endGame();
      return;
    }

    // Check for a draw
    if (_board.every((row) => row.every((cell) => cell.isNotEmpty))) {
      _endGame(draw: true);
    }
  }

  bool _checkDiagonals() {
    bool diagonal1 =
        _board.every((row) => row[_board.indexOf(row)] == _currentPlayer);
    bool diagonal2 = _board.every((row) =>
        row[_board.length - 1 - _board.indexOf(row)] == _currentPlayer);

    return diagonal1 || diagonal2;
  }

  void _endGame({bool draw = false}) {
    setState(() {
      _gameOver = true;
      String message;
      if (draw) {
        message = 'It\'s a draw!';
      } else {
        message = 'Player $_currentPlayer wins!';
      }
      _showDialog(message);
    });
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Over'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _initializeBoard();
              },
              child: const Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic-Tac-Toe'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                int row = index ~/ 3;
                int col = index % 3;
                return GestureDetector(
                  onTap: () {
                    _makeMove(row, col);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Center(
                      child: Text(
                        _board[row][col],
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
              itemCount: 9,
            ),
          ],
        ),
      ),
    );
  }
}
