# RESUMO GERAL — PROVA 1 (Paradigmas de Programação)

> Material único de estudo, montado a partir dos resumos de `definicoes/` + `documento-base/`,
> **direcionado ao formato das provas do prof. Edson Alves**.
>
> **Cobre:** Programação Lógica (Prolog, aulas 01–06) + Combinadores (Introdução e Base SK).
> **Não cobre:** Cálculo Lambda e Haskell (não caem nesta prova).

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

---

## 1. Lógica Proposicional Booleana

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

### 1.2. Tabela-verdade e número de linhas

- O nº de linhas de uma tabela-verdade é $2^n$, onde **$n$ = nº de proposições simples distintas**.
- **(Q11 — Prova 1):** $P: (p \lor (q \land p)) \land (\sim p \lor (p \land q))$ → só $p$ e $q$ → $2^2 = \mathbf{4}$ → **004**.
- *Pegadinha:* as repetições de $p$ e $q$ não contam; proposições compostas internas também não.

### 1.3. Termos primitivos e axiomas (cai como conceito)

- **Termos primitivos:** proposição, verdadeiro, falso.
- **Axiomas:** Princípio do **terceiro excluído** (toda proposição é V **ou** F) e da
  **não-contradição** (não pode ser V **e** F). Juntos fixam o universo {V, F}.
- **Pegadinha (lista Q1):** "ao mesmo tempo verdadeira e falsa" viola a **não-contradição**,
  **não** o terceiro excluído (o enunciado mistura os dois de propósito).

### 1.4. Exercícios de fixação da lista

- (Q2) "Se fizer bom tempo amanhã eu vou" = $p \to q$ (V). Situação **impossível**: **fazer bom
  tempo e não ir** (único caso em que V→F é falso).
- (Q3) menor natural $x$ com $x/2 > \pi$: $\pi \approx 3{,}1416 \Rightarrow x > 6{,}28 \Rightarrow x = \mathbf{7}$.

---

## 2. Fatos, Regras e Cláusulas em Prolog

### 2.1. Vocabulário (cobrado em prova)

| Termo | Definição |
|---|---|
| **Fato** | predicado mais simples; equivale a proposição verdadeira: `time('Monkeys', 1, 'go').` |
| **Regra** | cabeça `:-` corpo (proposição composta); corpo omitido = fato |
| **Cláusula** | qualquer fato **ou** regra |
| **Aridade** | nº de argumentos do predicado: `alfa(a, 1, True)` → `alfa/3` (aridade **3**) |

**(Q6 — Prova 1):** `alfa(a, 1, True).` → aridade **3** → **D**.
**(Q12 — Prova 1):** no código, contar **regras** (cláusulas com corpo):
`f(X,Y) :- ...`, `f(X,X) :- ...`, `g(Z) :- ...` → **3 regras** → **003**. (Os 7 `f/g/h` de cima são **fatos**, não contam.)

### 2.2. Mundo fechado (*closed world*)

**Tudo que não está declarado é falso.** Só o que aparece na base é verdadeiro.

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
as cláusulas.

### 2.4. Maiúsculas/minúsculas e símbolos

- Minúscula = **átomo** (`true`, `mg`) · Maiúscula/`_` = **variável** (`True` é variável!).
- Átomos com maiúscula/espaços precisam de aspas: `'Pedro Lucas'`, `'Cálculo 1'`.

### 2.5. Declaração e manipulação da base (fatos dinâmicos)

| Recurso | Uso |
|---|---|
| `$-s$ arquivo.pl` | carrega na inicialização |
| `consult('a.pl')` / `reconsult('a.pl')` | carregar / recarregar em sessão |
| `:- dynamic pred/N.` | habilita declarar/retirar fatos em execução (**só em arquivo**) |
| `asserta(fato)` / `assertz(fato)` | insere no **início** / **fim** |
| `retract(fato)` | **remove** um fato |

---

## 3. Unificação — o coração do Prolog

### 3.1. Regras de unificação

