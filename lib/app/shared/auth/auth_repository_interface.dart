abstract class IAuthRepository {
  Future signup(
      {String username, String fullname, String email, String password});
  Future signin({String email, String password});
}
