# 🍲 Receita App

Um aplicativo Flutter para gerenciar receitas culinárias, com cadastro e listagem de:

- Categorias
- Autores
- Dicas culinárias
- Ingredientes
- Utensílios
- Receitas
- Associação de Ingredientes por Receita

---

## 📱 Funcionalidades

- CRUD completo (Criar, Ler, Atualizar, Excluir) para todas as entidades
- Associação entre receitas e ingredientes com quantidade e unidade
- Interface simples e intuitiva
- Armazenamento local com SQLite
- Separação clara entre DTOs, DAOs, formulários e listagens
- Navegação entre telas via menu principal

---

## 🚀 Como executar

### Pré-requisitos

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- VS Code ou Android Studio com plugin Flutter
- Dispositivo físico ou emulador Android

### Passo a passo

```bash
# Clone o projeto
git clone https://github.com/seu-usuario/receita_app.git
cd receita_app

# Instale as dependências
flutter pub get

# Execute no emulador ou dispositivo conectado
flutter run

