// ignore_for_file: non_constant_identifier_names, constant_identifier_names

abstract class Routes {
  static const LOGIN = '/login';

  // Student Routes
  static const STUDENT_DASHBOARD = '/student-dashboard';
  static const EXAM_DETAILS = '/exam-details';
  static const EXAM_PLAYER = '/exam-player';
  static const EXAM_RESULT = '/exam-result';

  // Developer Routes
  static const DEVELOPER_DASHBOARD = '/developer-dashboard';

  // Instructor Routes
  static const INSTRUCTOR_DASHBOARD = '/instructor-dashboard';
  static const EXAM_BUILDER = '/exam-builder';
  static const EXAM_MONITOR = '/exam-monitor';
  static const EXAM_REPORTS = '/exam-reports';
  static const EXAM_ANALYTICS = '/exam-analytics'; // ✅ كان null

  // Room Routes
  static const ROOM_JOIN = '/room-join';
  static const ROOM_DASHBOARD = '/room-dashboard'; // ✅ (اختياري) لو عندك الصفحة

  // Aliases (اختياري)
  static String get EXAM => EXAM_DETAILS;
}
