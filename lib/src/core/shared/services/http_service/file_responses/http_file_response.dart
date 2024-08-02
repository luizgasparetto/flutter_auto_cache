final class FileResponse {
  final Stream<List<int>> bytes;
  final int statusCode;

  const FileResponse({
    required this.bytes,
    required this.statusCode,
  });
}
