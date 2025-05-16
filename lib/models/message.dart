class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;
  final bool isRead;
  final String messageType; // text, image, voice, file

  Message({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
    this.isRead = false,
    this.messageType = 'text',
  });
  Message newMessage = Message(
  id: 'msg_1',
  senderId: 'user_123',
  receiverId: 'doctor_456',
  content: 'Hello Doctor, I have a question about my health.',
  timestamp: DateTime.now(),
  isRead: false,
  messageType: 'text',
);


  // Convert Message to Map (For Firebase or Local Storage)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
      'messageType': messageType,
    };
  }

  // Create Message from Map (For retrieving data)
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      id: map['id'],
      senderId: map['senderId'],
      receiverId: map['receiverId'],
      content: map['content'],
      timestamp: DateTime.parse(map['timestamp']),
      isRead: map['isRead'] ?? false,
      messageType: map['messageType'] ?? 'text',
    );
  }
}
