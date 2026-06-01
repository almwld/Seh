import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/appointment_models/appointment_model.dart';

abstract class AppointmentState extends Equatable {
  const AppointmentState();
  @override
  List<Object?> get props => [];
}

class AppointmentInitial extends AppointmentState {}
class AppointmentLoading extends AppointmentState {}
class AppointmentsLoaded extends AppointmentState {
  final List<AppointmentModel> appointments;
  const AppointmentsLoaded(this.appointments);
  @override
  List<Object?> get props => [appointments];
}
class AppointmentBooked extends AppointmentState {
  final AppointmentModel appointment;
  const AppointmentBooked(this.appointment);
  @override
  List<Object?> get props => [appointment];
}
class AppointmentCancelled extends AppointmentState {
  final String appointmentId;
  const AppointmentCancelled(this.appointmentId);
  @override
  List<Object?> get props => [appointmentId];
}
class AppointmentError extends AppointmentState {
  final String message;
  const AppointmentError(this.message);
  @override
  List<Object?> get props => [message];
}

abstract class AppointmentEvent extends Equatable {
  const AppointmentEvent();
  @override
  List<Object?> get props => [];
}

class LoadAppointments extends AppointmentEvent {
  final String? status;
  const LoadAppointments({this.status});
  @override
  List<Object?> get props => [status];
}
class BookAppointment extends AppointmentEvent {
  final String doctorId;
  final DateTime date;
  final String time;
  final String? notes;
  const BookAppointment({required this.doctorId, required this.date, required this.time, this.notes});
  @override
  List<Object?> get props => [doctorId, date, time, notes];
}
class CancelAppointment extends AppointmentEvent {
  final String appointmentId;
  final String? reason;
  const CancelAppointment({required this.appointmentId, this.reason});
  @override
  List<Object?> get props => [appointmentId, reason];
}

class AppointmentBloc extends Bloc<AppointmentEvent, AppointmentState> {
  AppointmentBloc() : super(AppointmentInitial()) {
    on<LoadAppointments>(_onLoadAppointments);
    on<BookAppointment>(_onBookAppointment);
    on<CancelAppointment>(_onCancelAppointment);
  }

  Future<void> _onLoadAppointments(LoadAppointments event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      final appointments = [
        AppointmentModel(
          id: 'a1', patientId: 'p1', doctorId: 'd1',
          doctorName: 'د. أحمد علي', doctorSpecialization: 'طب القلب',
          appointmentDate: DateTime.now().add(const Duration(days: 2)),
          appointmentTime: '10:00 ص', status: 'confirmed',
          type: 'استشارة', price: 5000, currency: 'YER',
          isPaid: true,
        ),
        AppointmentModel(
          id: 'a2', patientId: 'p1', doctorId: 'd2',
          doctorName: 'د. سارة محمد', doctorSpecialization: 'طب الأطفال',
          appointmentDate: DateTime.now().add(const Duration(days: 5)),
          appointmentTime: '2:00 م', status: 'pending',
          type: 'فحص', price: 4500, currency: 'YER',
          isPaid: false,
        ),
        AppointmentModel(
          id: 'a3', patientId: 'p1', doctorId: 'd3',
          doctorName: 'د. خالد عبدالله', doctorSpecialization: 'الجراحة العامة',
          appointmentDate: DateTime.now().subtract(const Duration(days: 3)),
          appointmentTime: '9:00 ص', status: 'completed',
          type: 'جراحة', price: 6000, currency: 'YER',
          isPaid: true,
        ),
      ];
      emit(AppointmentsLoaded(appointments));
    } catch (e) {
      emit(AppointmentError('فشل تحميل المواعيد'));
    }
  }

  Future<void> _onBookAppointment(BookAppointment event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    try {
      await Future.delayed(const Duration(seconds: 1));
      final appointment = AppointmentModel(
        id: 'new_${DateTime.now().millisecondsSinceEpoch}',
        patientId: 'p1', doctorId: event.doctorId,
        appointmentDate: event.date, appointmentTime: event.time,
        status: 'confirmed', notes: event.notes,
      );
      emit(AppointmentBooked(appointment));
    } catch (e) {
      emit(AppointmentError('فشل حجز الموعد'));
    }
  }

  Future<void> _onCancelAppointment(CancelAppointment event, Emitter<AppointmentState> emit) async {
    emit(AppointmentLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(AppointmentCancelled(event.appointmentId));
    } catch (e) {
      emit(AppointmentError('فشل إلغاء الموعد'));
    }
  }
}
