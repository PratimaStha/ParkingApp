part of 'book_slot_cubit.dart';

enum BookSlotStatus {
  initial,
  getBookLoading,
  getBookSuccess,
  getBookFailure,
  addBookLoading,
  addBookFailure,
  addBookSuccess,
  getMyBookLoading,
  getMyBookSuccess,
  getMyBookFailure,
  deleteLoading,
  deleteSuccess,
  deleteFailure,
  updateReservedLoading,
  updateReservedSuccess,
  updateReservedFailure,
}

class BookSlotState extends Equatable {
  final BookSlotStatus status;
  final String? message;
  final BookSlotResponseModel? bookSlotResponseModel;
  final AddBookSlotResponseModel? addBookSlotResponseModel;
  final BookSlotResponseModel? myBookSlotResponseModel;
  final String? token;
  const BookSlotState({
    this.status = BookSlotStatus.initial,
    this.message,
    this.bookSlotResponseModel,
    this.addBookSlotResponseModel,
    this.myBookSlotResponseModel,
    this.token,
  });

  @override
  List<Object?> get props => [
        status,
        message,
        bookSlotResponseModel,
        myBookSlotResponseModel,
        addBookSlotResponseModel,
        token,
      ];

  BookSlotState copyWith({
    BookSlotStatus? status,
    String? message,
    BookSlotResponseModel? bookSlotResponseModel,
    BookSlotResponseModel? myBookSlotResponseModel,
    AddBookSlotResponseModel? addBookSlotResponseModel,
    String? token,
  }) {
    return BookSlotState(
      status: status ?? this.status,
      message: message ?? this.message,
      bookSlotResponseModel:
          bookSlotResponseModel ?? this.bookSlotResponseModel,
      myBookSlotResponseModel:
          myBookSlotResponseModel ?? this.myBookSlotResponseModel,
      addBookSlotResponseModel:
          addBookSlotResponseModel ?? this.addBookSlotResponseModel,
      token: token ?? this.token,
    );
  }
}
