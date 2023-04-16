part of hireme_providers;

class JobProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List<Job> jobs = [];
  List? data;
  List<Job> appliedJobs = [];

  AuthProvider? auth;
  JobProvider([this.auth]);

  Future<List<Job>> fetchJobs() async {
    final res = await supabase.from('jobs').select('*').limit(100);
    jobs = (res as List).map((element) => Job.fromJson(element)).toList();
    return jobs;
  }

  checkAuth() => auth == null && auth!.user == null;

  Future<bool> saveApplicationDetails(
      {name,
      email,
      phone,
      education,
      experience,
      skills,
      salaryRange,
      userId}) async {
    try {
      // print(name);
      // print(email);
      // print(phone);
      // print(education);
      // print(experience);
      // print(skills);
      // print(salaryRange);
      // print(userId);

      await supabase.from('application_info').insert({
        'name': name,
        'email': email,
        'phone': phone,
        'education': education,
        'experience': experience,
        'skills': skills,
        'salary_range': salaryRange,
        'user_id': userId,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> fetchApplicationDetails(userId) async {
    try {
      data = await supabase
          .from('application_info')
          .select('*')
          .eq('user_id', userId);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> apply(int jobId) async {
    if (checkAuth()) return false;
    try {
      await fetchAppliedJobs();
      if (appliedJobs.any((e) => e.id == jobId)) return false;
      await supabase
          .from('applied_jobs')
          .insert({'user_id': auth!.user!.id, 'job_id': jobId});
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<Job>> fetchAppliedJobs([bool shouldNotify = false]) async {
    if (checkAuth()) return [];

    final res = await supabase
        .from('applied_jobs')
        .select('jobs:job_id(*)')
        .eq('user_id', auth!.user!.id);
    appliedJobs = (res as List).map((e) => Job.fromJson(e["jobs"])).toList();

    if (shouldNotify) {
      notifyListeners();
    }

    return [];
  }
}
