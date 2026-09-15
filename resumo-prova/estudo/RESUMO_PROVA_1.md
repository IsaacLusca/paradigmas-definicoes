# RESUMO GERAL — PROVA 1 (Paradigmas de Programação)

> Material **único e autocontido** de estudo: dá para estudar **só por este arquivo**,
> sem precisar abrir `definicoes/`, `documento-base/` ou as listas.
> Cada conceito vem com **definição + exemplo resolvido** no estilo da prova
> (conceito + análise de código: traço de execução, unificação, aritmética, combinadores).
>
> **Cobre:** Programação Lógica (Prolog, aulas 01–06) + Combinadores (Introdução e Base SK).
> **Não cobre:** Cálculo Lambda e Haskell (não caem nesta prova).
>
> **Como usar:** leia as seções 1–8 em ordem (cada uma explica a base do zero);
> depois treine a seção 9 (padrões de código) e confira a 11 (erros clássicos);
> feche com os 3 simulados (`simulador.html`) e o checklist da seção 12.

---

## 0. Como a prova é montada (leia isto primeiro)

> **Aviso (informação de aula):** segundo o professor, **não haverá escrita de código** nesta prova —
> no máximo **código para analisar** (traço/resultado de consultas, contagem, reduções). Por isso os
> **simulados** foram ajustados para o formato abaixo (12 MC + 2 abertas, 30 pts), cobrindo o mesmo
> conteúdo da prova original.

**Formato dos simulados (`resumo-prova/simulados/` e `simulador.html`):**

| Parte | Questões | Valor | O que cobra |
|---|---|---|---|
| **A** | 12 múltipla escolha (5 alternativas) | 2 pts cada | Conceito + **análise de código** (traço de execução, unificação, aritmética, combinadores) |
| **B** | 2 questões abertas (Q13–Q14) | 3 pts cada | Resposta numérica/curta em **CDU** (centena, dezena, unidade) |

**Formato da Prova 1 aplicada (código 4BAE41), para referência:**

| Parte | Questões | Valor | O que cobrava |
|---|---|---|---|
| **A** | 10 múltipla escolha | 2 pts cada | Conceito + leitura de código |
| **B** | 2 abertas (Q11–Q12) | 2 pts cada | Resposta em **CDU** |
| **C** | 2 implementações (Q13–Q14) | 3 pts cada | Escrever predicado Prolog (não haverá nesta prova) |

**Regras do jogo:**
- Gabarito **à caneta** (lápis/rasura = zero).
- O gabarito da Parte B é em **CDU**: ex., resposta `4` → C=0, D=0, U=4; resposta `23` → C=0, D=2, U=3; resposta `370` → C=3, D=7, U=0.
- Interpretação do enunciado faz parte da avaliação.

**Gabarito da Prova 1 (4BAE41):** `E B A A A D A C B A | 004 | 003 | is_sum_of_5 | power_of_5`

**O que a Prova 2 de 704C60 contribui (sem Lambda/Haskell):** questões de **Combinadores e Base SK**
(Q1 Schönfinkel/Z, Q2 redução SKSabc, Q3 definição de combinador, Q13 redução-β com dígitos).
As questões de λ puro (Q4, Q5, Q12) e Haskell (Q6–Q11, Q14–Q16) **não** entram.

### 0.1. O que mais cai — confirmado nas **provas reais** (fonte confiável)

> Referência: as duas provas **aplicadas** (`prova_1/4BAE41` e `prova_2/704C60`). Os
> **simulados** foram feitos com IA: servem para treinar, mas **não** são a referência.

| Tema | Prova real | Questão |
|---|---|---|
| Conectivo pelo símbolo (bicondicional = **↔**) | 4BAE41 | Q1 |
| Predicado ↔ conectivo em **mundo fechado** (`op(true,true)` → conjunção) | 4BAE41 | Q2 |
| **Nº de linhas da tabela-verdade** de proposição composta ($2^n$) | 4BAE41 | Q11 |
| Aritmética/precedência (`X is 2 + 1*3` → 5) | 4BAE41 | Q3 |
| `:- op` (precedência, associatividade, posição) | 4BAE41 | Q4 |
| Porta **`redo`** ao digitar `;` | 4BAE41 | Q5 |
| **Aridade** (`alfa(a,1,True)` → `alfa/3`) | 4BAE41 | Q6 |
| Traço de recursão (Collatz: `f(10,4,X)` → `X=4`) | 4BAE41 | Q7 |
| Contagem de consultas **falsas** na unificação | 4BAE41 | Q8 |
| `\=` (não unifica) | 4BAE41 | Q9 |
| Recursão em lista (`p([2,3,5],X)` → `X=1`) | 4BAE41 | Q10 |
| **Contagem de regras** | 4BAE41 | Q12 |
| Schönfinkel: **Z = composição** | 704C60 | Q1 |
| Redução `SKSabc = abc` | 704C60 | Q2 |
| **Definição de combinador**: $\mathrm{FV}(M)=\emptyset$ | 704C60 | Q3 |
| Redução-β com dígitos (`...307` → **370**) | 704C60 | Q13 |

---

## 1. Lógica Proposicional Booleana

> **Contexto (aula 01):** **George Boole** (1815–1864) propôs formalizar a lógica com
> matemática — *The Mathematical Analysis of Logic* (1847) e *An Investigation of the Laws
> of Thought* (1849). **Prolog (1972)** = *"PROgramming in LOGic"*, de **Alain Colmerauer**
> e **Philippe Roussel**, com inspiração de **Robert Kowalski**; tem raízes na lógica de
> primeira ordem.

### 1.1. Conectivos (com todas as notações)

| Operação | Símbolos | Leitura | Definição |
|---|---|---|---|
| Negação | $\lnot a$ · $\sim a$ · $\bar{a}$ · `NOT` | não $a$ | inverte o valor de $a$ |
| Disjunção | $a \vee b$ · $a \mid b$ · $a + b$ · `OR` | $a$ ou $b$ | **falso só se ambos falsos** |
| Conjunção | $a \land b$ · $a \& b$ · $a \cdot b$ · `AND` | $a$ e $b$ | **verdadeiro só se ambos verdadeiros** |
| Condicional | $a \to b$ · $a \Rightarrow b$ · $a \supset b$ | se $a$, então $b$ | **falso só se $a$=V e $b$=F** |
| Bicondicional | $a \leftrightarrow b$ · $a \iff b$ · $a \equiv b$ | $a$ sse $b$ | verdadeiro se **mesmo valor** |
| Disjunção exclusiva (XOR) | $a \veebar b$ · $a \oplus b$ · `a xor b` | $a$ ou $b$, **mas não ambos** | verdadeiro **só** se os valores forem **diferentes** |

**Pegadinha da prova (Q1):** "qual conectivo representa a bicondicional?" → **↔** (alternativa E).

### 1.1b. Proposições compostas — o que mais cai (base: Prova 1 real 4BAE41)

| Item | Como apareceu na prova real |
|---|---|
| **Nº de linhas da tabela-verdade** de uma composta | Q11: $(p \lor (q \land p)) \land (\sim p \lor (p \land q))$ → só $p,q$ → $2^2 = \mathbf{004}$ |
| **Identificar o conectivo** pelo símbolo | Q1: bicondicional = **↔** |
| **Predicado ↔ conectivo** em mundo fechado | Q2: `op(true, true).` (único fato) → **conjunção** |
| **Predicado não é função** (controle × aninhamento) | `and(or(true,false),true)` → `false`; `(false ; true), true` → `true` |

Consultas e resultados (arquivo executável: `definicoes/02_programacao_logica/aula_01_logica_proposicional_booleana/codes/proposicoes_compostas.pl` — rode `?- demo.` para as tabelas completas):

| Consulta | Resultado |
|---|---|
| `?- true, true.` | `true` |
| `?- true, false.` | `false` |
| `?- false ; true.` | `true` |
| `?- false ; false.` | `false` |
| `?- \+ true.` | `false` |
| `?- ((false ; true), true).` | `true` |
| `?- and(or(true, false), true).` | `false` |

Mais casos — transcrição `?- sessao.` (foco nos **operadores de controle**):

```prolog
?- true.                    % --- constantes de controle ---
true.
?- false.
false.
?- fail.
false.

?- true, true.              % --- conjuncao  ,  (a e b) ---
true.
?- true, false.
false.
?- false ; true.            % --- disjuncao  ;  (a ou b) ---
true.
?- false ; false.
false.
?- \+ true.                 % --- negacao  \+  (nao a) ---
false.
?- \+ (true, false).
true.
?- true -> true.            % --- condicional  ->  (se a entao b) ---
true.
?- true -> false.
false.
?- false -> true.
false.
?- (true -> false ; true).  % o '->' COMITA: nao cai no 'else'
false.
?- (false ; true), true.    % --- precedencia ---
true.
?- \+ true ; false.
false.                      % = (\+ true) ; false
```

> Os **simulados** (feitos com IA) também cobram XOR/NAND/NOR e regras "falso/verdadeiro apenas
> quando...", mas **isso não apareceu na Prova 1 real (4BAE41)** — priorize os 4 itens acima.

