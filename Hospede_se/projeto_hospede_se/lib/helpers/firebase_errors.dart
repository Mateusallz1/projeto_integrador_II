String getErrorString(String code) {
  switch (code) {
    case 'no-such-provider':
      return 'O usuário não foi vinculado a uma conta com o provedor fornecido.';
    case 'operation-not-allowed':
      return 'O provedor fornecido está desabilitado para este projeto Firebase. Habilite-o no console do Firebase; na aba método de login da seção Auth.';
    case 'operation-not-supported-in-this-environment':
      return 'Esta operação não é suportada no ambiente em que esta aplicação está rodando.';
    case 'popup-blocked':
      return 'Incapaz de estabelecer uma conexão com o popup. Pode ter sido bloqueada pelo navegador.';
    case 'popup-closed-by-user':
      return 'O popup foi fechado pelo usuário antes de finalizar a operação';
    case 'provider-already-linked':
      return 'O usuário só pode ser vinculado a uma identidade para o provedor dado';
    case 'quota-exceeded':
      return 'Usuário Bloqueado por muitas requisições';
    case 'redirect-cancelled-by-user':
      return 'A operação de redirecionamento foi cancelada pelo usuário antes de finalizar';
    case 'redirect-operation-pending':
      return 'Uma operação de redirecionamento de login já está pendente';
    case 'timeout':
      return 'A operação foi expirada';
    case 'user-token-expired':
      return 'A credencial do usuário não é mais válida. O usuário deve fazer o login novamente.';
    case 'too-many-requests':
      return 'Bloqueamos todas as solicitações deste dispositivo devido a atividade incomum. Tente novamente mais tarde.';
    case 'user-cancelled':
      return 'O usuário não concedeu a sua solicitação as permissões que solicitou.';
    case 'user-not-found':
      return 'Não há nenhum registro de usuário correspondente.';
    case 'user-disabled':
      return 'A conta do usuário foi desabilitada por um administrador.';
    case 'user-mismatch':
      return 'As credenciais fornecidas não correspondem ao usuário previamente cadastrado.';
    case 'wrong-password':
      return 'Senha incorreta.';
    case 'user-signed-out':
      return '';
    case 'web-storage-unsupported':
      return 'Este navegador não é suportado ou cookies e dados de terceiros podem ser desabilitados.';
    case 'email-already-in-use':
      return 'Este email de usuário já está em uso. Tente outro.';
    default:
      return 'Um erro indefinido ocorreu.';
  }
}
