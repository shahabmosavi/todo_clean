import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo')),
      body: const Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: Column(
        children: [
          Expanded(flex: 10, child: Placeholder()),
          const SizedBox(height: 10),
          Expanded(
              child: Row(
            children: [
              Expanded(flex: 4, child: Placeholder()),
              const SizedBox(width: 10),
              Expanded(child: Placeholder()),
            ],
          )),
        ],
      ),
    );
  }
}
