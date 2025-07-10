import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:notoro/controllers/workout_detail/workout_detail_bloc.dart';
import 'package:notoro/controllers/workout_detail/workout_detail_event.dart';
import 'package:notoro/controllers/workout_detail/workout_detail_state.dart';
import 'package:notoro/models/workout/workout_model.dart';
import 'package:hive/hive.dart';
import 'package:mockito/mockito.dart';

class MockWorkoutBox extends Mock implements Box<WorkoutModel> {}

void main() {
  group('WorkoutDetailBloc', () {
    late MockWorkoutBox box;
    late WorkoutModel mockWorkout;

    setUp(() {
      box = MockWorkoutBox();
      mockWorkout = WorkoutModel(name: 'Test', exercises: []);
      when(box.get(any)).thenReturn(mockWorkout);
    });

    blocTest<WorkoutDetailBloc, WorkoutDetailState>(
      'emits loaded workout when LoadWorkoutDetail is added',
      build: () => WorkoutDetailBloc(box),
      act: (bloc) => bloc.add(LoadWorkoutDetail(0)),
      expect: () => [
        isA<WorkoutDetailState>()
            .having((s) => s.workout?.name, 'workout name', 'Test')
      ],
    );
  });
}
