// ignore_for_file: file_names

class Urls {
  static String ip = "192.168.1.5:8000";
  static String baseUrl = "http://$ip/api/";
  //auth endpoint
  static String login = "auth/login";
  static String register = "auth/register";
  static String verifiPhoneNum = "auth/verify-account";
  static String getCities = "cities";
  static String getProfile = "auth/me";

  //leaderbord
  static String getLeaderbord = "students";

  //courses
  static String getCourses = "courses";

  //subjects
  static String getSubjects = "subjects";
}
