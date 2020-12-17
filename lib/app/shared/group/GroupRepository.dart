import 'package:dio/dio.dart';
import 'package:emergency_group/app/models/group.dart';
import 'package:emergency_group/app/models/user.dart';
import 'package:emergency_group/app/shared/auth/auth_local_storage.dart';
import 'package:emergency_group/app/shared/group/IGroupRepository.dart';

class GroupRepository implements IGroupRepository {
  // final _url = 'https://backend-emergency-group.herokuapp.com';
  final dio = Dio(
    BaseOptions(baseUrl: 'https://backend-emergency-group.herokuapp.com'),
  );
  final AuthLocalStorage _authLocalStorage;
  GroupRepository(this._authLocalStorage);
  @override
  Future<UserModel> addUserInGroup({String username, int groupId}) async {
    final String token = await _authLocalStorage.getUserToken();
    final Response response = await dio.post('/addUserGroup',
        options: Options(headers: {
          'Authorization': 'bearer $token',
        }),
        data: {
          'username': username,
          'groupId': groupId,
        });

    final UserModel user = UserModel(
      id: response.data['id'],
      fullname: response.data['fullname'],
      username: response.data['username'],
      email: response.data['email'],
    );

    return user;
  }

  @override
  Future create({String name, int ownerId}) async {
    final String token = await _authLocalStorage.getUserToken();

    final response = await dio.post('/group',
        options: Options(headers: {
          'Authorization': 'bearer $token',
        }),
        data: {
          'name': name,
          'owner': ownerId,
        });

    return GroupModel.fromJson(
      id: response.data['id'],
      name: response.data['name'],
      owner: response.data['owner'],
    );
  }

  @override
  Future<List<GroupModel>> getUserGroups({int userId}) async {
    final String token = await _authLocalStorage.getUserToken();

    List<GroupModel> list;
    final Response<List> response = await dio.get(
      '/groups/$userId',
      options: Options(headers: {
        'Authorization': 'bearer $token',
      }),
    );
    list = response.data
        .map(
          (e) => GroupModel.fromJson(
            name: e['name'],
            owner: e['owner'],
            id: e['id'],
          ),
        )
        .toList();
    return list;
  }

  @override
  Future<List<UserModel>> getUsersInGroup({int groupId}) async {
    final String token = await _authLocalStorage.getUserToken();

    List<UserModel> list;
    final Response<List> response = await dio.get(
      '/users/$groupId',
      options: Options(headers: {
        'Authorization': 'bearer $token',
      }),
    );
    list = response.data
        .map(
          (e) => UserModel.fromJson(
            smartphoneToken: e['smartphoneToken'],
            username: e['username'],
            fullname: e['fullname'],
            email: e['email'],
            id: e['id'],
          ),
        )
        .toList();
    return list;
  }

  @override
  Future removeGroup({int groupId}) async {
    final String token = await _authLocalStorage.getUserToken();

    await dio.delete(
      '/group/$groupId',
      options: Options(headers: {
        'Authorization': 'bearer $token',
      }),
    );
  }

  @override
  Future removeUserGroup({int groupId, int userId}) async {
    final String token = await _authLocalStorage.getUserToken();

    await dio.delete(
      '/deleteUserGroup',
      data: {
        'userId': userId,
        'groupId': groupId,
      },
      options: Options(
        headers: {
          'Authorization': 'bearer $token',
        },
      ),
    );
  }
}
