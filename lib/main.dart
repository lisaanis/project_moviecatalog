import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectmoviecatalog/helper/shared_preferences.dart';
import 'package:projectmoviecatalog/model/data_model.dart';
import 'package:projectmoviecatalog/view/login_page.dart';
import 'package:projectmoviecatalog/nav.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  initiateLocalDB();
  SharedPreference().getLoginStatus().then((status) {
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: status ? Nav() : LoginPage()));
  });
}

void initiateLocalDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(DataModelAdapter());
  await Hive.openBox<DataModel>("data");
}
