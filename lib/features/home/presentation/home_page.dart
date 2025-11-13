import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/home_bloc.dart';
import '../../../core/di/injector.dart' as di;
import '../../auth/presentation/pages/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeBloc bloc;
  @override
  void initState() {
    super.initState();
    bloc = di.sl<HomeBloc>();
    bloc.loadHome();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Center(
          child: BlocBuilder<HomeBloc, dynamic>(
            builder: (context, state) {
              if (state is HomeLoading) return const CircularProgressIndicator();
              if (state is HomeLoaded) return Text(state.welcome);
              if (state is HomeError) return Text(state.msg);
              return const Text('Home');
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await bloc.logout();
            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const LoginPage()));
          },
          child: const Icon(Icons.logout),
          tooltip: 'Logout',
        ),
      ),
    );
  }
}
