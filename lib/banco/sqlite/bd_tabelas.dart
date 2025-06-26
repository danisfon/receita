final List<String> criarTabelas = [
  '''
  CREATE TABLE IF NOT EXISTS Receita (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    ingredientes TEXT NOT NULL,
    tags TEXT NOT NULL
  )
  ''',
  '''
  CREATE TABLE IF NOT EXISTS Tag (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL
  )
  '''
];

final List<String> inserirReceitas = [
  "INSERT INTO Receita (nome, ingredientes, tags) VALUES ('Bolo de Chocolate', 'Farinha;Açúcar;Ovo', 'Doce,Fitness')",
  "INSERT INTO Receita (nome, ingredientes, tags) VALUES ('Salada de Frutas', 'Maçã;Banana;Melancia', 'Fitness,Vegana')",
  "INSERT INTO Tag (nome) VALUES ('Doce')",
  "INSERT INTO Tag (nome) VALUES ('Fitness')",
  "INSERT INTO Tag (nome) VALUES ('Rápida')",
  "INSERT INTO Tag (nome) VALUES ('Vegana')"
];
