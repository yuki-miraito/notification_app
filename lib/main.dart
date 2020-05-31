import 'package:flutter/material.dart';
import './notification_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: MyHomePage(title: 'Counter Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
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
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Notification Page'),
                  Icon(Icons.navigate_next)
                ],
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return NotificationPage();
                  }),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        verticalDirection: VerticalDirection.up, // childrenの先頭を下に配置
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: FloatingActionButton(
              heroTag: 'addButton',
              onPressed: _incrementCounter,
              tooltip: 'Increment',
              child: Icon(Icons.add),
            ),
          ),
          Container( // 余白のためContainerでラップ
            margin: EdgeInsets.only(left: 16.0),
            child: FloatingActionButton(
              heroTag: 'removeButton',
              onPressed: _decrementCounter,
              child: Icon(Icons.remove),
              backgroundColor: Colors.red,
            ),
          ),
          Container( // 余白のためContainerでラップ
            margin: EdgeInsets.only(left: 16.0),
            child: FloatingActionButton(
              heroTag: 'resetButton',
              onPressed: _resetCounter,
              child: Icon(Icons.refresh),
              backgroundColor: Colors.grey,
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
