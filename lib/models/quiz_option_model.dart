class Quiz_Option_Model {
  Quiz_Option_Model(
      {required this.Icon,
      required this.Progress,
      required this.Title,
      this.onpressed}) {}

  String Title;
  String Progress;
  String Icon;
  void Function()? onpressed;
}
