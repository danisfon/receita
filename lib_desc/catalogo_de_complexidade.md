# Catálogo de Complexidade - App de Receitas

Este documento descreve a pontuação de complexidade atingida pelo projeto, com base nos critérios estabelecidos.

## Tabela de Pontuação

| Descrição | Pontos Obtidos | Aplicação no projeto |
|-----------|----------------|----------------------|
| **4 Cadastros simples** | 4 | `form_categoria.dart`, `form_ingrediente.dart`, `form_autor.dart` e `form_utensilio.dart`. |
| **4 Cadastros com associação (1:N)** | 12 | `form_receita.dart`, `form_autor_rede_social.dart`, `form_comentario.dart` e `form_dica.dart`. |
| **2 Cadastros com associação (N:N)** | 12 | `form_receita_ingrediente.dart` e `form_autor_receita_favorita.dart`.|
| **Componentização com campo de opções inteligentes** | 2 | `lib/widget/componentes/campos/comum/`. |
| **Chamada externa de aplicativos** | 1 | `form_autor_rede_social.dart`. |

---

### ✅ Total: **31 pontos**

---
