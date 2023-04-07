import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryTile extends StatelessWidget {
  final Color backgroundColor;
  final SvgPicture icon;
  final Function onSelect;
  final Function? onClose;
  final Widget child;

  const CategoryTile({
    super.key,
    required this.backgroundColor,
    required this.icon,
    required this.onSelect,
    this.onClose,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () => onSelect(context),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
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
                          child: IconButton(
                            onPressed: () => onClose!(),
                            icon: const Icon(
                              Icons.clear,
                              size: 28,
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
