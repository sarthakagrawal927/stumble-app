import 'package:dating_made_better/app_colors.dart';
import 'package:dating_made_better/constants.dart';
import 'package:dating_made_better/text_styles.dart';
import 'package:dating_made_better/widgets/dropdown_options_constants.dart';
import 'package:flutter/material.dart';

class MenuDropdown extends StatefulWidget {
  final Icon menuIcon;
  final List<DropdownOptionParams> menuOptions;

  const MenuDropdown(this.menuIcon, this.menuOptions, {super.key});

  @override
  State<MenuDropdown> createState() => _MenuDropdownState();
}

class _MenuDropdownState extends State<MenuDropdown> {
  List<DropdownOptionParams> get menuOptions => widget.menuOptions;
  Icon get menuIcon => widget.menuIcon;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
        key: UniqueKey(),
        builder:
            (BuildContext context, MenuController controller, Widget? child) {
          return IconButton(
            onPressed: () {
              if (controller.isOpen) {
                controller.close();
              } else {
                controller.open();
              }
            },
            icon: menuIcon,
            iconSize: marginWidth16(context),
          );
        },
        style: const MenuStyle(
          elevation: MaterialStatePropertyAll(0),
          shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
        menuChildren: menuOptions
            .map((e) => MenuItemButton(
                  onPressed: e.onClick,
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              vertical: 3, horizontal: 16)),
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.backgroundColor)),
                  child: Row(
                    children: [
                      e.icon != null
                          ? Icon(e.icon, color: AppColors.primaryColor)
                          : Container(),
                      SizedBox(width: e.icon == null ? 0 : 8),
                      Text(e.value, style: AppTextStyles.dropdownText(context)),
                    ],
                  ),
                ))
            .toList());
  }
}
