# Check 2 - CRUD com associação

Este projeto consiste em um aplicativo de receitas desenvolvido em Flutter com persistência de dados via SQLite. 

## Atualização da Pontuação de Complexidade

| Critério | Pontos Obtidos | Descrição | Aplicação no Projeto |
|---------|--------|-----------|-----------------------|
| **Cadastro simples** | 5 pts | CRUDs básicos. | `Categoria`, `Ingrediente`, `Autor`, `Utensílio`, `Dica Culinária`. |
| **Cadastro com associação (1:N)** | 6 pts | Relacionamento um-para-muitos. | `Receita` possui associações com `Categoria` e `Autor`; e `Autor` possui associação com `Rede Social` (1:N). |
| **Cadastro com associação (N:N)** | 6 pts | Relacionamento muitos-para-muitos. | `ReceitaIngrediente` permite associar vários ingredientes a uma receita (e vice-versa) (N:N). |
| **Organização em camadas (MVC/MVVM)** | 2 pts | Separação entre lógica e interface. | Uso de DTOs, DAOs e widgets. |
| **Componentização com campo de opções inteligentes** | 2 pts | Campos reutilizáveis. | Campos personalizados criados em `lib/widget/componentes/campos/comum/`, como `CampoTexto`, `CampoDropdown`. |

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
- O uso de widgets reutilizáveis reduz duplicações e melhora a manutenção.

---
