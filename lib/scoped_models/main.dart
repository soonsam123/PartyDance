import 'package:scoped_model/scoped_model.dart';

import './connected_events.dart';

class MainModel extends Model with ConnectedEvents, EventModel, UserModel, UtilityModel {}