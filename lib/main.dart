import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_crud_with_provider_package/provider/user_provider.dart';
import 'package:flutter_crud_with_provider_package/ui/view/list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: true,
      theme: ThemeData(brightness: Brightness.dark),
      home: ChangeNotifierProvider<UserProvider>(
        builder: (context) => UserProvider()..fetchUsers(),
        child: UserListScreen(),
        )
    );
  }
}
