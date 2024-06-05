// ignore_for_file: public_member_api_docs, sort_constructors_first
enum CommunicationMethod {
  SMS,
  WhatsApp,
  Email,
}
class CommunicationPreferenceModel {
  int communicationPreferenceId;
  CommunicationMethod method;
  CommunicationPreferenceModel({
    required this.communicationPreferenceId,
    required this.method,
  });

  static CommunicationMethod _parseMethod(String method) {
    switch (method) {
      case 'SMS':
        return CommunicationMethod.SMS;
      case 'WhatsApp':
        return CommunicationMethod.WhatsApp;
      case 'Email':
        return CommunicationMethod.Email;
      default:
        throw ArgumentError('Invalid method: $method');
    }
  }

  static String _methodToString(CommunicationMethod method) {
    switch (method) {
      case CommunicationMethod.SMS:
        return 'SMS';
      case CommunicationMethod.WhatsApp:
        return 'WhatsApp';
      case CommunicationMethod.Email:
        return 'Email';
    }
  }
}
