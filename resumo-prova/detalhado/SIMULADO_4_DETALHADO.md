# Simulado 4 — Explicação detalhada (Prova 1 real 4BAE41 + Combinadores)

> Este é o simulado **fiel à prova aplicada**: Q1–Q10 são as múltiplas escolha originais,
> Q11–Q12 as abertas em CDU, e a Parte C traz combinadores da antiga Prova 2 + análise dos
> predicados que eram de código. Códigos verificados no SWI-Prolog.

**Gabarito:** A: `E, B, A, A, A, D, A, C, B, A` · B: **004**, **003** · C: `D, E, D, C, B`, **370**.

---

## Parte A

### Q1 — Conectivo da bicondicional → **E (↔)**

Bicondicional = "se, e somente se": verdadeira quando os valores são **iguais** (V↔V, F↔F) e falsa quando diferem. Símbolos: $a \leftrightarrow b$, $a \iff b$, $a \equiv b$.

### Q2 — `op(true, true).` → **B (conjunção)**

```prolog
(1) op(true, true).
```

**Teste de cada consulta (substituindo e verificando a unificação):**

| Consulta | Substituindo | Resultado |
|---|---|---|
| `?- op(true, true).` | casa com (1) | **true** |
| `?- op(true, false).` | (1) exige 2º `true`; `false` ≠ `true` | false |
| `?- op(false, true).` | (1) exige 1º `true`; `false` ≠ `true` | false |
| `?- op(false, false).` | nenhum argumento casa | false |

Tabela = conjunção (só V com V e V). Sem pensar em mundo fechado, o candidato natural seria "disjunção" — pegadinha.

### Q3 — `f(X) :- X is 2 + 1*3.` → **A (Y = 5)**

Precedência: `*` (400) liga antes de `+` (500):

```text
2 + 1*3  =  2 + (1*3)  =  2 + 3  =  5
```

(Se fosse `(2+1)*3` daria 9 — mas **não há parênteses**.)

### Q4 — Diretiva com precedência/associatividade/posição → **A (`:- op`)**

```prolog
:- op(500, yfx, +).
%      ^     ^    ^
%   precedência tipo posição/nome
```

`current_op/3` **consulta**; `op/3` **declara**. Tipos: `xfx` (não assoc.), `xfy` (dir.), `yfx` (esq.), `fy`/`fx` (prefixo), `xf` (pós-fixo).

### Q5 — Entrar na consulta Q3 pela porta **redo** → **A (`;`)**

Numa conjunção `Q1, Q2, Q3`: o `;` digitado após um sucesso força **redo no último objetivo** (Q3), desatando apenas as variáveis locais dele. As portas: **call** (início), **exit** (sucesso), **fail** (sem cláusula), **redo** (retomada) — e é o `;` que pede o redo.

### Q6 — Aridade de `alfa` → **D (3)**

```prolog
alfa(a, 1, True).       ← 3 argumentos → alfa/3
beta(25).               → beta/1
gama(banana, laranja).  → gama/2
delta(norte, 9.0, sul, 4.5). → delta/4
omega :- f(A, B, C), write(B), nl.   → omega/0
```

Aridade = **número de argumentos**: `alfa/3`. Note que `True` (maiúsculo) é variável, mas continua sendo **1 argumento**.

### Q7 — Traço de `f(10, 4, X)` (Collatz) → **A (X = 4)**

> *Mesmo método de debug por fichas/substituição do Sim1 Q7.*

```prolog
(1) f(N, M, X) :- g(M, N, X).
(2) g(M, N, X) :- N > 0, (N mod 2 =:= 0 -> NewN is N div 2 ; NewN is 3*N + 1),
                   succ(NewM, M), g(NewM, NewN, X).
(3) g(0, X, X).
```

**Casamento das cláusulas:**

- `f(10, 4, X)` — existe só a cláusula (1) → `N = 10`, `M = 4`; o corpo chama `g(4, 10, X)`.
- No `g`, a ordem é: **(2) recursiva primeiro**, depois **(3) base**.

| Chamada | (2) `g(M, N, X)` | (3) `g(0, X, X)` |
|---|---|---|
| `g(4, 10, X)` | cabeça ✓ e `N > 0` ✓ → usa esta | (nem chega) |
| `g(3, 5, X)` | ✓ | (nem chega) |
| `g(2, 16, X)` | ✓ | (nem chega) |
| `g(1, 8, X)` | ✓ | (nem chega) |
| `g(0, 4, X)` | cabeça casa (`M = 0`), mas o corpo **falha** em `succ(NewM, 0)` — não existe natural cujo sucessor seja 0 ("succ" do SWI exige antecessor ≥ 0) | `0 = 0` **✓ → BASE** (`X = 4`) |

