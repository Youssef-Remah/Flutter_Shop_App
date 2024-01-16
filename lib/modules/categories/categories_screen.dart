import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state) {  },
      builder: (BuildContext context, ShopStates state) {

        ShopCubit cubit = ShopCubit.get(context);

        return ListView.separated(
          itemBuilder: (BuildContext context, int index) => buildCatItem(cubit.categoriesModel.data!.data[index]),
          separatorBuilder: (BuildContext context, int index) => const Divider(),
          itemCount: cubit.categoriesModel.data!.data.length,
        );
      },
    );
  }

  Widget buildCatItem(DataModel model)
  {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:
        [
          Image(
            image: NetworkImage('${model.image}'),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),

          const SizedBox(width: 20.0,),

          Text(
            '${model.name}',
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const Spacer(),

          const Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
