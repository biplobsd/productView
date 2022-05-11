import 'package:flutter/material.dart';
import 'package:productview/app/view/search/search.dart';
import 'package:productview/routes/routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Routes().onGenerateRoute,
      initialRoute: SearchPage.pathName,
    );
  }
}
