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
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          '$counter',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: onIncrement,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
        const SizedBox(height: 10),
        FloatingActionButton(
          onPressed: onDecrement,
          tooltip: 'Decrement',
          backgroundColor: Theme.of(context).colorScheme.error,
          child: const Icon(Icons.remove),
        ),
      ],
    );
  }
}
