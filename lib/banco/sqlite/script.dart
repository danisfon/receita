class ScriptSQLite {
  static List<String> comandosCriarTabelas = [
    '''
    CREATE TABLE categoria (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      descricao TEXT
    );
    ''',
    '''
    CREATE TABLE autor (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      bio TEXT
    );
    ''',
    '''
    CREATE TABLE ingrediente (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      tipo TEXT,
      quantidade_padrao REAL,
      unidade TEXT
    );
    ''',
    '''
    CREATE TABLE utensilio (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      material TEXT,
      observacao TEXT
    );
    ''',
    '''
    CREATE TABLE dica (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      titulo TEXT NOT NULL,
      descricao TEXT NOT NULL,
      autor_id INTEGER NOT NULL,
      FOREIGN KEY(autor_id) REFERENCES autor(id)
    );

    ''',
    '''
    CREATE TABLE receita (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      modo_preparo TEXT NOT NULL,
      tempo_preparo INTEGER,
      categoria_id INTEGER NOT NULL,
      autor_id INTEGER NOT NULL,
      FOREIGN KEY(categoria_id) REFERENCES categoria(id),
      FOREIGN KEY(autor_id) REFERENCES autor(id)
    );
    ''',
    '''
    CREATE TABLE receita_ingrediente (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      receita_id INTEGER NOT NULL,
      ingrediente_id INTEGER NOT NULL,
      quantidade REAL,
      unidade TEXT,
      FOREIGN KEY(receita_id) REFERENCES receita(id),
      FOREIGN KEY(ingrediente_id) REFERENCES ingrediente(id),
      UNIQUE(receita_id, ingrediente_id)
    );
    ''',
    '''
    CREATE TABLE autor_rede_social (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      autor_id INTEGER NOT NULL,
      rede TEXT NOT NULL,
      url TEXT NOT NULL,
      FOREIGN KEY(autor_id) REFERENCES autor(id)
    );
    ''',
    '''
    CREATE TABLE autor_receita_favorita (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      autor_id INTEGER NOT NULL,
      receita_id INTEGER NOT NULL,
      FOREIGN KEY(autor_id) REFERENCES autor(id),
      FOREIGN KEY(receita_id) REFERENCES receita(id),
      UNIQUE(autor_id, receita_id)
    );
    '''
  ];

  static List<List<String>> comandosInsercoes = [
    // categoria
    [
      "INSERT INTO categoria (id, nome, descricao) VALUES (1, 'Sobremesa', 'Doces em geral');",
      "INSERT INTO categoria (id, nome, descricao) VALUES (2, 'Prato principal', 'Almoço ou jantar');",
    ],
    // autor
    [
      "INSERT INTO autor (id, nome, email, bio) VALUES (1, 'Maria Silva', 'maria@email.com', 'Chef especialista em sobremesas.');",
      "INSERT INTO autor (id, nome, email, bio) VALUES (2, 'João Souza', 'joao@email.com', 'Amante da culinária brasileira.');",
    ],
    // ingrediente
    [
      "INSERT INTO ingrediente (id, nome, tipo, quantidade_padrao, unidade) VALUES (1, 'Leite condensado', 'Laticínio', 395, 'gramas');",
      "INSERT INTO ingrediente (id, nome, tipo, quantidade_padrao, unidade) VALUES (2, 'Morango', 'Fruta', 100, 'gramas');",
    ],
    // utensilio
    [
      "INSERT INTO utensilio (id, nome, material, observacao) VALUES (1, 'Tigela', 'Vidro', 'Ideal para misturas frias.');",
      "INSERT INTO utensilio (id, nome, material, observacao) VALUES (2, 'Panela', 'Alumínio', 'Boa para caldas.');",
    ],
    // dica
    [
      "INSERT INTO dica (id, titulo, descricao, autor_id) VALUES (1, 'Use ingredientes frescos', 'Sempre prefira ingredientes frescos para realçar o sabor.', 1), (2, 'Pré-aqueça o forno', 'Sempre pré-aqueça o forno para garantir o cozimento uniforme.', 1);",
    ],
    // receita
    [
      "INSERT INTO receita (id, nome, modo_preparo, tempo_preparo, categoria_id, autor_id) VALUES (1, 'Mousse de Morango', 'Misture tudo e leve à geladeira.', 20, 1, 1);",
      "INSERT INTO receita (id, nome, modo_preparo, tempo_preparo, categoria_id, autor_id) VALUES (2, 'Feijoada', 'Cozinhe tudo por 3 horas.', 180, 2, 2);",
    ],
    // receita_ingrediente
    [
      "INSERT INTO receita_ingrediente (id, receita_id, ingrediente_id, quantidade, unidade) VALUES (1, 1, 1, 395, 'gramas');",
      "INSERT INTO receita_ingrediente (id, receita_id, ingrediente_id, quantidade, unidade) VALUES (2, 1, 2, 100, 'gramas');",
    ],
    // autor_rede_social
    [
      "INSERT INTO autor_rede_social (id, autor_id, rede, url) VALUES (1, 1, 'Instagram', 'https://instagram.com/maria');",
      "INSERT INTO autor_rede_social (id, autor_id, rede, url) VALUES (2, 2, 'YouTube', 'https://youtube.com/joaosouza');",
    ],
    // autor_receita_favorita
    [
      "INSERT INTO autor_receita_favorita (id, autor_id, receita_id) VALUES (1, 1, 1);",
      "INSERT INTO autor_receita_favorita (id, autor_id, receita_id) VALUES (2, 2, 2);",
    ],
  ];
}
