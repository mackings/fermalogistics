import 'dart:convert';
import 'dart:io';
import 'package:fama/Views/Drivers/Chats/Models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http_parser/http_parser.dart';



class UserService {
  final String apiUrl =
      "https://fama-logistics.onrender.com/api/v1/firebaseMessage/viewAllUsers";
  final String sendMessageUrl =
      "https://fama-logistics.onrender.com/api/v1/firebaseMessage/userSendMessage/";

  Future<String?> _getAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData['token'];
    }
    return null;
  }


  Future<String?> getCurrentUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('userData');
    if (userDataString != null) {
      Map<String, dynamic> userData = jsonDecode(userDataString);
      return userData[
          'id']; // Ensure this matches the key used in your API response
    }
    return null;
  }

  Future<List<UserModel>> fetchUsers() async {
    String? token = await _getAuthToken();
    if (token == null) {
      throw Exception("Authentication token not found");
    }

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> usersList = data['users']['users'];
        return UserModel.fromJsonList(usersList);
      } else {
        throw Exception("Failed to load users: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }

  Future<void> sendMessage({
    required String receiverId,
    required String message,
    File? imageFile, // Optional image file
  }) async {
    String? token = await _getAuthToken();
    if (token == null) {
      throw Exception("Authentication token not found");
    }

    var uri = Uri.parse("$sendMessageUrl$receiverId");
    var request = http.MultipartRequest('POST', uri)
      ..headers['Authorization'] = "Bearer $token";

    request.fields['message'] = message;

    // Attach image if provided
    if (imageFile != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'imageUrl',
        imageFile.path,
        contentType: MediaType('image', 'jpeg'),
      ));
    }

    // ✅ Print Request Body
    print("📤 Request Body: ${jsonEncode(request.fields)}");

    if (imageFile != null) {
      print("📤 Image File: ${imageFile.path}");
    }

    try {
      var response = await request.send();
      var responseBody =
          await response.stream.bytesToString(); // Read response body

      // ✅ Print Response Body
      print("📥 Response Status Code: ${response.statusCode}");
      print("📥 Response Body: $responseBody");

      if (response.statusCode == 200) {
        print("✅ Message sent successfully!");
      } else {
        print(receiverId);
        print(
            "❌ Failed to send message: ${jsonDecode(responseBody)['message']}");
        throw Exception(
            "Failed to send message: ${jsonDecode(responseBody)['message']}");
      }
    } catch (e) {
      print("🚨 Error sending message: $e");
      throw Exception("Error sending message.");
    }
  }

  Future<List<Map<String, dynamic>>> fetchChatMessages(String userId) async {
    String? token = await _getAuthToken();
    if (token == null) {
      throw Exception("Authentication token not found");
    }

    final uri = Uri.parse(
        "https://fama-logistics.onrender.com/api/v1/firebaseMessage/userViewMessage/$userId");
    try {
      final response = await http.get(
        uri,
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> messagesList = data['messages'];

        return messagesList.map((message) {
          final details =
              message['receiverDetails'] ?? message['senderDetails'];
          return {
            "id": message["id"],
            "text": details["message"] ?? "",
            "image": details["imageUrl"] ?? "",
            "time": DateTime.fromMillisecondsSinceEpoch(details["timestamp"]),
            "isMe": details["senderId"] == userId,
            "senderName": details["name"],
            "senderImage": details["picture"],
          };
        }).toList();
      } else {
        throw Exception("Failed to load messages: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching messages: $e");
    }
  }
}
