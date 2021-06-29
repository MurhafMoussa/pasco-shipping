import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pasco_shipping/abstracts/module/yes_module.dart';
import 'package:pasco_shipping/module_auth/service/auth_service/auth_service.dart';
import 'package:pasco_shipping/module_chat/ui/screen/chat_page/chat_page_screen.dart';
import 'package:pasco_shipping/module_chat/ui/screen/chats_list/chats_list_screen.dart';


import 'chat_routes.dart';

@injectable
class ChatModule extends YesModule {
  final ChatsListScreen _chatsListScreen;
  final ChatScreen _chatScreen;
  final AuthService _authService;

  ChatModule(this._chatsListScreen, this._authService,this._chatScreen) {
    YesModule.RoutesMap.addAll(getRoutes());
  }


  Map<String, WidgetBuilder> getRoutes() {
    return {
      ChatRoutes.chatsListRoute: (context) => _chatsListScreen,
      ChatRoutes.chatRoute: (context) => _chatScreen
      //     FutureBuilder(
      //   future: _authService.isLoggedIn,
      //   builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
      //     if (snapshot.data == true) {
      //       return _chatScreen;
      //     }
      //
      //     return Scaffold();
      //   },
      // ),
    };
  }
}