| Elementos | Comportamento |
|---|---|
| **variável × termo** | sempre unifica; a variável é **atada** ao termo |
| **primitivo × primitivo** | unifica só se **idênticos** (`a` com `b` não) |
| **estrutura × estrutura** | mesmo **construtor** + mesma **aridade** + argumentos par a par |
| **`_` (anônima)** | casa com tudo, **não** é atada |

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

### 3.3. Exemplos resolvidos (Q8 — Prova 1: quantas consultas retornam falso?)

```prolog
?- 2 + 2 = 4.                     % FALSE — = não avalia: 2+2 é um termo, ≠ 4
?- X = Y.                         % true  — duas variáveis sempre unificam
?- f(_) = f(x, x).                % FALSE — aridades diferentes (f/1 vs f/2)
?- f(_, g(B,c)) = f(A, g(b,C)), B \= C.
      % B = b, C = c, então B \= C → b \= c → true
```
→ **2 falsas** → **C**.

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

### 4.3. Predicados extra-lógicos (controle)

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
- Se `If` é verdadeiro → `Then`; senão → `Else`.
- **Atenção ao `;` do `->`**: `(A -> B ; C)` é o if-then-else; sem parênteses pode interagir com
  outras disjunções.

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

### 5.2. Declarar operadores (Q4!)

- **(Q4 — Prova 1):** diretiva que define precedência, associatividade e posição → **`:- op`** (A).
- Sintaxe: `:- op(Precedencia, Tipo, Nome).`
  - Tipos: `xfx` (não associativo), `xfy` (assoc. direita), `yfx` (assoc. esquerda), `fy` (prefixo).
  - `current_op(P, T, N)` consulta operador existente; precedência `0` apaga.

### 5.3. Aritméticos e relacionais

- Aritméticos: `+ - * / // div mod ^` (divisão inteira `//`/`div`, resto `mod`).
- Relacionais (700, xfx): `>` `<` `>=` `=<` `=:=` `=\=` — **comparam valores calculados**
  (`=<` é escrito assim, não `<=`).

### 5.4. Funções aritméticas próprias (estilo lista Q10)

```prolog
:- use_module(library(arithmetic)).
:- arithmetic_function(divisores/1).      % aridade = aridade do predicado - 1
:- op(700, xfx, divisores).                % vira operador infixado não associativo

divisores(N, X) :- ...                     % último argumento = retorno
```
Com isso: `?- 60 divisores X.` → `X = 12.` e `?- R is divisores(20).` → `R = 6.`

### 5.5. Predicados com múltiplas semânticas

- `var/1` (livre), `nonvar/1` (atado), `integer/1`, `number/1`, `atom/1`.
- `succ/2` funciona nas duas direções: `succ(2, S)` → `S = 3`; `succ(A, 2)` → `A = 1`.
- Padrão (ex. Celsius/Fahrenheit): testar quem está atado e escolher o ramo:

```prolog
celsius_fahrenheit(C, F) :-
    (nonvar(C) -> F is C*9/5 + 32 ; C is (F - 32)*5/9).
```

---

## 6. Recursão

### 6.1. Estrutura obrigatória

1. **Cláusula(s)-base** (fato/generalização) — encerra;
2. **Regra recursiva** — chama a si mesma reduzindo o problema.

```prolog
fact(0, F) :- F is 1.                 % base
fact(N, F) :- N > 0,                  % recursiva
    succ(NewN, N),
    fact(NewN, F1),
    F is F1*N.
```

- Cada nível tem **seu próprio** conjunto de variáveis.
- **Recursão comum** calcula **depois** da chamada (`F is F1*N`) — acumula na pilha.
- **Recursão de cauda** passa o acumulador adiante (`factTR(N, Acc, F)`) — não cresce a pilha.

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

### 7.2. Implementações canônicas (a prova pede para implementar!)

