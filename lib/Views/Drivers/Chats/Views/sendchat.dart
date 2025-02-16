import 'dart:convert';
import 'dart:io';
import 'package:fama/Views/Drivers/Chats/Apis/chatservice.dart';
import 'package:fama/Views/widgets/texts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fama/Views/Drivers/Chats/Models/user.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatScreen extends StatefulWidget {
  final UserModel user;

  const ChatScreen({required this.user, Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final UserService _userService = UserService();
  File? _selectedImage;
  bool _isSending = false;
  List<Map<String, dynamic>> messages = [];
  bool _isLoading = true;
  String? currentUserName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _loadMessages();
  }

  Future<void> _loadUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      setState(() {
        currentUserName = userData['name'];
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _loadMessages() async {
    try {
      List<Map<String, dynamic>> chatMessages =
          await _userService.fetchChatMessages(widget.user.id!);
      setState(() {
        messages = chatMessages.reversed.toList();
        _isLoading = false;
      });
    } catch (e) {
      print("Error loading messages: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_messageController.text.isEmpty && _selectedImage == null) {
      return;
    }

    setState(() {
      _isSending = true;
    });

    try {
      await _userService.sendMessage(
        receiverId: widget.user.id!,
        message: _messageController.text,
        imageFile: _selectedImage,
      );

      // Add the sent message locally
      setState(() {
        messages.insert(0, {
          "text": _messageController.text,
          "time": DateTime.now(),
          "senderName": currentUserName,
          "image": _selectedImage?.path,
        });

        _messageController.clear();
        _selectedImage = null;
      });

      _loadMessages();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Message sent!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to send message.")),
      );
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : messages.isEmpty
                    ? Center(child: Text("No messages yet"))
                    : ListView.builder(
                        reverse: true,
                        padding: EdgeInsets.all(10),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          return _buildMessageBubble(message);
                        },
                      ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    bool isMe = message["senderName"] != widget.user.name;
    String messageText = message["text"] ?? "";
    String? imageUrl = message["image"];
    DateTime messageTime = message["time"] ?? DateTime.now();

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10),
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (isMe)
            CircleAvatar(
              backgroundImage: NetworkImage(
                widget.user.picture ??
                    "https://cdn-icons-png.flaticon.com/512/149/149071.png",
              ),
              radius: 16,
            ),
          SizedBox(width: 5),
          Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                constraints: BoxConstraints(maxWidth: 250),
                decoration: BoxDecoration(
                  color: isMe ? Colors.red : Colors.grey,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: isMe ? Radius.circular(15) : Radius.zero,
                    bottomRight: isMe ? Radius.zero : Radius.circular(15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (imageUrl != null && imageUrl.isNotEmpty)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: imageUrl.startsWith("http")
                            ? Image.network(
                                imageUrl,
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(imageUrl),
                                height: 150,
                                width: 150,
                                fit: BoxFit.cover,
                              ),
                      ),
                    if (messageText.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          messageText,
                          style: TextStyle(
                              color: isMe ? Colors.white : Colors.black),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        DateFormat.jm().format(messageTime),
                        style: TextStyle(fontSize: 10, color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(
              widget.user.picture ??
                  "https://cdn-icons-png.flaticon.com/512/149/149071.png",
            ),
          ),
          SizedBox(width: 10),
          // Text(widget.user.name ?? "User"),
          CustomText(text: widget.user.name ?? "User"),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    );
  }

  Widget _buildMessageInput() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_selectedImage != null)
          Container(
            margin: EdgeInsets.all(10),
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.red, width: 2),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _selectedImage!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 5,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.close, color: Colors.white, size: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        Row(
          children: [
            IconButton(
                icon: Icon(Icons.image, color: Colors.red),
                onPressed: () {
                  _pickImage();
                }),
            Expanded(
                child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(hintText: "Type here..."))),
            IconButton(
                icon: Icon(Icons.send, color: Colors.red),
                onPressed: _sendMessage),
          ],
        ),
      ],
    );
  }
}
