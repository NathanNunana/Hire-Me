part of hireme_models;

@HiveType(typeId: 0)
class Profile {
  @HiveField(0)
  late final String? firstName;
  @HiveField(1)
  late final String? middleName;
  @HiveField(2)
  late final String? lastName;
  @HiveField(3)
  late final String? profilePic;

  Profile({this.firstName, this.lastName, this.middleName, this.profilePic});
}
