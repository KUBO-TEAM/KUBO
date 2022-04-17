import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'scanned_pictures_event.dart';
part 'scanned_pictures_state.dart';

class ScannedPicturesBloc
    extends Bloc<ScannedPicturesEvent, ScannedPicturesState> {
  ScannedPicturesBloc() : super(ScannedPicturesInitial()) {
    on<ScannedPicturesEvent>((event, emit) {
      if (event is ScannedPicturesSaved) {
        final imagePath = event.imagePath;

        if (state is ScannedPicturesInitial) {
          emit(ScannedPicturesInProgress());

          emit(ScannedPicturesSuccess(pictures: [imagePath]));
        } else if (state is ScannedPicturesSuccess) {
          final pictures = (state as ScannedPicturesSuccess).pictures;

          emit(ScannedPicturesInProgress());

          pictures.insert(0, imagePath);

          emit(ScannedPicturesSuccess(pictures: pictures));
        }
      }
    });
  }
}
