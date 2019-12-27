import 'package:today_do/bloc/base.dart';
import 'package:today_do/model/user.dart';


class HomeBLoC with BaseBLoC<UserModel, void> {

  HomeBLoC() {
    var userStream = repository.listenUserState().map((firebseUser) => UserModel(firebseUser));
    
    controller.addStream(userStream);
  }

  void signin({bool isAnonymous = true}) {
    if (isAnonymous) repository.signinAnonymously();
  }
}