import 'package:scoped_model/scoped_model.dart';

import './event.dart';
import './user.dart';

class MainModel extends Model with EventModel, UserModel {}