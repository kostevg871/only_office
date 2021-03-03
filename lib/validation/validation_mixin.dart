import 'dart:async';

class ValidationMixin {
  final validatorEmail = new StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      if (!email.contains('@')) {
        sink.addError('Please enter a valid email');
      } else if (email.contains(' ')) {
        sink.addError('Seriously 🤦');
      } else {
        sink.add(email);
      }
    },
  );

  final validatorPassword = new StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {
      if (password.length > 5) {
        sink.add(password);
      } else {
        sink.addError('Use better more than 5 characters!');
      }
    },
  );

  final validatorPortal = new StreamTransformer<String, String>.fromHandlers(
    handleData: (portal, sink) {
      if (portal.length > 3) {
        sink.add(portal);
      } else {
        sink.addError('Use better more than 3 characters!');
      }
    },
  );
}
