import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryTile extends StatelessWidget {
  final Color? backgroundColor;
  final SvgPicture icon;
  final Function onSelect;
  final Function? onClose;
  final Widget child;

  const CategoryTile({
    super.key,
    this.backgroundColor,
    required this.icon,
    required this.onSelect,
    this.onClose,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: backgroundColor,
      elevation: 0,
      margin: EdgeInsets.zero,
      child: InkWell(
        splashColor: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
        onTap: () => onSelect(context),
        child: SizedBox(
          height: 70,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: icon,
                ),
                Expanded(
                  child: child,
                ),
                onClose != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: Ink(
                          padding: EdgeInsets.zero,
                          width: 38,
                          height: 38,
                          decoration: ShapeDecoration(
                            color: colorScheme.secondaryContainer,
                            shape: const CircleBorder(),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            onPressed: () => onClose!(),
                            icon: const Icon(
                              Icons.remove,
                              size: 28,
                            ),
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
