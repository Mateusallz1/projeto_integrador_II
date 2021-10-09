class Validators {
  static String? validateName(String name) {
    return name.isEmpty
        ? 'Campo obrigatório'
        : name.trim().split(' ').length <= 1
            ? 'Preencha seu nome completo'
            : null;
  }

  static String? validateEmail(String email) {
    final RegExp regex = RegExp(r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
    return regex.hasMatch(email) ? null : 'E-mail inválido';
  }

  static String? validatePassword(String password) {
    return password.isEmpty
        ? 'Campo Obrigatório'
        : password.length < 8
            ? 'Sua senha deve ter no mínimo 8 caracteres'
            : null;
  }
}
