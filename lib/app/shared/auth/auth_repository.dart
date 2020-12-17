import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:emergency_group/app/shared/auth/auth_local_storage.dart';
import 'package:emergency_group/app/shared/auth/auth_repository_interface.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class AuthRepository implements IAuthRepository {
  // final _url = 'https://backend-emergency-group.herokuapp.com';
  FirebaseMessaging _fcm;
  final dio = Dio(
    BaseOptions(baseUrl: 'https://backend-emergency-group.herokuapp.com'),
  );
  AuthLocalStorage _authLocalStorage;
  AuthRepository(this._authLocalStorage) {
    _fcm = FirebaseMessaging();
  }

  @override
  Future signin({String email, String password}) async {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    String androidToken = await _fcm.getToken();
    final response = await dio.post('/login',
        data: jsonEncode({
          'email': email.trim(),
          'password': password.trim(),
        }));
    await dio.post('/updateToken', data: {
      'id': response.data['id'],
      'smartphoneToken': androidToken,
    });
    await _authLocalStorage.saveLocal(
      id: response.data['id'],
      email: response.data['email'],
      fullname: response.data['fullname'],
      token: response.data['token'],
      username: response.data['username'],
      androidToken: androidToken,
    );
  }

  @override
  Future signup(
      {String username, String fullname, String email, String password}) async {
    await dio.post('/signup',
        data: jsonEncode({
          'email': email.trim(),
          'fullname': fullname.trim(),
          'username': username.trim(),
          'password': password.trim(),
        }));

    await signin(
      email: email.trim(),
      password: password.trim(),
    );
  }

  Future sendNotification({String smartphoneToken, String fullname}) async {
    await Dio().post('https://fcm.googleapis.com/fcm/send',
        data: {
          "notification": {
            "body": "$fullname precisa de ajuda agora!!!!",
            "title": "Alerta!!!"
          },
          "priority": "high",
          "data": {
            "clickaction": "FLUTTERNOTIFICATIONCLICK",
            "id": "1",
            "status": "done"
          },
          "to": smartphoneToken
        },
        options: Options(headers: {
          'Authorization':
              'key=AAAA--f6tdQ:APA91bFXlOyczDRJmORn6X6b-cSZq59fl_WgVcoM2bM_XQNfvQaHoc-JAOP2yftphyZjrlXMRT1Jmwm5O22F2YUqhS6LJHSTvQW4ccNXX9b6-ull6De0A8P_P0vMR4qRYe008Er6aeNq',
        }));
  }
}
