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
      descricao TEXT NOT NULL
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
    '''
  ];

  static List<List<String>> comandosInsercoes = [
    [
      "INSERT INTO categoria (nome, descricao) VALUES ('Sobremesa', 'Doces em geral');",
      "INSERT INTO categoria (nome, descricao) VALUES ('Prato principal', 'Almoço ou jantar');",
    ],
    [],
    [],
    [],
    [],
    [],
    [],
    [],
  ];
}
