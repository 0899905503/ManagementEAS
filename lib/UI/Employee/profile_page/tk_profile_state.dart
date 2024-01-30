part of 'tk_profile_cubit.dart';

class TkProfileState extends Equatable {
  final LoadStatus getProfileStatus;
  final LoadStatus logoutStatus;
  final ProfileEntity? profile;
  final String getAvatarStatus;
  final String story;
  final String name;
  final String phonenumber;
  final String email;
  final String number_of_day_off;
  final String working_hours;
  final String remaining_vacation_days_in_the_year;
  final String overtime;
  final int selectedIndex;
  final String department;
  final String designation;
  final String join;

  const TkProfileState({
    this.getProfileStatus = LoadStatus.initial,
    this.logoutStatus = LoadStatus.initial,
    this.profile,
    this.getAvatarStatus = "",
    this.name = "",
    this.email = "",
    this.phonenumber = "",
    this.number_of_day_off = "",
    this.story = "",
    this.overtime = "",
    this.working_hours = "",
    this.selectedIndex = 0,
    this.remaining_vacation_days_in_the_year = "",
    this.department = "",
    this.designation = "",
    this.join = "",
  });

  @override
  List<Object?> get props => [
        getProfileStatus,
        logoutStatus,
        profile,
        story,
        getAvatarStatus,
        name,
        email,
        phonenumber,
        number_of_day_off,
        working_hours,
        overtime,
        selectedIndex,
        remaining_vacation_days_in_the_year,
        department,
        designation,
        join,
      ];

  TkProfileState copyWith({
    LoadStatus? getProfileStatus,
    LoadStatus? logoutStatus,
    ProfileEntity? profile,
    String? getAvatarStatus,
    String? name,
    String? email,
    String? phonenumber,
    String? number_of_day_off,
    String? working_hours,
    String? overtime,
    String? remaining_vacation_days_in_the_year,
    String? department,
    String? designation,
    String? join,
    int? selectedIndex,
  }) {
    return TkProfileState(
      getProfileStatus: getProfileStatus ?? this.getProfileStatus,
      logoutStatus: logoutStatus ?? this.logoutStatus,
      profile: profile ?? this.profile,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      name: name ?? this.name,
      email: email ?? this.email,
      phonenumber: phonenumber ?? this.phonenumber,
      number_of_day_off: number_of_day_off ?? this.number_of_day_off,
      working_hours: working_hours ?? this.working_hours,
      overtime: overtime ?? this.overtime,
      remaining_vacation_days_in_the_year:
          remaining_vacation_days_in_the_year ??
              this.remaining_vacation_days_in_the_year,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      join: join ?? this.join,
    );
  }
}
