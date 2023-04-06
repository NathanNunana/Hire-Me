part of hireme_providers;

class JobProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  List jobs = [];
  Future fetchJobs() async {
    final data = await supabase.from('jobs').select('*');
    jobs = data.map((element) => Job.fromJson(element)).toList();
    return jobs;
  }

  get getJobs => jobs;
}
