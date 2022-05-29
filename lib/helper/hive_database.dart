import 'package:hive_flutter/hive_flutter.dart';
import 'package:projectmoviecatalog/helper/shared_preferences.dart';
import 'package:projectmoviecatalog/model/data_model.dart';

class HiveDatabase{
  Box<DataModel> _localDB = Hive.box<DataModel>("data");

  void addData(DataModel data) {
    _localDB.add(data);
  }

  int getLength() {
    return _localDB.length;
  }

  bool checkLogin(String email, String password) {
    bool found = false;
    for(int i = 0; i< getLength(); i++){
      if (email == _localDB.getAt(i)!.email && password == _localDB.getAt(i)!.password) {
        SharedPreference().setLogin(email);
        print("Login Success");
        found = true;
        break;
      } else {
        found = false;
      }
    }

    return found;
  }

}