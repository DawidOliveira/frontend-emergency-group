// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(i<AuthLocalStorage>(), i<IGroupRepository>()),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$listGroupsAtom = Atom(name: '_HomeControllerBase.listGroups');

  @override
  ObservableList<GroupModel> get listGroups {
    _$listGroupsAtom.reportRead();
    return super.listGroups;
  }

  @override
  set listGroups(ObservableList<GroupModel> value) {
    _$listGroupsAtom.reportWrite(value, super.listGroups, () {
      super.listGroups = value;
    });
  }

  final _$nameAtom = Atom(name: '_HomeControllerBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$getGroupsAsyncAction = AsyncAction('_HomeControllerBase.getGroups');

  @override
  Future<void> getGroups() {
    return _$getGroupsAsyncAction.run(() => super.getGroups());
  }

  final _$createGroupAsyncAction =
      AsyncAction('_HomeControllerBase.createGroup');

  @override
  Future<void> createGroup() {
    return _$createGroupAsyncAction.run(() => super.createGroup());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void setName(String value) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setName');
    try {
      return super.setName(value);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listGroups: ${listGroups},
name: ${name}
    ''';
  }
}
