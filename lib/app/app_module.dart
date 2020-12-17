import 'package:emergency_group/app/modules/group/group_controller.dart';
import 'package:emergency_group/app/modules/group/group_page.dart';
import 'package:emergency_group/app/modules/home/home_page.dart';
import 'package:emergency_group/app/modules/signup/signup_controller.dart';
import 'package:emergency_group/app/modules/splash/splash_module.dart';
import 'package:emergency_group/app/shared/auth/auth_local_storage.dart';
import 'package:emergency_group/app/shared/auth/auth_repository.dart';
import 'package:emergency_group/app/shared/auth/auth_repository_interface.dart';
import 'package:emergency_group/app/shared/group/GroupRepository.dart';
import 'package:emergency_group/app/shared/group/IGroupRepository.dart';

import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:emergency_group/app/app_widget.dart';
import 'package:emergency_group/app/modules/login/login_page.dart';
import 'package:emergency_group/app/modules/signup/signup_page.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $AppController,
        Bind((i) => SignupController(i.get())),
        Bind<IAuthRepository>((i) => AuthRepository(i.get<AuthLocalStorage>())),
        Bind((i) => AuthLocalStorage()),
        Bind((i) =>
            GroupController(i.get(), i.get<AuthLocalStorage>(), i.get())),
        Bind<IGroupRepository>(
            (i) => GroupRepository(i.get<AuthLocalStorage>())),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, module: SplashModule()),
        ModularRouter('/login', child: (context, args) => LoginPage()),
        ModularRouter('/signup', child: (context, args) => SignupPage()),
        ModularRouter('/home', child: (context, args) => HomePage()),
        ModularRouter('/group', child: (context, args) => GroupPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
