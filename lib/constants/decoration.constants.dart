import 'package:flutter/material.dart';

BoxDecoration kShadowPrimary = BoxDecoration(
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      spreadRadius: 4,
      offset: const Offset(0.0, 0.0),
      blurRadius: 15.0,
    ),
  ],
);
