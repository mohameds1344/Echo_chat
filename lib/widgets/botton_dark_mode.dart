import 'package:flutter/material.dart';

class BottonDarkMode extends StatelessWidget {
  const BottonDarkMode({super.key, required this.onTap, required this.isDark});

  final ValueChanged<bool> onTap;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(!isDark),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        width: 62,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            colors: isDark
                ? [Color(0xff1D2671), Color(0xff0F2027)]
                : [Color(0xff4facfe), Color(0xff00f2fe)],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            if (isDark)
              Positioned(
                top: 5,
                left: 10,
                child: Icon(Icons.star, size: 4, color: Colors.white),
              ),
            if (isDark)
              Positioned(
                top: 5,
                left: 20,
                child: Icon(Icons.star, size: 3, color: Colors.white),
              ),
            if (!isDark)
              Positioned(
                bottom: 2,
                right: 10,
                child: Icon(Icons.cloud, size: 12, color: Colors.white),
              ),
            AnimatedAlign(
              alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
              duration: Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Container(
                  width: 26,
                  height: 60,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDark ? Color(0xffD1D1D1) : Color(0xffFFD700),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 5,
                      ),
                    ],
                  ),
                  child: isDark
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                top: 5,
                                left: 4,
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 6,
                                right: 6,
                                child: Container(
                                  width: 5,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[400],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
