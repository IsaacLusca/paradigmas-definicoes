# TEMPLATE - Formato padrão dos resumos

> Este arquivo define o formato dos resumos em `definicoes/`. Todo resumo novo deve
> seguir esta estrutura. O **objetivo**: além de listar definições, **explicar o porquê**
> de cada conceito existir — com motivação, analogia, exemplo negativo e síntese.

---

## Estrutura obrigatória

```markdown
# NN.aula_NN - <Título do Tópico> (<Linguagem>)

**Fonte:** <caminho no documento-base>
**Linguagem:** <Prolog, Haskell, APL, Smalltalk, Forth, Fortran, nasm...>
**Códigos usados:** `codes/` (veja a seção "Códigos fonte usados no resumo")

---

## 1. Contexto / Motivação

- <O que é o tópico e por que existe. História, problema que resolve, autores.
  Responder: por que alguém inventou isso?>

## 2. <Conceito central>

### O problema / A ideia por trás

- <EXPLICAÇÃO DETALHADA: o porquê do conceito. Mostre o raciocínio completo,
  não apenas a definição pronta.>

- <Exemplo negativo: o que aconteceria sem o conceito (ciclo, erro, falha)?
  De preferência com código/raciocínio que demonstra o problema.>

- <Analogia do mundo real ou de outro domínio que torne o conceito concreto.>

| Tabela | de | síntese |
|---|---|---|
| ... | ... | ... |

## 3. <Próximo conceito>

... (mesmo padrão)

## N. Código de exemplo (do codes/ da fonte)

\```<linguagem>
<exemplos reais da pasta codes/, sem inventar>
\```

## N+1. Referências / Fontes

- <links e livros citados na aula>
```

---

## Regras de estilo para "explicação detalhada"

1. **Todo conceito responde ao "porquê".** Não basta "X é Y"; explique *por que X
   precisa existir* e o que aconteceria sem ele (ex.: regressão infinita de definições,
   unificação falhando, ausência de parâmetros, etc.).
2. **Exemplo negativo primeiro.** Mostre o problema/caso que falha antes da solução —
   isso fixa a motivação (ex.: `composta_fail.pl` antes dos predicados de controle).
3. **Analogia concreta** sempre que possível (Euclides/geometria, mundo real, outro
   paradigma já estudado).
4. **Síntese em tabela** ao fim de cada conceito — colunas curtas (Termo | Papel,
   Operação | Leitura | Definição).
5. **Código real da fonte**, copiado de `codes/` do módulo correspondente. Os arquivos
   usados no resumo devem ser **copiados** para a pasta da aula
   (`definicoes/NN_<topico>/aula_NN_<nome>/codes/`) e listados numa tabela final
   ("Códigos fonte usados no resumo") com o nome do arquivo, o conteúdo e a seção onde é
   usado. Não inventar exemplos.
6. **Seções numeradas** (`## 1.`, `## 2.`, ...) para permitir linkar/consultar.
7. **Imagens/diagramas** (diagramas de fluxo, árvores, figuras conceituais): salvar em
   `definicoes/NN_<topico>/img/` e referenciar com `![desc](img/nome.png)`. Não copiar
   retratos/fotos decorativas — só o que agrega entendimento.
8. **Linguagem acessível**: parágrafos curtos, sem jargão não explicado.