```prolog
member_(H, [H|_]).                            % teste de pertinência
member_(X, [_|T]) :- member_(X, T).

append([], X, X).                             % concatenação
append([H|T1], X, [H, T2]) :- append(T1, X, T2).

length_([], 0).                               % comprimento
length_([_|T], X) :- length_(T, NewX), X is NewX + 1.
```
- `append/3` também **decompõe**: `?- append(X, Y, [1,2]).` gera todas as divisões.
- Meta-predicados (aula 06): `maplist(celsius_fahrenheit, [-1,100], F)`, `include(is_odd, L, O)`,
  `exclude`, `foldl(plus, L, 0, S)`, `findall(X, f(X), L)`.
  - `findall/3` **mantém duplicatas e a ordem** de ocorrência: `findall(X, member(X,[a,b,a]), L)` → `L = [a,b,a]`.
  - `include/3` mantém quem satisfaz; `exclude/3` mantém quem **falha**.
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

### 8.1. O artigo e os cinco combinadores

- **Schönfinkel** (1920/1924): *On the building blocks of mathematical logic*.
  Resgatou de **Frege** a ideia de **currying** (toda função como unária).
- **Funções particulares** (aplica-e-ignora o argumento):

| Combinador | Nome | Regra |
|---|---|---|
| $I$ | identidade | $Ix = x$ |
| $K$ (**C** de Schönfinkel) | constância | $Kxy = x$ |
| $T$ | intercâmbio | $(T\varphi)xy = \varphi yx$ |
| $Z$ (**B**) | **composição** | $Z\varphi\chi x = \varphi(\chi x)$ |
| $S$ | fusão | $S\varphi\chi x = \varphi x(\chi x)$ |

**(Q1 — antiga Prova 2):** a letra maiúscula **Z** = **função de composição** → **D**.

- **Definição de combinador:** termo **fechado**, $FV(M) = \emptyset$ (sem variáveis livres) —
  ou, informalmente: função cujo valor depende só de **aplicação** dos termos.
  **(Q3 — antiga Prova 2):** alternativa **D** (`FV(M) = ∅`).

### 8.2. Reduções na base SK (decore!)

$$I = SKK \qquad B = S(KS)K \qquad C = S(BBS)(KK)$$

- **M (tordo-imitador):** $Mx = xx$ e $M = SII$.
- **Cálculo SK:** só $S$ e $K$ primitivos; aplicação associativa à esquerda; avaliação **preguiçosa**
  (subexpressões à direita não são avaliadas) — evita loops como $SII(SII)$ (que não termina)
  enquanto $KS(SII(SII)) = S$ termina.
- **Regras práticas de redução:** $Sfgx = (fx)(gx)$ · $Kxy = x$ · $Ix = x$ · $Bfgx = f(gx)$ ·
  $Cxyz = xzy$. **Associe à esquerda** sempre.

**(Q2 — antiga Prova 2):** reduzir `SKSabc`:
$$SKSabc = ((SKS)a)bc = (Ka(Sa))bc = abc \;\rightarrow\; \mathbf{E}$$

**(Q13 — antiga Prova 2):** `S((S(K((S(KS))K)))S)(KK)307` (os dígitos 3, 0, 7 são termos):
1. $S\ (US)\ (KK)\ 3 = (US\ 3)(KK\ 3)$;
2. $US = S(K((S(KS))K))S \Rightarrow US\ 3 = ((S(KS))K)(S3) = B(S3)$ (pois $S(KS)K = B$);
3. $KK\ 3 = K$;
4. Então $= B(S3)\,K\,0 = (S3)(K0)$;
5. $(S3)(K0)\,7 = (3\,7)((K0)\,7) = (3\,7)\,0$ → dígitos na ordem: **370**.

### 8.3. Reduções da lógica booleana (conteúdo da lista)

- **Scheffer (1913):** um único conectivo gera tudo:
  - **NAND** ($\uparrow$ ou $p \mid q$): $p \land q = (p|q)|(p|q)$ · $p \lor q = (p|p)|(q|q)$ · $\bar{p} = p|p$.
  - **NOR** ($\downarrow$): $p \downarrow q \equiv \bar{p} \land \bar{q}$; $p \land q = (p\downarrow p) \downarrow (q \downarrow q)$ etc.
- **Conectivo fundamental de Schönfinkel:** $f(x)\,|^x\,g(x) \equiv (x)[\overline{f(x)} \lor \overline{g(x)}]$
  — gera negação, disjunção e os quantificadores $\forall$ e $\exists$.

