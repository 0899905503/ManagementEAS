import 'dart:async';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meas/Data/repositories/auth_repository.dart';
import 'package:meas/UI/Employee/Homepage/home_page_view.dart';
import 'package:meas/UI/Employee/Login/auth_viewmodel.dart';
import 'package:meas/UI/Employee/Login/signin/signin_viewmodel.dart';
import 'package:meas/common/app_colors.dart';
import 'package:meas/common/app_images.dart';
import 'package:meas/common/app_text_styles.dart';
import 'package:meas/configs/security.dart';
import 'package:meas/utils/routes/routes.dart';
import 'package:meas/widgets/buttons/app_button.dart';
import 'package:meas/widgets/textfields/app_text_field.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final SigninViewModel signinViewModel = SigninViewModel();

  late StreamSubscription<String> emailSubscription;
  late StreamSubscription<String> passwordSubscription;

  late AuthViewModel authViewModel;
  late SharedPreferences _prefs;
  bool rememberMe = false; // hoặc giá trị mặc định của bạn

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initPrefs();
    // Lắng nghe sự thay đổi từ Stream
    emailSubscription = signinViewModel.emailStream.listen((String email) {
      print(email);
    });

    passwordSubscription =
        signinViewModel.passwordStream.listen((String password) {
      print(password);
    });

    // Đặt giá trị mặc định cho email và password
    // signinViewModel.emailSink.add('admin');
    // signinViewModel.passwordSink.add('123456789');
    authViewModel = AuthViewModel();
  }

  @override
  void dispose() {
    // Hủy lắng nghe khi widget bị dispose
    emailSubscription.cancel();
    passwordSubscription.cancel();

    emailController.dispose();
    passwordController.dispose();

    signinViewModel.dispose();
    super.dispose();
  }

  Future<void> _initPrefs() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    // Đọc trạng thái "Remember Me" từ SharedPreferences
    bool? savedRememberMe = _prefs.getBool('rememberMe');

    if (savedRememberMe != null) {
      setState(() {
        rememberMe = savedRememberMe;
      });
    }

    // Nếu đã chọn "Remember Me", đọc tài khoản và mật khẩu từ SharedPreferences
    if (rememberMe == true) {
      String? savedEmail = _prefs.getString('email');
      String? savedPassword = _prefs.getString('password');
      print("$savedEmail ----$savedPassword");
      if (savedEmail != null) {
        emailController.text = savedEmail;
        signinViewModel.emailSink.add(savedEmail);
      }

      if (savedPassword != null) {
        passwordController.text = savedPassword;
        signinViewModel.passwordSink.add(savedPassword);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => authViewModel),
        ],
        child: MaterialApp(
            home: Scaffold(
          key: _scaffoldKey,
          body: SafeArea(child: _buildBodyWidget()),
        )));
  }

  Widget _buildBodyWidget() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(color: Color(0xFFF1F0EF)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    "MEAS",
                    style: AppTextStyle.brownS40W800.copyWith(
                      fontSize: 40,
                    ),
                  ),
                  const SizedBox(
                    height: 49,
                  ),
                  SizedBox(
                    height: 228,
                    width: 228,
                    child: Image.asset(AppImages.icbackground),
                  ),
                  const SizedBox(
                    height: 99,
                  ),
                  StreamBuilder<String>(
                    stream: signinViewModel.emailStream,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: 367,
                        child: AppTextField(
                            hintText: "Email",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            borderRadius: 10,
                            showOutline: true,
                            onChanged: signinViewModel.emailSink.add),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  StreamBuilder<String>(
                    stream: signinViewModel.passwordStream,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: 367,
                        child: AppTextField(
                            hintText: "Password ",
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            borderRadius: 10,
                            showOutline: true,
                            obscureText: true,
                            onChanged: signinViewModel.passwordSink.add),
                      );
                    },
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 800),
                      Text('Remember Me',
                          style: AppTextStyle.blackS12W400
                              .copyWith(color: AppColors.defaultText)),
                      Checkbox(
                        value: rememberMe,
                        activeColor: AppColors.textWhite,
                        checkColor: AppColors.buttonLogin,
                        onChanged: (value) {
                          setState(() {
                            rememberMe = value ?? false;
                            _initPrefs(); // Cập nhật trạng thái Remember Me khi người dùng thay đổi
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 800,
                      ),
                      boxMenu("Forgot Password?", 12, FontWeight.w400),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  _buildSignButton(),
                  Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 610,
                        ),
                        Text(
                          "You don't have an account ?",
                          style: AppTextStyle.blackS12W400,
                        ),
                        boxMenu("Sign Up", 12, FontWeight.w700),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget boxMenu(String content, double? size, FontWeight weight) {
    return Row(
      children: [
        TextButton(
          child: Text(
            content,
            style: TextStyle(
                fontSize: size,
                fontWeight: weight,
                color: AppColors.defaultText),
          ),
          onPressed: () {
            if (content == "Signin") {
              print(content);
            }
            if (content == "Sign Up") {
              print(content);
            }
          },
        ),
      ],
    );
  }

  Widget _buildSignButton() {
    return StreamBuilder<bool>(
      stream: signinViewModel.loginStream,
      builder: (context, snapshot) {
        return Container(
          child: AppButton(
            title: "Sign In",
            onPressed: snapshot.hasData && snapshot.data == true
                ? () {
                    _login();
                  }
                : null,
          ),
        );
      },
    );
  }

  String hashPassword(String password) {
    // Băm mật khẩu với thuật toán bcrypt
    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

    // Thay đổi định dạng salt từ $2a$ sang $2y$
    String modifiedSalt =
        hashedPassword.substring(0, 29).replaceFirst('\$2a\$', '\$2y\$');

    // Kết hợp salt đã thay đổi và mật khẩu đã băm
    String finalHashedPassword = modifiedSalt + hashedPassword.substring(29);

    return finalHashedPassword;
  }

  void _login() {
    signinViewModel.emailStream.listen((String email) {
      signinViewModel.passwordStream.listen((String password) async {
        if (email.isNotEmpty && password.isNotEmpty) {
          Map<dynamic, dynamic> data = {
            'email': email,
            'password': password,
          };
          final res = await authViewModel.signinApi(data);
          String token = res[1]['token'];
          // String? token = res[1]['token'];
          // Security security = Security();
          await Security.storage.write(key: 'token', value: token);
          // await security.saveToken(token!);
          if (res != null) {
            if (token != null) {
              Get.snackbar("Nofitication!!!", "Token saved successful",
                  colorText: Colors.white,
                  icon: const Icon(
                    Icons.check,
                    color: Colors.green, // Thay đổi màu sắc nếu cần
                    size: 24, // Thay đổi kích thước nếu cần
                  ));
            } else {
              Get.snackbar(
                "Warning!!!",
                "Token is null",
                colorText: Colors.white,
                icon: const Icon(
                  IconData(0x2757, fontFamily: 'Alumi Sans'),
                  color: Colors.yellow, // Thay đổi màu sắc nếu cần
                  size: 30, // Thay đổi kích thước nếu cần
                ),
              );
            }
            // print(res[1].runtimeType);
            // print(security);
            // res[1]['user']['first_name'];

            Get.offNamed(RouteConfig.chooseAppScreen);
          }
        } else {
          Get.snackbar(
            "Warning!!!",
            "Invalid email or password!",
            colorText: Colors.red,
            icon: const Icon(
              IconData(0x2757, fontFamily: 'Alumi Sans'),
              color: Colors.red, // Thay đổi màu sắc nếu cần
              size: 30, // Thay đổi kích thước nếu cần
            ),
          );
        }
      });
    });
  }
}
