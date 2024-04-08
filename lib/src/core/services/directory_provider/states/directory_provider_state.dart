import 'dart:io';

final class DirectoryProviderState {
  final Directory applicationDocumentsDirectory;
  final Directory applicationSupportDirectory;

  const DirectoryProviderState({
    required this.applicationDocumentsDirectory,
    required this.applicationSupportDirectory,
  });

  factory DirectoryProviderState.empty() {
    return DirectoryProviderState(
      applicationDocumentsDirectory: Directory(''),
      applicationSupportDirectory: Directory(''),
    );
  }

  bool get isLoaded => this is LoadedDirectoryProviderState;
}

final class LoadedDirectoryProviderState extends DirectoryProviderState {
  const LoadedDirectoryProviderState({
    required super.applicationDocumentsDirectory,
    required super.applicationSupportDirectory,
  });
}
