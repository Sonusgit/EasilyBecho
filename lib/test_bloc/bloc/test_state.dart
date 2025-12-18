part of 'test_bloc.dart';

class TestState extends Equatable {
  const TestState({
    this.message = '',
    this.data,
    this.status = ApiStatus.initial,
    this.massageDetail = '',
    this.detailData,
  });
  final String message;
  final dynamic data;
  final dynamic detailData;
  final String massageDetail;

  final ApiStatus status;

  TestState copyWith({String? message, dynamic data, ApiStatus? status}) {
    return TestState(
      message: message ?? this.message,
      data: data ?? this.data,
      status: status ?? this.status,
      massageDetail: massageDetail ?? this.massageDetail,
      detailData: detailData ?? this.detailData,
    );
  }

  @override
  List<Object?> get props => [message, data, status, massageDetail, detailData];
}
