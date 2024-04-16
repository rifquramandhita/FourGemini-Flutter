import 'dart:io';

class MessageEntity {
  final String text;
  final File? image;

  MessageEntity({required this.text, this.image});
}
