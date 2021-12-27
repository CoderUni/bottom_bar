library bottom_bar;

import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  /// Creates a `BottomBar` that displays a list of `BottomBarItem` along with
  /// added animations whenever a `BottomBarItem` is clicked
  BottomBar({
    Key? key,
    required this.selectedIndex,
    this.curve = Curves.easeOutQuint,
    this.duration = const Duration(milliseconds: 750),
    this.height,
    this.backgroundColor,
    this.showActiveBackgroundColor = true,
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    required this.items,
    required this.onTap,
    this.textStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  }) : super(key: key);

  /// Current index that is selected
  final int selectedIndex;

  /// Animation Curve of animation
  final Curve curve;

  /// Duration of the animation
  final Duration duration;

  /// Height of `BottomBar`
  final num? height;

  /// Background Color of `BottomBar`
  final Color? backgroundColor;

  /// Shows the background color of `BottomBarItem` when it is active
  /// and when this is set to true
  final bool showActiveBackgroundColor;

  /// Padding between the background color and
  /// (`Row` that contains icon and title)
  final EdgeInsets itemPadding;

  /// List of `BottomBarItems` to display
  final List<BottomBarItem> items;

  /// Fires this callback whenever a `BottomBarItem` is tapped
  ///
  /// Use this callback to update the `selectedIndex`
  final ValueChanged<int> onTap;

  /// `TextStyle` of title
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    final _brightness = Theme.of(context).brightness;

    return Container(
      height: height?.toDouble(),
      decoration: BoxDecoration(color: backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            items.length,
            (int index) {
              final _selectedColor = _brightness == Brightness.light
                  ? items[index].activeColor
                  : items[index].darkActiveColor ?? items[index].activeColor;

              final _selectedColorWithOpacity = _selectedColor.withOpacity(0.1);

              final _inactiveColor = items[index].inactiveColor ??
                  (_brightness == Brightness.light
                      ? const Color(0xFF404040)
                      : const Color(0xF2FFFFFF));

              final _rightPadding = itemPadding.right;

              return _BottomBarItemWidget(
                index: index,
                key: items.elementAt(index).key,
                isSelected: index == selectedIndex,
                selectedColor: _selectedColor,
                selectedColorWithOpacity: _selectedColorWithOpacity,
                showActiveBackgroundColor: showActiveBackgroundColor,
                inactiveColor: _inactiveColor,
                rightPadding: _rightPadding,
                curve: curve,
                duration: duration,
                itemPadding: itemPadding,
                textStyle: textStyle,
                icon: items.elementAt(index).icon,
                inactiveIcon: items.elementAt(index).inactiveIcon,
                title: items.elementAt(index).title,
                onTap: () => onTap(index),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BottomBarItemWidget extends StatelessWidget {
  /// Creates a Widget that displays the contents of a `BottomBarItem`
  const _BottomBarItemWidget({
    Key? key,
    required this.index,
    required this.isSelected,
    required this.selectedColor,
    required this.selectedColorWithOpacity,
    required this.showActiveBackgroundColor,
    required this.inactiveColor,
    required this.rightPadding,
    required this.curve,
    required this.duration,
    required this.itemPadding,
    required this.textStyle,
    required this.icon,
    this.inactiveIcon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  /// Index of `BottomBarItem`
  final int index;

  /// Indicates whether `BottomBarItem` is selected or not
  final bool isSelected;

  /// Color of `BottomBarItem` when it is selected
  final Color selectedColor;

  /// Color of Material and InkWell
  final Color selectedColorWithOpacity;

  /// Shows the background color of `BottomBarItem` when it is active
  /// and when this is set to true
  final bool showActiveBackgroundColor;

  /// Color of `BottomBarItem` when it is **NOT** selected
  final Color inactiveColor;

  /// Right padding of Row that contains icon and title
  final double rightPadding;

  /// Curve of `BottomBarItem` animation
  final Curve curve;

  /// Duration of `BottomBarItem` animation
  final Duration duration;

  /// Padding between the background color and
  /// (`Row` that contains icon and title)
  final EdgeInsets itemPadding;

  /// `TextStyle` of `BottomBarItem` Title
  final TextStyle textStyle;

  /// Icon of `BottomBarItem`
  final Widget icon;

  /// Icon to display when the `BottombarItem` is not active
  final Widget? inactiveIcon;

  /// Title of `BottomBarItem`
  final Widget title;

  /// Fires this callback whenever a `BottomBarItem` is tapped
  ///
  /// Use this callback to update the `selectedIndex`
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(
        begin: 0,
        end: isSelected ? 1 : 0,
      ),
      curve: curve,
      duration: duration,
      builder: (BuildContext context, double value, Widget? child) {
        return Material(
          color: showActiveBackgroundColor
              ? Color.lerp(
                  selectedColor.withOpacity(0),
                  selectedColorWithOpacity,
                  value,
                )
              : Colors.transparent,
          shape: const StadiumBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: const StadiumBorder(),
            focusColor: selectedColorWithOpacity,
            highlightColor: selectedColorWithOpacity,
            splashColor: selectedColorWithOpacity,
            hoverColor: selectedColorWithOpacity,
            child: Padding(
              padding:
                  itemPadding - EdgeInsets.only(right: rightPadding * value),
              child: Row(
                children: [
                  IconTheme(
                    data: IconThemeData(
                      color: Color.lerp(inactiveColor, selectedColor, value),
                      size: 24,
                    ),
                    child: isSelected ? icon : (inactiveIcon ?? icon),
                  ),
                  ClipRect(
                    child: SizedBox(
                      height: 20,
                      child: Align(
                        alignment: const Alignment(-0.2, 0),
                        widthFactor: value,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: rightPadding / 2,
                            right: rightPadding,
                          ),
                          child: DefaultTextStyle(
                            style: textStyle.copyWith(
                              color: Color.lerp(
                                  Colors.transparent, selectedColor, value),
                            ),
                            child: title,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class BottomBarItem {
  /// This contains information about the item that `BottomBar` has to display
  BottomBarItem({
    this.key,
    required this.icon,
    this.inactiveIcon,
    required this.title,
    required this.activeColor,
    this.darkActiveColor,
    this.inactiveColor,
  });

  /// Key of `BottomBarItem`.
  /// This will be the key of the specific `BottomBarItem` shown in `BottomBar`
  final Key? key;

  /// Icon of `BottomBarItem`.
  /// This will be the icon shown in each `BottomBarItem`
  final Widget icon;

  /// Icon to display when the `BottombarItem` is not active
  /// This will be the icon shown in each `BottomBarItem`
  final Widget? inactiveIcon;

  /// Title of `BottomBarItem`.
  /// This will be the shown next to the icon whenever `BottomBarItem` is
  /// selected
  final Widget title;

  /// Color of `BottomBarItem` during **light mode** when it is selected.
  /// This will be the active color of icon, title, and background
  final Color activeColor;

  /// Color of `BottomBarItem` during **dark mode** when it is selected.
  /// This will be the active color of icon, title, and background.
  final Color? darkActiveColor;

  /// Color of `BottomBarItem` while it is not selected.
  /// This will be the inactive color of icon, title, and background.
  final Color? inactiveColor;
}
