class Api {
  //* Creating instance constructor;
  static Api instance = Api();
  //* Base API URL DEV "https://critt.muncak.id/"
  static const baseURL = "https://v1.critt.id/";

  //* ---------------
  //* ENDPOINT FIELD
  //* ----------------

  // Auth //
  static const login = baseURL + "users/login/";
  static const user = baseURL + "users/";
  static const register = baseURL + "users/register";
  static const verifAccount = baseURL + 'verification';

  // Receiver CRITT //
  static const receiver = baseURL + "reciever/";

  // Bank Method GET//
  static const bankList = baseURL + "transaction/list-bank";

  // Transaksi CRITT //
  static const transaksi = baseURL + "transaction/";
  static const sendBuktiTransfer = baseURL + "transaction/send-receipt";
  static const invoice = baseURL + "invoice/";

  // Withdraw CRITT //
  static const withdraw = baseURL + "withdraw/";

  // Refund CRITT //
  static const refund = baseURL + "refund/";
  static const refundReason = baseURL + "refund/reason";

  static const profile = baseURL + "users/";
  static const checkAccountBank = "https://irfan.co.id/nama-rek/api";
  // Type.put
  static const updatePin = baseURL + "users/update-pin/";
  static const checkPin = baseURL + "users/check-pin/";

  // Article Crit //
  static const article = baseURL + "article/";

  static const cs = baseURL + 'customer-service';
}
