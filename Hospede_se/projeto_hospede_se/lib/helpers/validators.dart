class Validators {
  static String? validateName(String name) {
    return name.isEmpty
        ? 'Campo obrigatório'
        : name.trim().split(' ').length <= 1
            ? 'Preencha seu nome completo'
            : null;
  }

  static String? validateEmail(String email) {
    final RegExp regex = RegExp(
        r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");

    return email.isEmpty
        ? 'Campo obrigatório'
        : !regex.hasMatch(email)
            ? 'E-mail inválido'
            : null;
  }

  static String? validatePassword(String password) {
    return password.isEmpty
        ? 'Campo Obrigatório'
        : password.length < 8
            ? 'Sua senha deve ter no mínimo 8 caracteres'
            : null;
  }

  static String? comparePassword(String password1, String password2) {
    return password1 != password2 ? 'As senhas não coincidem' : null;
  }

  static String? validateText(String text) {
    return text.isEmpty ? 'Campo Obrigatório' : null;
  }

  static String? validatePhone(String phonenumber) {
    final regex = RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');

    return phonenumber.isEmpty
        ? 'Campo Obrigatório'
        : !regex.hasMatch(phonenumber)
            ? 'Telefone inválido'
            : null;
  }

  static String? validateNumber(String number) {
    if (number.isEmpty) {
      return 'Campo Obrigatório';
    }
    final n = num.tryParse(number);
    if (n == null) {
      return 'Digite apenas números';
    }
    return null;
  }

  static String? validateImage(List<dynamic> images) {
    if (images.isEmpty) {
      return 'Insira pelo menos uma Imagem';
    }
    return null;
  }
}
