import 'package:dating_made_better/global_store.dart';
import 'package:dating_made_better/providers/first_screen_state_providers.dart';
import 'package:dating_made_better/utils/general.dart';

ScreenMode getScreenMode() {
  bool userIsEmpty = isNullEmptyOrFalse(AppConstants.user);
  if (userIsEmpty) {
    return ScreenMode.landing;
  } else if (isNullEmptyOrFalse(AppConstants.user["name"])) {
    return ScreenMode.nameInput;
  } else if (isNullEmptyOrFalse(AppConstants.user["dob"])) {
    return ScreenMode.ageInput;
  } else if (isNullEmptyOrFalse(AppConstants.user['gender'])) {
    return ScreenMode.genderInput;
  } else if (isNullEmptyOrFalse(AppConstants.user['photos'])) {
    return ScreenMode.photoAdditionInput;
  } else if (isNullEmptyOrFalse(AppConstants.user['conversation_starter'])) {
    return ScreenMode.promptAdditionInput;
  } else {
    return ScreenMode.swipingScreen;
  }
}