### 1.2. Tabela-verdade e número de linhas

- O nº de linhas de uma tabela-verdade é $2^n$, onde **$n$ = nº de proposições simples distintas**.
- **(Q11 — Prova 1):** $P: (p \lor (q \land p)) \land (\sim p \lor (p \land q))$ → só $p$ e $q$ → $2^2 = \mathbf{4}$ → **004**.
- *Pegadinha:* as repetições de $p$ e $q$ não contam; proposições compostas internas também não.

**Receita para montar (ordem-padrão das combinações).** Cada variável tem **metade V e metade F**, e os blocos vão **caindo pela metade** da esquerda para a direita (a última coluna alterna a cada linha). Para n = 3:

```
p:  V V V V F F F F     % blocos de 4 (= 2^(n-1))
q:  V V F F V V F F     % blocos de 2 (= 2^(n-2))
r:  V F V F V F V F     % alterna a cada linha (= 2^0)
```

- Alternativa para conferir (contagem binária): F = 0, V = 1 e conte de $0$ a $2^n - 1$.
- **Para preencher as demais colunas:** calcule **de dentro para fora** (subexpressões na
  ordem da precedência: `¬` → `∧` → `∨` → `→`/`↔`) e deixe o conectivo principal por último.
- **Conferência:** toda coluna de **variável** tem exatamente metade V e metade F.

### 1.3. Termos primitivos e axiomas (cai como conceito)

**Por que isso existe — a regressão infinita das definições.** Toda definição usa palavras, e
cada palavra usada precisaria, por sua vez, ser definida. Exemplo ao definir a conjunção:
*"a ∧ b é verdadeiro quando a e b são ambos verdadeiros"* → o que é "verdadeiro"? → o que é
"proposição"? → "afirmação", "sentença", "significado"?... Ou voltamos sempre ao mesmo ponto
(definições circulares), ou nunca chegamos ao fim (**regressão infinita**). Formalizar a
lógica exige **parar o ciclo**: um limite em que o vocabulário e as regras são aceitos
**sem definição nem prova**.

**Termos primitivos — o vocabulário dado, aceito sem definição** (base da programação lógica):

| Termo primitivo | Papel no sistema |
|---|---|
| **Proposição** | unidade mínima que pode ser julgada: afirma um fato e pode ser avaliada como V ou F ("está chovendo", "2 + 2 = 4") |
| **Verdadeiro** | um dos dois valores lógicos possíveis de uma proposição |
| **Falso** | o outro valor lógico possível |

> Ex.: "2 + 2 = 4" **é** verdadeira — não precisamos definir "verdadeiro" para usar o termo.

**Axiomas — as verdades assumidas, aceitas sem prova.** Não se provam: são o alicerce de toda
dedução (provar um axioma exigiria outros axiomas → ciclo de novo).

| Axioma | Enunciado | Frase típica que o viola |
|---|---|---|
| **Terceiro excluído** (*tertium non datur*) | toda proposição é V **ou** F — não há terceira possibilidade | "nem verdadeira nem falsa" |
| **Não-contradição** | uma proposição **não pode** ser V **e** F ao mesmo tempo | "ao mesmo tempo verdadeira e falsa" |

**Síntese que cai como conceito:** o terceiro excluído garante **pelo menos um** valor; a
não-contradição garante **no máximo um** ⇒ toda proposição tem **exatamente um** dos dois ⇒
o universo de valores lógicos é **{V, F}** (o pressuposto que torna a lógica booleana
possível — e ecoa no `true/0` e `false/0` do Prolog).

**Analogia de Euclides:** primitivos = **ponto, reta, plano** (intuitivos, sem definição
formal); axiomas/postulados = "por dois pontos distintos passa uma única reta" (aceitos sem
prova); derivados = teoremas como o de Pitágoras (**provados** a partir deles). Na lógica:
primitivos + axiomas são o "térreo"; conectivos, fatos, regras e teoremas são os andares
construídos em cima.

**Pegadinhas e falsos amigos:**
- (lista Q1) "ao mesmo tempo verdadeira e falsa" viola a **não-contradição**, **não** o
  terceiro excluído — o enunciado mistura os dois de propósito.
- **Falsos amigos:** "termo primitivo" **aqui** é vocabulário da lógica. Em outras aulas a
  palavra tem outro sentido: **átomos e números** são os termos primitivos de Prolog
  (seção 3) e **S e K** são as primitivas da base SK (seção 8) — não é o mesmo conceito.

### 1.4. Exercícios de fixação da lista

- (Q2) "Se fizer bom tempo amanhã eu vou" = $p \to q$ (V). Situação **impossível**: **fazer bom
  tempo e não ir** (único caso em que V→F é falso).
- (Q3) menor natural $x$ com $x/2 > \pi$: $\pi \approx 3{,}1416 \Rightarrow x > 6{,}28 \Rightarrow x = \mathbf{7}$.

---

## 2. Fatos, Regras e Cláusulas em Prolog

### 2.0. O que existe em Prolog: só termos

- Em Prolog há **um único tipo de dado: o termo**. Tudo (dados e programa) é termo.
- Espécies de termo:
  - **átomo**: nome próprio começando com **minúscula** (`ana`, `mg`, `true`). Se tiver
    maiúscula, espaço ou começar com número, usa aspas: `'Pedro Lucas'`, `'Cálculo 1'`.
  - **número**: primitivo (`1`, `5.16`, `-10`). Não precisa de aspas.
  - **variável**: começa com **Maiúscula ou `_`** (`X`, `True`, `_`, `_Nome`). É um "buraco"
    a ser preenchido por unificação — **não guarda valor como em Python**.
  - **termo composto / estrutura**: `functor(arg1, ..., argN)` (`car(honda, red, 4)`,
    `and(or(true,false),true)`). O `functor/aridade` (`car/3`) identifica a estrutura.
- **Universo U:** toda variável varia sobre um conjunto universo `U` (ex.: pessoas, números).
  Uma **constante** é um membro específico de `U` (`'Carlos'`, `38`); uma **variável**
  (`X`, `Idade`) é um objeto **não especificado** de `U` que a consulta tenta descobrir:
  `paciente('Carlos', 38).` (constantes) vs `?- paciente(X, Idade).` (variáveis a atar).
- **Sentença aberta `S(x)`:** fórmula com variável livre (ex.: "`x` é estudante da FCTE").
  Ao substituir `x` por uma constante `v`, vira **proposição** (V ou F):
  `x = ana` → V; `x = diana` → F. Também chamada de **predicado / função proposicional**.
- **Exemplos da aula:**
  ```prolog
  cotacao(dolar, 5.16).
  paciente('Pedro Lucas', 40).
  limites(eixo_x, -10, 10).
  ```

### 2.1. Vocabulário (cobrado em prova)

| Termo | Definição |
|---|---|
| **Fato** | predicado mais simples; equivale a proposição verdadeira: `time('Monkeys', 1, 'go').` |
| **Regra** | cabeça `:-` corpo (proposição composta); corpo omitido = fato. `f(1).` ≡ `f(1) :- true.` |
| **Cláusula** | qualquer fato **ou** regra (fatos + regras = cláusulas) |
| **Aridade** | nº de argumentos do predicado: `alfa(a, 1, True)` → `alfa/3` (aridade **3**) |

**(Q6 — Prova 1):** `alfa(a, 1, True).` → aridade **3** → **D**.
**(Q12 — Prova 1):** no código, contar **regras** (cláusulas com corpo):
`f(X,Y) :- ...`, `f(X,X) :- ...`, `g(Z) :- ...` → **3 regras** → **003**. (Os 7 `f/g/h` de cima são **fatos**, não contam.)

### 2.2. Mundo fechado (*closed world*)

**Tudo que não está declarado é falso.** Só o que aparece na base é verdadeiro.

> **Por quê:** o Prolog não tem axiomas sobre o domínio — a base é **tudo o que se sabe**.
> Quando uma consulta falha, ele não conclui que "é falso de verdade": conclui que **não há
> prova** (mesma ideia da negação por falha `\+`, seção 3.2). Tratar "não provado" como falso
> é a **hipótese do mundo fechado**.

**(Q2 — Prova 1):** `op(true, true).` é o único fato. Logo:
- `op(true,true)` → **true**
- `op(true,false)`, `op(false,true)`, `op(false,false)` → **false** (não declarados)

Isso é exatamente a tabela da **conjunção** (V só quando ambos V) → **B**.
*Cuidado:* sem pensar no mundo fechado, seria natural chutar "disjunção".

### 2.3. Regras: múltiplas cláusulas = disjunção

```prolog
selecionado(X) :- campeao(X).
selecionado(X) :- time(X, _, 'mg').
```
= "é selecionado se for campeão **ou** tiver time de mg". O predicado é a **disjunção** de todas
as cláusulas. As duas formas abaixo são **equivalentes**:

```prolog
unb(X) :- (fcte(X) ; darcy(X)).     % uma cláusula, corpo com OU
unb2(X) :- fcte(X).                 % duas cláusulas = mesmo OU
unb2(X) :- darcy(X).
```

