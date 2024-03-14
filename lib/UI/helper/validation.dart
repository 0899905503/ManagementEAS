class Validation {
  // ignore: non_constant_identifier_names
  static String? validateUsername(String username) {
    if (username.isEmpty) {
      return 'Tên người dùng không được để trống';
    } else if (username.length < 6) {
      return 'Tên người dùng phải có ít nhất 6 ký tự';
    } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(username)) {
      return 'Tên người dùng chỉ chấp nhận ký tự chữ, số và dấu gạch dưới';
    }
    // Nếu tên người dùng hợp lệ, trả về null
    return null;
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Mật khẩu không được để trống';
    } else if (password.length < 8) {
      return 'Mật khẩu phải có ít nhất 8 ký tự';
    } else if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d).+$').hasMatch(password)) {
      return 'Mật khẩu phải chứa ít nhất một chữ cái và một số';
    }
    // Nếu mật khẩu hợp lệ, trả về null
    return null;
  }
}
