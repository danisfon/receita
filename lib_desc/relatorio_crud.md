
# Relatório de Classificação dos CRUDs

---

## 🧾 Classificação dos CRUDs

| Formulário                             | Tipo      | Justificativa                                                                 |
|---------------------------------------|-----------|------------------------------------------------------------------------------|
| **form_categoria.dart**               | **Simples** | A tabela `categoria` não possui chaves estrangeiras nem se relaciona com outras tabelas. |
| **form_autor.dart**                   | **Simples** | A tabela `autor` não possui chaves estrangeiras nem se relaciona com outras tabelas. |
| **form_ingrediente.dart**             | **Simples** | A tabela `ingrediente` não possui chaves estrangeiras nem se relaciona com outras tabelas. |
| **form_utensilio.dart**               | **Simples** | A tabela `utensilio` não possui chaves estrangeiras nem se relaciona com outras tabelas. |
| **form_dica.dart**                    | **1:N**     | Cada dica pertence a **1 autor**, e um autor pode ter **muitas dicas** (`autor_id`). |
| **form_receita.dart**                 | **1:N**     | Cada receita pertence a **1 categoria** e **1 autor**, e ambos podem ter **muitas receitas**. |
| **form_comentario.dart**              | **1:N**     | Cada comentário pertence a **1 receita** e **1 autor**, e ambos podem ter **muitos comentários**. |
| **form_autor_rede_social.dart**       | **1:N**     | Cada rede social pertence a **1 autor**, e um autor pode ter **muitas redes sociais**. |
| **form_receita_ingrediente.dart**     | **N:N**     | Um ingrediente pode estar em **muitas receitas** e uma receita pode usar **muitos ingredientes**. |
| **form_autor_receita_favorita.dart**  | **N:N**     | Um autor pode favoritar **muitas receitas** e uma receita pode ser favorita de **muitos autores**. |

---