- **Precedência do `;`:** a vírgula `,` (1000) liga **mais forte** que o `;` (1100).
  Logo `a ; b , c` significa `a ; (b , c)` — e `(false ; true), true` **exige parênteses**;
  sem eles, seria lido como `false ; (true, true)`.
- **Predicado não é função:** predicado **nunca retorna nada** — ele **sucede ou falha**
  por unificação. `and(or(true,false),true)` dá `false` porque o termo composto
  `or(...)` **não casa** com nenhum fato (não há "avaliação aninhada" como em Python).
  E `True` (maiúscula) é **variável livre** → busca infinita, não o valor verdadeiro.
  *(Para as tabelas de consulta→resultado dos conectivos de controle, veja a seção 1.1b e o
  arquivo `codes/proposicoes_compostas.pl`.)*

### 2.3b. Quantificadores: o que a consulta significa

- **Existencial `∃x. S(x)`** = "existe `v` tal que `S(v)` é V". Em Prolog, é **uma consulta
  com variável lógica**: `?- unb(X).` pede um `X` que torne `unb(X)` verdadeiro;
  o `;` pede **mais respostas** (`X=ana ; X=beto ; ...`). `?- unb(fernando).` → `false`
  (nenhum `v` funciona).
- **Universal `∀x. S(x)`** = "para **todo** `v`, `S(v)` é V". Em Prolog, é um **fato que casa
  com tudo**, em geral com a anônima `_` (variável não usada no corpo):
  ```prolog
  is_term(_).
  ?- is_term(1).    % true (casa com tudo)
  ?- is_term(A).    % true
  ?- is_term(A, B). % erro (aridade: is_term/1 ≠ is_term/2)
  ```

### 2.4. Maiúsculas/minúsculas e símbolos

- Minúscula = **átomo** (`true`, `mg`) · Maiúscula/`_` = **variável** (`True` é variável!).
  Por isso `true/0` e `false/0` são **predicados** (fatos), não "dados booleanos":
  `?- true.` sucede, `?- True.` (variável livre) entra em busca infinita.
- Átomos com maiúscula/espaços precisam de aspas: `'Pedro Lucas'`, `'Cálculo 1'`.
- Números são primitivos e casam só com eles mesmos: `limites(eixo_x, -10, 10).`

### 2.5. Declaração e manipulação da base (fatos dinâmicos)

| Recurso | Uso |
|---|---|
| `prolog -s arquivo.pl` (Windows: `swipl -s arquivo.pl`) | carrega na inicialização |
| `consult('a.pl')` / `reconsult('a.pl')` | carregar / recarregar em sessão |
| `:- dynamic pred/N.` | habilita declarar/retirar fatos em execução (**só em arquivo**) |
| `asserta(fato)` / `assertz(fato)` | insere no **início** / **fim** |
| `retract(fato)` | **remove** um fato |

- **Ordem importa:** a consulta percorre as cláusulas **de cima para baixo**, então
  `asserta` (início) responde **antes** e `assertz` (fim) responde **depois**:
  ```prolog
  % base: coordenador(matheus). coordenador(himilsys). coordenador(batistuta). coordenador(sebastien).
  ?- asserta(coordenador(andrea)), assertz(coordenador(john)), retract(coordenador(matheus)).
  ?- coordenador(X).
  X = andrea ; X = himilsys ; X = batistuta ; X = sebastien ; X = john.
  ```

---

## 3. Unificação — o coração do Prolog

### 3.1. Regras de unificação

| Elementos | Comportamento |
|---|---|
| **variável × termo** | sempre unifica; a variável é **atada** ao termo |
| **primitivo × primitivo** | unifica só se **idênticos** (`a` com `b` não) |
| **estrutura × estrutura** | mesmo **construtor** + mesma **aridade** + argumentos par a par |
| **`_` (anônima)** | casa com tudo, **não** é atada |

- **Versão simplificada (só fatos — cai como traço):** para unificar `?- p(args).` com um
  fato `p(args).`, precisa das **3 condições**: (1) mesmo predicado, (2) mesma aridade,
  (3) mesmos argumentos posição a posição. E **a mesma variável força igualdade**:
  ```prolog
  % f(1,1). f(1,2). f(1,3). f(2,1). f(2,2). f(2,3). g(a,1). g(1,a).
  ?- f(3,3).   % false (nenhum fato tem esses args)
  ?- f(1).     % false (aridade: f/2 ≠ f/1)
  ?- f(X,X).   % X=1 ; X=2 (só valem os fatos com os dois args iguais)
  ?- g(X,X).   % false (a≠1 em toda posição simultânea)
  ```
- **Cadeia de apelidos (alias):** variáveis atadas entre si propagam o valor:
  `?- X = Y, a(Z) = a(Y), X = teste.` → `X = Y, Y = Z, Z = teste`
  (atar `X=teste` preenche toda a cadeia).

### 3.2. Os predicados que a prova mistura (decore a diferença!)

| Predicado | Significado | Exemplo |
|---|---|---|
| `=` | **unifica** (sintático, não calcula) | `2 + 2 = 4` → **false** |
| `\=` | verdadeiro se **não unifica** | `a \= b` → true |
| `\+` | negação por falha (não há prova) | `\+ member(x, [])` → true |
| `is` | **avalia** expressão e ata | `X is 2+2` → `X = 4` |
| `=:=` | comparação de **valor** | `2 + 2 =:= 4` → **true** |
| `=\=` | diferente em **valor** | `2 + 2 =\= 5` → true |

- **(Q9 — Prova 1):** "não unifica" → **`\=`** (B). *`\+` nega um objetivo, não compara dois termos.*
- **Negação por falha (`\+/1`):** `\+ G` é verdadeiro quando **não há prova** de `G`
  (não é "falso lógico", é "falha em provar"). É um **predicado de controle traduzido
  pelo compilador**, não um fato da base: `?- \+ member(x, []).` → `true`.

### 3.3. Exemplos resolvidos (Q8 — Prova 1: quantas consultas retornam falso?)

```prolog
?- 2 + 2 = 4.                     % FALSE — = não avalia: 2+2 é um termo, ≠ 4
?- X = Y.                         % true  — duas variáveis sempre unificam
?- f(_) = f(x, x).                % FALSE — aridades diferentes (f/1 vs f/2)
?- f(_, g(B,c)) = f(A, g(b,C)), B \= C.
      % B = b, C = c, então B \= C → b \= c → true
?- [_, X, _] = [1,2,3].           % X = 2 (posição a posição)
?- [H|T] = [].                    % FALSE — [] nunca unifica com [H|T]
?- asserta(f([a,b,c], d)), f(X, d).  % X = [a,b,c] (lista inteira como argumento)
```
→ Na Q8, **2 falsas** → **C**.

### 3.4. Pegadinhas de variáveis (lista)

- `X = Y, Y \= Z, Z = W, X = a, W = b.` → **falha**: no momento de `Y \= Z` ambas são **livres** e
  **unificam** (duas variáveis sempre unificam) → `\=` é falso → consulta falha como um todo.
  **Correção:** instanciar antes: `X = Y, Z = W, X = a, W = b, Y \= Z.` → agora `a \= b` → true.
- `same_parity(X,Y) :- mod(X,2) = mod(Y,2).` → **errado**: `=` não calcula.
  **Correção:** `same_parity(X,Y) :- mod(X,2) =:= mod(Y,2).`
- `is_set(1, 2, 3)` com `is_set/1` → **erro**: o predicado tem aridade 1; a consulta tenta
  `is_set/3` (inexistente). Para lista: `is_set([1,2,3])`.

---

## 4. Backtracking e as 4 portas

### 4.0. Objetivo, atar e desatar (a mecânica)

- O padrão da consulta chama-se **objetivo** (*goal*): `?- cidade(X, mt).` tem objetivo
  `cidade(X, mt)`.
- Quando uma variável casa com um termo, ela fica **atada** (amarrada àquele valor).
  O algoritmo, para cada objetivo: (1) percorre as cláusulas de cima para baixo,
  (2) ao unificar, deixa uma **marcação** (choice point) e retorna os atados/`true`,
  (3) no `;`, **retoma da última marcação desatando** as variáveis atadas depois dela.
- `redo` **desata só o último** predicado da consulta composta; o que foi atado à
  esquerda **permanece atado** (é por isso que o traço anda "para a direita" e volta).

### 4.1. As portas (call/exit/fail/redo)

| Porta | O que acontece |
|---|---|
| **call** | avaliação começa |
| **exit** | cláusula unificou → sucesso, variáveis atadas |
| **fail** | nenhuma cláusula unificou |
| **redo** | usuário pede mais respostas: retoma da **última marcação**, **desatando** variáveis |

**(Q5 — Prova 1):** para entrar num objetivo pela porta **redo**, digita-se **`;`** → **A**.

### 4.2. Consultas compostas

