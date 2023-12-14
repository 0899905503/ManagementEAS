enum AppPermission {
  salary,
  employee;

  bool get isSalary => this == salary;
  bool get isEmployee => this == employee;
}
