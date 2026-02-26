// ignore_for_file: non_constant_identifier_names, constant_identifier_names

abstract class Routes {
  static const LOGIN = '/login';

  // Student Routes
  static const STUDENT_DASHBOARD = '/student-dashboard';
  static const EXAM_DETAILS = '/exam-details';
  static const EXAM_PLAYER = '/exam-player';
  static const EXAM_RESULT = '/exam-result';

  // Instructor Routes
  static const INSTRUCTOR_DASHBOARD = '/instructor-dashboard';
  static const EXAM_BUILDER = '/exam-builder';
  static const EXAM_MONITOR = '/exam-monitor';
  static const EXAM_REPORTS = '/exam-reports';

  static const ROOM_JOIN = '/room-join';

  static String get EXAM => EXAM_DETAILS;
}
