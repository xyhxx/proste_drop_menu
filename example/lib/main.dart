import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proste_drop_menu/proste_drop_menu.dart';

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
    return MaterialApp(home: MyBody());
  }
}

class MyBody extends StatefulWidget {
  const MyBody({Key? key}) : super(key: key);

  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      endDrawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              Text('this is Drawer'),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: null,
            icon: Text(''),
          ),
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              print('other');
            },
            child: Container(
              height: 50,
              color: Colors.green,
            ),
          ),
          ProsteDropMenu(
            headers: [
              ProsteDropMenuHeaderItem(label: '下拉'),
              ProsteDropMenuHeaderItem(label: '长文本测试长文本测试'),
              ProsteDropMenuHeaderItem(label: 'drawer'),
            ],
            menus: [
              ProsteDropMenuItem(
                builder: (_) => Container(
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        30,
                        (index) => Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(index.toString()),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ProsteDropMenuItem(
                tigger: (_) {
                  print('触发');
                },
              ),
              ProsteDropMenuItem(
                tigger: (_) {
                  _key.currentState!.openEndDrawer();
                },
              ),
            ],
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(14),
                  child: Text(i.toString()),
                );
              },
              separatorBuilder: (_, i) {
                return Divider();
              },
              itemCount: 20,
            ),
          )
        ],
      ),
    );
  }
}
