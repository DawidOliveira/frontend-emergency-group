import 'package:emergency_group/app/shared/auth/auth_repository.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'app_controller.g.dart';

@Injectable()
class AppController = _AppControllerBase with _$AppController;

abstract class _AppControllerBase with Store {
  AuthRepository authRepository;
  _AppControllerBase(this.authRepository);
}
