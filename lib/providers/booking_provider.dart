import 'package:flutter/material.dart';
import '../models/booking_model.dart';
import '../utils/logger.dart';

class BookingProvider extends ChangeNotifier {
  final List<BookingModel> _bookings = [];

  List<BookingModel> get bookings => List.unmodifiable(_bookings);

  void addBooking(BookingModel booking) {
    _bookings.add(booking);
    applogger.info('New booking added: ${booking.doctorName} on ${booking.dateTime}');
    notifyListeners();
  }

  void removeBooking(String bookingId) {
    _bookings.removeWhere((booking) => booking.id == bookingId);
    applogger.warning('Booking removed: ID - $bookingId');
    notifyListeners();
  }

  void updateBooking(BookingModel updatedBooking) {
    int index = _bookings.indexWhere((booking) => booking.id == updatedBooking.id);
    if (index != -1) {
      _bookings[index] = updatedBooking;
      applogger.debug('Booking updated: ID - ${updatedBooking.id}');
      notifyListeners();
    }
  }

  BookingModel? getBookingById(String bookingId) {
    return _bookings.firstWhere((booking) => booking.id == bookingId, orElse: () => BookingModel.empty());
  }
}
