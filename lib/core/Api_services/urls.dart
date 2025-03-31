class Urls {
  static String ip = "92.205.186.203:81";
  static String baseUrl = "http://$ip/api/";
  //auth endpoint
  static String login = "auth/login";
  static String logout = "auth/logout";
  static String register = "auth/register";
  static String verifiPhoneNum = "auth/verify-account";
  static String getCities = "cities";
  static String getProfile = "auth/me";
  static String forgetPassword = "auth/forget-password";
  static String verfiResetPassword = "auth/verify-reset-password";
  static String resendCode = "/auth/resend-code";

  //leaderbord
  static String getLeaderbord = "students";

  //courses
  static String getCourses = "courses";

  //subjects
  static String getSubjects = "subjects";
}
