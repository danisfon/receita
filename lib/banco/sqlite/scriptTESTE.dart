final _tag = '''
CREATE TABLE IF NOT EXISTS Tag (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL
);
''';

final _receita = '''
CREATE TABLE IF NOT EXISTS Receita (
  id TEXT PRIMARY KEY AUTOINCREMENT,
  nome TEXT NOT NULL,
  ingredientes TEXT NOT NULL,
  tags TEXT NOT NULL
);
''';

final criarTabelas = [
  _tag,
  _receita,
];

final insertTags = [
  '''
INSERT INTO Tag (nome)
VALUES ('Doce');
''',
  '''
INSERT INTO Tag (nome)
VALUES ('Fitness');
''',
  '''
INSERT INTO Tag (nome)
VALUES ('Rápida');
''',
  '''
INSERT INTO Tag (nome)
VALUES ('Vegana');
''',
];

final insertReceitas = [
  '''
INSERT INTO Receita (nome, ingredientes, tags)
VALUES ('Bolo de Chocolate', 'Farinha,Açúcar,Ovo', 'Doce,Fitness');
''',
  '''
INSERT INTO Receita (nome, ingredientes, tags)
VALUES ('Salada de Frutas', 'Maçã,Banana,Melancia', 'Fitness,Vegana');
''',
  '''
INSERT INTO Receita (nome, ingredientes, tags)
VALUES ('Bolo de Cenoura', 'Farinha,Óleo,Ovo,Chocolate', 'Doce,Rápida');
''',
  '''
INSERT INTO Receita (nome, ingredientes, tags)
VALUES ('Tapioca de Frango', 'Farinha de Tapioca,Frango,Gergelim', 'Fitness');
''',
];

final insertReceitaETags = [
  ...insertTags,
  ...insertReceitas,
];
