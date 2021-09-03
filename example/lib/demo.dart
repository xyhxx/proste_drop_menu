import 'package:flutter/material.dart';
import 'package:proste_drop_menu/proste_drop_menu.dart';

class Demo extends StatefulWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
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
        leading: BackButton(),
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
              ProsteDropMenuHeaderItem(
                label: '下拉',
                selectColor: Colors.red,
                selectStyle: TextStyle(color: Colors.red),
              ),
              ProsteDropMenuHeaderItem(label: '长文本测试长文本测试'),
              ProsteDropMenuHeaderItem(label: 'drawer'),
            ],
            menus: [
              ProsteDropMenuItem(
                backgroundColor: Colors.pink,
                height: 200,
                radius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                ),
                child: Column(
                  children: List.generate(
                    30,
                    (index) => Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(index.toString()),
                    ),
                  ),
                ),
                builder: (_, c) => SingleChildScrollView(
                  key: PageStorageKey('single'),
                  child: c!,
                ),
              ),
              ProsteDropMenuItem(
                tigger: (_) {
                  _key.currentState!.openEndDrawer();
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
              controller: ScrollController(),
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