- Unifica da **esquerda para a direita**; sucesso só se sair por `exit` do **último** predicado.
- Se falha **um** objetivo, a consulta composta **falha inteira**.
- O `;` força `redo` no **último** predicado (não em todos).
- O **escopo** de uma variável é a consulta: o mesmo nome em predicados diferentes = **mesma variável**.
- **Exemplo de traço composto:** com `cidade(X,Y)` (várias cidades/UFs), `regiao(centro_oeste, Y)`
  e `capital(X)`:
  `?- cidade(X, Y), regiao(centro_oeste, Y), capital(X).`
  1. `cidade(X,Y)` ata a 1ª cidade; 2. `regiao(...)` testa o `Y` atado — se falha, volta
     (`redo`) em `cidade` para a **próxima** cidade, desatando `X,Y`; 3. só quando os dois
     da esquerda têm `exit` é que `capital(X)` é chamado com o `X` já atado.

**Traço concreto com as portas** (decore esta sequência — é o que a prova chama de "traço"):

```prolog
cor(vermelho).
cor(azul).
```

```prolog
?- cor(X).        % call → exit X=vermelho ; redo → exit X=azul ; redo → fail (cláusulas acabaram)
```

Consulta composta — **a falha da direita dispara o `redo` da esquerda sozinha**:

```prolog
?- cor(X), X = azul.
   call cor(X)  → exit X = vermelho
   call X=azul  → fail             (vermelho ≠ azul)
   redo cor(X)  → desata X, exit X = azul
   call X=azul  → exit             → sucesso total: X = azul
```

> Note que **não** se digitou `;`: falha no meio da conjunção força o backtracking automaticamente.

### 4.2b. Depurando com trace (para entender o traço)

- `?- trace.` liga o rastreador: cada passo mostra `call/exit/fail/redo`
  (`creep`/espaço avança um passo no SWI-Prolog). Desliga com `?- notrace.` + `?- nodebug.`
  ```prolog
  ?- trace.
  ?- unb(X).     % passo a passo: call → exit (1ª resposta) → ; → redo → exit (2ª) ...
  ```
  Na prova não se usa o trace, mas saber ler essas 4 portas **é** ler o traço cobrado.

### 4.3. Predicados extra-lógicos (controle)

- **Definição:** não têm cláusulas na base — na `call`, o interpretador chama uma
  **rotina interna** (efeito colateral: escrever, pular linha, falhar). Respondem tanto
  na `call` quanto na `redo`.

| Predicado | Na `call` | Na `redo` |
|---|---|---|
| `write/1` | escreve o termo | **sempre falha** |
| `nl/0` | nova linha | sempre falha |
| `tab/1` | avança N espaços | sempre falha |
| `fail/0` | sempre falha (= `false/0`) | — |

**Receita clássica (enumeração):** para imprimir **todos** os resultados sem interação, termine o
corpo com `fail` e adicione uma cláusula-fato para o predicado não "falhar":

```prolog
software :-
    estudante(E, _, 'Engenharia de Software'),
    writeln(E),
    fail.
software.                    % garante sucesso ao final
```

### 4.4. Condicionais `->`

```prolog
If -> Then ; Else
```
- Se `If` é verdadeiro → `Then`; senão → `Else`. O `->/2` é **extra-lógico**.
- **Atenção ao `;` do `->`**: `(A -> B ; C)` é o if-then-else; sem parênteses pode interagir com
  outras disjunções.
- **Pegadinha do commit:** `(true -> false ; true)` → **false**! O `->` **comita**: se a
  **condição** sucede e o *then* falha, o **else não roda** (o else só roda quando a **condição**
  falha). Leia como $(C \land T) \lor (\neg C \land E)$ — e **não** como $(C \to T) \lor E$.
  O commit também **poda alternativas da condição**: `member(X,[1,2,3]) -> ...` só usa `X=1`.
- **Padrão "tabela-verdade" da aula** (enumera combinações e imprime cada resultado;
  `bool/1` gera `true/false`, `call(Op,X,Y)` chama o conectivo, `fail` força o próximo):
  ```prolog
  :- meta_predicate execute_goal(2).

  execute_goal(Op, X, Y) :-
      (call(Op, X, Y) -> writeln(true) ; writeln(false)).

  truth_table(Op, Symbol) :-
      bool(X), bool(Y),
      write(X), write(' '), write(Symbol), write(' '), write(Y), write(' = '),
      execute_goal(Op, X, Y), fail.
  truth_table(_, _).      % cláusula final: garante sucesso ao fim da enumeração

  ?- truth_table(and, '&').
  true & true = true
  true & false = false
  false & true = false
  false & false = false
  true.
  ```

---

## 5. Aritmética em Prolog

### 5.1. `is/2` e precedência

- `Number is Expr.` — **avalia** `Expr` e **ata** `Number`. Parênteses alteram a ordem.
- **Regra de ouro:** na precedência do Prolog, **quanto MENOR o número, MAIOR a precedência**
  (liga mais forte antes).

**(Q3 — Prova 1):** `f(X) :- X is 2 + 1*3.` → `*` (400) liga mais forte que `+` (500) →
$2 + 3 = 5$ → **A** (`Y = 5`).

| Precedência | Operadores | Tipo |
|---|---|---|
| 1200 | `:-`, `-->` | xfx |
| 1100 | `;` (ou) | xfy |
| 1050 | `->` | xfy |
| 1000 | `,` (e) | xfy |
| 900 | `\+` (não) | fy |
| 700 | `=` `==` `\==` `<` `>` `=<` `>=` `=:=` `=\=` `is` | xfx |
| 500 | `+` `-` | yfx |
| 400 | `*` `/` `//` `div` `mod` | yfx |
| 200 | `^` (potência); `+`/`-` unários | xfy/fy |

> Consequência prática: `a ; b , c` = `a ; (b , c)` (o `,` liga mais forte que `;`) — por isso os
> parênteses em `(false ; true), true` são **obrigatórios**.

> **`:-` (1200) tem dois papéis:** **regra** (`cabeça :- corpo`, **xfx** — ler "cabeça SE corpo";
> o corpo **implica** a cabeça: `corpo → cabeça`) e **diretiva** (`:- Objetivo.`, **fx** — roda ao
> carregar o arquivo, ex.: `:- op(...)`, `:- dynamic p/1`, `:- use_module(...)`). E `?-` (fx, 1200)
> é a **consulta** do listener. Demo: `codes/precedencia_conectivos.pl` (`?- demo.`, seção 6).

> **Notação de tipo (`f`, `x`, `y`)** — é padrão do Prolog. `f` = posição do **operador**
> (`a Op b` → `xfy`); **`x`** = lado com precedência **estritamente menor** (não aceita o mesmo
> operador → lado "travado"); **`y`** = lado com precedência **≤** (aceita o mesmo operador →
> encadeia). Daí:
> - `xfx` = **não associa** (`=` 700 → `a = b = c` = **erro de sintaxe**; use `(a=b), (b=c)`);
> - `xfy` = associa **à direita** (`,` `;` `->` `:-` `^` → `2^3^2` = `2^(3^2)` = **512**);
> - `yfx` = associa **à esquerda** (`+` `-` `*` `/` → `10-2-3` = `(10-2)-3` = **5**);
> - `fy`/`fx` = **prefixo** (`\+`; `:-` diretiva); `yf`/`xf` = pós-fixo (raro).
>
> Demo com árvores canônicas: `codes/tipos_operadores.pl` (`?- demo.`) — seção 5.1 da aula 01.

### 5.2. Declarar operadores (Q4!)

- **(Q4 — Prova 1):** diretiva que define precedência, associatividade e posição → **`:- op`** (A).
- Sintaxe: `:- op(Precedencia, Tipo, Nome).`
  - A precedência é um **inteiro entre 0 e 1200**.
  - O `Tipo` combina **posição** (`f` = operador, `x`/`y` = argumentos) com **associatividade**:
    `xfx` (não associativo: `a =:= b =:= c` dá **erro**), `xfy` (assoc. à direita:
    `a^b^c` = `a^(b^c)`), `yfx` (assoc. à esquerda: `a+b+c` = `(a+b)+c`),
    `fy`/`fx` (prefixo, ex. `\+`), `xf` (pós-fixado).
  - `current_op(P, T, N)` consulta operador existente; precedência `0` apaga
    (`:- op(0, xfx, foo).`).

### 5.3. Aritméticos e relacionais

- Aritméticos: `+ - * / // div mod ^ **` — atenção às divisões/potências:
  `2/5 = 0.4` (real), `20//3 = 6` e `div` (quociente inteiro), `mod` (resto),
  `^` e `**` (potência). Funções como `sqrt/1` valem **dentro** de `is/2`:
  `X is sqrt(Delta)`.
- Relacionais (700, xfx): `>` `<` `>=` `=<` `=:=` `=\=` — **comparam valores calculados**
  (`=<` é escrito assim, não `<=`).

```prolog
% exemplo da aula: guarda relacional + função própria + sqrt no mesmo is/2
roots(A, B, C, X) :-
    A =\= 0,                            % guarda relacional (A ≠ 0)
    Delta is B^2 - 4*A*C,
    S is root_signal(Delta),            % função aritmética própria
    X is (-B + S*sqrt(Delta))/(2*A).
```

