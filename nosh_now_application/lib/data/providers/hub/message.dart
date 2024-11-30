class Message{
  String title;
  String content;

  Message({required this.title, required this.content});
  factory Message.fromJson(Map<String, dynamic> json){
    return Message(title: json['title'], content: json['content']);
  }
}