import 'package:emergency_group/app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalStorage {
  Future saveLocal({
    int id,
    String email,
    String fullname,
    String username,
    String token,
    String androidToken,
  }) async {
    SharedPreferences ps = await SharedPreferences.getInstance();

    await ps.setInt("id", id);
    await ps.setString("email", email);
    await ps.setString("fullname", fullname);
    await ps.setString("username", username);
    await ps.setString("token", token);
    await ps.setString("androidToken", androidToken);
  }

  Future<UserModel> getDataUser() async {
    UserModel dataUser;

    SharedPreferences ps = await SharedPreferences.getInstance();
    if (ps.getString("email") == null) {
      return null;
    }

    dataUser = UserModel(
      id: ps.getInt("id"),
      username: ps.getString("username"),
      fullname: ps.getString("fullname"),
      email: ps.getString("email"),
      token: ps.getString("token"),
      androidToken: ps.getString("androidToken"),
    );
    return dataUser;
  }

  Future<String> getUserToken() async {
    SharedPreferences ps = await SharedPreferences.getInstance();

    return ps.getString('token');
  }

  Future<String> getUserAndroidToken() async {
    SharedPreferences ps = await SharedPreferences.getInstance();

    return ps.getString('androidToken');
  }

  Future<void> updateAndroidToken({String androidToken}) async {
    SharedPreferences ps = await SharedPreferences.getInstance();

    await ps.setString('androidToken', androidToken);
  }

  Future logout() async {
    SharedPreferences ps = await SharedPreferences.getInstance();
    await ps.remove("id");
    await ps.remove("email");
    await ps.remove("username");
    await ps.remove("fullname");
    await ps.remove("token");
  }
}