### 5.4. Funções aritméticas próprias (estilo lista Q10)

```prolog
:- use_module(library(arithmetic)).
:- arithmetic_function(divisores/1).      % aridade = aridade do predicado - 1
:- op(700, xfx, divisores).                % vira operador infixado não associativo

divisores(N, X) :- ...                     % último argumento = retorno
```
Com isso: `?- 60 divisores X.` → `X = 12.` e `?- R is divisores(20).` → `R = 6.`

- **Uso aninhado dentro do `is/2`** (mesmo sem `op/3`):
  ```prolog
  :- arithmetic_function(number_of_lines/1).
  number_of_lines(N, Res) :- Res is 2^N.
  ?- X is 1 + number_of_lines(4).    % X = 17
  ```

### 5.5. Idioma `between` + `\=\=` (gerar sem repetir — estilo Sudoku da aula)

```prolog
permutation(A, B, C, D) :-
    between(1, 4, A), between(1, 4, B),
    between(1, 4, C), between(1, 4, D),
    A =\= B, A =\= C, A =\= D, B =\= C, B =\= D, C =\= D.
```
- `between` **gera** candidatos; `\=\=` (valor diferente) **filtra** repetições.
  Compare com a Q13 (`is_sum_of_5`, seção 9.2): lá o filtro é `A < B < C < D < E`
  (ordenado, evita permutações); aqui é `\=\=` par a par. Dois sabores do mesmo idioma.

### 5.6. Predicados com múltiplas semânticas

- `var/1` (livre), `nonvar/1` (atado), `integer/1`, `number/1`, `atom/1`.
- `succ/2` funciona nas duas direções: `succ(2, S)` → `S = 3`; `succ(A, 2)` → `A = 1`.
- Padrão (ex. Celsius/Fahrenheit): testar quem está atado e escolher o ramo:

```prolog
celsius_fahrenheit(C, F) :-
    (nonvar(C) -> F is C*9/5 + 32 ; C is (F - 32)*5/9).
```
- **Guarda da aula:** se **ambas** livres, nada há para calcular → erro de instanciação:
  ```prolog
  celsius_fahrenheit(C, F) :-
      ((var(C), var(F)) -> instantiation_error('Ao menos uma var. deve estar atada') ; true),
      (nonvar(C) -> F is C*9/5 + 32 ; C is (F - 32)*5/9).
  ```
  E `?- celsius_fahrenheit(100, 100).` → **false** (100°C ≠ 100°F, o `is` calcula e compara).

---

## 6. Recursão

### 6.1. Estrutura obrigatória

1. **Cláusula(s)-base** (fato/generalização) — encerra;
2. **Regra recursiva** — chama a si mesma reduzindo o problema.

```prolog
fact(N, F) :- N > 0,                  % recursiva
    succ(NewN, N),
    fact(NewN, F1),
    F is F1*N.
fact(0, F) :- F is 1.                 % base (na fonte vem depois)
```

- Cada nível tem **seu próprio** conjunto de variáveis.
- **Recursão comum** calcula **depois** da chamada (`F is F1*N`) — acumula na pilha.
- **Recursão de cauda** passa o acumulador adiante (`factTR(N, Acc, F)`) — não cresce a pilha.
  ```prolog
  % recursão de cauda (acumulador) + wrapper
  factTR(N, Acc, F) :-
      N > 0, succ(NewN, N), NewAcc is Acc * N, factTR(NewN, NewAcc, F).
  factTR(0, Acc, F) :- F is Acc.
  factorial(N, F) :- factTR(N, 1, F).

  % Fibonacci iterativo (mesmo molde) — vira função aritmética própria:
  fibTR(N, B, A, F) :-
      N > 0, succ(NewN, N), C is A + B, fibTR(NewN, C, B, F).
  fibTR(0, _, Acc, Acc).
  :- use_module(library(arithmetic)).
  :- arithmetic_function(fib/1).
  fib(N, F) :- fibTR(N, 1, 0, F).
  % ?- X is fib(200). → X = 280571172992510140037611932413038677189525.
  ```
- **Comparação direta (aula 05):**

  | Recursão comum | Recursão de cauda |
  |---|---|
  | O resultado depende da chamada recursiva (`F is F1*N`) | O resultado já vem acumulado na chamada |
  | Acumula chamadas pendentes na pilha | Pode ser otimizada (a pilha não cresce) |
  | Sufoca a pilha em entradas grandes | Suporta entradas muito grandes |

  > Medição da aula (Fibonacci até $10^6$): Python iterativo ~9,25 s × Prolog de cauda ~6,49 s.
- **Armadilha do `redo` (aula 05):** é preciso garantir que os **parâmetros não
  caracterizem uma cláusula-base** — sem esse cuidado, um retorno pela porta `redo` pode
  fazer um conjunto que era caso-base **avançar na regra recursiva**, causando **laços
  infinitos** (por isso a forma das cláusulas/sobreposição importa no traço).

### 6.2. Como a prova cobra: traçar execução (Q7)

**Q7 (Prova 1):** o predicado abaixo lembra o "Collatz": se par divide por 2, se ímpar $3n+1$;
`M` é um contador que **desce** com `succ(NewM, M)`.

```prolog
f(N, M, X) :- g(M, N, X).
g(M, N, X) :-
    N > 0,
    (N mod 2 =:= 0 -> NewN is N div 2 ; NewN is 3*N + 1),
    succ(NewM, M),
    g(NewM, NewN, X).
g(0, X, X).
```

Traço de `?- f(10, 4, X).` → chama `g(4, 10, X)`:

| M | N | N par? | Novo N | Novo M |
|---|---|---|---|---|
| 4 | 10 | sim | 5 | 3 |
| 3 | 5 | não | 16 | 2 |
| 2 | 16 | sim | 8 | 1 |
| 1 | 8 | sim | 4 | 0 |
| 0 | 4 | — | base: **X = 4** | |

→ **A** (`X = 4`). *Dica:* monte a tabelinha; `succ(NewM, M)` **diminui** M (succ(3)=4).

### 6.3. Estruturas de dados

```prolog
car(honda, red, 4).          % estrutura ≡ fato na sintaxe
car(honda, color(red), doors(4)).   % aninhada — NÃO unifica com a de cima
?- car(X, red, _).           % ordem dos argumentos importa
```
- `_` ignora campo; aninhamento melhora legibilidade e **muda** a unificação.

### 6.4. Recursão com impressão: as matrioskas `list/2` (e `doll/1`) — leitura

```prolog
matrioska(a, b). matrioska(a, c). matrioska(b, d). matrioska(b, c).
matrioska(b, f). matrioska(c, e). matrioska(c, g). matrioska(d, g).
matrioska(e, f). matrioska(f, g). matrioska(f, h).   % 11 fatos (com ramificações)
doll(X) :- matrioska(X, _).    % X contém alguém
doll(X) :- matrioska(_, X).    % X está dentro de alguém
list_(M, L) :-
    nl, tab(L), print(->), tab(1), print(M),
    matrioska(M, X), NewL is L + 4, list_(X, NewL).   % recursiva: imprime e desce
list(M, L) :- list_(M, L).
list(_, _).                                           % base: sempre sucede no fim
```
- Moral: recursão também serve para **percorrer + imprimir** (com `tab` indentando);
  a base `list(_, _)` só existe para a enumeração terminar em sucesso (mesmo idioma
  do `software.` da seção 4.3).

---

## 7. Listas

### 7.1. Sintaxe e casamento de padrão

| Notação | Significado |
|---|---|
| `[a, b, c]` | lista |
| `[]` | lista vazia (*nil*) |
| `[H \| T]` | `H` = 1º elemento (**head**), `T` = resto (**tail**) |
| `[A, B \| T]` | vários elementos antes da barra (depois, **só uma** variável) |

- Lista é, de fato, o predicado `'[|]'/2`: `[1,2,3]` ≡ `'[|]'(1, '[|]'(2, '[|]'(3, [])))`.
- `[]` e `[H|T]` **nunca unificam** → é o que faz a recursão de listas parar.

### 7.2. Implementações canônicas (leia e entenda — a prova cobra **análise**, não escrita)

```prolog
member_(H, [H|_]).                            % teste de pertinência
member_(X, [_|T]) :- member_(X, T).

append([], X, X).                             % concatenação
append([H|T1], X, [H|T2]) :- append(T1, X, T2).

length_([], 0).                               % comprimento
length_([_|T], X) :- length_(T, NewX), X is NewX + 1.
```

> **Atenção (defeito no material):** a aula imprime `append([H|T1], X, [H, T2])` (com **vírgula**). Isso está errado: com essa versão, `?- append([1,2], [3], L).` dá `L = [1,[2,[3]]]`. O correto é `[H|T2]` (barra), que dá `L = [1,2,3]` — verificado no SWI-Prolog.
- `append/3` também **decompõe**: `?- append(X, Y, [1,2]).` gera todas as divisões.
- **Transformar lista em fatos + `findall` com `;`:**
  ```prolog
  list_to_facts([]).
  list_to_facts([H|T]) :- assertz(H), list_to_facts(T).   % cada elemento vira fato
  ?- findall(X, (f(X) ; g(X)), L).   % L = [1,3]: o 2º arg é o objetivo (pode ter ;)
  ```
  Assinatura: `findall(Padrão, Objetivo, Lista)` — coleta **com duplicatas e em ordem**.
