// ignore_for_file: file_names

class Urls {
  static String ip = "10.0.2.2:8000";
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

  //leaderbord
  static String getLeaderbord = "students";

  //courses
  static String getCourses = "courses";

  //subjects
  static String getSubjects = "subjects";
}
