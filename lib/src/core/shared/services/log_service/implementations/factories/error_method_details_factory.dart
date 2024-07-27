import '../value_objects/error_method_details.dart';

final class ErrorMethodDetailsFactory {
  static ErrorMethodDetails create() {
    final frames = StackTrace.current.toString().split('\n');

    final response = frames.firstWhere(_isExternalApplication, orElse: () => _getLocalFrame(frames));
    final frame = response.split(' ').where((e) => e.isNotEmpty).toList();

    return ErrorMethodDetails(method: _getMethodName(frame), errorLine: _getErrorLine(frame));
  }

  static bool _isExternalApplication(String frame) => !frame.contains('flutter_auto_cache');
  static String _getLocalFrame(List<String> frames) => frames.firstWhere((e) => !e.contains('new') && !e.contains('Log'));

  static String _getMethodName(List<String> frames) => frames[1];
  static String _getErrorLine(List<String> frames) => frames[2].split(':')[2];
}
