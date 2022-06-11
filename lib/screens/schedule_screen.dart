// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:zst_schedule/blocs/schedule_bloc/schedule_bloc.dart';
// import 'package:zst_schedule/models/models.dart';

// class ScheduleScreen extends StatelessWidget {
//   const ScheduleScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final args = ModalRoute.of(context)!.settings.arguments as Class;
//     return DefaultTabController(
//       length: 5,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(args.fullName!),
//           automaticallyImplyLeading: false,
//           actions: [
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: Text(args.code),
//               ),
//             ),
//           ],
//           bottom: const TabBar(
//             indicatorColor: Colors.white,
//             isScrollable: true,
//             tabs: [
//               Tab(
//                 text: "Pon.",
//               ),
//               Tab(
//                 text: "Wt.",
//               ),
//               Tab(
//                 text: "Śr.",
//               ),
//               Tab(
//                 text: "Czw.",
//               ),
//               Tab(
//                 text: "Pt.",
//               ),
//             ],
//           ),
//         ),
//         body: BlocBuilder<ScheduleBloc, ScheduleState>(
//           builder: (context, state) {
//             if (state is ScheduleLoaded) {
//               return TabBarView(
//                 children: [
//                   ScheduleList(
//                       lessons: state.schedule.schedule[0],
//                       maxGroup: state.schedule.groups),
//                   ScheduleList(
//                       lessons: state.schedule.schedule[1],
//                       maxGroup: state.schedule.groups),
//                   ScheduleList(
//                       lessons: state.schedule.schedule[2],
//                       maxGroup: state.schedule.groups),
//                   ScheduleList(
//                       lessons: state.schedule.schedule[3],
//                       maxGroup: state.schedule.groups),
//                   ScheduleList(
//                       lessons: state.schedule.schedule[4],
//                       maxGroup: state.schedule.groups),
//                 ],
//               );
//             } else {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

// class ScheduleList extends StatelessWidget {
//   final List<List<Lesson>> lessons;
//   final int maxGroup;
//   const ScheduleList({
//     Key? key,
//     required this.lessons,
//     required this.maxGroup,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         itemCount: lessons.length,
//         itemBuilder: ((context, index) {
//           var lesson = lessons[index];

//           if (lesson.isNotEmpty) {
//             return ListTile(
//               leading: Text("$index."),
//               title: Text(lesson[0].name),
//               trailing: lesson[0].group != null
//                   ? Text("${lesson[0].group}/$maxGroup")
//                   : null,
//               subtitle: Text(lesson[0].classroom.oldNumber +
//                   ", " +
//                   lesson[0].teacher.code),
//             );
//           } else {
//             return const SizedBox();
//           }
//         }),
//       ),
//     );
//   }
// }
