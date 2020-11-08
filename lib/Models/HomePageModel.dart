class MyText {
  int id;
  String text;

  MyText(this.id, this.text);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'text': text,
    };
    return map;
  }

  MyText.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    text = map['text'];
  }
}
