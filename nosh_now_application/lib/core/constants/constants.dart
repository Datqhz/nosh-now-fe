import 'package:nosh_now_application/data/models/payment_method.dart';

class Constants {
  static List<PaymentMethod> paymentMethods = [
    PaymentMethod(methodId: 'a527b118-fa42-4cca-b72e-5c71b4642d62', methodName: 'Cash', methodImage: 'https://res.cloudinary.com/dyhjqna2u/image/upload/v1732556257/cash_dggz5g.png'),
    PaymentMethod(methodId: 'a527b118-fa42-4cca-b72e-5c71b4642d63', methodName: 'Momo', methodImage: 'https://res.cloudinary.com/dyhjqna2u/image/upload/v1732556257/momo_mm1eu0.png'),
    PaymentMethod(methodId: 'a527b118-fa42-4cca-b72e-5c71b4642d64', methodName: 'GPay', methodImage: 'https://res.cloudinary.com/dyhjqna2u/image/upload/v1732556258/google-pay-icon_n1dqti.png')
  ];
  static String payViaCash = 'a527b118-fa42-4cca-b72e-5c71b4642d62';
  static String payViaMono = 'a527b118-fa42-4cca-b72e-5c71b4642d63';
  static String payViaGPay = 'a527b118-fa42-4cca-b72e-5c71b4642d64';
}