**Passo 0 — chamada `f(10, 4, X)`**

- Cláusula (1): `f(N, M, X)` casa → **N = 10**, **M = 4**.
- Corpo, linha por linha:

  | Linha | Substituindo | Resultado |
  |---|---|---|
  | `g(M, N, X)` | `g(4, 10, X)` | **nova chamada → Passo 1** |

  Repare a **troca de ordem**: o 1º argumento de `g` é o `M` (4) e o 2º é o `N` (10).

**Passo 1 — chamada `g(4, 10, X)`**

- Cláusula (3): `g(0, X, X)` casa? 1º argumento `0` com `4` → **não**. Tenta a (2):
  **M = 4**, **N = 10**.
- Corpo:

  | Linha | Substituindo | Resultado |
  |---|---|---|
  | `N > 0` | `10 > 0` | ✓ |
  | `N mod 2 =:= 0` | `10 mod 2 =:= 0` → `0 =:= 0` | **verdadeiro** → ramo `then` |
  | `NewN is N div 2` | `NewN is 10 div 2` | **NewN = 5** |
  | `succ(NewM, M)` | `succ(NewM, 4)` | **NewM = 3** ("o sucessor de NewM é 4") |
  | `g(NewM, NewN, X)` | `g(3, 5, X)` | **nova chamada → Passo 2** |

**Passo 2 — chamada `g(3, 5, X)`** → M = 3, N = 5

| Linha | Substituindo | Resultado |
|---|---|---|
| `N > 0` | `5 > 0` | ✓ |
| `N mod 2 =:= 0` | `5 mod 2 =:= 0` → `1 =:= 0` | **falso** → ramo `else` |
| `NewN is 3*N + 1` | `NewN is 3*5 + 1` | **NewN = 16** |
| `succ(NewM, M)` | `succ(NewM, 3)` | **NewM = 2** |
| `g(NewM, NewN, X)` | `g(2, 16, X)` | **nova chamada → Passo 3** |

**Passo 3 — chamada `g(2, 16, X)`** → M = 2, N = 16

| Linha | Substituindo | Resultado |
|---|---|---|
| `N > 0` | `16 > 0` | ✓ |
| `N mod 2 =:= 0` | `16 mod 2 =:= 0` → `0 =:= 0` | **verdadeiro** → `then` |
| `NewN is N div 2` | `NewN is 16 div 2` | **NewN = 8** |
| `succ(NewM, M)` | `succ(NewM, 2)` | **NewM = 1** |
| `g(NewM, NewN, X)` | `g(1, 8, X)` | **nova chamada → Passo 4** |

**Passo 4 — chamada `g(1, 8, X)`** → M = 1, N = 8

| Linha | Substituindo | Resultado |
|---|---|---|
| `N > 0` | `8 > 0` | ✓ |
| `N mod 2 =:= 0` | `8 mod 2 =:= 0` → `0 =:= 0` | **verdadeiro** → `then` |
| `NewN is N div 2` | `NewN is 8 div 2` | **NewN = 4** |
| `succ(NewM, M)` | `succ(NewM, 1)` | **NewM = 0** |
| `g(NewM, NewN, X)` | `g(0, 4, X)` | **nova chamada → Passo 5** |

**Passo 5 — chamada `g(0, 4, X)`**

- Cláusula (2): a cabeça casa (`M = 0`, `N = 4`), mas o corpo **falha** em `succ(NewM, 0)` —
  o `succ/2` do SWI exige antecessor **não-negativo** (não existe natural cujo sucessor seja 0).
- Cláusula (3): `g(0, X, X)` casa → o 2º argumento (4) e o 3º são o **mesmo X** → **X = 4**.
  Termina aqui.

**Volta:** nenhuma conta pendente — a resposta já sobe pronta (recursão de cauda). O `M` é só um
contador de segurança que **desce** até 0 (por isso o `succ(NewM, M)` "invertido"). Verificado:
`?- f(10, 4, X).` → `X = 4` ✓.

### Q8 — Quantas retornam **falso**? → **C (2)**