### 8.4. Pássaros da lista (para conferir depois)

| Pássaro | Regra | Em termos de $S,K,I,C,B$ |
|---|---|---|
| Blackbird $B_1$ | $B_1abcd = a(bcd)$ | $B_1 = BBB$ |
| Dove $D$ | $Dabcd = ab(cd)$ | $D = BB$ |
| Goldfinch $G$ | $Gabcd = ad(bc)$ | $G = BBC$ (a lista chama de $D$ por engano) |
| Owl $O$ | $Oab = b(ab)$ | $O = SI$ |

- **Tordo-imitador (problema do livro):** se para quaisquer $A,B$ existe $C$ com $Cx = A(Bx)$ **e** o
  tordo-imitador $M$ existe, então **todo pássaro gosta de alguém** (1º rumor verdadeiro):
  $C C = A(MC) \Rightarrow A(MC) = CC = MC$.

### 8.5. Reduções da lista (SK) — prática

- (b) $S(K((S((SK)K))((SK)K)))ab$: como $(SK)K = I$, o miolo é $SII = M$; então
  $S(KM)ab = (KMb)(ab) = M(ab) = (ab)(ab)$.
- (a) $S(K(S(K((S(KS))K))))abcde = abc(de)$ (os $S(K\ldots)$ empilham composições).
- (c) $S(K((S(K(S((SK)K))))K))abc = cK$.

---

## 9. Padrões de implementação (para **ler e entender** código)

### 9.1. Receita geral para os predicados da prova

1. Identifique o **caso base** (quase sempre valor pequeno, `0`, `1`, `[]`).
2. Escreva a **regra recursiva** reduzindo o problema.
3. Use `between/3`, `succ/2`, `mod/2`, `div/2`, `is/2` como ferramentas.
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
- [ ] Nº de linhas da tabela-verdade = $2^n$
- [ ] Fato × regra × cláusula; aridade; contar regras
- [ ] Mundo fechado (o não declarado é falso)
- [ ] Servidores: `=` vs `\=` vs `\+` vs `is` vs `=:=` vs `=\=`
- [ ] Unificação: variável/primitivo/estrutura + `_`
- [ ] Portas call/exit/fail/redo; o papel do `;`
- [ ] `write/nl/tab/fail`; comportamento no redo (sempre falha)
- [ ] Condicional `-> ;`
- [ ] Precedência (menor = mais forte) + `:- op`
- [ ] Tabela de operadores (500/400/700/200...)
- [ ] `arithmetic_function` e `op/3`
- [ ] Recursão: base + regra; traçar execução com tabelinha
- [ ] Recursão de cauda (acumulador)
- [ ] `var/nonvar`, `succ` nas duas direções
- [ ] Listas: `[H|T]`, member/append/length, recursão com aritmética
- [ ] Combinadores: $I, K, T, Z, S$ (Z = composição!), $I=SKK$, $B=S(KS)K$, $C=S(BBS)(KK)$, $M=SII$
- [ ] Definição de combinador ($FV(M)=\emptyset$)
- [ ] Reduções: `SKSabc = abc`, dígitos → `370`, $(ab)(ab)$, `cK`
- [ ] NAND/NOR gerando tudo; conectivo fundamental de Schönfinkel
- [ ] Reconhecer no código os 4 padrões (seção 9): between+ordenado, divisão recursiva, acumulador, contagem com `mod`/condicional
- [ ] Fazer os 3 simulados fechado (no `simulador.html`) e revisar cada erro

---

**Materiais de apoio:**
- `definicoes/02_programacao_logica/` — resumos detalhados das 6 aulas (com códigos)
- `definicoes/03_combinadores/` — Introdução e Base SK
- `resumo-prova/simulados/` — **3 simulados** no estilo da prova + gabaritos resolvidos
- `resumo-prova/simulador.html` — **simulador interativo** (abra no navegador): corrige e mostra o gabarito na hora
- `resumo-prova/prova_1/` — prova e gabarito (4BAE41)
- `resumo-prova/prova_2/` — prova e gabarito (704C60)
- `resumo-prova/listas/` — listas de Programação Lógica e Combinadores
