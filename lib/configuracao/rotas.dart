class Rotas {
  // Telas principais
  static const String menuPrincipal = '/';
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

  // Associação 1:N
  static const String cadastroReceita = '/cadastro-receita';
  static const String listaReceitas = '/lista-receitas';

  static const String cadastroAutorRedeSocial = '/cadastro-autor-rede-social';
  static const String listaAutorRedeSocial = '/lista-autor-rede-social';

  static const String cadastroDica = '/cadastro-dica';
  static const String listaDicas = '/lista-dicas';

  static const String cadastroComentario = '/cadastro-comentario';
  static const String listaComentario = '/lista-comentario';


  // Associação N:N
  static const String cadastroReceitaIngrediente = '/cadastro-ingrediente-por-receita';
  static const String listaReceitaIngredientes = '/lista-ingredientes-por-receita';

  static const String cadastroAutorReceitaFavorita = '/cadastro-receita-favorita-por-autor';
  static const String listaAutorReceitaFavorita = '/lista-receitas-favoritas-por-autor';

  // Receitas por categoria (nova rota)
  static const String receitasPorCategoria = '/receitas-por-categoria';
}
