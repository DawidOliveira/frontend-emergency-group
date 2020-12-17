import 'package:emergency_group/app/modules/home/home_page.dart';
import 'package:emergency_group/app/modules/login/login_page.dart';

import 'signup_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'signup_page.dart';

class SignupModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $SignupController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SignupPage()),
        ModularRouter('/login', child: (_, args) => LoginPage()),
        ModularRouter('/home', child: (_, args) => HomePage()),
      ];

  static Inject get to => Inject<SignupModule>.of();
}
