part of hireme_providers;

class JobProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List jobs = [];
  Future fetchJobs() async {
    final data = await supabase.from('jobs').select('*').limit(100);
    jobs = data.map((element) => Job.fromJson(element)).toList();
    return jobs;
  }

  get getJobs => jobs;

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
}
