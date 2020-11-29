# Cracker Mobile in Flutter

Big thanks to :octocat: [mmBs](https://github.com/mmBs) for time and advice. :clap:

[Windows installation instructions](https://flutter.dev/docs/get-started/install/windows)
[Search engine for open source packages for Flutter](https://pub.dev/)

## Getting Started

Before running the app you will need [Google Maps API key](https://console.cloud.google.com/apis/credentials).
After you get it, go to `android` directory and find the autogenerated `local.properties` file.
Add a new line with your API key in a format like this `google.mapsApiKey=YOUR_API_KEY`.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Packages:

- `flutter_appauth` - a well-maintained wrapper package around AppAuth for Flutter developed by Michael Bui. AppAuth authenticates and authorizes users and supports the PKCE extension
- `flutter_secure_storage` - A library to securely persist data locally developed by German Saprykin
- `geolocator` - geolocation plugin which provides easy access to platform specific location services (FusedLocationProviderClient or if not available the LocationManager on Android and CLLocationManager on iOS)
- `google_maps_flutter` - plugin that provides a Google Maps widget
- `graphql-flutter` - a package based on Apollo GraphQL client that allows an integration with a GraphQL server in Flutter
- `http` - a composable, Future-based library for making HTTP requests published by the Dart Team

## Resources:

- [Advanced Layout Rule Even Beginners Must Know](https://medium.com/flutter-community/flutter-the-advanced-layout-rule-even-beginners-must-know-edc9516d1a2)
- [Auth0 with Flutter](https://auth0.com/blog/get-started-with-flutter-authentication/)
- [Hide your api keys from your android manifest file with Flutter using local.properties](https://dev.to/stevenosse/hide-your-api-keys-from-your-android-manifest-file-with-flutter-using-local-properties-3f4e)
- [Widget lifecycle in Flutter](https://stackoverflow.com/questions/41479255/life-cycle-in-flutter)
