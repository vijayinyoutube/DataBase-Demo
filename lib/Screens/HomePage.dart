import 'package:bottomsheet/Models/HomePageModel.dart';
import 'package:bottomsheet/Screens/ShowTextpage.dart';
import 'package:bottomsheet/Utils/DBHelper.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = new TextEditingController();
  var _formKey = GlobalKey<FormState>();
  DBHelper dbHelper = new DBHelper();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          title: Text("DB Demo"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildTextField(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildSaveButton(),
                  buildViewButton(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField() {
    return TextFormField(
      controller: textController,
      decoration: InputDecoration(
        hintText: "Enter Something",
        prefixIcon: Icon(Icons.text_fields),
      ),
      validator: (String myText) {
        if (myText.isEmpty) {
          return "Please enter something.";
        }
        return null;
      },
    );
  }

  Widget buildSaveButton() {
    return RaisedButton(
      color: Colors.blue,
      onPressed: () {
        if (_formKey.currentState.validate()) {
          MyText text = MyText(null, textController.text);
          dbHelper.insertText(text);
          ScaffoldMessenger.of(context)
              .showSnackBar(new SnackBar(content: Text("Text Added to DB")));
          textController.clear();
        }
      },
      child: Text("Save"),
    );
  }

  Widget buildViewButton() {
    return RaisedButton(
      color: Colors.blue,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ShowTextpage()));
      },
      child: Text("View"),
    );
  }
}
