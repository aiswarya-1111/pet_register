import 'package:pet_register/screens/registered_pet_feed_screen/cubit/registered_pet_feed_screen_cubit.dart';
import 'package:pet_register/screens/registered_pet_feed_screen/registered_pet_feed_screen.dart';
import 'package:pet_register/widget/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());

  Bloc.observer = EchoCubitDelegate();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Register',
      theme: ThemeData(textTheme: GoogleFonts.interTextTheme()),
      home: BlocProvider(
        create:
            (BuildContext context) => RegisteredPetFeedScreenCubit()..init(),
        child: RegisteredPetFeedScreen(),
      ),
    );
  }
}
