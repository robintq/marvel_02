import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class FavouritesButton extends StatefulWidget {
  /// The function to call when the icon button is pressed.
  final VoidCallback onPressed;

  /// Number of items as favroties. When this is `0`, no badge will be shown.
  final int itemCount;

  final Color badgeColor;

  final Color badgeTextColor;

  FavouritesButton({
    Key key,
    @required this.itemCount,
    this.onPressed,
    this.badgeColor: Colors.red,
    this.badgeTextColor: Colors.white,
  })  : assert(itemCount >= 0),
        assert(badgeColor != null),
        assert(badgeTextColor != null),
        super(key: key);

  @override
  FavouritesButtonState createState() {
    return FavouritesButtonState();
  }
}

class FavouritesButtonState extends State<FavouritesButton>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  final Tween<Offset> _badgePositionTween = Tween(
    begin: const Offset(-0.5, 0.9),
    end: const Offset(0.0, 0.0),
  );

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Stack(
          overflow: Overflow.visible,
          children: [
            Icon(Icons.star),
            Positioned(
              top: -8.0,
              right: -3.0,
              child: SlideTransition(
                position: _badgePositionTween.animate(_animation),
                child: Material(
                    type: MaterialType.circle,
                    elevation: 2.0,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        widget.itemCount.toString(),
                        style: TextStyle(
                          fontSize: 13.0,
                          color: widget.badgeTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )),
              ),
            ),
          ],
        ),
        onPressed: widget.onPressed);
  }

  @override
  void didUpdateWidget(FavouritesButton oldWidget) {
    if (widget.itemCount != oldWidget.itemCount) {
      _animationController.reset();
      _animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);
    _animationController.forward();
  }
}
