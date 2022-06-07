# Bottom Bar

Bottom bar helps create an optimized bottom navigation bar with beautiful animations.

![Bottom Bar](https://raw.githubusercontent.com/CoderUni/bottom_bar/main/assets/preview.gif)

# Content

- [Installation](#installation)
- [Parameters](#parameters)
- [Take Note](#take-note)
- [FAQ](#faq)
- [Community Support](#community-support)

# Installation
Add `bottom_bar` to pubspec.yaml
```yaml
dependencies:
  bottom_bar: ^2.0.1
```

# Breaking Changes
- `darkActiveColor` is removed to simplify the api. Instead, use [PlatformBrightness](https://stackoverflow.com/a/56307575) to check dark mode and adjust the color accordingly

# Parameters

## BottomBar
#### Creates a `BottomBar` that displays a list of [BottomBarItem](#BottomBarItem)

### Required:
-  selectedIndex - Index of selected item
-  items - List of [BottomBarItem](#BottomBarItem) to display
-  onTap - Fires when a [BottomBarItem](#BottomBarItem) is tapped

### Optional:
-  backgroundColor - Background Color of `BottomBar`
-  height - Height of `BottomBar`
-  padding - Padding of `BottomBar` container
-  curve - `Curve` of animation
-  duration - `Duration` of animation
-  border - Border of [BottomBarItem](#BottomBarItem)'s background color
-  itemPadding - `Padding` of [BottomBarItem](#BottomBarItem)'s background color
-  textStyle - `TextStyle` of title widget
-  showActiveBackgroundColor - Shows the background color of a selected [BottomBarItem](#BottomBarItem) if set to true

 
## BottomBarItem
#### Contains information about the item that [BottomBar](#BottomBar) has to display

### Required:
-  icon - `Icon` of `BottomBarItem`
-  title - Title of `BottomBarItem` (Typically a Text widget)
-  activeColor - Primary color of a selected `BottomBarItem`

### Optional:
-  activeIconColor - Icon color of a selected `BottomBarItem`
-  activeTitleColor - Text color of a selected `BottomBarItem`
-  backgroundColorOpacity - Opacity of a selected `BottomBarItem` background color (Defaults to 15%)
-  inactiveIcon- Icon to display when `BottomBarItem` is not active
-  inactiveColor - Primary color of `BottomBarItem` when it is **NOT** selected

# Usage

## Import the Package
```dart
import 'package:bottom_bar/bottom_bar.dart';
```

## Example
```dart
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          Container(color: Colors.blue),
          Container(color: Colors.red),
          Container(color: Colors.greenAccent.shade700),
          Container(color: Colors.orange),
        ],
        onPageChanged: (index) {
          // Use a better state management solution
          // setState is used for simplicity
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: Colors.blue,
          ),
          BottomBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
            activeColor: Colors.red,
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
            activeColor: Colors.greenAccent.shade700,
          ),
          BottomBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
            activeColor: Colors.orange,
          ),
        ],
      ),
    );
  }
```

# FAQ
### My phone's notch is overlapping with BottomBar. How do I fix this?
- Simply wrap BottomBar with a SafeArea widget.

### How do I change the overall color of BottomBarItem when in dark mode?
- You can use [PlatformBrightness](https://stackoverflow.com/a/56307575) to check dark mode and adjust the color accordingly.
```dart
  @override
  Widget build(BuildContext context) {
    bool isDarkMode = MediaQuery.of(context).platformBrightness == Brightness.dark;

    BottomBarItem(
      activeColor: isDarkMode ? Colors.orange : Colors.blue, // Is dark mode true? (Yes -> Colors.orange | No -> Colors.blue)
    ),
  }
```

# Community Support

If you have any suggestions or issues, feel free to open an [issue](https://github.com/CoderUni/bottom_bar/issues)

If you would like to contribute, feel free to create a [PR](https://github.com/CoderUni/bottom_bar/pulls)