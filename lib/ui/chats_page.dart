//Packages
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:sono_first/models/chat_message.dart';
import 'package:sono_first/models/chat_user.dart';
import 'package:sono_first/providers/chats_page_provider.dart';
// import 'package:sono_first/providers/users_page_provider.dart';
import 'package:sono_first/ui/chat_page.dart';
import 'package:sono_first/ui/users_page.dart';

//Sevices
import '../services/navigation_service.dart';

//Widgets
// import 'package:sono_first/widgets/custom_input_field.dart';
import 'package:sono_first/widgets/custom_list_view_tiles.dart';
import '../models/chat.dart';
// import '../widgets/top_bar.dart';

//Models
// import 'package:sono_first/models/chat.dart';
// import '../models/chat_message.dart';

//Providers
import '../providers/authentication_provider.dart';
// import '../providers/chat_page_provider.dart';

class ChatsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatsPageState();
  }
}

class _ChatsPageState extends State<ChatsPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late AuthenticationProvider _auth;
  late NavigationService _navigation;
  late ChatsPageProvider _pageProvider;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatsPageProvider>(
          create: (_) => ChatsPageProvider(_auth),
        )
      ],
      child: _buildUI(),
    );
  }

  Widget _buildUI() {
    return Builder(
      builder: (BuildContext _context) {
        _pageProvider = _context.watch<ChatsPageProvider>();
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              backgroundColor: const Color(0XFF6f67f0),
              elevation: 5,
              title: const Text(
                'Chats',
              ),
              centerTitle: true,
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
          body: SingleChildScrollView(
            child: Container(
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
                  // ElevatedButton.icon(
                  //   onPressed: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) {
                  //       return UsersPage();
                  //     }));
                  //   },
                  //   icon: const Icon(Icons.people_alt),
                  //   label: const Text(
                  //     'Create a Chat',
                  //     style: TextStyle(fontSize: 17),
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //     primary: Colors.green,
                  //     elevation: 5,
                  //   ),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  _chatsList()
                ],
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return UsersPage();
              }));
            },
            backgroundColor: Colors.green,
            child: const Icon(
              Icons.add,
              color: Colors.white,
              size: 45,
            ),
          ),
        );
      },
    );
  }

  Widget _chatsList() {
    List<Chat>? _chats = _pageProvider.chats;
    print(_chats);
    return Expanded(child: (() {
      if (_chats != null) {
        if (_chats.length != 0) {
          return ListView.builder(
            itemCount: _chats.length,
            itemBuilder: (BuildContext _context, int _index) {
              return Container(
                decoration: BoxDecoration(
                  border: _index == 0
                      ? const Border()
                      : const Border(
                          top: BorderSide(width: 1, color: Colors.black26)),
                ),
                child: _chatTile(
                  _chats[_index],
                ),
              );
            },
          );
        } else {
          return const Center(
            child: Text(
              "No Chats Found.",
              style: TextStyle(color: Colors.black),
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
    })());
  }

  Widget _chatTile(Chat _chat) {
    List<ChatUser> _recepients = _chat.recepients();
    bool _isActive = _recepients.any((_d) => _d.wasRecentlyActive());
    String _subtitleText = "";
    if (_chat.messages.isNotEmpty) {
      _subtitleText = _chat.messages.first.type != MessageType.TEXT
          ? "Media Attachment"
          : _chat.messages.first.content;
    }
    return CustomListViewTileWithActivity(
        height: _deviceHeight * 0.10,
        title: _chat.title(),
        subtitle: _subtitleText.length > 40
            ? _subtitleText.substring(0, 40)
            : _subtitleText,
        imagePath: _chat.imageURL(),
        // "https://photo-cdn2.icons8.com/PDG4uJ-8GI-G0BIU3utjbEtn5Ql47Za3fJVbD_UisG8/rs:fit:715:1072/czM6Ly9pY29uczgu/bW9vc2UtcHJvZC5h/c3NldHMvYXNzZXRz/L3NhdGEvb3JpZ2lu/YWwvNDIwL2QzMGE3/MjBhLTMxZTYtNGNi/OC05N2UzLTYwZmQy/MWMxOGE2MS5qcGc.jpg",
        isActive: _isActive,
        isActivity: _chat.activity,
        onTap: () {
          _navigation.navigateToPage(ChatPage(chat: _chat));
        });
  }
}
