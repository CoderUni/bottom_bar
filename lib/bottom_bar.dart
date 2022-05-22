library bottom_bar;

import 'package:flutter/material.dart';

/// {@template bottom_bar}
/// Creates a `BottomBar` that displays a list of `BottomBarItem`
///
/// Animations will play once a `BottomBarItem` is clicked
/// {@endtemplate}
class BottomBar extends StatelessWidget {
  /// {@macro bottom_bar}
  const BottomBar({
    Key? key,
    required this.selectedIndex,
    this.curve = Curves.easeOutQuint,
    this.duration = const Duration(milliseconds: 750),
    this.height,
    this.backgroundColor,
    this.showActiveBackgroundColor = true,
    this.border = const StadiumBorder(),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    required this.items,
    required this.onTap,
    this.textStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  }) : super(key: key);

  /// Index of selected item
  final int selectedIndex;

  /// Curve of animation
  final Curve curve;

  /// Duration of the animation
  final Duration duration;

  /// Height of `BottomBar`
  final num? height;

  /// Background color of `BottomBar`
  final Color? backgroundColor;

  /// Shows the background color of a selected `BottomBarItem` if set to true
  final bool showActiveBackgroundColor;

  /// [ShapeBorder] of the `BottomBarItem's` background color
  final ShapeBorder border;

  /// Padding between the background color and the
  /// `Row` that contains the icon and title
  final EdgeInsets itemPadding;

  /// List of `BottomBarItems` to display
  final List<BottomBarItem> items;

  /// Fires this callback when `BottomBarItem` is tapped
  ///
  /// Use this callback to update the `selectedIndex`
  final ValueChanged<int> onTap;

  /// `TextStyle` of title
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return Container(
      height: height?.toDouble(),
      decoration: BoxDecoration(color: backgroundColor),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            items.length,
            (int index) {
              final bottomBarItem = items.elementAt(index);
              final backgroundColor = bottomBarItem.activeColor
                  .withOpacity(bottomBarItem.backgroundColorOpacity.toDouble());

              final Color activeIconColor =
                  bottomBarItem.activeIconColor ?? bottomBarItem.activeColor;
              final Color activeTitleColor =
                  bottomBarItem.activeTitleColor ?? bottomBarItem.activeColor;

              final inactiveColor = items[index].inactiveColor ??
                  (brightness == Brightness.light
                      ? Color.fromARGB(255, 80, 80, 80)
                      : const Color(0xF2FFFFFF));

              return _BottomBarItemWidget(
                index: index,
                key: items.elementAt(index).key,
                isSelected: index == selectedIndex,
                activeBackgroundColor: backgroundColor,
                activeIconColor: activeIconColor,
                activeTitleColor: activeTitleColor,
                showActiveBackgroundColor: showActiveBackgroundColor,
                border: border,
                inactiveColor: inactiveColor,
                rightPadding: itemPadding.right,
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
    required this.activeBackgroundColor,
    required this.activeIconColor,
    required this.activeTitleColor,
    required this.showActiveBackgroundColor,
    required this.border,
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

  final int index;
  final bool isSelected;
  final Color activeBackgroundColor;
  final Color? activeIconColor;
  final Color? activeTitleColor;
  final bool showActiveBackgroundColor;
  final ShapeBorder border;
  final Color inactiveColor;
  final double rightPadding;
  final Curve curve;
  final Duration duration;
  final EdgeInsets itemPadding;
  final TextStyle textStyle;
  final Widget icon;
  final Widget? inactiveIcon;
  final Widget title;
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
                  activeBackgroundColor.withOpacity(0),
                  activeBackgroundColor,
                  value,
                )
              : Colors.transparent,
          shape: border,
          child: InkWell(
            onTap: onTap,
            customBorder: border,
            focusColor: activeBackgroundColor,
            highlightColor: activeBackgroundColor,
            splashColor: activeBackgroundColor,
            hoverColor: activeBackgroundColor,
            child: Padding(
              padding:
                  itemPadding - EdgeInsets.only(right: rightPadding * value),
              child: Row(
                children: [
                  IconTheme(
                    data: IconThemeData(
                      color: Color.lerp(inactiveColor, activeIconColor, value),
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
                                Colors.transparent,
                                activeTitleColor,
                                value,
                              ),
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

/// {@template bottom_bar_item}
/// This contains information about the item that `BottomBar` has to display
/// {@endtemplate}
class BottomBarItem {
  ///{@macro bottom_bar_item}
  const BottomBarItem({
    this.key,
    required this.icon,
    this.inactiveIcon,
    required this.title,
    required this.activeColor,
    this.backgroundColorOpacity = 0.15,
    this.inactiveColor,
    this.activeIconColor,
    this.activeTitleColor,
  });

  /// Key of `BottomBarItem`
  ///
  /// This will be the key of the specific `BottomBarItem` shown in `BottomBar`.
  final Key? key;

  /// Icon of `BottomBarItem`
  ///
  /// This will be the icon shown in each `BottomBarItem`.
  final Widget icon;

  /// Icon to display when the `BottombarItem` is not active
  ///
  /// This will be the icon shown in each `BottomBarItem`.
  final Widget? inactiveIcon;

  /// Title of `BottomBarItem` (Typically a Text widget)
  ///
  /// This will be the shown next to the icon whenever `BottomBarItem` is
  /// selected.
  final Widget title;

  /// Color of `BottomBarItem` when it is selected.
  ///
  /// This will be the active color of the background
  ///
  /// This can also be the active color of the icon and title if
  /// [activeIconColor] and [activeTitleColor] are null
  final Color activeColor;

  /// Opacity of the `BottomBarItem` active color
  final num backgroundColorOpacity;

  /// Color of `BottomBarItem` while it is not selected.
  ///
  /// This will be the inactive color of icon, title, and background.
  final Color? inactiveColor;

  /// Color of a selected `BottomBarItem` icon
  final Color? activeIconColor;

  /// Color of a selected `BottomBarItem` title
  final Color? activeTitleColor;
}
