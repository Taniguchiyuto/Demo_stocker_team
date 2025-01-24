import 'package:flutter_riverpod/flutter_riverpod.dart';
import './ViewModel/MyHomePage/my_home_state.dart';
import './Model/firestore/firestore_model.dart';
import './ViewModel/MyHomePage/MyHomePage.dart';
import './View/MyHomePage/MyHomePage.dart';

final myHomeProvider = StateNotifierProvider<MyHomeViewModel, MyHomeState>(
  (ref) => MyHomeViewModel(),
);
