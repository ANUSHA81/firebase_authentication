import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  

  AnimationController _controller;
  Animation<Size> _myAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        _controller.repeat(reverse: true);
      }
    });

    _myAnimation = Tween<Size>(
        begin: Size(100, 100),
        end:  Size(200, 200)
    ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.bounceIn)
    );
     _controller.forward();

     }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        centerTitle: true,
      ),

      body: Center(
          child:
          AnimatedBuilder(animation: _myAnimation,
              builder: (ctx, ch) =>  Container(
                width: _myAnimation.value.width+100,
                height: _myAnimation.value.height+100,

                decoration: BoxDecoration(
                    image: new DecorationImage(
                        image: new AssetImage(
                          'assets/welcome.jpg',
                        )
                    )
                ),
              )
          )
      ),
    );
  }
}