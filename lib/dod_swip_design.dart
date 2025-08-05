import 'package:flutter/material.dart';

class DotIntroPage extends StatefulWidget {
  @override
  _DotIntroPageState createState() => _DotIntroPageState();
}

class _DotIntroPageState extends State<DotIntroPage> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final int _numPages = 5;

  // Listen to page controller for fractional offset
  double _pageOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _pageOffset = _controller.hasClients && _controller.page != null
            ? _controller.page!
            : 0.0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Helper to compute smooth active value for dot
  double _dotScale(int index) {
    double diff = (_pageOffset - index).abs();
    // when diff is 0 -> active (scale 1.8), when >=1 -> inactive (1.0)
    return 1.0 + (1.0 - (diff.clamp(0.0, 1.0))) * 0.8;
  }

  double _dotOpacity(int index) {
    double diff = (_pageOffset - index).abs();
    return 1.0 - (diff.clamp(0.0, 1.0)) * 0.5; // active brighter
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.white, Colors.blue.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          Column(
            children: [
              const SizedBox(height: 100),
              // Smooth Dot Indicator
              // Dot Indicator
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_numPages, (idx) {
                    bool isActive = idx == _currentPage;
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      width: isActive ? 22.0 : 12.0,
                      height: isActive ? 22.0 : 12.0,
                      margin: EdgeInsets.symmetric(horizontal: 6.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: isActive
                            ? LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Color(0xFF9C27B0), // Purple
                            Color(0xFF2196F3), // Blue
                          ],
                        )
                            : null,
                        color: isActive ? null : Colors.grey.withOpacity(0.3),
                        boxShadow: isActive
                            ? [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.4),
                            blurRadius: 10.0,
                            spreadRadius: 2.0,
                            offset: Offset(0, 0),
                          ),
                        ]
                            : [],
                      ),
                    );

                  }),
                ),
              ),

              const SizedBox(height: 40),
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  physics: const BouncingScrollPhysics(),
                  itemCount: _numPages,
                  onPageChanged: (idx) {
                    setState(() => _currentPage = idx);
                  },
                  itemBuilder: (ctx, idx) {
                    // compute relative position for scale/opacity
                    double delta = (_pageOffset - idx);
                    double scale = 1 - (delta.abs() * 0.08).clamp(0.0, 0.08);
                    double opacity = 1 - (delta.abs() * 0.3).clamp(0.0, 0.3);

                    return Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        transform: Matrix4.identity()..scale(scale, scale),
                        width: 320,
                        height: 240,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFB388FF),
                              Color(0xFF8C9EFF),
                              Color(0xFF82B1FF),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.deepPurple.withOpacity(0.25),
                              blurRadius: 25,
                              spreadRadius: 4,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Opacity(
                          opacity: opacity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.auto_awesome,
                                size: 60,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Welcome to Page ${idx + 1}",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                "This is a smooth intro card with subtle scale and fade effects during swipes.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white.withOpacity(0.85),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ],
      ),
    );
  }
}
