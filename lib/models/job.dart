part of hireme_models;

class Job {
  final int? jobId;
  final String? title;
  final String? company;
  final String? description;
  final List<dynamic>? area;
  final String? location;
  final num? minSalary;
  final num? maxSalary;
  final String? category;
  final String? categoryTag;
  final String? contractTime;
  final String? contractType;
  final String? created;
  final bool? save;

  Job({
    this.title,
    this.company,
    this.minSalary,
    this.maxSalary,
    this.location,
    this.area,
    this.description,
    this.category,
    this.categoryTag,
    this.contractTime,
    this.contractType,
    this.created,
    this.jobId,
    this.save = false,
  });

  factory Job.fromJson(Map<String, dynamic> job) {
    return Job(
      jobId: job['job_id'],
      title: job['title'],
      company: job['company'],
      minSalary: job['min_salary'],
      maxSalary: job['max_salary'],
      location: job['location'],
      area: job['area'],
      description: job['description'],
      category: job['category'],
      categoryTag: job['category_tag'],
      contractTime: job['contract_time'],
      contractType: job['contract_type'],
      created: job['created'],
    );
  }
}
