import 'package:base_app/redux/actions.dart';
import 'package:base_app/model.dart';

// We create the State reducer by combining many smaller reducers into one!
AppState appReducer(AppState state, action) {
  return AppState(
    isOffline: connectionReducer(state.isOffline, action)
  );
}

bool connectionReducer(bool isOffline, dynamic action) {
  if (action is ChangedConnectionAction) {
    return action.isOffline;
  }
  return isOffline;
}