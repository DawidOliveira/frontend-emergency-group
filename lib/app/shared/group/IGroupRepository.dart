import 'package:emergency_group/app/models/group.dart';
import 'package:emergency_group/app/models/user.dart';

abstract class IGroupRepository {
  Future create({String name, int ownerId});
  Future<List<GroupModel>> getUserGroups({int userId});
  Future addUserInGroup({String username, int groupId});
  Future removeGroup({int groupId});
  Future<List<UserModel>> getUsersInGroup({int groupId});
  Future removeUserGroup({int groupId, int userId});
}
