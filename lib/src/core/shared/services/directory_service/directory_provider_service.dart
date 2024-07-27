import 'dart:io';

import 'package:flutter/foundation.dart';

import 'exceptions/directory_provider_exceptions.dart';
import '../path_provider_service/i_path_provider_service.dart';
import 'states/directory_provider_state.dart';

/// Provides access to specific directories required by the application.
///
/// This service interface defines methods for retrieving and initializing
/// directories used for storing preferences and caching data.
abstract interface class IDirectoryProviderService {
  /// The directory designated for storing preference files.
  ///
  /// This property should provide the path to the directory where the application's
  /// preference files are stored. It should be initialized by the [getCacheDirectories] method.
  Directory get prefsDirectory;

  /// Initializes and loads the necessary cache directories.
  ///
  /// This method is responsible for setting up the [prefsDirectory] and other
  /// relevant directories such as `sqlDirectory`. It ensures that the directories
  /// are correctly configured and accessible for use.
  ///
  /// Throws a [DirectoryProviderException] if the directories cannot be loaded or initialized.
  Future<void> getCacheDirectories();
}

class DirectoryProviderService extends ValueNotifier<DirectoryProviderState> implements IDirectoryProviderService {
  final IPathProviderService _service;

  DirectoryProviderService(this._service) : super(EmptyDirectoryProviderState());

  @override
  Directory get prefsDirectory => this.value.applicationSupportDirectory;

  @override
  Future<void> getCacheDirectories() async {
    try {
      if (this.value.isLoaded) return;

      final isTest = Platform.environment.containsKey('FLUTTER_TEST');

      final tempDocumentsDir = await Directory.systemTemp.createTemp('documents');
      final tempSupportDir = await Directory.systemTemp.createTemp('support');

      final applicationDocumentsDirectory = isTest ? tempDocumentsDir : await _service.getApplicationDocumentsDirectory();
      final applicationSupportDirectory = isTest ? tempSupportDir : await _service.getApplicationSupportDirectory();

      this.value = LoadedDirectoryProviderState(applicationDocumentsDirectory, applicationSupportDirectory);
    } catch (exception, stackTrace) {
      throw DirectoryProviderException(
        message: 'An error occurred while loading directories: ${exception.toString()}',
        stackTrace: stackTrace,
      );
    }
  }

  @visibleForTesting
  void reset() => this.value = EmptyDirectoryProviderState();
}
