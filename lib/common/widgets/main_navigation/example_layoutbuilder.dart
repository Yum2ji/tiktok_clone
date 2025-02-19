import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExampleLayoutbuilder extends StatelessWidget {
  const ExampleLayoutbuilder({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width/2,

        //LayoutBuilder는 얼마나 child가 커질수있는지 찾을때. father's size에 관심없이
        //LayoutBuilder 안에서 사이즈를 조절해도 constraints.maxwidth는 크게 영향안받음.
        //LayoutBuilder 윗단에서 조절해야함.
        //LayoutBuilder가 전체화면의 크기를 알려주는 건 아니라는 것(!=MediaQuery)
        
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: Colors.teal,
            child: Center(
              child: Text(
                "${size.width} /// ${constraints.maxWidth}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 98,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}