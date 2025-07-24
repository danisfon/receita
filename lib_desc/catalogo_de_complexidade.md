# Catálogo de Complexidade - App de Receitas

Este documento descreve a pontuação de complexidade atingida pelo projeto, com base nos critérios estabelecidos.

## Tabela de Pontuação

| Descrição | Pontos Obtidos | Aplicação no projeto |
|-----------|----------------|----------------------|
| **Cadastro simples** | 5 | `form_categoria.dart`, `form_ingrediente.dart`, `form_autor.dart`, `form_utensilio.dart`, `form_dica_culinaria.dart`. |
| **Cadastro com associação (1:N)** | 6 | `form_receita.dart`, `form_autor_rede_social.dart`. |
| **Cadastro com associação (N:N)** | 6 | `form_receita_ingrediente.dart`. |
| **Organização em camadas** | 2 | Uso de DTO, DAO e widget |
| **Componentização com campo de opções inteligentes** | 2 | `lib/widget/componentes/campos/comum/`. |

---

### ✅ Total: **21 pontos**

---
