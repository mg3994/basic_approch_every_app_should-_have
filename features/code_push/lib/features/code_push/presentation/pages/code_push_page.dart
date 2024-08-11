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
// import 'dart:isolate';

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
            ..showMaterialBanner(MaterialBanner(
              content: const Text(
                  "A new update is available. Restart now to apply the update."),
              leading: Icon(Icons.system_update,
                  color: Theme.of(context).primaryColor),
              leadingPadding: const EdgeInsets.only(right: 20),
              actions: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.maybeOf(context)
                        ?.hideCurrentMaterialBanner();
                    //TODO: Restart now to apply
                    // Isolate.current.kill(priority: Isolate.immediate);
                    // Isolate.exit();

                    // SystemNavigator.pop().then((v) {
                    //   SystemNavigator.routeInformationUpdated();
                    // });
                  },
                  child: const Text("RESTART NOW"),
                ),
              ],
            ));
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
