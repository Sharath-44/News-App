import 'package:news_app/blocs/newsbloc/news_bloc.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:news_app/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late NewsBloc _newsBloc; // 1. Declare a NewsBloc variable

  @override
  void initState() {
    super.initState();
    _newsBloc = NewsBloc(newsRepositoty: NewsRepository());  
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(
          create: (context) => _newsBloc,  
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          )),
        home: SplashScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _newsBloc.close();  // 4. Dispose of the bloc when the widget is disposed
    super.dispose();
  }
}
