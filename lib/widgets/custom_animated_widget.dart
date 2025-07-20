import 'package:flutter/material.dart';
import 'package:multi_creen_flutter_app/widgets/custom_button.dart';

class CustomAnimatedWidget extends StatelessWidget {
  const CustomAnimatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 250,
        width: 280,
        child: Card(
          color: Colors.blueGrey[700],
          elevation: 5,
          child: Column(
            children: [
              SizedBox(height: 32),
              TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(seconds: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.scale(scale: value, child: child),
                  );
                },
                child: Icon(Icons.edit_note, size: 65, color: Colors.white),
              ),
              SizedBox(height: 32),
              TweenAnimationBuilder(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: Duration(seconds: 1),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.scale(scale: value, child: child),
                  );
                },
                child: Text(
                  "Welcome to my App",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 32),
              CustomButton(),
            ],
          ),
        ),
      ),
    );
  }
}
