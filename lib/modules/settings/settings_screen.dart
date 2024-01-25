import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/constants.dart';


class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (BuildContext context, ShopStates state)
      {

      },
      builder: (BuildContext context, ShopStates state)
      {
        if(ShopCubit.get(context).isUserDataReceived)
        {
          var model = ShopCubit.get(context).userModel;

          nameController.text = model.data!.name;
          emailController.text = model.data!.email;
          phoneController.text = model.data!.phone;
        }

        return ConditionalBuilder(
          condition: ShopCubit.get(context).isUserDataReceived,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children:
                [
                  if(state is ShopLoadingUpdateUserState)
                    const LinearProgressIndicator(),

                  const SizedBox(height: 20.0,),

                  TextFormField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Name',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (String? nameValue)
                    {
                      if(nameValue == null || nameValue.isEmpty)
                      {
                        return 'name must not be empty';
                      }
                      else
                      {
                        return null;
                      }
                    },

                  ),

                  const SizedBox(height: 20.0,),

                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Email Address',
                      prefixIcon: const Icon(Icons.email),
                    ),
                    validator: (String? emailValue)
                    {
                      if(emailValue == null || emailValue.isEmpty)
                      {
                        return 'email must not be empty';
                      }
                      else
                      {
                        return null;
                      }
                    },

                  ),

                  const SizedBox(height: 20.0,),

                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      labelText: 'Phone',
                      prefixIcon: const Icon(Icons.phone),
                    ),
                    validator: (String? phoneValue)
                    {
                      if(phoneValue == null || phoneValue.isEmpty)
                      {
                        return 'phone must not be empty';
                      }
                      else
                      {
                        return null;
                      }
                    },

                  ),

                  const SizedBox(height: 20.0,),

                  ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState?.validate() != null)
                      {
                        ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                        );
                      }
                    },
                    child: const Text(
                      'Update',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0,),

                  ElevatedButton(
                    onPressed: (){
                      if(formKey.currentState?.validate() != null)
                      {
                        signOut(context);
                      }
                    },
                    child: const Text(
                      'SIGN OUT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          fallback: (context) => const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }
}
