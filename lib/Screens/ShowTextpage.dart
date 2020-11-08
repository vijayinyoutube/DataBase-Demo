import 'package:flutter/material.dart';

import '../Models/HomePageModel.dart';
import '../Utils/DBHelper.dart';

class ShowTextpage extends StatefulWidget {
  ShowTextpage({Key key}) : super(key: key);

  @override
  _ShowTextpageState createState() => _ShowTextpageState();
}

class _ShowTextpageState extends State<ShowTextpage> {
  DBHelper dbHelper = new DBHelper();
  Future<List<MyText>> myText;

  @override
  void initState() {
    super.initState();
    myText = dbHelper.getText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TextList"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            myTextList(),
          ],
        ),
      ),
    );
  }

  Widget myTextList() {
    return Container(
      child: Expanded(
        child: FutureBuilder(
            future: myText,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildText(snapshot.data);
              } else {
                return CircularProgressIndicator();
              }
            }),
      ),
    );
  }

  Widget buildText(List<MyText> myText) {
    return new ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: myText.length,
      itemBuilder: (context, int index) {
        return Center(
          child: ListTile(
            title: Text(myText[index].text),
          ),
        );
      },
    );
  }
}
