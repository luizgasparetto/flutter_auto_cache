<p align="center"><img src="./assets/logo.png"></p>

# Introduction

`Flutter Auto Cache` is a sophisticated, high-tech cache manager for [`Flutter`](https://flutter.dev), designed to optimize cache management in mobile applications. Enhances cache replacement policies, provides robust encryption methods, and ensures efficient disk space management. Our platform delivers a comprehensive solution for cache data management.

With `Flutter Auto Cache`, you can seamlessly integrate advanced cache management features, allowing you to focus on your application’s core functionality while we handle the complexities of data caching. Our user-friendly interface and powerful capabilities make `Flutter Auto Cache` the go-to choice for Flutter developers aiming to achieve high performance and security in their applications.

Experience unparalleled efficiency and reliability in cache management with `Flutter Auto Cache`.

## Features

- **Advanced Cache Replacement Policies**: `Flutter Auto Cache` implements state-of-the-art algorithms to ensure that the most relevant data is always available while efficiently managing disk space.
- **Robust Encryption Methods**: Secure your cached data with cutting-edge encryption, ensuring that sensitive information remains protected at all times.
- **Efficient Disk Space Management**: Our platform intelligently manages disk space, preventing excessive usage and optimizing performance.
- **Seamless Integration**: Easily integrate `Flutter Auto Cache` into your existing `Flutter` projects with minimal effort.
- **User-Friendly Interface**: Designed with developers in mind, `Flutter Auto Cache` provides an intuitive interface that simplifies cache management tasks.

## Benefits

- **Enhanced Performance**: By optimizing cache management, `Flutter Auto Cache` helps improve the overall performance of your applications.
- **Increased Security**: Protect your data with our robust encryption methods, ensuring that sensitive information remains safe.
- **Reduced Development Time**: Focus on developing your application's core features while `Flutter Auto Cache` handles the complexities of data caching.
- **Reliability**: Trust in a solution that offers unparalleled efficiency and reliability in managing cached data.

# Installation

Getting started with Flutter Auto Cache is a straightforward process that can be accomplished in just a few simple steps. First, you have the flexibility to add it to your project directly from [`pub.dev`](https://pub.dev/), the official package repository for Dart and Flutter, ensuring that you have access to the latest version and updates. </br>
Alternatively, if you prefer to have more control over the package versioning and dependencies, you can install it **locally** by downloading the package and including it in your project manually. This flexibility allows you to tailor the integration to your specific development preferences and workflow, making it easier to incorporate `Flutter Auto Cache` into your existing projects.

## Adding via pub.dev
To add `Flutter Auto Cache` to your project, run the following command in your terminal:

```
flutter pub add flutter_auto_cache
```

## Installing Locally
If you prefer to install `Flutter Auto Cache` locally, follow these steps:

### Clone repository

```bash
git clone https://github.com/luizgasparetto/flutter_auto_cache.git
```

### Install dependency
```yaml
dependencies:
  flutter_auto_cache:
    path: <path_to_flutter_auto_cache>
```
After adding the dependency, you need to run the following command in your terminal:

```bash
flutter pub get
```

Once installed, you can start using `Flutter Auto Cache` in your Flutter project to enhance your application's cache management with advanced features, including encryption and efficient disk space management.

# Initialization

To effectively use Flutter Auto Cache in your project, it is essential to initialize the cache manager before invoking runApp. This initialization step ensures that all cache configurations are properly set up, providing a seamless caching experience for your application. Additionally, you have the flexibility to pass a custom initialization configuration if needed, allowing for more tailored cache management according to your specific requirements.

Here is an example of how to initialize Flutter Auto Cache:

```dart
import 'package:flutter_auto_cache/flutter_auto_cache.dart';

Future<void> main() async {
  await AutoCacheInitializer.initialize();
  runApp(MyApp());
}
```

The initialization process is straightforward and can be customized to fit your development needs, ensuring efficient cache management and improved user experience.

# Configuration

`Flutter Auto Cache` provides the flexibility to pass a custom configuration during the initialization process. This feature allows you to tailor the caching behavior to meet the specific needs of your application, ensuring optimal performance and efficient resource management.

To create a custom configuration, you need to define a CacheConfiguration object with your desired settings. This object can include parameters such as cache size limits, encryption settings, and expiration policies.

Here is an example of how to create and pass a custom configuration:

```dart
import 'package:flutter_auto_cache/flutter_auto_cache.dart';

Future<void> main() async {
  final config = CacheConfiguration();

  await AutoCacheInitializer.initialize(configuration: config);

  runApp(MyApp());
}
```

## Cache Size

`Flutter Auto Cache` provides a flexible and comprehensive way to manage cache size through it's CacheConfiguration class.
This configuration allows you to define the maximum size limits for your cache, ensuring efficient use of memory and disk space.</br>
The `CacheSizeOptions` class represents the configurable maximum sizes for your cache. This allows you to set precise limits on how much space your cache can occupy, which is particularly useful for applications that need to manage memory or disk usage efficiently.

To create cache size options, you need to define a CacheSizeOptions object with your desired maximum sizes. If no values are provided, it defaults to **0 KB** for `maxKb` and **20 MB** for `maxMb`.

Here's an example of how to define and use cache size options:

```dart
import 'package:flutter_auto_cache/flutter_auto_cache.dart';

Future<void> main() async {
  final sizeOptions = CacheSizeOptions(maxKb: 5000, maxMb: 50);
  final config = CacheConfiguration(sizeOptions: sizeOptions);

  await AutoCacheInitializer.init(configuration: config);

  runApp(MyApp());
}
```

### Benefits
By configuring the cache size, you can optimize the cache management for your application's needs, preventing excessive memory or disk usage and ensuring a smoother user experience. The flexibility to define cache size limits helps in maintaining efficient resource utilization and enhances the performance of your application.

Implementing custom cache size options in Flutter Auto Cache allows for precise control over the cache, providing a tailored caching solution that aligns with your application's specific requirements.

## Cryptography

`Flutter Auto Cache` offers robust cryptography options to enhance the security of your cached data. By incorporating cryptographic measures, you can ensure that sensitive information stored in the cache is protected against unauthorized access. The `CacheCryptographyOptions` class provides a straightforward way to implement encryption using a secret key. </br>

The `CacheCryptographyOptions` class allows you to specify a secret key that is used to encrypt and decrypt cache data. The underlying algorithm used for encryption is `AES` *(Advanced Encryption Standard)*, known for its efficiency and strong security.

To create cryptography options, you need to define a CacheCryptographyOptions object with a non-empty secret key. This key will be used for all encryption and decryption operations within the cache.

Here's an example of how to define and use cryptography options:

```dart
import 'package:flutter_auto_cache/flutter_auto_cache.dart';

Future<void> main() async {
  final cryptographyOptions = CacheCryptographyOptions(secretKey: 'your_secret_key');
  final config = CacheConfiguration(cryptographyOptions: cryptographyOptions);

  await AutoCacheInitializer.init(configuration: config);

  runApp(MyApp());
}
```

The `CacheCryptographyOptions` class includes an assertion to ensure that the secret key is provided and is not an empty string. This is crucial for maintaining the integrity and security of the encryption process.

### Benefits

By implementing cryptography options in your cache configuration, you add an essential layer of security to your application. Encrypting cache data with a secret key ensures that even if the cache is accessed by unauthorized users, the data remains protected and unreadable.

Using `AES` encryption under the hood provides a reliable and widely recognized standard for data security. This allows you to focus on building your application without worrying about potential vulnerabilities in your cache management.

Incorporating cryptographic measures through `CacheCryptographyOptions` in Flutter Auto Cache guarantees that your cached data is secure, maintaining user trust and compliance with security best practices.

## Data Cache
`Flutter Auto Cache ` provides specific configuration options for managing raw data types such as strings, integers, JSON objects, and more. The `DataCacheOptions` class allows you to customize how your cache handles data substitution and invalidation, providing flexibility and control over your cache management strategy. </br>

The `DataCacheOptions` class enables you to define the substitution policy and invalidation method for your cache. This ensures that your cache operates efficiently, replacing old or less important data as needed and invalidating data based on your specified criteria. </br>

To create data cache options, you need to define a `DataCacheOptions` object with your desired substitution policy and invalidation method. If no values are provided, it defaults to using `FIFO` *(First In, First Out)* for substitution and `TTL` *(Time-To-Live)* for invalidation.

Here's an example of how to define and use data cache options:

```dart
import 'package:flutter_auto_cache/flutter_auto_cache.dart';

Future<void> main() async {
  final dataCacheOptions = DataCacheOptions(
    substitutionPolicy: SubstitutionPolicies.random,
    invalidationMethod: TTLInvalidationMethod(duration: Duration(days: 1)), // Invalidate after 1 day
  );

  final config = CacheConfiguration(dataCacheOptions: dataCacheOptions);

  await AutoCacheInitializer.init(configuration: config);

  runApp(MyApp());
}
```

### Invalidation Methods
Currently, the primary invalidation method available is `TTL` *(Time-To-Live)*. This method ensures that cache data is automatically invalidated after a specified duration, helping maintain the relevance and freshness of the cached information. The `TTL` *(Time-To-Live)* invalidation method allows you to specify a duration after which the cached data will be considered invalid and removed from the cache. This is particularly useful for applications where data needs to be periodically refreshed to stay current.

### Substitution Methods
`Flutter Auto Cache` provides several substitution methods to manage how cached data is replaced when the cache reaches its size limit. These methods ensure that the cache remains efficient by replacing old or less important data with new data. Currently, `Flutter Auto Cache` supports two primary substitution methods: `FIFO` *(First In, First Out)* and `Rnadom`.
mail.luizgasparetto.devpop.hostinger.com
#### FIFO (First In, First Out)

The `FIFO` *(First In, First Out)* substitution method is a straightforward and widely used strategy. It ensures that the oldest data in the cache is replaced first when new data needs to be added. This method is ideal for applications where the chronological order of data entry is important and where older data is less likely to be needed.

**Key Characteristics:** </br>
    • **Order-based Replacement**: Replaces the oldest data entries first. </br>
    • **Predictability**: Provides a predictable replacement pattern, making it easy to understand and manage. </br>
    • **Simplicity**: Simple to implement and suitable for many common use cases.

#### LRU (Least Recently Used)
The Least Recently Used (LRU) substitution method replaces the least recently used data in the cache first. This method prioritizes keeping frequently accessed data in the cache, making it useful for applications where recent data usage is a good indicator of future data usage.

**Key Characteristics:** </br>
    • **Usage-Based Replacement**: Data that has not been accessed for the longest time is replaced first.</br>
    • **Efficient for Temporal Locality**: Works well in scenarios where recently accessed data is likely to be accessed again soon.</br>
    • **Managed Cache Size**: Helps in managing the cache size by regularly evicting older, less frequently accessed data.

#### MRU (Most Recently Used )
The Most Recently Used (MRU) substitution method replaces the most recently used data in the cache first. This method is the opposite of LRU and is beneficial in scenarios where data accessed recently is less likely to be accessed again soon.

**Key Characteristics:** </br>
    • **Inverse Usage-Based Replacement**: Data that has been accessed most recently is replaced first.</br>
    • **Efficient for Certain Patterns**: Suitable for workloads where recently accessed data is less important than older data.</br>
    • **Cache Turnover**: Ensures frequent turnover of cached data, which can be beneficial for specific use cases.

#### Random
The `Random` substitution method replaces data in the cache randomly, without considering the age or usage frequency of the data. This method can be useful in scenarios where there is no specific preference for which data should be replaced, or where a uniform distribution of data replacement is desired.

**Key Characteristics:** </br>
    • **Unpredictable Replacement**: Data entries are replaced at random, leading to an unpredictable replacement.</br>
    • **Versatility**: Suitable for use cases where no particular order or pattern is required for data replacement.</br>
    • **Uniform Distribution**: Ensures that all data entries have an equal chance of being replaced, which can be beneficial in certain applications. 

### Benefits

By configuring data cache options, you can optimize how your cache handles different data types, ensuring efficient storage and retrieval. Customizing the substitution policy allows you to manage cache replacement based on your application's usage patterns.

Similarly, setting a custom invalidation method helps you control the lifespan of cached data, ensuring that outdated or irrelevant data is removed in a timely manner. This can improve the performance of your application by maintaining a clean and relevant cache.

Implementing `DataCacheOptions` in Flutter Auto Cache provides a robust mechanism for managing raw data within your cache, offering flexibility and efficiency tailored to your specific needs.

# Usage
`Flutter Auto Cache` provides a straightforward approach to managing cached data in your Flutter applications. Currently, the primary feature available is the **data section**, which focuses on handling raw data types such as integers, strings, and JSON objects. By accessing the `AutoCache` instance, you can efficiently use its methods to store and retrieve these data types, ensuring effective cache management.

Here's an example of how to use Flutter Auto Cache within a simple counter store:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_auto_cache/flutter_auto_cache.dart';

class CounterStore extends ValueNotifier<int> {
  CounterStore() : super(0);

  Future<void> getCount() async {
    final response = await AutoCache.data.getInt(key: CacheConstants.countKey);
    value = response.data ?? 0;
  }

  Future<void> increment() => _updateCount(() => value += 1);

  Future<void> decrement() => _updateCount(() => value -= 1);

  Future<void> _updateCount(VoidCallback action) async {
    action.call();
    await AutoCache.data.saveInt(key: CacheConstants.countKey, data: value);
  }
}
```

## Available Methods

### Query Methods
These methods allow you to retrieve cached values in different data types:

   • `getString`: Retrieves a string value from the cache for the given key.</br>
   • `getInt`: Retrieves an integer value from the cache for the given key.</br>
   • `getJson`: Retrieves a JSON map from the cache for the given key.</br>
   • `getStringList`: Retrieves a list of strings from the cache for the given key.</br>
   • `getJsonList`: Retrieves a list of JSON maps from the cache for the given key.

### Command Methods
These methods allow you to modify the content of the cache with specific keys:

   • `saveString`: Saves a string value in the cache with the specified key.</br>
   • `saveInt`: Saves an integer value in the cache with the specified key.</br>
   • `saveJson`: Saves a JSON map in the cache with the specified key.</br>
   • `saveStringList`: Saves a list of strings in the cache with the specified key.</br>
   • `saveJsonList`: Saves a list of JSON maps in the cache with the specified key.</br>
   • `delete`: Deletes the cache entry for the specified key.</br>
   • `clear`: Clears all entries from the cache.

