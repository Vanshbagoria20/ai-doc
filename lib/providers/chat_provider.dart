import 'package:flutter/material.dart';
import '../models/message.dart';

class ChatProvider with ChangeNotifier {
  List<Message> _messages = [];

  List<Message> get messages => _messages;

  // Send a new message
  void sendMessage(Message message) {
    _messages.add(message);
    notifyListeners();
  }

  // Mark message as read
  void markMessageAsRead(String messageId) {
    int index = _messages.indexWhere((msg) => msg.id == messageId);
    if (index != -1) {
      _messages[index] = Message(
        id: _messages[index].id,
        senderId: _messages[index].senderId,
        receiverId: _messages[index].receiverId,
        content: _messages[index].content,
        timestamp: _messages[index].timestamp,
        isRead: true,
        messageType: _messages[index].messageType,
      );
      notifyListeners();
    }
  }

  // Get unread message count
  int get unreadMessagesCount {
    return _messages.where((msg) => !msg.isRead).length;
  }

  // Load messages from database (if needed)
  void setMessages(List<Message> newMessages) {
    _messages = newMessages;
    notifyListeners();
  }
}
