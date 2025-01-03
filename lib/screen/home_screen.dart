import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:konser/model/event_model.dart';
import 'package:konser/screen/menu_screen.dart';
import 'package:konser/utils/app_colors.dart';
import 'package:konser/widget/event_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final List<EventModel> _eventItems = [
    EventModel(
      image: 'images/vol3.jpg',
      title: 'CRSL CONCERT Vol 4',
      time: '13:30',
      date: '02/11/2024',
      location: 'Std.Kridosono,Jogja',
    ),
    EventModel(
      image: 'images/vol4.jpg',
      title: 'BIGBANG JAKARTA',
      time: '15:30',
      date: '21/12/2024',
      location: 'JIExpo Kemayoran',
    ),
  ];

  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;
  late Animation<Offset> _slideUpAnimation;
  late Animation<double> _buttonOpacityAnimation;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();
    super.initState();

    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _slideUpAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.3), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _buttonOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.7, curve: Curves.easeIn),
      ),
    );

    _buttonScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 0.8, curve: Curves.elasticOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeTransition(
                opacity: _fadeInAnimation,
                child: SlideTransition(
                  position: _slideUpAnimation,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Hello!',
                          style: GoogleFonts.ibmPlexMono(
                            color: purple,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                          children: [
                            TextSpan(
                              text: ' People',
                              style: GoogleFonts.ibmPlexMono(
                                color: pink,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const MenuScreen(),
                            ),
                          );
                        },
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          child: Container(
                            height: 53,
                            width: 53,
                            decoration: const BoxDecoration(
                              color: green,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: pink,
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(1.5, 3),
                                ),
                                BoxShadow(
                                  color: yellow,
                                  spreadRadius: 0,
                                  blurRadius: 0,
                                  offset: Offset(1.5, 1.5),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '?',
                                style: GoogleFonts.jotiOne(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                  color: black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FadeTransition(
                opacity: _buttonOpacityAnimation,
                child: ScaleTransition(
                  scale: _buttonScaleAnimation,
                  child: Container(
                    height: 56,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: black,
                      ),
                      boxShadow: const [
                        BoxShadow(
                          color: pink,
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: Offset(1.5, 3),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          CupertinoIcons.search,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Event',
                style: GoogleFonts.jotiOne(
                  fontWeight: FontWeight.w300,
                  fontSize: 20,
                  color: black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _eventItems.length,
                  itemBuilder: (context, index) {
                    final animationDelay = 0.2 * index;
                    final itemController = AnimationController(
                      vsync: this,
                      duration: const Duration(seconds: 2),
                    )..forward();

                    final fadeInAnimation = CurvedAnimation(
                      parent: itemController,
                      curve: Interval(
                        animationDelay,
                        1.0,
                        curve: Curves.easeIn,
                      ),
                    );

                    final slideUpAnimation = Tween<Offset>(
                      begin: const Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: itemController,
                        curve: Interval(animationDelay, 1.0,
                            curve: Curves.easeOut),
                      ),
                    );
                    return FadeTransition(
                      opacity: fadeInAnimation,
                      child: SlideTransition(
                        position: slideUpAnimation,
                        child: EventContainer(
                          image: _eventItems[index].image,
                          title: _eventItems[index].title,
                          time: _eventItems[index].time,
                          date: _eventItems[index].date,
                          location: _eventItems[index].location,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
