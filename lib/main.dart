import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stateful Widget',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String status = 'Active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snack Bar'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Simulate removing something
            setState(() {
              status = 'Removed';
            });

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                duration: const Duration(seconds: 5),
                behavior: SnackBarBehavior.floating,
                content: const Text('Successfully removed!'),
                action: SnackBarAction(
                  label: 'UNDO',
                  onPressed: () {
                    setState(() {
                      status = 'Active';
                    });
                  },
                ),
              ),
            );
          },
          child: const Text('Click to remove'),
        ),
      ),
    );
  }
}
