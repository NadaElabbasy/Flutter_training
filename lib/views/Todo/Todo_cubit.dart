import 'package:bloc/bloc.dart';
import 'package:flutter_navigation/models/completion_model.dart';
import 'package:flutter_navigation/services/completion_service.dart';
import 'package:meta/meta.dart';

part 'Todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial()) {
    getList();
  }

  List<CompletionModel> todo = [];
  bool isLoading = true;

  getList() async {
    emit(TodoLoading());
    try {
      todo = await CompletionService().getData();
      isLoading = false;

      emit(TodoSuccess());
    } catch (e) {
      print(e.toString());
      emit(TodoError());
    }
  }
}
