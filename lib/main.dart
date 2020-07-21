import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Data>(
          create: (_) => Data(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _error;

  void _incrementCounter(BuildContext context) {
    try {
      Provider.of<Data>(context, listen: false).getData();
    } catch (e) {
      setState(() => _error = e.toString());
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${Provider.of<Data>(context).counter}',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              '\n${_error ?? ""}',
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontSize: 5,
                  ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _incrementCounter(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Data extends ChangeNotifier {
  int counter = 0;
  void getData() async {
    print("object");
    // try {
    await Future.delayed(Duration(milliseconds: 500), () async {
      if (math.Random().nextBool()) {
        throw "Random Error";
      }
    });
    counter++;
    notifyListeners();
    // } catch (e) {
    //   throw e;
    // }
  }
}
