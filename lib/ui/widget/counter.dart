import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int counter;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  CounterWidget({
    required this.counter,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: onIncrement,
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
          ],
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '$counter',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              onPressed: onDecrement,
              tooltip: 'Decrement',
              backgroundColor: Theme.of(context).colorScheme.error,
              child: const Icon(Icons.remove),
            ),
          ],
        ),
      ],
    );
  }
}
