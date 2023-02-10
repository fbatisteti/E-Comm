import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomm/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CarouselImage extends StatefulWidget {
  const CarouselImage({ Key? key }) : super(key: key);

  @override
  State<CarouselImage> createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  final CarouselController _carouselController = CarouselController();
  Timer? timer;

  void nextSlide() { _carouselController.nextPage(); }

  void stopTimer() { timer?.cancel(); }
  void startTimer() {timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => nextSlide());}

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => nextSlide());
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }
  
  @override
  Widget build(BuildContext context){
    return kIsWeb
    ? MouseRegion(
      onHover: (_) => stopTimer(),
      onExit: (_) => startTimer(),
      child: CarouselSlider(
        items: GlobalVariables.carouselImages.map(
            (i) {
            return Builder(
              builder: (BuildContext context) => Image.network(
                i,
                fit: BoxFit.fitWidth,
                alignment: Alignment.center,
                height: 200,
              ),
            );
          }).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
        ),
        carouselController: _carouselController,
      ),
    )
    : GestureDetector(
      onLongPressStart: (_) => stopTimer(),
      child: CarouselSlider(
        items: GlobalVariables.carouselImages.map(
            (i) {
            return Builder(
              builder: (BuildContext context) => Image.network(
                i,
                fit: BoxFit.fitHeight,
                height: 200,
              ),
            );
          }).toList(),
        options: CarouselOptions(
          viewportFraction: 1,
          height: 200,
        ),
        carouselController: _carouselController,
      ),
    );
  }    
}