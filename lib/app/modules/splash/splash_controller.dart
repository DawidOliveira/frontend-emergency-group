import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'splash_controller.g.dart';

@Injectable()
class SplashController = _SplashControllerBase with _$SplashController;

abstract class _SplashControllerBase with Store {
  @observable
  bool login = false;

  @action
  void setLogin(bool value) => login = value;

  Future<bool> verifyLogin() async {
    SharedPreferences ps = await SharedPreferences.getInstance();
    if (ps.getString("email") == null) {
      return false;
    }
    return true;
  }
}
