## hire_me

Find your dream job using hire_me.

## Features

- Showcase for `material`, `cupertino`, and other widgets
- [Adaptive layout](lib/layout/adaptive.dart) for mobile and desktop
- State restoration support
- Settings to text scaling, text direction, locale, theme, and more...
- Demo for `animations`
- Foldable support and demo for `dual_screen`
- Deferred loading
- CI/CD
- ...and much more!

## Running

One can run hire_me locally for any of these platforms. For desktop platforms,
please see the [Flutter docs](https://docs.flutter.dev/desktop) for the latest
requirements.

```bash
cd Hire-Me/
flutter pub get
flutter run
```

<details>
<summary>Troubleshooting</summary>

### Flutter `master` channel

Hire-Me targets Flutter's `master` channel. As such, it can take advantage
of new SDK features that haven't landed in the stable channel.

If you'd like to run the Hire-Me, you may have to switch to the `master` channel
first:

```bash
flutter channel master
flutter upgrade
```

When you're done, use this command to return to the safety of the `stable`
channel:

```bash
flutter channel stable
flutter upgrade
```

</details>
