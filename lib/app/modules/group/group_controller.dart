import 'package:emergency_group/app/models/user.dart';
import 'package:emergency_group/app/shared/auth/auth_local_storage.dart';
import 'package:emergency_group/app/shared/auth/auth_repository.dart';
import 'package:emergency_group/app/shared/group/GroupRepository.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'group_controller.g.dart';

@Injectable()
class GroupController = _GroupControllerBase with _$GroupController;

abstract class _GroupControllerBase with Store {
  final GroupRepository _groupRepository;
  final AuthLocalStorage _authLocalStorage;
  final AuthRepository _authRepository;

  @observable
  UserModel user;
  @observable
  String username;
  @observable
  ObservableList<UserModel> users;

  @action
  void setUsername(String value) => username = value;

  @action
  _GroupControllerBase(
      this._groupRepository, this._authLocalStorage, this._authRepository) {
    users = ObservableList();
    setUserId();
  }

  @action
  Future setUserId() async {
    user = await _authLocalStorage.getDataUser();
  }

  @action
  Future getUserGroups({int groupId}) async {
    users = (await _groupRepository.getUsersInGroup(groupId: groupId))
        .asObservable();
  }

  @action
  Future removeUserGroup({int groupId, int userId}) async {
    await _groupRepository.removeUserGroup(
      groupId: groupId,
      userId: userId,
    );

    users.removeWhere((element) => element.id == userId);
  }

  @action
  Future addUserInGroup(
      {String username, int groupId, BuildContext ctx}) async {
    try {
      final UserModel user = await _groupRepository.addUserInGroup(
        groupId: groupId,
        username: username,
      );

      users.add(user);
    } catch (err) {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text('Usuário não existe!'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ));
    } finally {
      username = '';
    }
  }

  Future sendNotification() async {
    users.forEach((userData) async {
      await _authRepository.sendNotification(
        fullname: user.fullname,
        smartphoneToken: userData.androidToken,
      );
    });
  }

  Future deleteGroup({int groupId}) async {
    await _groupRepository.removeGroup(groupId: groupId);
    Modular.to.pop();
  }
}
