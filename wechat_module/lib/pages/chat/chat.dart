class Chat {
  final String name;
  final String message;
  final String imageUrl;

  Chat( {this.imageUrl,this.name, this.message});

  factory Chat.formJson(Map json){
    return Chat(
      name: json['name'],
      message: json['message'],
      imageUrl: json['imageUrl'],
    );
  }
}