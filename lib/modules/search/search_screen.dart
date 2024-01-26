import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/search/cubit/cubit.dart';
import 'package:shop_app/modules/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  var formKey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, SearchStates state) {  },

        builder: (BuildContext context, SearchStates state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    TextFormField(
                      controller: searchController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelText: 'Search',
                        prefixIcon: const Icon(Icons.search),
                      ),
                      validator: (String? searchValue)
                      {
                        if(searchValue == null || searchValue.isEmpty)
                        {
                          return 'Type something to search for';
                        }
                        else
                        {
                          return null;
                        }

                      },
                      onFieldSubmitted: (String text)
                      {
                        SearchCubit.get(context).search(text);
                      },
                    ),

                    SizedBox(height: 10.0,),

                    if(state is SearchLoadingState)
                      const LinearProgressIndicator(),

                    SizedBox(height: 10.0,),


                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(

                          itemBuilder: (BuildContext context, int index) => buildListProduct(
                              SearchCubit.get(context).model.data!.data![index],
                              context,
                              isOldPrice: false
                          ),

                          separatorBuilder: (BuildContext context, int index) => const Divider(),

                          itemCount: SearchCubit.get(context).model.data!.data!.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
