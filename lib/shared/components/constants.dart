import '../../layout/shop_app/cubit/cubit.dart';
import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cashe_helper.dart';
import 'components.dart';

void signOut (context){
  CasheHelper.removeData(key: 'token').then((value) {
    if(value){
      ShopCubit.get(context).curIndex=0;
      navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

void printFullText(String text){
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}

dynamic token='';