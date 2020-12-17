import 'package:emergency_group/app/models/group.dart';
import 'package:emergency_group/app/models/user.dart';
import 'package:emergency_group/app/shared/auth/auth_local_storage.dart';
import 'package:emergency_group/app/shared/group/IGroupRepository.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  final AuthLocalStorage _authLocalStorage;
  final IGroupRepository _groupRepository;
  @observable
  ObservableList<GroupModel> listGroups;

  @observable
  String name;

  @action
  void setName(String value) => name = value;

  _HomeControllerBase(this._authLocalStorage, this._groupRepository) {
    getGroups();
  }

  Future<void> signOut() async {
    _authLocalStorage
        .logout()
        .then((_) => Modular.to.pushReplacementNamed('/login'));
  }

  @action
  Future<void> getGroups() async {
    final UserModel user = await _authLocalStorage.getDataUser();
    listGroups =
        (await _groupRepository.getUserGroups(userId: user.id)).asObservable();
  }

  @action
  Future<void> createGroup() async {
    final UserModel _user = await _authLocalStorage.getDataUser();
    final group = await _groupRepository.create(
      name: name,
      ownerId: _user.id,
    );

    listGroups.add(GroupModel(
      id: group.id,
      name: name,
      ownerId: _user.id,
    ));
    name = '';
  }
}
