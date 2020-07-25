class Message {
  String message;
  bool admin;

  Message({this.admin, this.message});
}

List<Message> messages = [
  new Message(
      admin: false,
      message:
          "Lets assume this message is really long, can it start wrapping when it reaches the edge?"),
  new Message(
      admin: false,
      message:
          "Lets assume this message is really long, can it start wrapping when it reaches the edge?"),
  new Message(
      admin: true,
      message:
          "Lets assume this message is really long, can it start wrapping when it reaches the edge?"),
  new Message(
      admin: false,
      message:
          "Lets assume this message is really long, can it start wrapping when it reaches the edge?"),
  new Message(
      admin: true,
      message:
          "Lets assume this message is really long, can it start wrapping when it reaches the edge?"),
  new Message(
      admin: false,
      message:
          "Lets assume this message is really long, can it start wrapping when it reaches the edge?"),
  new Message(
      admin: false,
      message:
          "Lets assume this message is really long, can it start wrapping when it reaches the edge?"),
  new Message(
      admin: false,
      message:
          "Lets assume this message is really long, can it start wrapping when it reaches the edge?"),
  new Message(
      admin: true,
      message:
          "Lets assume this message is really long, can it start wrapping when it reaches the edge?"),
  new Message(
      admin: false,
      message:
          "Lets assume this message is really long, can it start wrapping when it reaches the edge?"),
];