| Consulta | Substituindo e executando | Resultado |
|---|---|---|
| `?- 2 + 2 = 4.` | `=` não avalia: o termo `+(2,2)` ≠ o átomo `4` | **false** |
| `?- X = Y.` | duas variáveis livres unificam sempre (ficam apelidadas) | true |
| `?- f(_) = f(x, x).` | aridades diferentes: `f/1` vs `f/2` → nem compara os args | **false** |
| `?- f(_, g(B,c)) = f(A, g(b,C)), B \= C.` | casa estrutura a estrutura: `B = b`, `C = c`; depois `b \= c` | true |

**2 falsas** (a 1ª e a 3ª). A pegadinha é a 2ª (`X = Y` é **true**!) e a 4ª (unificação aninhada funciona).

### Q9 — Predicado "não unifica" → **B (`\=`)**

| Predicado | O que faz |
|---|---|
| `=` | unifica (sintático) |
| **`\=`** | **verdadeiro se NÃO unifica** |
| `\+` | nega um **objetivo** (negacão por falha) |
| `=:=` / `=\=` | comparam **valores** |

Ex.: `a \= b` → true; `2 \= 2` → false; `2+2 \= 4` → **true** (não calcula!).

### Q10 — Traço de `p([2, 3, 5], X)` → **A (X = 1)**

```prolog
(1) p([_|[]], X) :- p([], X).                     % lista de exatamente 1 elemento
(2) p([], 0).                                     % base
(3) p([A,B|C], X) :- p(C, NewX), X is NewX + (B - A).
```

**O que o código faz, em português:**

1. **Lista vazia** (`[]`) → resposta **0**.
2. **Lista de 1 elemento** (`[_|[]]`) → "repassa" para a lista vazia → **0** (o elemento sozinho
   é ignorado).
3. **Lista de 2 ou mais** (`[A,B|C]`) → pega **os dois primeiros** (A e B), calcula `B − A` e
   soma com a resposta do **resto** (`C`).

Resultado prático: **soma as diferenças de pares consecutivos** — (2º−1º) + (4º−3º) + (6º−5º)…
Se a lista tiver tamanho **ímpar**, o último elemento é descartado (cai na regra 2).

**Como ler `[A,B|C]` (e a questão da "aridade"):**

- `[X|Y]` é só forma curta de `'.'(X, Y)` — o functor dos pares (cabeça, cauda), que tem
  **aridade 2**. Mas isso é a anatomia interna da lista, **não** a aridade do predicado.
- A **aridade do predicado** conta os argumentos: `p([2,3,5], X)` tem 2 argumentos → `p/2`; a
  lista inteira conta como **1** argumento.
- `[A,B|C]` = `'.'(A, '.'(B, C))` → "A = 1º, B = 2º, C = lista do resto". Exemplo:
  `[2,3,5]` = `'.'(2, '.'(3, '.'(5, [])))`; casando com `[A,B|C]`: **A = 2**, **B = 3**,
  **C = [5]**.

**Verificações no SWI (para fixar a dinâmica):**

| Consulta | Conta | Resultado |
|---|---|---|
| `p([], X)` | base | `0` |
| `p([9], X)` | regra 2 → lista vazia | `0` |
| `p([2,3,5], X)` | (3−2) | `1` |
| `p([1,4,10,20], X)` | (4−1) + (20−10) | `13` |
| `p([1,2,3,4,5,6], X)` | (2−1) + (4−3) + (6−5) | `3` |

**Teste das cláusulas ("casou ou não", passo a passo):**

```text
p([2,3,5], X)
  (1) [_|[]] = [2,3,5]    →  _ = 2 (✓) e [] = [3,5] (✗)   → não casa
  (2) [] = [2,3,5]        →  ✗
  (3) [A,B|C] = [2,3,5]   →  A = 2, B = 3, C = [5]        → casa ✓

p([5], NewX)               ← o resto C é a LISTA [5]
  (1) [_|[]] = [5]        →  _ = 5 (✓) e [] = [] (✓)      → casa ✓ (corpo: p([], NewX))
      p([], NewX)
        (1) [_|[]] = []   →  ✗
        (2) p([], 0) = p([], NewX)  →  NewX = 0            → casa ✓

voltando:  X is NewX + (B - A)  →  X is 0 + (3 - 2)  →  X = 1
```

**Passo 1 — chamada `p([2, 3, 5], X)`**

