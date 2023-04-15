part of hireme_providers;

class JobProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List jobs = [];
  List? data;
  List? appliedJobs;

  Future fetchJobs() async {
    final data = await supabase.from('jobs').select('*').limit(100);
    jobs = data.map((element) => Job.fromJson(element)).toList();
    return jobs;
  }

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
      print(name);
      print(email);
      print(phone);
      print(education);
      print(experience);
      print(skills);
      print(salaryRange);
      print(userId);

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

  Future<bool> apply(userId, applicationId, jobId) async {
    try {
      await supabase.from('applied_jobs').insert({
        'application_id': applicationId,
        'user_id': userId,
        'job_id': jobId
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> fetchAppliedJobs(userId) async {
    try {
      appliedJobs =
          await supabase.from('applied_jobs').select('*').eq('user_id', userId);
      print(appliedJobs);
      return true;
    } catch (e) {
      return false;
    }
  }
}
