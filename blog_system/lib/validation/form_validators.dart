class Validators {
  static String? validateTitle(String value) {
    if (value.isEmpty) {
      return 'Não é permitido títulos vazios';
    }
    if (value.length < 12) {
      return 'Preencha um título mais especifíco';
    }
    return null;
  }

  static String? validateBody(String value) {
    if (value.isEmpty) {
      return 'Escreva algo a respeito do seu post.';
    }
    if (value.length < 120) {
      return 'Não é permitidos post com um conteúdo muito curto.';
    }
    return null;
  }
}