- (1) `[_|[]]` casa com `[2,3,5]`? Essa máscara exige lista de **1** elemento → não (tem 3).
- (2) `p([], 0)` casa? 1º argumento `[]` com `[2,3,5]` → não.
- (3) cabeça `p([A,B|C], X)` → **A = 2**, **B = 3**, **C = [5]**.
- Corpo:

  | Linha do corpo | Substituindo | Resultado |
  |---|---|---|
  | `p(C, NewX)` | `p([5], NewX)` | **nova chamada → Passo 2** |
  | `X is NewX + (B - A)` | `X is NewX + (3 - 2)` | **pendente** |

**Passo 2 — chamada `p([5], NewX)`**

- (1) `p([_|[]], X) :- p([], X)` casa: a máscara `[_|[]]` = lista de 1 elemento → **sim**
  (`[_|[]]` = `[5]`). A 2ª posição da chamada (`NewX`) é o `X` desta cláusula.
- Corpo:

  | Linha | Substituindo | Resultado |
  |---|---|---|
  | `p([], X)` | `p([], NewX)` | **nova chamada → Passo 3** |

  Não há conta depois — a cláusula (1) só **delega** para a base.

**Passo 3 — chamada `p([], NewX)`**

- (2) `p([], 0)` casa → **NewX = 0**. Termina.

**Volta:**

| Ficha | Conta pendente | Substituindo | Resultado |
|---|---|---|---|
| Passo 2 | — (delegação) | — | devolve `NewX = 0` |
| Passo 1 | `X is NewX + (3-2)` | `X is 0 + 1` | **X = 1** ✓ |

No nosso exemplo só existe **um par**: `X = 0 + (3 − 2) = 1` ✓ (verificado no SWI, junto com os
outros exemplos da tabela acima).

---

## Parte B

### Q11 — Linhas da tabela-verdade → **004**

$P : (p \lor (q \land p)) \land (\sim p \lor (p \land q))$. Variáveis simples distintas: $p$ e $q$ (repetições e subexpressões não contam) → $2^2 = 4$ → CDU **004**.

### Q12 — Quantas **regras** → **003**

```prolog
1  f(1, 2).      fato
2  f(2, 2).      fato
3  f(3, 1).      fato
5  g(1).         fato
6  g(2).         fato
7  g(3).         fato
8  h(10).        fato
10 f(X, Y) :- g(X), h(Y).     REGRA (1)
11 f(X, X) :- g(X) ; h(X).    REGRA (2)
12 g(Z) :- f(1, Z).           REGRA (3)
```

**3 regras** (linhas 10, 11, 12) → CDU **003**.

---

## Parte C — Combinadores e análise

### Q13 — Letra **Z** de Schönfinkel → **D (composição)**

$Z\varphi\chi x = \varphi(\chi x)$ — composição, hoje $B$ (bluebird). As outras funções: $I$ identidade, $K$ constância, $T$ intercâmbio, $S$ fusão.

### Q14 — Redução de `SKSabc` → **E (`abc`)**

```text
S K S a b c
= ((S K S) a) b c          (associa à esquerda)
= (K a (S a)) b c          (Sfgx = (fx)(gx), f=K, g=S, x=a)
= a b c                    (Kay = a: o K descarta o (S a))
```

**`abc`** ✓. É o mesmo padrão do `SKS34` do Sim3 (lá, `34`).

### Q15 — Conceito de combinador → **D (`FV(M) = ∅`)**

Combinador é **termo fechado**: sem variáveis livres. As demais notações são: aplicação (`MN`), abstração (`λx.M`), substituição (`M[x := N]`) e extensionalidade (`∀x, Mx ≡ Nx`) — nenhuma delas define "combinador".

### Q16 — `is_sum_of_5`: quantas consultas retornam true → **C (2)**

```prolog
is_sum_of_5(N) :-
    N >= 15,                                        % mínimo: 1+2+3+4+5 = 15
    between(1, N, A),
    between(A, N, B), A < B,
    between(B, N, C), B < C,
    between(C, N, D), C < D,
    between(D, N, E), D < E,
    N =:= A + B + C + D + E.
```

Análise das três consultas (substituindo os valores e seguindo os objetivos):

| Consulta | Substituindo e executando | Resultado |
|---|---|---|
| `?- is_sum_of_5(5).` | 1º objetivo: `5 >= 15` → **falha** (nem tenta os `between`) | **false** |
| `?- is_sum_of_5(15).` | `15 >= 15` ✓; a busca acha `A,B,C,D,E = 1,2,3,4,5`; `15 =:= 1+2+3+4+5` ✓ | **true** |
| `?- is_sum_of_5(30).` | `30 >= 15` ✓; acha, por exemplo, `1,2,3,4,20`; `30 =:= 30` ✓ | **true** |

