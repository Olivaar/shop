class AuthException implements Exception {
  static const Map<String, String> errors = {
    'EMAIL_EXISTS': 'e-mail já cadastrado.',
    'OPERATION_NOT_ALLOWED': 'Operaçao nao permitida.',
    'TOO_MANY_ATTEMPTS_TRY_LATER': 'Acesso bloqueado temporariamente. Tente mais tarde',
    'EMAIL_NOT_FOUND': 'E-mail nao encontrado.',
    'INVALID_PASSWORD': 'Senha informada nao confere.',
    'USER_DISABLED': 'A conta do usuário foi desabilitada.',
    'INVALID_LOGIN_CREDENTIALS': 'E-mail e/ou senha incorretos.',
  };

  final String key;

  AuthException(this.key);

  @override
  String toString() {
    return errors[key] ?? 'Ocorreu em erro no processo de atenticaçao.';
  }
}