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
  final items = List<String>.generate(20, (i) => 'Item ${i + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dismissible List"),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item),
            direction: DismissDirection.endToStart,
            dismissThresholds: const {
              DismissDirection.startToEnd: 0.5, // 50% swipe right
              DismissDirection.endToStart: 0.5, // 50% swipe left
            },
            onDismissed: (direction) {
              final removedItem = items[index];
              final removedIndex = index;

              // Remove the item
              setState(() {
                items.removeAt(index);
              });

              // Show snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Item dismissed'),
                  backgroundColor: Colors.green,
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {
                      setState(() {
                        items.insert(removedIndex, removedItem);
                      });
                    },
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            // Show a red background as the item is swiped away
            background: Container(color: Colors.red),
            child: ListTile(title: Text(item)),
          );
        },
      ),
    );
  }
}
