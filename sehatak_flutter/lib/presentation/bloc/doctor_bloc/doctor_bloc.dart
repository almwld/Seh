import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../data/models/doctor_models/doctor_model.dart';

abstract class DoctorState extends Equatable {
  const DoctorState();
  @override
  List<Object?> get props => [];
}

class DoctorInitial extends DoctorState {}
class DoctorLoading extends DoctorState {}
class DoctorsLoaded extends DoctorState {
  final List<DoctorModel> doctors;
  final bool hasMore;
  const DoctorsLoaded(this.doctors, {this.hasMore = false});
  @override
  List<Object?> get props => [doctors, hasMore];
}
class DoctorDetailsLoaded extends DoctorState {
  final DoctorModel doctor;
  final List<DoctorReviewModel> reviews;
  const DoctorDetailsLoaded(this.doctor, this.reviews);
  @override
  List<Object?> get props => [doctor, reviews];
}
class DoctorError extends DoctorState {
  final String message;
  const DoctorError(this.message);
  @override
  List<Object?> get props => [message];
}

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();
  @override
  List<Object?> get props => [];
}

class LoadDoctors extends DoctorEvent {
  final String? specialization;
  final int page;
  const LoadDoctors({this.specialization, this.page = 1});
  @override
  List<Object?> get props => [specialization, page];
}
class LoadDoctorDetails extends DoctorEvent {
  final String doctorId;
  const LoadDoctorDetails(this.doctorId);
  @override
  List<Object?> get props => [doctorId];
}
class SearchDoctors extends DoctorEvent {
  final String query;
  const SearchDoctors(this.query);
  @override
  List<Object?> get props => [query];
}
class ToggleFavoriteDoctor extends DoctorEvent {
  final String doctorId;
  const ToggleFavoriteDoctor(this.doctorId);
  @override
  List<Object?> get props => [doctorId];
}

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  DoctorBloc() : super(DoctorInitial()) {
    on<LoadDoctors>(_onLoadDoctors);
    on<LoadDoctorDetails>(_onLoadDoctorDetails);
    on<SearchDoctors>(_onSearchDoctors);
    on<ToggleFavoriteDoctor>(_onToggleFavorite);
  }

  Future<void> _onLoadDoctors(LoadDoctors event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 800));
      final doctors = [
        DoctorModel(
          id: '1', userId: 'u1', fullName: 'د. أحمد علي',
          specialization: 'طب القلب', experience: 15, rating: 4.8,
          reviewCount: 120, consultationPrice: 5000,
          isAvailable: true, isVerified: true,
          clinicAddress: 'صنعاء - شارع الستين',
        ),
        DoctorModel(
          id: '2', userId: 'u2', fullName: 'د. سارة محمد',
          specialization: 'طب الأطفال', experience: 10, rating: 4.9,
          reviewCount: 200, consultationPrice: 4500,
          isAvailable: true, isVerified: true,
          clinicAddress: 'عدن - المنصورة',
        ),
        DoctorModel(
          id: '3', userId: 'u3', fullName: 'د. خالد عبدالله',
          specialization: 'الجراحة العامة', experience: 20, rating: 4.7,
          reviewCount: 85, consultationPrice: 6000,
          isAvailable: false, isVerified: true,
          clinicAddress: 'تعز - شارع تعز',
        ),
        DoctorModel(
          id: '4', userId: 'u4', fullName: 'د. فاطمة أحمد',
          specialization: 'أمراض النساء', experience: 12, rating: 4.9,
          reviewCount: 150, consultationPrice: 5500,
          isAvailable: true, isVerified: true,
          clinicAddress: 'صنعاء - حدة',
        ),
        DoctorModel(
          id: '5', userId: 'u5', fullName: 'د. محمد صالح',
          specialization: 'الجلدية', experience: 8, rating: 4.6,
          reviewCount: 90, consultationPrice: 4000,
          isAvailable: true, isVerified: true,
          clinicAddress: 'الحديدة - شارع صنعاء',
        ),
      ];
      emit(DoctorsLoaded(doctors));
    } catch (e) {
      emit(DoctorError('فشل تحميل الأطباء: $e'));
    }
  }

  Future<void> _onLoadDoctorDetails(LoadDoctorDetails event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      final doctor = DoctorModel(
        id: event.doctorId, userId: 'u1', fullName: 'د. أحمد علي',
        specialization: 'طب القلب', subSpecialization: 'جراحة القلب',
        bio: 'استشاري أمراض القلب والأوعية الدموية بخبرة 15 عاماً',
        experience: 15, rating: 4.8, reviewCount: 120,
        consultationPrice: 5000, followUpPrice: 2500,
        isAvailable: true, isVerified: true,
        clinicAddress: 'صنعاء - شارع الستين',
        clinicPhone: '+967-1-234-567',
        workingHours: 'السبت - الخميس: 9:00 ص - 5:00 م',
        languages: const ['العربية', 'الإنجليزية'],
        services: const ['استشارة', 'فحص', 'متابعة'],
      );
      final reviews = [
        DoctorReviewModel(
          id: 'r1', doctorId: event.doctorId, patientId: 'p1',
          patientName: 'محمد أحمد', rating: 5.0,
          comment: 'طبيب ممتاز ومختص', createdAt: DateTime.now().subtract(const Duration(days: 2)),
        ),
        DoctorReviewModel(
          id: 'r2', doctorId: event.doctorId, patientId: 'p2',
          patientName: 'فاطمة علي', rating: 4.5,
          comment: 'خدمة رائعة واهتمام كبير', createdAt: DateTime.now().subtract(const Duration(days: 5)),
        ),
      ];
      emit(DoctorDetailsLoaded(doctor, reviews));
    } catch (e) {
      emit(DoctorError('فشل تحميل تفاصيل الطبيب'));
    }
  }

  Future<void> _onSearchDoctors(SearchDoctors event, Emitter<DoctorState> emit) async {
    emit(DoctorLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      emit(DoctorsLoaded(const []));
    } catch (e) {
      emit(DoctorError('فشل البحث'));
    }
  }

  Future<void> _onToggleFavorite(ToggleFavoriteDoctor event, Emitter<DoctorState> emit) async {
    // Handle toggle favorite
  }
}
