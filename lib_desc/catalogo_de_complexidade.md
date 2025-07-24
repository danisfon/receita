# Catálogo de Complexidade - App de Receitas

Este documento descreve a pontuação de complexidade atingida pelo projeto, com base nos critérios estabelecidos. Foram implementadas diversas funcionalidades com diferentes níveis de dificuldade, respeitando a estrutura proposta.

## Tabela de Pontuação

| Critério | Pontos Obtidos | Descrição |Aplicação no projeto |
|---------|----------------|-----------|------------------------|
| **Cadastro simples** | 5 pts | CRUDs básicos. | `form_categoria.dart`, `form_ingrediente.dart`, `form_autor.dart`, `form_utensilio.dart`, `form_dica_culinaria.dart`. |
| **Cadastro com associação (1:N)** | 6 pts | Relacionamentos um-para-muitos. | `form_receita.dart`, `form_autor_rede_social.dart`. |
| **Cadastro com associação (N:N)** | 6 pts | Relacionamento muitos-para-muitos. | `form_receita_ingrediente.dart`. |
| **Organização em camadas** | 2 pts | Separação. | Uso de DTO, DAO e widget |
| **Componentização com campo de opções inteligentes** | 2 pts | Campos reutilizáveis e interativos. | `lib/widget/componentes/campos/comum/`. |

---

### ✅ Total: **21 pontos**

---
