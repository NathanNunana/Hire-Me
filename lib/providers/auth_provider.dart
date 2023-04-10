part of hireme_providers;

class AuthProvider extends ChangeNotifier {
  final sb = Supabase.instance.client;
  User? user;
  StreamSubscription? _authSub;
  AuthProvider() {
    _authSub = sb.auth.onAuthStateChange.listen(authChange);
  }

  authChange(AuthState event) {
    if (event.session != null) {
      user = sb.auth.currentUser;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    if (_authSub != null) {
      _authSub!.cancel();
    }
    super.dispose();
  }

  Future<bool> signIn(String email, String password) async {
    try {
      final res =
          await sb.auth.signInWithPassword(password: password, email: email);
      if (res.session != null && res.user != null) {
        user = res.user;
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signUp({
    required String fullname,
    required String email,
    required String password,
  }) async {
    try {
      final res = await sb.auth.signUp(
          password: password, email: email, data: {"fullname": fullname});
      if (res.session != null && res.user != null) {
        user = res.user;
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signOut() async {
    try {
      await sb.auth.signOut();
      await sb.auth.refreshSession();
      // sb.
      user = null;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