- Meta-predicados (aula 06) — `maplist` vale para **N de 2 a 5** (o objetivo é aplicado às
  N-tuplas correspondentes):
  ```prolog
  ?- maplist(celsius_fahrenheit, [-1,100,40], F).  % F = [30.2, 212, 104]
  subset(N, S) :- length(S, N), maplist(between(0,1), S).  % S = lista binária de tamanho N
  replicate(N, V, L) :- length(L, N), maplist(=(V), L).    % L = N cópias de V
  ```
  - `include(Goal, L, Filtrada)` mantém quem **satisfaz**; `exclude(Goal, L, Resto)` mantém
    quem **falha**:
    ```prolog
    is_odd(X) :- X mod 2 =\= 0.
    odds(L, O) :- include(is_odd, L, O).
    evens(L, E) :- exclude(is_odd, L, E).
    ?- numlist(1, 5, L), odds(L, Odds), evens(L, Evens).
    % L=[1,2,3,4,5], Odds=[1,3,5], Evens=[2,4]
    ```
  - `foldl(Goal, L, V0, V)` dobra a lista aplicando `Goal/(m+1)` desde `V0`;
    `scanl` é igual mas **guarda os parciais**:
    ```prolog
    summation(A, B, Sum) :- numlist(A, B, L), foldl(plus, L, 0, Sum).
    multiply(A, B, C) :- C is A*B.
    factorial(N, F) :- numlist(1, N, L), foldl(multiply, L, 1, F).
    ```
- Biblioteca útil: `length(L, N)` (tamanho), `numlist(A, B, L)` (todos os inteiros de A a B),
  `between(A, B, X)` (gera/escolhe X no intervalo), `succ(X, Y)`, `append/3`, `member/2`.
  Ex.: `include(is_odd, L, Odds), length(Odds, N)` conta ímpares **usando `include` + `length`**.

### 7.3. Como a prova cobra: recursão em listas (Q10)

**Q10 (Prova 1):**

```prolog
p([_|[]], X) :- p([], X).
p([], 0).
p([A,B|C], X) :-
    p(C, NewX),
    X is NewX + (B - A).
```

`?- p([2,3,5], X).` → desce até `C=[5]`: `p([5], NewX)` casa a 1ª cláusula → `p([], X)` → `X=0`;
sobe: `X is 0 + (3-2) = 1` → **A** (`X = 1`).
*Observe:* o padrão soma `B - A` = diferenças **entre elementos consecutivos**.

---

## 8. Combinadores e Base SK (conteúdo da antiga Prova 2 que cai agora)

**O que mais cai (confirmado na Prova 2 real — 704C60):**

| Questão | Item | Resposta |
|---|---|---|
| Q1 | Schönfinkel: a letra **Z** = função de **composição** | **D** |
| Q2 | Redução de `SKSabc` (`Sfgx = fx(gx)`, `Kxy = x`) | **abc** (E) |
| Q3 | Definição de **combinador** (termo fechado) | $\mathrm{FV}(M)=\emptyset$ (D) |
| Q13 | Redução-β de `S((S(K((S(KS))K)))S)(KK)307` | dígitos **370** |

> Os itens de Combinadores vêm da Prova 2 (704C60) — são **questões reais**, não simulados.

### 8.1. O artigo e os cinco combinadores

- **Schönfinkel** (1920/1924): *On the building blocks of mathematical logic*.
  Resgatou de **Frege** a ideia de **currying** (toda função como unária).
- **Currying e aplicação (base de tudo):** justaposição é aplicação —
  $f(x) \equiv fx$, $F(x,y) = (fx)y = fxy$, $H(x_1..x_N) = Hx_1..x_N$ — e a aplicação
  é **associativa à esquerda**: $abc$ significa $((ab)c)$. Parênteses só mudam a ordem.
- O `=` entre combinadores **não** é equivalência lógica: significa **mesmo
  comportamento** (ex.: $II = I$ — aplicados a qualquer $x$, dão o mesmo resultado).
- **Funções particulares** (denominação do próprio Schönfinkel no artigo), com os nomes alemães:

| Combinador | Nome (alemão) | Regra |
|---|---|---|
| $I$ | identidade (*Identität*) | $Ix = x$ |
| $K$ (**C** de Schönfinkel) | constância (*Konstanz*) | $Kxy = x$ |
| $T$ (**C** moderno) | intercâmbio/transposição (*Vertauschung*) | $(T\varphi)xy = \varphi yx$ |
| $Z$ (**B** moderno) | **composição** (*Zusammensetzung*) | $Z\varphi\chi x = \varphi(\chi x)$ |
| $S$ | fusão (*Verschmelzung*) | $S\varphi\chi x = \varphi x(\chi x)$ |

> **Bússola das letras:** o moderno **B = Z** (composição) e o moderno **C = T**
> (troca a ordem dos argumentos). **(Q1 — antiga Prova 2):** a letra **Z** = **função de
> composição** → **D**.

- **Definição de combinador:** termo **fechado**, $FV(M) = \emptyset$ (sem variáveis livres) —
  ou, informalmente: função cujo valor depende só de **aplicação** dos termos.
  Definição completa da aula: sejam $x_1..x_N$ termos sem restrições; $C$ é combinador se
  seu valor depende única e exclusivamente da **aplicação** desses termos e de combinadores
  prévios (pura estrutura de aplicação). Ex.: $Ufg = fx\,|^x\,gx$ é combinador.
  **(Q3 — antiga Prova 2):** alternativa **D** (`FV(M) = ∅`).

### 8.2. Reduções na base SK (decore!)

$$I = SKK \qquad B = S(KS)K \qquad C = S(BBS)(KK)$$

- **M (tordo-imitador):** $Mx = xx$ e $M = SII$.
- **De onde vêm as fórmulas (intuição de cada derivação — basta acompanhar uma vez):**
  - $I = SKK$: queremos $Ix = x$. Como $Kxy = x$, faça $y \to Kx$:
    $Ix = Kx(Kx) = SKKx$ (aplique a regra do $S$: $Sfgx = (fx)(gx)$ com $f = Kx$).
    O 2º $K$ pode ser **qualquer coisa**: $I = SK(\text{qualquer coisa})$.
  - $B = S(KS)K$ (= Z): queremos $f(gx)$. Escreva $f = Kfx$ (pois $Kfx = f$):
    $f(gx) = (Kfx)(gx) = S(Kf)gx = (KSf)(Kf)gx = S(KS)Kfgx$.
  - $C = S(BBS)(KK)$ (= T): queremos $fxy$ com args trocados. Com $K$:
    $fxy = fx(Kyx) = Sf(Ky)x = B(Sf)Kyx = BBSfKyx = (BBSf)(KKf)yx = S(BBS)(KK)fyx$.
  - $M = SII$: $Mx = xx$; com $a$ qualquer: $Ma = aa = Ia(Ia) = SIIa$.
- **Cálculo SK:** só $S$ e $K$ primitivos; aplicação associativa à esquerda; avaliação **preguiçosa**
  (subexpressões à direita não são avaliadas). As 3 regras da avaliação:
  1. reduza sempre a **subexpressão mais à esquerda** com argumentos suficientes;
  2. o lado **direito** não é avaliado antes da hora (*lazy*);
  3. **nunca expanda** um termo que será descartado.
  Por isso $SII(SII)$ **não termina** (o $M$ aplicado a si mesmo entra em loop $MM \to MM$,
  análogo ao paradoxo da autorreferência), mas $KS(SII(SII)) = S$ **termina**: o $K$
  descarta o segundo argumento **sem avaliá-lo**.
- **Regras práticas de redução:** $Sfgx = (fx)(gx)$ · $Kxy = x$ · $Ix = x$ · $Bfgx = f(gx)$ ·
  $Cxyz = xzy$ · $Mx = xx$. **Associe à esquerda** sempre.

**(Q2 — antiga Prova 2):** reduzir `SKSabc`:
$$SKSabc = ((SKS)a)bc = (Ka(Sa))bc = abc \;\rightarrow\; \mathbf{E}$$

**(Q13 — antiga Prova 2):** `S((S(K((S(KS))K)))S)(KK)307` (os dígitos 3, 0, 7 são termos):
1. $S\ (US)\ (KK)\ 3 = (US\ 3)(KK\ 3)$;
2. $US = S(K((S(KS))K))S \Rightarrow US\ 3 = ((S(KS))K)(S3) = B(S3)$ (pois $S(KS)K = B$);
3. $KK\ 3 = K$;
4. Então $= B(S3)\,K\,0 = (S3)(K0)$;
5. $(S3)(K0)\,7 = (3\,7)((K0)\,7) = (3\,7)\,0$ → dígitos na ordem: **370**.

### 8.3. Reduções da lógica booleana (conteúdo da lista)

