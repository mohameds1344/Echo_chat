import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:chat_app/view/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/view/chat_view.dart';
import 'package:chat_app/view/cubit/auth_cubit/auth_cubit.dart';
import 'package:chat_app/view/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/view/cubit/theme_cubit/theme_cubit.dart';
import 'package:chat_app/view/initial_page.dart';
import 'package:chat_app/view/login_view.dart';
import 'package:chat_app/view/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = SimpleBlocObserver();
  runApp(const chatApp());
}

class chatApp extends StatelessWidget {
  const chatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => ChatCubit()),
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: MaterialApp(
        routes: {
          LoginView.id: (context) => LoginView(),
          RegisterView.id: (context) => RegisterView(),
          ChatView.id: (context) => ChatView(),
          InitialPage.id: (context) => InitialPage(),
        },
        debugShowCheckedModeBanner: false,
        initialRoute: InitialPage.id,
      ),
    );
  }
}
