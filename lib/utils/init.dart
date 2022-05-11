import 'package:nine_song/api/backend_service.dart';
import 'package:nine_song/utils/local_storage.dart';

class Init {

  static Future<void> initLocalStorage() async {
    await LocalStorage.init();
  }

  static Future<void> initAll() async {
    await initLocalStorage();
    BackendService.loadToken();
  }
}