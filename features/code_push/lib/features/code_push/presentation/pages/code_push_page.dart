// import 'package:dependencies/dependencies.dart';
// import 'package:flutter/material.dart';

// import '../cubit/code_push_cubit.dart';

// class CodePushListener extends StatelessWidget {
//   const CodePushListener({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Code Push')),
//       body: BlocBuilder<CodePushCubit, CodePushState>(
//         builder: (context, state) {
//           if (state is CodePushLoading) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (state is CodePushUpToDate) {
//             return const Center(child: Text('App is up to date'));
//           } else if (state is CodePushUpdated) {
//             return Center(
//               child: ElevatedButton(
//                 onPressed: () {
//                   context.read<CodePushCubit>().updateApp();
//                 },
//                 child: const Text('Update Now'),
//               ),
//             );
//           } else if (state is CodePushError) {
//             return Center(child: Text('Error: ${state.message}'));
//           }
//           return const Center(child: Text('Initializing...'));
//         },
//       ),
//     );
//   }
// }

//////////////////?
import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../cubit/code_push_cubit.dart';

class CodePushListener extends StatelessWidget {
  const CodePushListener({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CodePushCubit, CodePushState>(
      listener: (context, state) {
        if (state is CodePushNeedRestart) {
          ScaffoldMessenger.maybeOf(context)
            ?..hideCurrentMaterialBanner()
            ..showMaterialBanner(
                MaterialBanner(content: const Text("Restart Now"), actions: [ //TODO design this
              BackButton(
                onPressed: () {
                  ScaffoldMessenger.maybeOf(context)
                      ?.hideCurrentMaterialBanner();
                  // restart
                },
              )
            ]));
        }
        if (state is CodePushUpToDate || state is CodePushError) {
          ScaffoldMessenger.maybeOf(context)?.hideCurrentMaterialBanner();
        }
      },
      child: child,
      // builder: (context, state) {
      //   if (state is CodePushLoading) {
      //     return const Center(child: CircularProgressIndicator());
      //   } else if (state is CodePushUpToDate) {
      //     return const Center(child: Text('App is up to date'));
      //   } else if (state is CodePushUpdated) {
      //     return Center(
      //       child: ElevatedButton(
      //         onPressed: () {
      //           context.read<CodePushCubit>().updateApp();
      //         },
      //         child: const Text('Update Now'),
      //       ),
      //     );
      //   } else if (state is CodePushError) {
      //     return Center(child: Text('Error: ${state.message}'));
      //   }
      //   return const Center(child: Text('Initializing...'));
      // },
    );
  }
}
