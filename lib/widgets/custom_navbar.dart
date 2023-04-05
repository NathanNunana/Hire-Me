import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int> onTap;

  const CustomBottomNavigationBar({
    super.key,
    required this.items,
    required this.onTap,
  });

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: NavigationBarPainter(
        curve: Curves.easeInOut,
        selectedIndex: _selectedIndex,
        iconCount: widget.items.length,
        controller: _animationController,
        animation: _animation,
      ),
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(widget.items.length, (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                  widget.onTap(index);
                });

                _animationController.reset();
                _animationController.forward();
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      // widget.items[index].icon as Icon,
                      color:
                          _selectedIndex == index ? Colors.white : Colors.grey,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.items[index].label.toString(),
                      style: TextStyle(
                        color: _selectedIndex == index
                            ? Colors.white
                            : Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class NavigationBarPainter extends CustomPainter {
  final double itemRadius;
  final double itemHeight;
  final int? iconCount;
  final int? selectedIndex;
  final double iconSize;
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final Animation<double>? animation;
  final AnimationController? controller;
  final Curve? curve;

  NavigationBarPainter({
    this.itemRadius = 30,
    this.itemHeight = 50,
    this.iconCount,
    this.selectedIndex,
    this.iconSize = 24,
    this.backgroundColor = Colors.grey,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.white,
    this.animation,
    this.controller,
    this.curve,
  }) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..isAntiAlias = true;
    final path = Path();

    final barWidth = size.width / iconCount!;

    path.moveTo(0, 0);
    path.lineTo(barWidth * selectedIndex!, 0);

    path.arcToPoint(
      Offset(barWidth * (selectedIndex! + 0.5), itemHeight),
      radius: Radius.circular(itemRadius),
      clockwise: false,
    );

    path.arcToPoint(
      Offset(barWidth * (selectedIndex! + 1), 0),
      radius: Radius.circular(itemRadius),
      clockwise: false,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint..color = backgroundColor);

    final circleRadius = itemRadius * animation!.value;
    final selectedCirclePaint = Paint()..color = selectedColor;
    final unselectedCirclePaint = Paint()..color = unselectedColor;

    for (var i = 0; i < iconCount!; i++) {
      final isSelected = i == selectedIndex;
      final iconColor = isSelected ? selectedColor : unselectedColor;

      final textPainter = TextPainter(
        text: TextSpan(
          text: isSelected ? 'Selected' : 'Unselected',
          style: TextStyle(color: iconColor, fontSize: 16),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      final centerX = i * barWidth + barWidth / 2;
      final centerY = itemHeight / 2;

      canvas.drawCircle(
        Offset(centerX, centerY),
        circleRadius,
        isSelected ? selectedCirclePaint : unselectedCirclePaint,
      );

      canvas.drawCircle(
        Offset(centerX, centerY),
        iconSize / 2,
        Paint()..color = iconColor,
      );

      final dx = centerX - textPainter.width / 2;
      final dy = centerY - textPainter.height / 2;

      textPainter.paint(canvas, Offset(dx, dy));
    }
  }

  @override
  bool shouldRepaint(NavigationBarPainter oldDelegate) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.animation != animation;
  }
}
