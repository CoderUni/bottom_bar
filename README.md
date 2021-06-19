# Bottom Bar

Bottom bar helps create an optimized bottom navigation bar with beautiful animations. This package is inspired by `bottom_navy_bar` and has many improvements over it:

- BottomBarItem's width is dynamic and not fixed ([Bottom_bar](https://github.com/CoderUni/bottom_bar/blob/main/assets/preview.gif) vs [bottom_navy_bar](https://github.com/pedromassango/bottom_navy_bar/blob/master/images/navy.gif))
- Dark Mode Support
- More optimized ([BottomBarItem](https://github.com/CoderUni/bottom_bar/blob/87cb7e53976e9c27c72d18a4efad2e474255cf8b/lib/bottom_bar.dart#L58) vs [BottomNavyBarItem](https://github.com/pedromassango/bottom_navy_bar/blob/2e88b51a445006d4a0a21b3f0dd22627f1a6e359/lib/bottom_navy_bar.dart#L145))
- Allows inserting keys for each `BottomBarItem` for widget testing

![Bottom Bar](https://raw.githubusercontent.com/CoderUni/bottom_bar/main/assets/preview.gif)

# Content

- [Installation](#Installation)
- [Parameters](#Parameters)
- [Take Note](#take-note)
- [Community Support](#community-support)

# Installation
Add `bottom_bar` to pubspec.yaml
```yaml
dependencies:
  bottom_bar: ^1.2.2+1
```

# Parameters

## BottomBar
#### Creates a `BottomBar` that displays a list of [BottomBarItem](###BottomBarItem)

-  `selectedIndex` - `Index` of selected item
-  `curve` - `Curve` of animation
-  `duration` - `Duration` of animation
-  `items` - List of [BottomBarItem](###BottomBarItem) to display
-  `itemPadding` - `Padding` between the background color and (`Row` that contains icon and title)
-  `onTap` - Fires whenever a `BottomBarItem` is tapped
-  `textStyle` - `TextStyle` of `title` widget (Only applied when widget is `Text`)

 
## BottomBarItem
#### Contains information about the item that [BottomBar](###BottomBar) has to display
-  `icon` - `Icon` of `BottomBarItem`
-  `title` - `Title` of `BottomBarItem`
-  `activeColor` - `Color` of `icon`, `title`, and `background` of `BottomBarItem` during **light mode** when it is selected
-  `darkActiveColor` - `Color` of `icon`, `title`, and `background` of `BottomBarItem` during **dark mode** when it is selected
-  `inactiveColor` - `Color` of `icon`, `title`, and `background` of `BottomBarItem` when it is **not** selected

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
            darkActiveColor: Colors.red.shade400, // Optional
          ),
          BottomBarItem(
            icon: Icon(Icons.person),
            title: Text('Account'),
            activeColor: Colors.greenAccent.shade700,
            darkActiveColor: Colors.greenAccent.shade400, // Optional
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

# Community Support

If you have any suggestions or issues, feel free to open an [issue](https://github.com/CoderUni/bottom_bar/issues)

If you would like to contribute, feel free to create a [PR](https://github.com/CoderUni/bottom_bar/pulls)