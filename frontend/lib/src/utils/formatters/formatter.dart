import 'package:intl/intl.dart';

class TFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date); // Customize the date format as needed
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount); // Customize the currency locale and symbol as needed
  }

  static String formatPhoneNumber(String phoneNumber) {
    // Assuming an Indonesian phone number format: +62 812-3456-7890
    phoneNumber = phoneNumber.replaceAll(
        RegExp(r'\D'), ''); // Remove non-digit characters

    if (phoneNumber.startsWith('62')) {
      phoneNumber = '+$phoneNumber';
    } else if (phoneNumber.startsWith('0')) {
      phoneNumber = '+62${phoneNumber.substring(1)}';
    } else {
      phoneNumber = '+62$phoneNumber';
    }

    if (phoneNumber.length > 5) {
      return '${phoneNumber.substring(0, 3)} ${phoneNumber.substring(3, 5)}-${phoneNumber.substring(5, 9)}-${phoneNumber.substring(9)}';
    }

    return phoneNumber;
  }


  // Not fully tested.
  static String internationalFormatPhoneNumber(String phoneNumber) {
    // Remove any non-digit characters from the phone number
    var digitsOnly = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // Extract the country code from the digitsOnly
    String countryCode = '+${digitsOnly.substring(0, 2)}';
    digitsOnly = digitsOnly.substring(2);

    // Add the remaining digits with proper formatting
    final formattedNumber = StringBuffer();
    formattedNumber.write('($countryCode) ');

    int i = 0;
    while (i < digitsOnly.length) {
      int groupLength = 2;
      if (i == 0 && countryCode == '+1') {
        groupLength = 3;
      }

      int end = i + groupLength;
      formattedNumber.write(digitsOnly.substring(i, end));

      if (end < digitsOnly.length) {
        formattedNumber.write(' ');
      }
      i = end;
    }

    return formattedNumber.toString();
  }

  static String formatDateToFullDayName(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Unknown date';
    }
    // Formatting the date (e.g., "Monday, 5 January")
    return DateFormat('EEEE, d MMMM').format(dateTime);
  }

  static String formatTimeToLocal(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Unknown';
    }

    // Konversi ke waktu lokal (WIB = UTC+7)
    DateTime localTime = dateTime.toUtc().add(const Duration(hours: 7));

    // Formatting the timestamp (e.g., "10:00 AM")
    String hour = (localTime.hour % 12 == 0 ? 12 : localTime.hour % 12)
        .toString()
        .padLeft(2, '0');
    String minute = localTime.minute.toString().padLeft(2, '0');
    String period = localTime.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }


  static String formatWhatsAppNumber(String phone) {
    // Bersihkan dari karakter khusus
    var cleanPhone = phone.replaceAll(RegExp(r'[\s\+\-()]'), '');

    // Jika dimulai dengan 0, hapus 0 dan tambahkan 62
    if (cleanPhone.startsWith('0')) {
      cleanPhone = '62${cleanPhone.substring(1)}';
    }
    // Jika belum ada kode negara, tambahkan 62
    else if (!cleanPhone.startsWith('62')) {
      cleanPhone = '62$cleanPhone';
    }
  
    return cleanPhone;
  }


}


/*
*
*
* */
