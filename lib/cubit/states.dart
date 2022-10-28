abstract class AppStates {}

class AppInitialState extends AppStates{}
class AppBottomNavBarChangeState extends AppStates{}
class AppIconChangeChangeState extends AppStates{}
class AppBottomSheetChangeState extends AppStates{}

class AppCreateDataBaseState extends AppStates{}
class AppInsertIntoDataBaseState extends AppStates{}
class AppGetFromDataBaseState extends AppStates{}
class AppDeleteFromDataBaseState extends AppStates{}
class AppSaveState extends AppStates{}