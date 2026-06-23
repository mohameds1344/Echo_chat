import 'package:chat_app/constans.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/view/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/view/cubit/theme_cubit/theme_cubit.dart';
import 'package:chat_app/view/initial_page.dart';
import 'package:chat_app/widgets/botton_dark_mode.dart';
import 'package:chat_app/widgets/chat_buble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatView extends StatelessWidget {
  static String id = 'ChatView';

  var email;

  final _controller = ScrollController();
  List<Message> messagesList = [];

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    email = ModalRoute.of(context)!.settings.arguments;
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        bool isDarkMode = false;
        if (state is ThemeChange) {
          isDarkMode = state.isDark;
        }
        return BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is ChatSuccess) {
              messagesList = state.messages;
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: isDarkMode ? KDarkColor : KLightColor,
              appBar: AppBar(
                surfaceTintColor: Colors.transparent,
                scrolledUnderElevation: 0,
                backgroundColor: Colors.transparent,
                centerTitle: true,
                elevation: 0,
                leadingWidth: 75,
                leading: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8),
                    child: BottonDarkMode(
                      onTap: (val) {
                        BlocProvider.of<ThemeCubit>(
                          context,
                        ).toggleTheme(isDark: val);
                      },
                      isDark: isDarkMode,
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: IconButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signOut();
                          if (context.mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              InitialPage.id,
                              (route) => false,
                            );
                          }
                        } catch (e) {
                          debugPrint("logout error:$e");
                        }
                      },
                      icon: Icon(Icons.login_rounded, color: Colors.white),
                    ),
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20),
                  ),
                ),
                title: Text(
                  'Echo chat',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Pacifico',
                    fontSize: 27,
                  ),
                ),
              ),
              body: Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: isDarkMode ? Color(0xff2D2F41) : Color(0xffF8F9FA),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          reverse: true,
                          controller: _controller,
                          itemCount: messagesList.length,
                          itemBuilder: (context, index) {
                            return ChatBuble(
                              message: messagesList[index],
                              isDarkMode: isDarkMode,
                              isMy: messagesList[index].id == email,
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          style: TextStyle(
                            color: isDarkMode ? Colors.grey : Colors.black54,
                          ),
                          controller: controller,
                          onSubmitted: (data) {
                            _sendMessage(context,data);
                          },
                          decoration: InputDecoration(
                            hintText: 'Type messages..',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            filled: true,
                            fillColor: isDarkMode
                                ? Color(0xff3D3F50)
                                : Color.fromARGB(226, 197, 205, 212),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 15,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color.fromARGB(255, 63, 126, 244),
                                      Color.fromARGB(255, 104, 141, 205),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: Transform.rotate(
                                  angle: -0.5,
                                  child: IconButton(
                                    onPressed: () {
                                      _sendMessage(context,controller.text);
                                    },
                                    icon: Icon(
                                      Icons.send_rounded,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _sendMessage(BuildContext context, String data) {
    if (data.trim().isNotEmpty) {
      BlocProvider.of<ChatCubit>(
        context,
      ).sendMessage(message: data, email: email);
      controller.clear();
      _controller.animateTo(
        0,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeIn,
      );
    }
  }
}
