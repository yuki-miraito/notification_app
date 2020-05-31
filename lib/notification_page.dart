import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Notification Page');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NotificationDetails platformChannelSpecifics;

  @override
  void initState() {
    super.initState();

//    _refresh();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocationLocation);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  }

  Future onSelectNotification(String payload) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Text(payload),
        maintainState : false,
      ),
    );
  }

  Future onDidReceiveLocationLocation(
    int id, String title, String body, String payload) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content:  Text(body),
          actions: <Widget>[
            FlatButton(
              child: Text(payload),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      }
    );
  }

  // ボタンを押したタイミングで通知がくる
  Future _onNotification() async {
    await flutterLocalNotificationsPlugin.show(
        0, 'plain title', 'plain body', platformChannelSpecifics,
        payload: 'item id 2'
    );
  }

  // ボタンを押したらAndroidにスケジュールを登録して指定した時間で通知がくる
  // AlarmManagerを使用できるようにManifestを修正する
//  Future _onNotification() {
//    return flutterLocalNotificationsPlugin.schedule(
//        0, 'plain title', 'plain body', DateTime.now().add(Duration(seconds: 3)),
//        platformChannelSpecifics, payload: 'item id 2');
//  }

  // 繰り返し通知
//  Future _onNotification() {
//    return flutterLocalNotificationsPlugin.periodicallyShow(
//        0, 'plain title', 'plain body', RepeatInterval.EveryMinute,
//        platformChannelSpecifics, payload: 'item id 2');
//  }

  // 特定の時間を繰り返す
//  Future _onNotification() {
//    var date = DateTime.now().add(Duration(seconds: 3));
//    return flutterLocalNotificationsPlugin.showDailyAtTime(
//        0, 'plain title', 'plain body', Time(date.hour, date.minute, date.second),
//        platformChannelSpecifics, payload: 'item id 2');
//  }

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
              '通知ボタン',
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
              child: RaisedButton(
                child: Icon(Icons.send),
                onPressed: _onNotification,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
