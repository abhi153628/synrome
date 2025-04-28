import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Synrome(),
    );
  }
}

class Synrome extends StatefulWidget {
  const Synrome({
    super.key,
  });

  @override
  State<Synrome> createState() => _SynromeState();
}

class _SynromeState extends State<Synrome> {
  TextEditingController controll = TextEditingController();
  List<String> names = ['arju', 'kamalu', 'abhi', 'abhishek', 'shek'];

  void addNames() {
    String newItem = controll.text.trim();
    if (newItem.isNotEmpty) {
      setState(() {
        names.add(newItem);
      });
      controll.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
           Expanded(
            child: ListView.builder(
              itemCount: names.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(names[index]),
                );
              },
            ),
          ),
          TextField(
            controller: controll,
            decoration: InputDecoration(
              labelText: 'enter new name',
            ),
          ),
            ElevatedButton(
              onPressed: addNames,
              child: Text('add names'),
            ),
        ],
      ),
    );
  }
}
