import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:virtual_closet/core/utls/app_router.dart';
import 'package:virtual_closet/feature/outfit/presentation/manage/outfit%20cubit/outfit_cubit.dart';

import 'feature/home/presentation/manage/home cubit/home_cubit.dart';

void main() {
  runApp(const VirtualCloset());
}

class VirtualCloset extends StatelessWidget {
  const VirtualCloset({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OutfitCubit>(
          create: (context) => OutfitCubit(),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter.router,
        title: "Virtual Closet",
      ),
    );
  }
}
