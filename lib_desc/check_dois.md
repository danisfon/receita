# Complexidade do Projeto: App de Receitas

Este projeto consiste em um aplicativo de receitas desenvolvido em Flutter com persistência de dados via SQLite. O app possui uma estrutura organizada, com componentização reutilizável, organização em camadas, relacionamentos entre entidades e formulários bem estruturados.

## Pontuação de Complexidade

| Critério | Pontos | Descrição | Aplicação no Projeto |
|---------|--------|-----------|-----------------------|
| **Cadastro simples** | 5 pts (máx.) | CRUDs básicos, sem relações. | `Categoria`, `Ingrediente`, `Autor`, `Utensílio`, `Dica Culinária`. Cada um com `FormX.dart` e `ListaX.dart`, usando widgets como `CampoTexto`, `CampoDropdown`. |
| **Cadastro com associação (1:N)** | 6 pts | Entidades com relação pai-filho. | `Receita` possui associações com `Categoria` e `Autor`; e `Autor` possui associação com `Rede Social` (1:N). Ambos com formulários e listagens próprios. |
| **Cadastro com associação (N:N)** | 6 pts | Cadastro com tabela intermediária. | `ReceitaIngrediente` permite associar vários ingredientes a uma receita (e vice-versa), com formulário e listagem próprios. |
| **Organização em camadas (MVC/MVVM)** | 2 pts | Separação entre lógica e interface. | Uso de DTOs (`dto_*.dart`), DAOs (`dao_*.dart`) e widgets (`form_*.dart`, `lista_*.dart`). A arquitetura facilita manutenção e expansão. |
| **Componentização com campo de opções inteligentes** | 2 pts | Campos reutilizáveis, interativos e inteligentes. | Campos personalizados criados em `lib/widget/componentes/campos/comum/`, como `CampoTexto`, `CampoDropdown`. |

---

### Total: **21 pontos**

---

## Considerações

- O projeto está dentro das regras, contendo **mais de uma associação com persistência**:
  - Associações 1:N:
    - `Categoria`, `Autor` dentro de `Receita`;
    - `Autor` → `Rede Social`.
  - Associação N:N (`ReceitaIngrediente`).
- A estrutura é escalável, organizada e reutilizável.
- Todos os formulários possuem validação, controle de estado e navegação apropriada.
- O uso de widgets reutilizáveis reduz duplicações e melhora a manutenção.

---
