import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:path_provider/path_provider.dart';

import '../../core/network/network_manager.dart';

class GenerateRandomProfilePic {
  final _manager = NetworkManager.instance;
  final Iterable<String> _word = nouns.take(200);

  Future<String> generateRandomPic() async {
    var _tempDir = await getTemporaryDirectory();
    String _fullpath = _tempDir.path + "/avatar.svg";
    await _manager.dio.download(
        "https://avatars.dicebear.com/api/bottts/${_word.elementAt(Random().nextInt(199))}.svg", _fullpath);
    return _fullpath;
  }
}