- **Clássicas (para traduzir enunciados):** $p \to q \equiv \bar{p} \lor q$;
  $p \sim q \equiv (p \,\&\, q) \lor (\bar{p} \,\&\, \bar{q})$;
  $p \,\&\, q \equiv \overline{\bar{p} \lor \bar{q}}$ (Whitehead–Russell).
- **Scheffer (1913):** um único conectivo gera tudo:
  - **NAND** ($\uparrow$ ou $p \mid q$, com $p|q \equiv \bar{p} \lor \bar{q}$):
    $\bar{p} = p|p$ · $p \land q = (p|q)|(p|q)$ · $p \lor q = (p|p)|(q|q)$.
  - **NOR** ($\downarrow$, com $p \downarrow q \equiv \bar{p} \land \bar{q}$):
    $\bar{p} = p \downarrow p$ · $p \lor q = (p \downarrow q) \downarrow (p \downarrow q)$ ·
    $p \land q = (p \downarrow p) \downarrow (q \downarrow q)$.
  - Moral (analogia da aula): NAND é a "porta universal" — com só ela se monta qualquer circuito.
- **Conectivo fundamental de Schönfinkel:** $f(x)\,|^x\,g(x) \equiv (x)[\overline{f(x)} \lor \overline{g(x)}]
  \equiv (x)\overline{f(x)\,\&\,g(x)}$ — gera negação, disjunção e os quantificadores
  $\forall$ (notação $(x)$) e $\exists$ (notação $(Ex)$):
  $\bar{a} = a\,|^x\,a$ ·
  $a \lor b = \bar{a}\,|^x\,\bar{b} = (a\,|^y\,a)\,|^x\,(b\,|^y\,b)$ ·
  $(x)f(x) = \overline{f}\,|^x\,\overline{f}$ ·
  $(Ex)f(x) = \overline{(x)\overline{f(x)}}$.

### 8.4. Pássaros (tabela completa — a lista cobra derivar estes)

| Pássaro | Nome PT (da aula 02) | Regra | Em termos de $S,K,I,C,B$ |
|---|---|---|---|
| Starling $S$ | Estorninho | $S\varphi\chi x = \varphi x(\chi x)$ | primitivo |
| Kestrel $K$ | Cernícalo americano | $Kxy = x$ | primitivo |
| Idiot bird $I$ | Albatroz de cauda curta | $Ix = x$ | $I = SKK$ |
| Bluebird $B$ (= $Z$) | Tordo-azul-oriental | $Bfgx = f(gx)$ | $B = S(KS)K$ |
| Cardinal $C$ (= $T$) | Cardeal-do-norte | $Cxyz = xzy$ | $C = S(BBS)(KK)$ |
| Mockingbird $M$ | Tordo-imitador | $Mx = xx$ | $M = SII$ |
| Blackbird $B_1$ | — | $B_1abcd = a(bcd)$ | $B_1 = BBB$ |
| Dove $D$ | — | $Dabcd = ab(cd)$ | $D = BB$ |
| Goldfinch $G$ | — | $Gabcd = ad(bc)$ | $G = BBC$ (a lista o chama de $D$ por engano) |
| Owl $O$ | — | $Oab = b(ab)$ | $O = SI$ |

- **Tordo-imitador (1º rumor do livro — "todo pássaro gosta de alguém"):** se para quaisquer
  $A,B$ existe $C$ com $Cx = A(Bx)$ **e** o tordo-imitador $M$ existe, então todo pássaro
  $A$ gosta de alguém (a saber, de $MC$): tome $C$ com $Cx = A(Mx)$; então
  $CC = A(MC)$ e, como $MC = CC$ (pois $Mx = xx$), $A(MC) = MC$.
- **Egocêntrico (Q6 da lista — "existe $E$ com $EE = E$"):** aplique o 1º rumor com
  $A := M$: vale $M(MC) = MC$. Mas $Mx = xx$, logo $M(MC) = (MC)(MC)$ — ou seja,
  $E := MC$ satisfaz $EE = E$.

### 8.5. Reduções da lista (SK) — prática

- (b) $S(K((S((SK)K))((SK)K)))ab$: como $(SK)K = I$, o miolo é $SII = M$; então
  $S(KM)ab = (KMb)(ab) = M(ab) = (ab)(ab)$.
- (a) $S(K(S(K((S(KS))K))))abcde = abc(de)$ (os $S(K\ldots)$ empilham composições).
- (c) $S(K((S(K(S((SK)K))))K))abc = c(ab)$: com $(SK)K = I$ e $S((SK)K) = SI$, pondo
  $Y = S(K(SI))$ vale $YK\,x = SI(Kx)$, logo $S(K(YK))abc = YK(ab)c = SI(K(ab))c = c(ab)$.
- **Método para redução-β com dígitos (estilo Q13 da antiga Prova 2):** dígitos são termos;
  reduza da esquerda, um $S$ por vez. Exemplo `S((S(K((S(KS))K)))S)(KK)307`:
  1. $S\,(US)\,(KK)\,3 = (US\,3)(KK\,3)$ (regra do $S$);
  2. $US\,3 = B(S3)$ (pois $U = S(K(\ldots))S$ aplicado a $3$ recompõe $((S(KS))K)(S3)$,
     e $(S(KS))K = B$);
  3. $KK\,3 = K$;
  4. $= B(S3)\,K\,0 = (S3)(K0)$ (regra do $B$);
  5. $(S3)(K0)\,7 = (3\,7)((K0)\,7) = (3\,7)\,0$ → dígitos na ordem: **370**.
- **Resultados do artigo (para reconhecer):** tudo se faz com $I,C,T,Z,S,U$; depois só com
  $C,S,U$; com $J$ (onde $JC = U$, $JS = C$, $Jx = S$ para $x$ diferente de $C$ e $S$):
  $JJ = S$, $J(JJ) = C$, $J[J(JJ)] = U$ — tudo só com $J$ + parênteses.

### 8.6. Exercícios da lista de Combinadores (roteiro)

- **Q1:** escreva (a) $p \,\&\, q$, (b) $p \lor q$, (c) $\bar{p}$ usando **só** o NOR $\downarrow$
  (use as fórmulas da seção 8.3 de trás para frente).
- **Q2:** $p \oplus q$ (verdadeira só se $p=F, q=V$...) e $p \odot q$ pedem a equivalência com
  (a) `¬,&`, (b) `↓`, (c) `¬,→` — truque: ambas equivalem a $\bar{p} \,\&\, q$; daí é só
  traduzir com 8.3.
- **Q3** ("$x$ não múltiplo de 3 e $y$ primo"): (a) escreva com variáveis + `¬,&,∨,→`;
  (b) negue simbolicamente; (c) reescreva só com `↓`; (d) só com $|^x$.

---

## 9. Padrões de implementação (para **ler e entender** código)

### 9.1. Receita geral para ler os predicados da prova

1. Identifique o **caso base** (quase sempre valor pequeno, `0`, `1`, `[]`).
2. Reconheça a **regra recursiva** (onde chama a si mesma reduzindo o problema).
3. Localize as ferramentas: `between/3`, `succ/2`, `mod/2`, `div/2`, `is/2`.
4. **Teste mentalmente** com os exemplos dados no enunciado (a prova dá exemplos!).

### 9.2. Q13 — `is_sum_of_5/1` (Prova 1)

"N pode ser escrito como soma de **cinco inteiros positivos distintos**."

```prolog
is_sum_of_5(N) :-
    N >= 15,                       % 1+2+3+4+5 é o mínimo possível
    between(1, N, A),
    between(A, N, B), A < B,
    between(B, N, C), B < C,
    between(C, N, D), C < D,
    between(D, N, E), D < E,
    N =:= A + B + C + D + E.
```
- `is_sum_of_5(5)` → falha no `N >= 15` → **false** ✓
- `is_sum_of_5(30)` → 1+2+3+4+20 = 30 → **true** ✓

> Por que ordenar ($A<B<C<D<E$)? Para evitar permutações repetidas e garantir **distintos**.

### 9.3. Q14 — `power_of_5/1` (Prova 1)

"N pode ser escrito como $5^k$, $k$ inteiro não-negativo."

```prolog
power_of_5(1).                        % 5^0 = 1 (caso base)
power_of_5(N) :-
    N > 1,
    N mod 5 =:= 0,                    % divisível por 5
    M is N div 5,                     % divide por 5
    power_of_5(M).                    % recursão
```
- `power_of_5(1)` → base → **true** ✓
- `power_of_5(125)` → 125 → 25 → 5 → 1 → **true** ✓
- `power_of_5(500)` → 500 → 100 → 20 → 20 não é divisível por 5 → **false** ✓

### 9.4. Outros padrões que apareceram nas listas

**Contagem com acumulador — `divisores/2`** (número de divisores de N):

```prolog
divisores(N, X) :- divisores_(N, 1, 0, X).
divisores_(N, D, Acc, X) :-
    D =< N,
    (0 =:= N mod D -> NewAcc is Acc + 1 ; NewAcc = Acc),
    NewD is D + 1,
    divisores_(N, NewD, NewAcc, X).
divisores_(_, D, Acc, Acc) :- D > N.
```

