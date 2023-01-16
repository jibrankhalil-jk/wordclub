class wordpackmodel {
  wordpackmodel(
      {required this.level, required this.urduname, required this.title});
  factory wordpackmodel.fromMap(var element) {
    return wordpackmodel(
        level: element['Level'],
        urduname: element['UrduName'],
        title: element['Name']);
  }
  String title, urduname, level;
}
