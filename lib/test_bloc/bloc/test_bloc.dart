import 'package:bloc/bloc.dart';
import 'package:easilybecho/core/utility/const/app_enums.dart';
import 'package:easilybecho/test_bloc/repo/test_repo/test_repo.dart';
import 'package:equatable/equatable.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  final TestRepo testRepo;
  TestBloc(this.testRepo) : super(TestState()) {
    on<GetData>(_testApi);
  }

  void _testApi(GetData event, Emitter<TestState> emit) async {
    try {
      emit(state.copyWith(status: ApiStatus.loading));
      final response = await testRepo.getProductData();
      if(response.status == true){
        emit(state.copyWith(data: response.data,status: ApiStatus.success));
      }else{
        emit(state.copyWith(message: response.message,status: ApiStatus.error));
      }
      
    } catch (e) {
      emit(state.copyWith(message: e.toString(),status: ApiStatus.error));
    }
  }
}
