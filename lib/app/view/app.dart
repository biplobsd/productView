import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:productview/app/view/home/home.dart';
import 'package:productview/app/view/search/search.dart';
import 'package:productview/core/cubit/maincart_cubit.dart';
import 'package:productview/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MaincartCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: Routes().onGenerateRoute,
        theme: ThemeData(
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            scaffoldBackgroundColor: const Color.fromRGBO(247, 242, 255, 1),
            fontFamily: 'balooDa2'),
        initialRoute: HomePage.pathName,
      ),
    );
  }
}
