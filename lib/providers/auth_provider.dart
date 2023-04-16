part of hireme_providers;

class AuthProvider extends ChangeNotifier {
  final sb = Supabase.instance.client;
  User? user;
  StreamSubscription? _authSub;
  List<Job> savedJobs = [];
  AuthProvider() {
    _authSub = sb.auth.onAuthStateChange.listen(authChange);
    Future.microtask(() {
      getSavedJobs();
    });
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

  Future<bool> hasAppInfo() async {
    try {
      if (user == null) throw Error();
      final res = await sb
          .from("application_info")
          .select("id")
          .eq("user_id", user!.id)
          .limit(1);
      return (res as List).isNotEmpty;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateProfile({fullname, position, email}) async {
    try {
      await sb.auth.updateUser(
        UserAttributes(
          data: {
            "fullname": fullname,
            "position": position,
          },
          email: email,
        ),
      );

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveJob(int jobId) async {
    if (user == null) return false;
    try {
      await sb.from("saved_jobs").insert({
        "user_id": user!.id,
        "job_id": jobId,
      });
      Future.microtask(() => getSavedJobs());
      return true;
    } catch (e) {
      return false;
    }
  }

  getApplicationInfo() async {
    final res =
        await sb.from("application_info").select("*").eq("user_id", user!.id);
    return (res as List).first;
  }

  Future<List<Job>> getSavedJobs([bool shouldNotify = false]) async {
    if (user == null) throw Error();
    try {
      final res = await sb
          .from("saved_jobs")
          .select("jobs:job_id(*)")
          .eq("user_id", user!.id);
      savedJobs = (res as List).map((e) => Job.fromJson(e["jobs"])).toList();
      if (shouldNotify) {
        notifyListeners();
      }
      return savedJobs;
    } catch (e) {
      rethrow;
    }
  }
}