**Contagem em lista — `count_odds/2`** (conta quantos ímpares há na lista):

```prolog
count_odds([], 0).
count_odds([H|T], X) :-
    count_odds(T, Y),
    (1 =:= H mod 2 -> X is Y + 1 ; X = Y).
```
*Alternativa com meta-predicados:* `odds(L, O) :- include(is_odd, L, O), ...` ou
`count_odds(L, N) :- include(is_odd, L, Odds), length(Odds, N).`
(Dica: `H mod 2 =\= 0` ou `1 =:= H mod 2` são equivalentes para testar ímpar.)

**Maior elemento — `max_list/2`** (recursão + condicional):

```prolog
max_list([X], X).                              % lista de 1 elemento: ele mesmo
max_list([H|T], X) :-
    max_list(T, Y),                            % maior do resto
    (H > Y -> X = H ; X = Y).                  % compara o 1º com o maior do resto
```
- `max_list([3, 7, 2], X)` → maior do resto ([7,2]) = 7; 3 > 7? não → **X = 7** ✓
- `max_list([9], X)` → base → **X = 9** ✓

**Contagem de divisores — `num_divisors/2`** (acumulador com `between`):

```prolog
num_divisors(N, X) :- num_divisors_(N, 1, 0, X).
num_divisors_(N, D, Acc, X) :-
    D =< N,
    (0 =:= N mod D -> NewAcc is Acc + 1 ; NewAcc = Acc),
    NewD is D + 1,
    num_divisors_(N, NewD, NewAcc, X).
num_divisors_(_, D, Acc, Acc) :- D > N.
```
- `num_divisors(6, X)` → 4 (1, 2, 3, 6) ✓ · `num_divisors(7, X)` → 2 (1, 7) ✓

**Fórmula direta — `distance/5`** ($S = I + V T + \frac{A T^2}{2}$):

```prolog
distance(I, V, A, T, S) :- S is I + V*T + A*T*T/2.
```

**Regra simples sobre base de fatos:**

```prolog
tem_calouros(D) :- matricula(D, E), estudante(E, 1, _).
turma_mista(D) :-
    matricula(D, E1), estudante(E1, _, 'Engenharias'),
    matricula(D, E2), estudante(E2, _, 'Engenharia de Software'),
    matricula(D, E3), estudante(E3, _, 'Engenharia de Energia').
```

**Impressão de todos com `fail` + cláusula final** (ver seção 4.3):
```prolog
software :-
    estudante(E, _, 'Engenharia de Software'), writeln(E), fail.
software.
```

**Família (Simpsons) — parentesco com regras:**
```prolog
uncle(X, Y) :- (father(P, Y) ; mother(P, Y)), siblings(X, P).
grandmother(X, Y) :- mother(X, P), (father(P, Y) ; mother(P, Y)).
```

---

## 10. Contagem de fatos × regras × cláusulas (cai fácil na Parte B)

- **Fato:** cláusula sem `:-` · **Regra:** cláusula com `:-` · **Cláusula:** fato + regra.
- **Exemplo da lista (`time/3`):** 8 fatos + 3 regras (`campeao` + 2× `selecionado`) = **11 cláusulas**.
- **Exemplo da prova Q12:** 7 fatos + **3 regras** = 10 cláusulas → resposta **003**.

> **Pegadinha:** cabeçalho de regra conta **1** vez; o corpo não conta. Fato com corpo `:- true`
> ainda é regra.

**Como contar sem errar (receita):**

1. Marque cada **cláusula** pelo ponto final (`.`), não pelas vírgulas do corpo.
2. Olhe se existe `:-` **naquela cláusula** (cabeça `:-` corpo): tem → **regra**; não tem → **fato**.
3. Cláusulas = fatos + regras. Se a pergunta for só "quantas **regras**", conte **apenas** as
   cláusulas com `:-`.

```prolog
p(1).                 % fato  → cláusula 1
p(2).                 % fato  → cláusula 2
q(X) :- p(X).         % regra → cláusula 3 (o p(X) do corpo NÃO é cláusula)
q(0).                 % fato  → cláusula 4
```

→ Nesse exemplo: **3 fatos + 1 regra = 4 cláusulas** (e o predicado `q/1` tem 1 regra e 1 fato).

---

## 11. Erros clássicos que a prova explora

| Erro | Correção |
|---|---|
| `2 + 2 = 4` (esperando true) | é **false**: `=` unifica; use `=:=` para comparar valores |
| `mod(X,2) = mod(Y,2)` | `=` não avalia → use `=:=` |
| `Y \= Z` com variáveis livres | duas livres **unificam** → `\=` falha; **instancie antes** |
| `is_set(1,2,3)` | aridade errada (`is_set/1`); passe lista: `is_set([1,2,3])` |
| `a ; b , c` esperando `(a;b), c` | `,` liga **mais forte** → é `a ; (b,c)`; **use parênteses** |
| esquecer `fail` + cláusula final ao enumerar | sem `fail` só sai o 1º; sem cláusula final, predicado "falha" no fim |
| `append/3` como função | **predicado não é função**: não retorna nada; atua por unificação |

---

## 12. Checklist final (revise na véspera)

- [ ] Tabela dos conectivos (símbolos e definição de cada um)
- [ ] Nº de linhas da tabela-verdade = $2^n$ (só variáveis **distintas** contam)
- [ ] Proposições compostas: controle (`,`, `;`, `\+`) × aninhamento de fatos; rodar `proposicoes_compostas.pl` (`?- demo.`) — seção 1.1b
- [ ] Termos primitivos (proposição, V, F) × axiomas (terceiro excluído × não-contradição) + regressão infinita
- [ ] Fato × regra × cláusula; aridade; contar regras
- [ ] Mundo fechado (o não declarado é falso)
- [ ] Diferenças entre `=` vs `\=` vs `\+` vs `is` vs `=:=` vs `=\=`
- [ ] Unificação: variável/primitivo/estrutura + `_`
- [ ] Portas call/exit/fail/redo; o papel do `;`; ler traço com `trace`
- [ ] `write/nl/tab/fail`; comportamento no redo (sempre falha)
- [ ] Condicional `-> ;` + padrão `truth_table` (enumerar com `fail`)
- [ ] Precedência (menor = mais forte) + `:- op` (xfx/xfy/yfx, `current_op`, apagar com 0)
- [ ] Tabela de operadores (500/400/700/200...) + agrupamentos (`a^b^c`, `a+b+c`)
- [ ] `/` vs `//`/`div` vs `mod` vs `^`/`**`; `sqrt` dentro de `is`
- [ ] `arithmetic_function` e `op/3`; guarda `var/nonvar` + `instantiation_error`
- [ ] Idioma `between` + filtro (`<` ordenado vs `\=\=` par a par)
- [ ] Recursão: base + regra; traçar execução com tabelinha; armadilha do `redo`
- [ ] Recursão de cauda (acumulador) + wrappers (`factorial`, `fibTR`)
- [ ] `var/nonvar`, `succ` nas duas direções
- [ ] Listas: `[H|T]`, member/append/length, recursão com aritmética
- [ ] `findall` (com `;`, mantém ordem/duplicatas), `maplist` (N=2..5), `include/exclude`, `foldl/scanl`
- [ ] Combinadores: $I, K, T, Z, S$ (Z = composição!), $I=SKK$, $B=S(KS)K$, $C=S(BBS)(KK)$, $M=SII$
- [ ] Currying (associa à esquerda) e `=` como mesmo comportamento
- [ ] Avaliação preguiçosa (3 regras) e loops ($SII(SII)$ vs $KS(\ldots)$)
- [ ] Definição de combinador ($FV(M)=\emptyset$)
- [ ] Reduções: `SKSabc = abc`, dígitos → `370`, $(ab)(ab)$, `c(ab)`; método dígito a dígito
- [ ] Pássaros: tabela completa ($B_1=BBB$, $D=BB$, $G=BBC$, $O=SI$) + $J$ ($JJ=S$...) + Q6 egocêntrico
- [ ] NAND/NOR gerando tudo (fórmulas); conectivo fundamental de Schönfinkel
- [ ] Reconhecer no código os 4 padrões (seção 9): between+ordenado, divisão recursiva, acumulador, contagem com `mod`/condicional
- [ ] Fazer os 3 simulados fechado (no `simulador.html`) e revisar cada erro

---

**Materiais de apoio (só se quiser aprofundar — o estudo fecha por este arquivo):**
- `definicoes/02_programacao_logica/` — resumos detalhados das 6 aulas (com códigos)
- `definicoes/03_combinadores/` — Introdução e Base SK
- `resumo-prova/simulados/` — **3 simulados** no estilo da prova + gabaritos resolvidos
- `resumo-prova/simulador.html` — **simulador interativo** (abra no navegador): corrige e mostra o gabarito na hora
- `resumo-prova/prova_1/` — prova e gabarito (4BAE41)
- `resumo-prova/prova_2/` — prova e gabarito (704C60)
- `resumo-prova/listas/` — listas de Programação Lógica e Combinadores
