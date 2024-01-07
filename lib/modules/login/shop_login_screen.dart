import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/login/cubit.dart';
import 'package:shop_app/modules/login/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({super.key});

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return BlocProvider<ShopLoginCubit>(

      create: (BuildContext context) => ShopLoginCubit(),

      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(

        listener: (BuildContext context, ShopLoginStates state) {  },

        builder: (BuildContext context, ShopLoginStates state)
        {
          ShopLoginCubit cubit = ShopLoginCubit.get(context);

          return Scaffold(
            appBar: AppBar(),

            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        const Text(
                          'Sign In',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0,
                          ),
                        ),

                        const SizedBox(
                          height: 15.0,
                        ),

                        const Text(
                          'Sign In and Browse our Hot Offers!',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                          ),
                        ),

                        const SizedBox(
                          height: 30.0,
                        ),

                        Form(
                          key: formKey,

                          child: Column(
                            children:
                            [
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Enter your Email',
                                  prefixIcon: const Icon(Icons.email_outlined),
                                ),
                                validator: (String? emailValue)
                                {
                                  if(emailValue == null || emailValue.isEmpty)
                                  {
                                    return 'Email Address Must Not be Empty!';
                                  }
                                  else
                                  {
                                    return null;
                                  }

                                },
                              ),

                              const SizedBox(
                                height: 30.0,
                              ),

                              TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: cubit.isPasswordVisible? false : true,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    labelText: 'Enter your Password',
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                      onPressed: ()
                                      {
                                        cubit.changePasswordVisibility();
                                      },
                                      icon: Icon(cubit.isPasswordVisible? Icons.visibility_off : Icons.visibility),
                                    )
                                ),
                                validator: (String? passwordValue)
                                {
                                  if(passwordValue == null || passwordValue.isEmpty)
                                  {
                                    return 'Password is Too Short!';
                                  }
                                  else
                                  {
                                    return null;
                                  }

                                },
                              ),

                              const SizedBox(
                                height: 30.0,
                              ),

                              ConditionalBuilder(
                                condition: state is! ShopLoginLoadingState,
                                builder: (BuildContext context) => SizedBox(
                                  width: double.infinity,
                                  height: 40.0,
                                  child: ElevatedButton(
                                    onPressed: (){
                                      if(formKey.currentState?.validate() != null)
                                      {
                                        ShopLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );
                                      }
                                    },
                                    child: const Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ),
                                ),
                                fallback: (BuildContext context) => const Center(child: CircularProgressIndicator()),
                              )
                            ],
                        ),
                    ),

                        const SizedBox(
                          height: 20.0,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: 
                          [
                            const Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                            ),

                            TextButton(
                                onPressed: (){},
                                child: const Text('Sign Up')
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}
