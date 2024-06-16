import 'dart:io';

sealed class DirectoryProviderState {
  final Directory applicationDocumentsDirectory;
  final Directory applicationSupportDirectory;

  const DirectoryProviderState(
    this.applicationDocumentsDirectory,
    this.applicationSupportDirectory,
  );

  bool get isLoaded => this is LoadedDirectoryProviderState;
}

final class EmptyDirectoryProviderState extends DirectoryProviderState {
  EmptyDirectoryProviderState() : super(Directory(''), Directory(''));
}

final class LoadedDirectoryProviderState extends DirectoryProviderState {
  const LoadedDirectoryProviderState(
    super.applicationDocumentsDirectory,
    super.applicationSupportDirectory,
  );
}
