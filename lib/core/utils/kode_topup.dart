import 'dart:math';

Random rand = Random();

String kodeTransaksi(String nominal){
  int randomCode = rand.nextInt(599);
                      String total = nominal;
                      int totalLength = (total.length);
                      int totalLengthHapus = (total.length) - randomCode.toString().length;
                     String kodePembayaran  = total.replaceRange(totalLengthHapus, totalLength,randomCode.toString());
                      
                      return kodePembayaran;
}