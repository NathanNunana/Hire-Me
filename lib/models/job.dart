part of hireme_models;

class Job {
  final String? title;
  final String? subTitle;
  final String? description;
  final String? country;
  final String? jobType;
  final String? location;
  final String? salaryRange;

  Job({
    this.title,
    this.subTitle,
    this.salaryRange,
    this.location,
    this.jobType,
    this.description,
    this.country,
  });
}
