
import 'package:getnamibia/Views/Drivers/Chats/Apis/chatservice.dart';
import 'package:getnamibia/Views/Drivers/Chats/Models/user.dart';
import 'package:getnamibia/Views/Drivers/Chats/Views/sendchat.dart';
import 'package:flutter/material.dart';


class ChatsPage extends StatefulWidget {
  @override
  _ChatsPageState createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final UserService _userService = UserService();
  List<UserModel> users = [];
  bool isLoading = true;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchUsers();
  }

  void _fetchUsers() async {
    try {
      List<UserModel> fetchedUsers = await _userService.fetchUsers();
      if (mounted) {
        setState(() {
          users = fetchedUsers;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        isError = true;
      });
    }
  }

  void _onTabTap(int index) {
    setState(() {
      _tabController.index = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Messages"),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Custom Tab Design
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300], // Grey background for tabs
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                // Chats Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onTabTap(0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _tabController.index == 0 ? Colors.white : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Chats",
                          style: TextStyle(
                            color: _tabController.index == 0 ? Colors.black : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // Calls Tab
                Expanded(
                  child: GestureDetector(
                    onTap: () => _onTabTap(1),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: _tabController.index == 1 ? Colors.white : Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Calls",
                          style: TextStyle(
                            color: _tabController.index == 1 ? Colors.black : Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildUsersList(),
                Center(child: Text("Calls Content")),
              ],
            ),
          ),
        ],
      ),
    );
  }

Widget _buildUsersList() {
  if (isLoading) {
    return Center(child: CircularProgressIndicator(color: Colors.red,));
  }
  if (isError) {
    return Center(child: Text("Failed to load users", style: TextStyle(color: Colors.red)));
  }
  if (users.isEmpty) {
    return Center(child: Text("No users found"));
  }

  return ListView.builder(
    itemCount: users.length,
    itemBuilder: (context, index) {
      UserModel user = users[index];
      String profilePicture = (user.picture != null && user.picture!.isNotEmpty)
          ? user.picture!
          : "https://cdn-icons-png.flaticon.com/512/149/149071.png"; // Default avatar URL

      return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(profilePicture), 
        ),
        title: Text(user.name ?? "Unknown User"),
        subtitle: Text(user.email ?? "No Email Available"),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatScreen(user: user),
            ),
          );
        },
      );
    },
  );
}



  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
