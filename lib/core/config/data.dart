import 'package:critt_v2/core/utils/currency_utils.dart';
import 'package:critt_v2/ui/constants/constants.dart';

String pesanHeaderHome(int saving) {
  if (saving == 0) {
    return "Ayo buat transaksi pertamamu di ${appName.toUpperCase()}";
  } else {
    return 'Anda telah menghemat ${formatRupiah.format(saving)} selama menggunakan ${appName.toUpperCase()}';
  }
}
