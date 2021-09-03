import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proste_drop_menu/proste_drop_menu.dart';

import 'demo.dart';

void main() {
  runApp(const Application());
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  const SystemUiOverlayStyle style = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  );
  SystemChrome.setSystemUIOverlayStyle(style);
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        prosteDropMenuObserver,
      ],
      home: MyBody(),
    );
  }
}

class MyBody extends StatelessWidget {
  const MyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ProsteDropMenu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, CupertinoPageRoute(builder: (_) => Demo()));
              },
              child: Text('demo'),
            ),
          ],
        ),
      ),
    );
  }
}