São **2 true** ✓ (verificado). O `A < B < C < D < E` garante distintos **sem repetir permutações** — se não houvesse a ordem, a busca geraria a mesma soma várias vezes.

### Q17 — `power_of_5`: resultados das três consultas → **B (true · true · false)**

```prolog
(1) power_of_5(1).                                    % base: 5^0
(2) power_of_5(N) :- N > 1, N mod 5 =:= 0, M is N div 5, power_of_5(M).
```

**Casamento das cláusulas:**

| Chamada | (1) `power_of_5(1)` | (2) `power_of_5(N)` |
|---|---|---|
| `power_of_5(1)` | `1 = 1` **✓ → true** | (nem tenta) |
| `power_of_5(25)` | `1 = 25` ✗ | `N = 25` ✓ (corpo: `25 mod 5 =:= 0` ✓ …) |
| `power_of_5(5)` | ✗ | ✓ |
| `power_of_5(1)` | `1 = 1` ✓ → true | |
| `power_of_5(100)` | ✗ | `N = 100` ✓ |
| `power_of_5(20)` | ✗ | ✓ |
| `power_of_5(4)` | `1 = 4` ✗ | `N = 4` ✓ mas o **corpo falha**: `4 mod 5 =:= 0` ✗ → sem mais cláusulas → **false** |

**Consulta `power_of_5(1)`**

- (1) `power_of_5(1)` casa direto → **true**. (As buscas seguintes terminam sem outra solução.)

**Consulta `power_of_5(25)`**

- (1) casa? `1` com `25` → não. (2) **N = 25**:

  | Linha | Substituindo | Resultado |
  |---|---|---|
  | `N > 1` | `25 > 1` | ✓ |
  | `N mod 5 =:= 0` | `25 mod 5 =:= 0` → `0 =:= 0` | ✓ |
  | `M is N div 5` | `M is 25 div 5` | **M = 5** |
  | `power_of_5(M)` | `power_of_5(5)` | **nova chamada** |

- `power_of_5(5)`: mesma ficha → `M is 5 div 5` → **M = 1** → chama `power_of_5(1)` →
  **(1) casa → true**; o `true` sobe por toda a cadeia → **true**.

**Consulta `power_of_5(100)`**

| Chamada | `N > 1` | `N mod 5 =:= 0` | `M is N div 5` | Próxima |
|---|---|---|---|---|
| `power_of_5(100)` | ✓ | `0 =:= 0` ✓ | **20** | `power_of_5(20)` |
| `power_of_5(20)` | ✓ | `0 =:= 0` ✓ | **4** | `power_of_5(4)` |
| `power_of_5(4)` | ✓ | **`4 =:= 0` ✗** | — | **falha** |

Em `power_of_5(4)`: (1) não casa (`1` com `4`); (2) falha no `mod` → **não há mais cláusulas** →
**false** (e esse false sobe para as chamadas de cima) → a consulta toda é **false**.

Resumo: `1` → true (é $5^0$); `25` → 25→5→1 → true; `100` → 100→20→4 ✗ → false ✓ (verificado).

### Q18 — Redução de `S((S(K((S(KS))K)))S)(KK)307` → **370**

Cada dígito é um termo. Reduza da esquerda para a direita, um $S$ por vez:

```text
1) S (US) (KK) 3          = (US 3)(KK 3)        [regra do S: Sfgx = (fx)(gx)]
        com U = S(K((S(KS))K))
2) US = S(K(B))S           → US 3 = B(S 3)       [pois (S(KS))K = B]
3) KK 3                    = K
4) = B(S3) K 0             = (S3)(K 0)           [regra do B: Bfgx = f(gx)]
5) (S3)(K0) 7              = (3 7)((K0) 7) = (3 7) 0
```

Os dígitos na ordem: **3, 7, 0** → **370** ✓ (gabarito oficial da prova: `3 7 0`).

---

> **O que treinar deste simulado:** o traço do Collatz (Q7) e as consultas de unificação (Q8), a contagem de linhas/regras (Q11/Q12) e a redução em cadeia (Q18). As seções §6.2, §3.3, §8.5 do resumo cobrem exatamente isso.
