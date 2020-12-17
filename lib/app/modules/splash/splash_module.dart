import 'package:emergency_group/app/modules/home/home_controller.dart';
import 'package:emergency_group/app/modules/home/home_page.dart';
import 'package:emergency_group/app/modules/login/login_controller.dart';
import 'package:emergency_group/app/modules/login/login_page.dart';
import 'package:emergency_group/app/shared/auth/auth_local_storage.dart';
import 'package:emergency_group/app/shared/auth/auth_repository.dart';
import 'package:emergency_group/app/shared/auth/auth_repository_interface.dart';
import 'package:emergency_group/app/shared/group/GroupRepository.dart';
import 'package:emergency_group/app/shared/group/IGroupRepository.dart';

import 'splash_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'splash_page.dart';

class SplashModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $SplashController,
        Bind((i) => LoginController(i.get())),
        Bind<IAuthRepository>((i) => AuthRepository(i.get<AuthLocalStorage>())),
        Bind((i) => HomeController(i.get<AuthLocalStorage>(), i.get())),
        Bind<IGroupRepository>(
            (i) => GroupRepository(i.get<AuthLocalStorage>())),
        Bind((i) => AuthLocalStorage())
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SplashPage()),
        ModularRouter('/login', child: (context, args) => LoginPage()),
        ModularRouter('/home', child: (context, args) => HomePage()),
      ];

  static Inject get to => Inject<SplashModule>.of();
}
