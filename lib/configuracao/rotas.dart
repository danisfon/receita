class Rotas {
  // Telas principais
  static const String home = '/home';
  static const String login = '/login';

  // CRUD Simples
  static const String cadastroIngrediente = '/cadastro-ingrediente';
  static const String listaIngredientes = '/lista-ingredientes';

  static const String cadastroCategoria = '/cadastro-categoria';
  static const String listaCategorias = '/lista-categorias';

  static const String cadastroUtensilio = '/cadastro-utensilio';
  static const String listaUtensilios = '/lista-utensilios';

  static const String cadastroAutor = '/cadastro-autor';
  static const String listaAutores = '/lista-autores';

  static const String cadastroDica = '/cadastro-dica';
  static const String listaDicas = '/lista-dicas';

  // Associação 1:N
  static const String cadastroReceita = '/cadastro-receita';
  static const String listaReceitas = '/lista-receitas';

  // Associação N:N
  static const String cadastroReceitaIngrediente =
      '/cadastro-ingrediente-por-receita';
  static const String listaReceitaIngredientes =
      '/lista-ingredientes-por-receita';
  // constante
  static const String menuPrincipal = '/';
}
