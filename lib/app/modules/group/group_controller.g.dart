// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $GroupController = BindInject(
  (i) => GroupController(
      i<GroupRepository>(), i<AuthLocalStorage>(), i<AuthRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GroupController on _GroupControllerBase, Store {
  final _$userAtom = Atom(name: '_GroupControllerBase.user');

  @override
  UserModel get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserModel value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$usernameAtom = Atom(name: '_GroupControllerBase.username');

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$usersAtom = Atom(name: '_GroupControllerBase.users');

  @override
  ObservableList<UserModel> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<UserModel> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  final _$setUserIdAsyncAction = AsyncAction('_GroupControllerBase.setUserId');

  @override
  Future<dynamic> setUserId() {
    return _$setUserIdAsyncAction.run(() => super.setUserId());
  }

  final _$getUserGroupsAsyncAction =
      AsyncAction('_GroupControllerBase.getUserGroups');

  @override
  Future<dynamic> getUserGroups({int groupId}) {
    return _$getUserGroupsAsyncAction
        .run(() => super.getUserGroups(groupId: groupId));
  }

  final _$removeUserGroupAsyncAction =
      AsyncAction('_GroupControllerBase.removeUserGroup');

  @override
  Future<dynamic> removeUserGroup({int groupId, int userId}) {
    return _$removeUserGroupAsyncAction
        .run(() => super.removeUserGroup(groupId: groupId, userId: userId));
  }

  final _$addUserInGroupAsyncAction =
      AsyncAction('_GroupControllerBase.addUserInGroup');

  @override
  Future<dynamic> addUserInGroup(
      {String username, int groupId, BuildContext ctx}) {
    return _$addUserInGroupAsyncAction.run(() =>
        super.addUserInGroup(username: username, groupId: groupId, ctx: ctx));
  }

  final _$_GroupControllerBaseActionController =
      ActionController(name: '_GroupControllerBase');

  @override
  void setUsername(String value) {
    final _$actionInfo = _$_GroupControllerBaseActionController.startAction(
        name: '_GroupControllerBase.setUsername');
    try {
      return super.setUsername(value);
    } finally {
      _$_GroupControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
user: ${user},
username: ${username},
users: ${users}
    ''';
  }
}
