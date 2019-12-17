# find_firebase_app_id plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-find_firebase_app_id)

## Getting Started

This project is a [_fastlane_](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-find_firebase_app_id`, add it to your project by running:

```bash
fastlane add_plugin find_firebase_app_id
```

## About find_firebase_app_id

Based on platform (ios or android) the plugin will search and find Firebase App ID from the GoogleService-Info.plist [iOS] or google-services.json [Android] files.

This plugin can be used when you are using same lane for distributing more than one apps. In this case the Firebase App IDs are not static and you require to find it from firebase configuration file to pass value to `firebase_app_distribution` plugin.

**Note to Android:** For Android platform it is required to provide `app_identifier`.

## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running 

```
bundle exec fastlane install_plugins
``` 

and 

```
bundle exec fastlane ios test
```

for iOS platform

```
bundle exec faslane android test
```

for Android.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://docs.fastlane.tools/plugins/plugins-troubleshooting/) guide.

## Using _fastlane_ Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://docs.fastlane.tools/plugins/create-plugin/).

## About _fastlane_

_fastlane_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).

## Author

Tigran Hambardzumyan, tigran@stdevmail.com

## Support

Feel free to [open issuses](https://github.com/stdevteam/fastlane-plugin-find_firebase_app_id/issues/new) with any suggestions, bug reports, feature requests, questions.

## Let us know!

We’d be really happy if you sent us links to your projects where you use our component. Just send an email to developer@stdevmail.com and do let us know if you have any questions or suggestion.

## License

The plugin is available under the MIT license. See the [LICENSE](./LICENSE) file for more info.