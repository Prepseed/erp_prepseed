class ApiUrls {
  static String STATIC_URL = "https://static.prepseed.com";
  static String BASEURL = 'https://napi.prepseed.com'; //'192.168.29.183:4040/api'; //'http://192.168.29.254:4040/api';

  static String CLIENT_BASE = BASEURL + "/clients";
  static String USER_BASE = BASEURL + "/users";
  static String ASSESSMENT_BASE = BASEURL + "/assessment";
  static String LEADERBOARD_BASE = BASEURL + "/leaderboard";

  static String listNames = CLIENT_BASE + '/listNames';
  static String signIn = USER_BASE + '/signin';
  static String reports = USER_BASE + '/get-reports?newReport=1';
  static String getWrappers = ASSESSMENT_BASE + '/getwrappers';
  static String getWrapper = ASSESSMENT_BASE + '/getwrapper';
  static String getGrades = ASSESSMENT_BASE + '/getGrades';
  static String listQuestions = ASSESSMENT_BASE;
  static String syncFlow = ASSESSMENT_BASE + '/syncFlow';
  static String getAnalysis = ASSESSMENT_BASE + '/getAnalysis';
  static String getSubmissionDetails = ASSESSMENT_BASE + '/getSubmissionDetails';
  static String getSubmissions = ASSESSMENT_BASE + '/getsubmissions';
  static String getranks = LEADERBOARD_BASE + '/getranks';
  static String getPhaseLeaderBoard = LEADERBOARD_BASE + '/getphaseleaderboard';
  static String practiceQuestion = '/session/getQuestionAtPosition';
  static String submit = ASSESSMENT_BASE + '/submit';
  static String updateAccount = USER_BASE + '/updateAccount';

/*
  static String logo_icon = BASEURL.replaceAll('/API/', '/')+'assets/img/logomob.png';
  static String logo_sm_icon = BASEURL.replaceAll('/API/', '/')+'assets/img/favicon.png';
  static String fetch_url = BASEURL+'fetchdata_API.php';
  static String insert_url = BASEURL+'insertdata_API.php';
  static String addImage_url = BASEURL+'addImage_API.php';
  static String otp_url = BASEURL+'get_otp.php';
*/

  static String video = BASEURL + '/video';
  static String videoAttendance = video + '/course-plan/of-phase';
  static String playlistUrl = video+'/playlists/';
  static String videoUrl = video+'/playlist/';
  //comment url
  static String commentUrl = video+"/comments?videoId=";

  static String announcementUrl = BASEURL+'/announcement/user/of-phase/';

  static String doubtUrl = BASEURL + "/phase/get/628c8a6d7640243d911a6cc6";

  //upload assignment url
  static String assignmentUploadUrl = BASEURL+'/assignment/public/uploadPolicy';

  //post the comment url
  static String commentPostUrl = video+'/comment';


}