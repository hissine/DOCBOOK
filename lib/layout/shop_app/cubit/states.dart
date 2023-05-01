import 'package:ramdan_proj/models/shop_app/change_favorites_model.dart';
import 'package:ramdan_proj/models/shop_app/profile_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataStates extends ShopStates{}

class ShopSuccessHomeDataStates extends ShopStates{}

class ShopErrorHomeDataStates extends ShopStates{
  final String error;
  ShopErrorHomeDataStates(this.error);
}

class ShopSuccessCategoriesDataStates extends ShopStates{}

class ShopErrorCategoriesDataStates extends ShopStates{
  final String error;

  ShopErrorCategoriesDataStates(this.error);
}

class ShopChangeFavoritesStates extends ShopStates{}

class ShopSuccessChangeFavoritesStates extends ShopStates{
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesStates(this.model);

}

class ShopErrorChangeFavoritesStates extends ShopStates{
  final String error;

  ShopErrorChangeFavoritesStates(this.error);
}

class ShopLoadingGetFavoriteState extends ShopStates{}

class ShopSuccessGetFavoriteState extends ShopStates{}

class ShopErrorGetFavoriteState extends ShopStates{}

class ShopLoadingUserDataStates extends ShopStates{}

class ShopSuccessUserDataStates extends ShopStates{
  final ProfileModel profileModel;

  ShopSuccessUserDataStates(this.profileModel);
}

class ShopErrorUserDataStates extends ShopStates{
  final String error;

  ShopErrorUserDataStates(this.error);

}
class ShopLoadingUpdateUserStates extends ShopStates{}

class ShopSuccessUpdateUserStates extends ShopStates{
  final ProfileModel profileModel;

  ShopSuccessUpdateUserStates(this.profileModel);
}

class ShopErrorUpdateUserStates extends ShopStates{
  final String error;

  ShopErrorUpdateUserStates(this.error);
}