<p align="center">
  <a href="https://github.com/luizgasparetto/flutter_auto_cache">
  <img src="./docs/assets/logo.svg">
  </a>
</p>


<h4 align="center">
  <a href="https://github.com/luizgasparetto/flutter_auto_cache/actions/workflows/ci.yaml">
    <img src="https://img.shields.io/github/actions/workflow/status/luizgasparetto/flutter_auto_cache/ci.yaml?branch=main&label=pipeline&style=flat-square&color=blue" alt="continuous integration" style="height: 20px;">
  </a>
  <a href="https://github.com/luizgasparetto/flutter_auto_cache/stargazers">
    <img src="https://img.shields.io/github/stars/luizgasparetto/flutter_auto_cache?style=flat-square" alt="start" style="height: 20px;">
  </a>
  <a href="https://opensource.org/license/bsd-3-clause">
  <img src="https://img.shields.io/github/license/luizgasparetto/flutter_auto_cache?style=flat-square&color=blue" alt="bsd-3-clause" style: "height: 20px;">
  </a>
  <br>
</h4>


## Introduction

`Flutter Auto Cache` is a sophisticated, high-tech cache manager for Flutter, designed to optimize cache management in mobile applications. Enhances cache replacement policies, provides robust encryption methods, and ensures efficient disk space management. Leveraging `shared_preferences`, our platform delivers a comprehensive solution for cache data management.

With `Flutter Auto Cache`, you can seamlessly integrate advanced cache management features, allowing you to focus on your application’s core functionality while we handle the complexities of data caching. Our user-friendly interface and powerful capabilities make `Flutter Auto Cache` the go-to choice for Flutter developers aiming to achieve high performance and security in their applications.

Experience unparalleled efficiency and reliability in cache management with `Flutter Auto Cache`.


## Installation 

Getting started with `Flutter Auto Cache` is straightforward and can be accomplished in a few simple steps. You have the flexibility to add it to your project directly from pub.dev or install it locally, depending on your development preferences and workflow.


### Adding via pub.dev
To add `Flutter Auto Cache` to your project, run the following command:

```
flutter pub add flutter_auto_cache
```

### Installing Locally
If you prefer to install `Flutter Auto Cache` locally, follow these steps:

#### 1. Clone the FlutterAutoCache repository:

```bash
git clone https://github.com/luizgasparetto/flutter_auto_cache.git
```

#### 2. Navigate to your project's `pubspec.yaml` file and add the following dependency:
```yaml
dependencies:
  flutter_auto_cache:
    path: ../path_to_flutter_auto_cache
```

#### 3. Install the dependency by running:
```bash
flutter pub get
```

Once installed, you can start using `Flutter Auto Cache` in your Flutter project to enhance your application's cache management with advanced features, including encryption and efficient disk space management.

## Usage
To use `Flutter Auto Cache`, you need to initialize the cache manager before calling `runApp`. This ensures that all cache configurations are set up correctly. You also have the option to pass your custom initialization configuration.

```dart
import 'package:flutter_auto_cache/flutter_auto_cache.dart';

Future<void> main() async {
  /// Optional: Pass a custom CacheConfiguration if needed
  await AutoCacheInitializer.initialize(configuration: yourCustomConfiguration);

  runApp(MyApp());
}
```

After initialization, you can use the cache management methods directly from the `AutoCache` class. Here is an example of how to access the preferences cache manager:

```dart
await AutoCache.prefs.getString(key: "my_string_cached");
```

With this setup, you can easily manage your application's cache using the methods provided by `AutoCache`.

> **Note**
> Each property of the `CacheConfiguration` can have a different impact on how the cache behaves. It is important to understand these properties to optimize your application's performance and reliability.


## Contributing

The majority of `Flutter Auto Cache` code is open-source. We are committed to a transparent development process and highly appreciate any contributions. Whether you are helping us fix bugs, proposing new features or improving our documentation.

- **Bug Report:** If you see an error message or encounter an issue while using this package, please create a [bug report](https://github.com/luizgasparetto/flutter_auto_cache/issues/new?assignees=&labels=type%3A+feature+request&template=BUG-REPORT.yml).

- **Feature Request:** If you have an idea or if there is a capability that is missing and would make development easier and more robust, please submit a [feature request](https://github.com/luizgasparetto/flutter_auto_cache/issues/new?assignees=&labels=type%3A+feature+request&template=SUGGESTION-REQUEST.yml).

## License

`Flutter Auto Cache` is licensed under the [BSD-3-Clause](./LICENSE). This license permits the redistribution and use of the software in source and binary forms, with or without modification, provided that the terms and conditions outlined in the license are met. By using `Flutter Auto Cache`, you agree to comply with these terms and conditions, which ensure the protection and proper use of the software.