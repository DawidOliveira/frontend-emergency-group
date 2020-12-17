import 'package:emergency_group/app/modules/home/home_page.dart';
import 'package:emergency_group/app/modules/signup/signup_controller.dart';
import 'package:emergency_group/app/modules/signup/signup_page.dart';
import 'package:emergency_group/app/shared/auth/auth_local_storage.dart';
import 'package:emergency_group/app/shared/auth/auth_repository.dart';
import 'package:emergency_group/app/shared/auth/auth_repository_interface.dart';

import 'login_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'login_page.dart';

class LoginModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => LoginController(i.get())),
        Bind((i) => SignupController(i.get())),
        Bind<IAuthRepository>((i) => AuthRepository(i.get<AuthLocalStorage>())),
        Bind((i) => AuthLocalStorage()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => LoginPage()),
        ModularRouter('/home', child: (_, args) => HomePage()),
        ModularRouter('/signup', child: (_, args) => SignupPage()),
      ];

  static Inject get to => Inject<LoginModule>.of();
}
