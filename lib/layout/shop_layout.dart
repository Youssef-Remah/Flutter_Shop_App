import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatefulWidget {
  const ShopLayout({super.key});

  @override
  State<ShopLayout> createState() => _ShopLayoutState();
}

class _ShopLayoutState extends State<ShopLayout> {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit, ShopStates>(

      listener: (BuildContext context, state) {  },

      builder: (BuildContext context, Object? state)
      {

        var cubit = ShopCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('Salla', style: TextStyle(color: Colors.black),),
            actions: 
            [
              IconButton(
                  onPressed: ()
                  {
                    Navigator.push(
                        context,
                      MaterialPageRoute (
                        builder: (BuildContext context) => const SearchScreen(),
                      ),
                    );
                  },
                  icon: Icon(Icons.search),
              )
            ],
          ),

          body: cubit.bottomNavScreens[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
              onTap: (index)
              {
                cubit.changeBottomNavIndex(index);
              },

              currentIndex: cubit.currentIndex,

              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled),
                    label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.apps),
                  label: 'Categories',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.favorite),
                  label: 'Favorites',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
              ]
          ),
        );

      },
    );
  }

}
