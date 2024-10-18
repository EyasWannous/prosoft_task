import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  Storage({
    required SharedPreferences plugin,
  }) : _plugin = plugin;

  final SharedPreferences _plugin;
  final Map<String, bool> keys = {};

  String? getValue(String key) => _plugin.getString(key);
  Future<void> setValue(String key, String value) {
    keys[key] = true;
    return _plugin.setString(key, value);
  }

  bool contains(String key) => _plugin.containsKey(key);

  Future<bool> remove(String key) => _plugin.remove(key);

  Future<bool> removeByPrefix(String prefixKy) async {
    // for (var element in keys.keys) {
    //   if (element.startsWith(prefixKy)) {
    //     remove(element);
    //   }
    // }

    Iterable<Future<bool>> futures = keys.keys
        .where((element) => element.startsWith(prefixKy))
        .map((e) => remove(e));

    var result = await Future.wait(futures);

    return !result.any((element) => false);
  }
}
