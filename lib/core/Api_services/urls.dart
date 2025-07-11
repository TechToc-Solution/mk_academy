class Urls {
  //base urls
  static String ip = "mkacademyapp.com";
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
  static String updateProfile = "auth/me";

  //leaderbord
  static String getLeaderbord = "students";

  //courses
  static String getCourses = "courses";

  //subjects
  static String getSubjects = "subjects";

  //Tests
  static String getGeneralTests = "quizzes/general";
  static String getSpecialTests = "quizzes/special";
  static String getTestsDetails = "quizzes/";

  //Ads
  static String getInternalAds = "ads/internal";
  static String getExternalAds = "ads/external";

  //version
  static String getVersion = "versions";

  //purchase
  static String purchase = "purchase-codes";
  static String purchaseCheck = "$purchase/check";
  static String purchaseUse = "$purchase/use";
}
