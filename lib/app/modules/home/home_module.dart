import 'package:emergency_group/app/modules/group/group_page.dart';
import 'package:emergency_group/app/modules/login/login_controller.dart';
import 'package:emergency_group/app/modules/login/login_page.dart';
import 'package:emergency_group/app/shared/auth/auth_local_storage.dart';
import 'package:emergency_group/app/shared/auth/auth_repository.dart';
import 'package:emergency_group/app/shared/auth/auth_repository_interface.dart';
import 'package:emergency_group/app/shared/group/GroupRepository.dart';
import 'package:emergency_group/app/shared/group/IGroupRepository.dart';

import 'home_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_page.dart';

class HomeModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => HomeController(i.get<AuthLocalStorage>(), i.get())),
        Bind<IGroupRepository>(
            (i) => GroupRepository(i.get<AuthLocalStorage>())),
        Bind((i) => LoginController(i.get())),
        Bind<IAuthRepository>((i) => AuthRepository(i.get<AuthLocalStorage>())),
        Bind((i) => AuthLocalStorage())
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => HomePage()),
        ModularRouter('/login', child: (_, args) => LoginPage()),
        ModularRouter('/group', child: (_, args) => GroupPage()),
      ];

  static Inject get to => Inject<HomeModule>.of();
}
