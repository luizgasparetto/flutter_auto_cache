<h1 align="center">Flutter Auto Cache</h1>

<p align="center">
  <i align="center">Improves cache management policies, including enhanced replacement strategies, invalidation methods and encryption in a KVS (Key-Value Store) database 🚀</i>
</p>

<h4 align="center">
  <a href="https://github.com/luizgasparetto/flutter_auto_cache/actions/workflows/ci.yaml">
    <img src="https://img.shields.io/github/actions/workflow/status/luizgasparetto/flutter_auto_cache/ci.yaml?branch=main&label=pipeline&style=flat-square" alt="continuous integration" style="height: 20px;">
  </a>
  <a href="https://github.com/luizgasparetto/flutter_auto_cache/graphs/contributors">
    <img src="https://img.shields.io/github/contributors-anon/luizgasparetto/flutter_auto_cache?color=yellow&style=flat-square" alt="contributors" style="height: 20px;">
  </a>
  <a href="https://opensource.org/license/bsd-3-clause">
  <img src="https://img.shields.io/github/license/luizgasparetto/flutter_auto_cache?style=flat-square&color=blue" style: "height: 20px;">
  </a>
</h4>


## Introduction

`FlutterAutoCache` is a sophisticated, high-tech cache manager for Flutter, designed to optimize cache management in mobile applications. FlutterAutoCache enhances cache replacement policies, provides robust encryption methods, and ensures efficient disk space management. Leveraging shared_preferences, our platform delivers a comprehensive solution for cache data management.

With FlutterAutoCache, you can seamlessly integrate advanced cache management features, allowing you to focus on your application’s core functionality while we handle the complexities of data caching. Our user-friendly interface and powerful capabilities make FlutterAutoCache the go-to choice for Flutter developers aiming to achieve high performance and security in their applications.

Experience unparalleled efficiency and reliability in cache management with FlutterAutoCache.


## Instalation 

Getting started with FlutterAutoCache is straightforward and can be accomplished in a few simple steps. You have the flexibility to add it to your project directly from pub.dev or install it locally, depending on your development preferences and workflow.

### Adding via pub.dev
To add FlutterAutoCache to your project, run the following command:

```
flutter pub add flutter_auto_cache
```

### Installing Locally
If you prefer to install FlutterAutoCache locally, follow these steps:

#### 1. Clone the FlutterAutoCache repository:

```
git clone https://github.com/luizgasparetto/flutter_auto_cache.git
```

#### 2. Navigate to your project's pubspec.yaml file and add the following dependency:
```
dependencies:
  flutter_auto_cache:
    path: ../path_to_flutter_auto_cache
```

#### 3. Install the dependency by running:
```
flutter pub get
```

Once installed, you can start using FlutterAutoCache in your Flutter project to enhance your application's cache management with advanced features, including encryption and efficient disk space management.

## Usage
To use FlutterAutoCache, you need to initialize the cache manager before calling `runApp`. This ensures that all cache configurations are set up correctly. You also have the option to pass your custom initialization configuration.

```dart
Future<void> main() async {
  // Optional: Pass a custom CacheConfiguration if needed
  await AutoCacheInitializer.instance.init(configuration: yourCustomConfiguration);

  runApp(MyApp());
}
```

After initialization, you can use the cache management methods directly from the AutoCache class. Here is an example of how to access the preferences cache manager:

```
await AutoCache.prefs.getString(key: "my_string_cached");
```

With this setup, you can easily manage your application's cache using the methods provided by AutoCache.

> **Note**
> Each property of the `CacheConfiguration` can have a different impact on how the cache behaves. It is important to understand these prCooperties to optimize your application's performance and reliability.


## Contributing

The majority of FlutterAutoCache code is open-source. We are committed to a transparent development process and highly appreciate any contributions. Whether you are helping us fix bugs, proposing new features, improving our documentation, or spreading the word - we would love to have you as a part of the FlutterAutoCache community.

- Bug Report: If you see an error message or encounter an issue while using Amplication, please create a [bug report](https://github.com/luizgasparetto/flutter_auto_cache/issues/new?assignees=&labels=type%3A+feature+request&template=BUG-REPORT.yml).

- Feature Request: If you have an idea or if there is a capability that is missing and would make development easier and more robust, please submit a [feature request](https://github.com/luizgasparetto/flutter_auto_cache/issues/new?assignees=&labels=type%3A+feature+request&template=SUGGESTION-REQUEST.yml).

## License

FlutterAutoCache is licensed under the [BSD-3-Clause](./LICENSE). This license permits the redistribution and use of the software in source and binary forms, with or without modification, provided that the terms and conditions outlined in the license are met. By using FlutterAutoCache, you agree to comply with these terms and conditions, which ensure the protection and proper use of the software.