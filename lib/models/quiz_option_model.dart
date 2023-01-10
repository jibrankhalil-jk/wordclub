class Quiz_Option_Model {
  Quiz_Option_Model(
      {required this.Icon,
      required this.Progress,
      required this.Title,
      required this.img,
      this.onpressed}) {}

  String Title;
  String Progress;
  String Icon;
  String img;
  void Function()? onpressed;
}
