import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/nav_item_model.dart';
// import 'package:flutter_application_1/pages/chat_page.dart';
// import 'package:flutter_application_1/pages/home_page.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';


const Color bottomNavBgColor = Color(0xFF17203A);

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key, required this.onItemSelected});

  final ValueChanged<int> onItemSelected;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<SMIBool> riveIconInput = [];
  List<StateMachineController?> controllers = [];
  int selectedNavIndex = 0;
  // List<Widget> pages = [
  //   const ChatPage(),
  //   const SearchPage(),
  //   const TimerPage()
  //   const Nothing(),
  // ];

  void animateTheIcon(int index) {
    riveIconInput[index].change(true);
    Future.delayed(Duration(seconds: 1), () {
      riveIconInput[index].change(false);
    });
  }

  void riveOnInit(Artboard artboard, {required String stateMachineName}) {
    StateMachineController? controller =
        StateMachineController.fromArtboard(artboard, stateMachineName);

    artboard.addController(controller!);
    controllers.add(controller);

    riveIconInput.add(controller.findInput<bool>('active') as SMIBool);
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Container(
          height: 56,
          padding: const EdgeInsets.all(6),
          margin: EdgeInsets.symmetric(horizontal: 24).copyWith(bottom: 8),
          decoration: BoxDecoration(
            color: bottomNavBgColor.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: bottomNavBgColor.withOpacity(0.3),
                offset: Offset(0, 20),
                blurRadius: 20,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(bottomNavItems.length, (index) {
              final riveIcon = bottomNavItems[index].rive;
              return GestureDetector(
                onTap: () {
                  animateTheIcon(index);
                  setState(() {
                    selectedNavIndex = index;
                  });
                  widget.onItemSelected(index);
                  //Navigator.push(context, MaterialPageRoute(builder: (context) => pages[index]),);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedBar(isActive: selectedNavIndex == index),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity: selectedNavIndex == index ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          riveIcon.src,
                          artboard: riveIcon.artboard,
                          onInit: (artboard) {
                            riveOnInit(artboard,
                                stateMachineName: riveIcon.stateMachineName);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(microseconds: 200),
      margin: EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: BoxDecoration(
          color: Color(0xFF81B4FF),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}