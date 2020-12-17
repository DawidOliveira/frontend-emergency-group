import 'package:emergency_group/app/shared/auth/auth_local_storage.dart';
import 'package:emergency_group/app/shared/auth/auth_repository.dart';
import 'package:emergency_group/app/shared/auth/auth_repository_interface.dart';
import 'package:emergency_group/app/shared/group/GroupRepository.dart';
import 'package:emergency_group/app/shared/group/IGroupRepository.dart';

import 'group_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'group_page.dart';

class GroupModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) =>
            GroupController(i.get(), i.get<AuthLocalStorage>(), i.get())),
        Bind<IAuthRepository>((i) => AuthRepository(i.get<AuthLocalStorage>())),
        Bind<IGroupRepository>(
            (i) => GroupRepository(i.get<AuthLocalStorage>())),
        Bind((i) => AuthLocalStorage()),
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => GroupPage()),
      ];

  static Inject get to => Inject<GroupModule>.of();
}
