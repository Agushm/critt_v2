import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

final formatter = NumberFormat("#,##0","in_ID");

final formatRupiah = NumberFormat("Rp" + "#,##0", "in_ID");

String formatTglTransaksi(DateTime tgl){
  final fDate = DateFormat('yyyy-MM-dd hh:mm');
  var newData = fDate.format(tgl);
  return newData;
}

String tanggal(DateTime date, {bool shortMonth=false}) {
	return "${date.day} ${_convertToLocalMonth(date.month, shortMonth)} ${date.year}";
}

String tanggalWithTime(DateTime date, {bool shortMonth=false}) {
	return "${date.day} ${_convertToLocalMonth(date.month, shortMonth)} ${date.year} ${date.hour}:${date.minute}:${date.second}";
}

String tanggalInvoice(DateTime date, {bool shortMonth=false}) {
	return "${date.day} ${_convertToLocalMonth(date.month, shortMonth)} ${date.year}, ${date.hour}:${date.minute} WIB";
}

List _longMonth = ['Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni', 'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'];
List _shortMonth = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];

String _convertToLocalMonth(int month, bool shortMonth) {
	if (shortMonth) return _shortMonth[month -1];
	return _longMonth[month - 1];
}

class CurrencyInputFormatter extends TextInputFormatter{
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.selection.baseOffset == 0){
      print(true);
      return newValue;
    }
    double value = double.parse(newValue.text);
    String newText = formatRupiah.format(value);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length)
    );
  }

}

String printDurationMinuteSeconds(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "$twoDigitMinutes:$twoDigitSeconds";
}

String formatStatus(String status){
  if(status == "on-progress"){
    return "Proses";
  }
  if(status == "on-process"){
    return "Proses";
  }
  if(status == "failed"){
    return "Dibatalkan";
  }
  if(status == "success"){
    return "Sukses";
  }
  else{
    return "";
  }
}

String formatStatus2(String status){
  if(status == "on-progress"){
    return "Diproses";
  }
  if(status == "failed"){
    return "Dibatalkan";
  }
  if(status == "success"){
    return "Sukses";
  }
  else{
    return "";
  }
}

String formatStatusTransaksi(String status){
  if(status == "on-progress"){
    return "Transaksi Sedang Diproses";
  }
  if(status == "failed"){
    return "Transaksi Dibatalkan";
  }
  if(status == "success"){
    return "Transaksi Sukses";
  }
  else{
    return "";
  }
}