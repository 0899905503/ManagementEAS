part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final LoadStatus signInStatus;
  final String? username;
  final String? password;
  final bool isRememberAccount;
  final bool isShowPassword;
  final bool enableValidate;

  const SignInState({
    this.signInStatus = LoadStatus.initial,
    this.username,
    this.password,
    this.isRememberAccount = false,
    this.isShowPassword = false,
    this.enableValidate = false,
  });

  @override
  List<Object?> get props => [
        signInStatus,
        username,
        password,
        isRememberAccount,
        isShowPassword,
        enableValidate,
      ];

  SignInState copyWith({
    LoadStatus? signInStatus,
    String? username,
    String? password,
    bool? isRememberAccount,
    bool? isShowPassword,
    bool? enableValidate,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      username: username ?? this.username,
      password: password ?? this.password,
      isRememberAccount: isRememberAccount ?? this.isRememberAccount,
      isShowPassword: isShowPassword ?? this.isShowPassword,
      enableValidate: enableValidate ?? this.enableValidate,
    );
  }
}
