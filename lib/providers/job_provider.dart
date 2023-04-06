part of hireme_providers;

class JobProvider extends ChangeNotifier {
  final supabase = Supabase.instance.client;
  Future fetchJobs() async {
    final data = await supabase.from('jobs').select('*');
    print(data);
    return data;
  }
}
