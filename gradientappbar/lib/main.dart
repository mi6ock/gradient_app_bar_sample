import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: GradientAppBar("サンプル"),
        body: Placeholder(),
      ),
    ),
  );
}

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  GradientAppBar(this.title);

  final String title;
  final List<String> strings = const <String>[
    "設定1",
    "設定2",
  ];
  // マテリアルデザインにおいてappbarのelevationは4と一応決められているので
  final double _appbarElevation = 4;

  @override
  Widget build(BuildContext context) {
    final double appBarPadding = MediaQuery.of(context).padding.top;
    final double appBarHeight = AppBar().preferredSize.height;
    final double appBarWidth = AppBar().preferredSize.width;

    void select(String value) {
      switch (value) {
        case ("設定1"):
          print("設定1");
          break;

        case ("設定2"):
          print("設定2");
          break;
      }
    }

    return Card(
      elevation: _appbarElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),

      /// デフォルトで[EdgeInsets.all(4.0)]となっているので0に
      margin: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.only(top: appBarPadding),
        height: appBarPadding + appBarHeight,
        width: appBarWidth,
        //グラデーションの実装
        decoration: BoxDecoration(
          gradient: LinearGradient(
            end: Alignment.bottomRight,
            begin: Alignment.topLeft,
            stops: [0, 0.3, 0.8],
            colors: [
              Color(0xFF276174),
              Color(0xFF33c58e),
              Color(0xFF63fd88),
            ],
          ),
        ),
        // タイトルやボタンをRowで表示
        child: Row(
          // 要素間にスペースを均等に分配する
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              color: Color(0xFFFFFFFF),
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () => print("戻る"),
            ),
            Center(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 30,
                  color: Color(
                    0xFFFFFFFF,
                  ),
                ),
              ),
            ),
            PopupMenuButton<String>(
              icon: Icon(
                Icons.settings,
                color: Color(0xFFeeeeee),
              ),
              onSelected: select,
              itemBuilder: (BuildContext context) {
                return strings.map(
                  (String value) {
                    return PopupMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
