//Packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:get_it/get_it.dart';

//Providers
import '../providers/authentication_provider.dart';
import '../providers/users_page_provider.dart';

//Widgets
// import '../widgets/top_bar.dart';
import '../widgets/custom_input_field.dart';
import '../widgets/custom_list_view_tiles.dart';
import '../widgets/rounded_button.dart';

//Models
import '../models/chat_user.dart';

class UsersPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UsersPageState();
  }
}

class _UsersPageState extends State<UsersPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late UsersPageProvider _pageProvider;
  late FirebaseAuth _authen;

  final TextEditingController _searchFieldTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _authen = FirebaseAuth.instance;
    print(_authen.currentUser?.uid);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsersPageProvider>(
          create: (_) => UsersPageProvider(_auth),
        ),
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (BuildContext _context) {
        _pageProvider = _context.watch<UsersPageProvider>();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: const Color(0XFF6f67f0),
              elevation: 5,
              title: const Text(
                'Select for Chat',
              ),
              actions: [
                IconButton(
                  tooltip: 'Logout',
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _auth.logout();
                  },
                ),
              ]),
          body: Container(
            padding: EdgeInsets.symmetric(
                horizontal: _deviceWidth * 0.03,
                vertical: _deviceHeight * 0.02),
            height: _deviceHeight * 0.98,
            width: _deviceWidth * 0.97,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  onEditingComplete: (_value) {
                    _pageProvider.getUsers(name: _value);
                    FocusScope.of(context).unfocus();
                  },
                  hintText: "Search...",
                  obscureText: false,
                  controller: _searchFieldTextEditingController,
                  icon: Icons.search,
                ),
                const Divider(
                    color: Colors.black,
                    height: 25,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20),
                const SizedBox(
                  height: 10,
                ),
                _usersList(),
                _createChatButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _usersList() {
    List<ChatUser>? _users = _pageProvider.users;
    return Expanded(
      child: () {
        if (_users != null) {
          if (_users.length != 0) {
            return ListView.builder(
              itemCount: _users.length,
              itemBuilder: (BuildContext _context, int _index) {
                // print("${_authen.currentUser?.uid} != ${_users[_index].uid}");
                return _authen.currentUser?.uid != _users[_index].uid
                    ? CustomListViewTile(
                        height: _deviceHeight * 0.10,
                        title: _users[_index].name,
                        subtitle:
                            "Last Active: ${_users[_index].lastDayActive()}",
                        imagePath: _users[_index].imageURL,
                        isActive: _users[_index].wasRecentlyActive(),
                        isSelected: _pageProvider.selectedUsers.contains(
                          _users[_index],
                        ),
                        onTap: () {
                          _pageProvider.updateSelectedUsers(
                            _users[_index],
                          );
                        },
                      )
                    : Container();
              },
            );
          } else {
            return const Center(
              child: Text(
                "No Users Found.",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }
      }(),
    );
  }

  Widget _createChatButton() {
    return Visibility(
      visible: _pageProvider.selectedUsers.isNotEmpty,
      child: RoundedButton(
        name: _pageProvider.selectedUsers.length == 1
            ? "Chat With ${_pageProvider.selectedUsers.first.name}"
            : "Create Group Chat",
        height: _deviceHeight * 0.08,
        width: _deviceWidth * 0.80,
        onPressed: () {
          _pageProvider.createChat();
        },
      ),
    );
  }
}
