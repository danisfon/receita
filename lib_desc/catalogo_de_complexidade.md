# Catálogo de Complexidade - App de Receitas

Este documento descreve a pontuação de complexidade atingida pelo projeto, com base nos critérios estabelecidos.

## Tabela de Pontuação

| Critério | Pontos Obtidos | Descrição |Aplicação no projeto |
|---------|----------------|-----------|------------------------|
| **Cadastro simples** | 5 | CRUD simples | `form_categoria.dart`, `form_ingrediente.dart`, `form_autor.dart`, `form_utensilio.dart`, `form_dica_culinaria.dart`. |
| **Cadastro com associação (1:N)** | 6 | CRUD (1:N) | `form_receita.dart`, `form_autor_rede_social.dart`. |
| **Cadastro com associação (N:N)** | 6 | CRUD (N:N) | `form_receita_ingrediente.dart`. |
| **Organização em camadas** | 2 | Separação do projeto | Uso de DTO, DAO e widget |
| **Componentização com campo de opções inteligentes** | 2 | Campos reutilizáveis. | `lib/widget/componentes/campos/comum/`. |

---

### ✅ Total: **21 pontos**

---
