class Message {
  final int senderId;
  final int receiverId;
  final String content;
  final DateTime sentTime;

  const Message({
    required this.senderId,
    required this.receiverId,
    required this.sentTime,
    required this.content,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        receiverId: json['receiverId'],
        senderId: json['senderId'],
        sentTime: json['sentTime'].toDate(),
        content: json['content'],
      );

  Map<String, dynamic> toJson() => {
        'receiverId': receiverId,
        'senderId': senderId,
        'sentTime': sentTime,
        'content': content,
      };
}

List<Message> messages = [
  Message(
    senderId: 1,
    receiverId: 2,
    content: 'Hello',
    sentTime: DateTime.now(),
  ),
  Message(
    senderId: 2,
    receiverId: 1,
    content: 'How are you?',
    sentTime: DateTime.now(),
  ),
  Message(
    senderId: 1,
    receiverId: 2,
    content: 'Fine',
    sentTime: DateTime.now(),
  ),
  Message(
    senderId: 2,
    receiverId: 1,
    content: 'What are you doing?',
    sentTime: DateTime.now(),
  ),
  Message(
    senderId: 1,
    receiverId: 2,
    content: 'Nothing',
    sentTime: DateTime.now(),
  ),
  Message(
    senderId: 2,
    receiverId: 1,
    content: 'Can you help me?',
    sentTime: DateTime.now(),
  ),
  Message(
    senderId: 2,
    receiverId: 1,
    content: 'Thank you',
    sentTime: DateTime.now(),
  ),
  Message(
    senderId: 1,
    receiverId: 2,
    content: 'You are welcome',
    sentTime: DateTime.now(),
  ),
  Message(
    senderId: 2,
    receiverId: 1,
    content: 'Bye',
    sentTime: DateTime.now(),
  ),
  Message(
    senderId: 1,
    receiverId: 2,
    content: 'Bye',
    sentTime: DateTime.now(),
  ),
  Message(
    senderId: 2,
    receiverId: 1,
    content: 'See you later',
    sentTime: DateTime.now(),
  ),
  Message(
    senderId: 1,
    receiverId: 2,
    content: 'See you later',
    sentTime: DateTime.now(),
  )
];
