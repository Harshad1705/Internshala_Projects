import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? pref;

  static init() async {
    pref = await SharedPreferences.getInstance();
  }
  static writeData(List<String> list) async{
    await pref?.setStringList('items', list);
  }
  static readData(){
    final List<String>? items = pref?.getStringList('items');
    print(items);
    return items;
  }
}
