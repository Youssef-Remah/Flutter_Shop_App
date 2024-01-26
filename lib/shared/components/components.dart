import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

void showFlutterToast({
  required context,
  required String text,
  required ToastStates state,
})
{

  showToast(
    text,
    borderRadius: BorderRadius.circular(10.0),
    context: context,
    animation: StyledToastAnimation.slideFromBottom,
    reverseAnimation: StyledToastAnimation.slideToBottom,
    position: StyledToastPosition.bottom,
    duration: const Duration(seconds: 5),
    animDuration: const Duration(milliseconds: 250),
    backgroundColor: chooseToastState(state: state),
    textStyle: const TextStyle(fontSize: 16.0, color: Colors.white),
  );



}

enum ToastStates {SUCCESS, ERROR, WARNING}

Color chooseToastState({
  required ToastStates state,
})
{

  Color color;

  switch(state)
  {

    case ToastStates.SUCCESS:
      color = Colors.green;
      break;

    case ToastStates.ERROR:
      color = Colors.red;
      break;

    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value){
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute (builder: (BuildContext context) => const ShopLoginScreen()),
            (route) => false
    );
  });
}

Widget buildListProduct(model, context, {bool isOldPrice = true,})
{
  ShopCubit cubit = ShopCubit.get(context);

  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: SizedBox(
      height: 120.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: 120.0,
                height: 120.0,
              ),
              if(model.discount != 0 && isOldPrice)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 5.0,),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8.0,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14.0,
                    height: 1.3,
                  ),
                ),

                const Spacer(),

                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 5.0,),
                    if(model.discount != 0 && isOldPrice)
                      Text(
                        '${model.oldPrice}',
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    const Spacer(),
                    IconButton(
                      onPressed: (){
                        cubit.changeFavorites(model.id!);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: (cubit.favorites[model.id] != null && cubit.favorites[model.id] == true)?Colors.blue:Colors.grey,
                        child: const Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}