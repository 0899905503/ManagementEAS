part of 'app_cubit.dart';

class AppState extends Equatable {
  final UserEntity? user;
  final LoadStatus fetchProfileStatus;
  final LoadStatus getProductStatus;
  final LoadStatus signOutStatus;
  final LoadStatus updateLanguageStatus;

  const AppState({
    this.user,
    this.fetchProfileStatus = LoadStatus.initial,
    this.signOutStatus = LoadStatus.initial,
    this.getProductStatus = LoadStatus.initial,
    this.updateLanguageStatus = LoadStatus.initial,
  });

  AppState copyWith({
    UserEntity? user,
    LoadStatus? fetchProfileStatus,
    LoadStatus? signOutStatus,
    LoadStatus? getProductStatus,
    LoadStatus? updateLanguageStatus,
  }) {
    return AppState(
      user: user ?? this.user,
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
      signOutStatus: signOutStatus ?? this.signOutStatus,
      getProductStatus: getProductStatus ?? this.getProductStatus,
      updateLanguageStatus: updateLanguageStatus ?? this.updateLanguageStatus,
    );
  }

  AppState removeUser() {
    return AppState(
      user: user,
      fetchProfileStatus: fetchProfileStatus,
      signOutStatus: signOutStatus,
    );
  }

  @override
  List<Object?> get props => [
        user,
        fetchProfileStatus,
        signOutStatus,
        getProductStatus,
        updateLanguageStatus,
      ];
}
