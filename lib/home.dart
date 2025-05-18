import 'package:flutter/material.dart';
import 'welcome.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> with TickerProviderStateMixin {
  late AnimationController _titleController;
  late AnimationController _textController;
  late Animation<double> _titleOpacity;
  late Animation<Offset> _titleOffset;
  late Animation<int> _textLengthAnimation;
  late AnimationController _logoController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoOpacityAnimation;

  final String _splashText =
      "Where every step becomes a story, every breeze a memory — capture your travels with heart, sky, and soul.";

  @override
  void initState() {
    super.initState();

    // Title animation setup
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeInOut),
    );

    _titleOffset = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _titleController, curve: Curves.easeOut));

    // Text animation setup
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );

    _textLengthAnimation = IntTween(
      begin: 0,
      end: _splashText.length,
    ).animate(_textController);

    // Logo animation setup
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _logoScaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.5,
    ).chain(CurveTween(curve: Curves.elasticOut)).animate(_logoController);

    _logoOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeIn));

    // Animation sequence
    _titleController.forward().then((_) => _textController.forward());

    // Modified navigation logic
    _textController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _logoController.forward().then((_) {
          Future.delayed(const Duration(milliseconds: 2000), () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder:
                    (context, animation, secondaryAnimation) => welcome(),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
                  return FadeTransition(opacity: animation, child: child);
                },
                transitionDuration: const Duration(milliseconds: 1000),
              ),
            );
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _textController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              child: Image(
                image: AssetImage('asset/images/road-8284023_1280.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _titleController,
              builder: (context, child) {
                return Opacity(
                  opacity: _titleOpacity.value,
                  child: Transform.translate(
                    offset: _titleOffset.value * 50,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome to',
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                color: Colors.black54,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'WanderLog',
                          style: TextStyle(
                            fontSize: 60,
                            color: Colors.amber[300],
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                color: Colors.black87,
                                offset: Offset(3, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 70,
            left: 0,
            right: 0,
            child: AnimatedBuilder(
              animation: _textController,
              builder: (context, child) {
                return Opacity(
                  opacity: _textController.value,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      _splashText.substring(0, _textLengthAnimation.value),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.amber[50],
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            color: Colors.black87,
                            offset: Offset(2, 2),
                            blurRadius: 8,
                          ),
                          Shadow(
                            color: Colors.black54,
                            offset: Offset(1, 1),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _logoController,
              builder: (context, child) {
                return Opacity(
                  opacity: _logoOpacityAnimation.value,
                  child: Transform.scale(
                    scale: _logoScaleAnimation.value,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 20,
                            spreadRadius: 5,
                            offset: Offset(0, 5),
                          ),
                        ],
                        gradient: RadialGradient(
                          colors: [
                            Colors.amber.withOpacity(0.2),
                            Colors.transparent,
                          ],
                          stops: [0.7, 1.0],
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image(
                          image: AssetImage('asset/images/image(3).jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
