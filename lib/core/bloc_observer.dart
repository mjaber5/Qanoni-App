import 'dart:developer';

import 'package:bloc/bloc.dart';

class SimpleBlocOvserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);

    log(transition.toString());
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);

    log(change.toString());
  }
}
