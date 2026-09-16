# Simulado 2 — Explicação detalhada (debug das questões)

> Tente resolver primeiro; aqui está o raciocínio completo de cada questão.
> Códigos verificados no SWI-Prolog. Referências: `estudo/RESUMO_PROVA_1.md` (§).

**Gabarito:** A: `D, B, D, C, C, C, C, C, C, B, C, C` · B: **004**, **003**.

---

## Parte A

### Q1 — Conectivo verdadeiro só com valores diferentes → **D (XOR ⊻)**

A **disjunção exclusiva** é verdadeira apenas quando os valores **diferem**; se forem iguais (V,V ou F,F), é falsa. Não confunda com a disjunção comum (∨), que aceita os dois verdadeiros.

### Q2 — `ou/2` na base fechada → **B (disjunção)**

```prolog
(1) ou(true, true).
(2) ou(true, false).
(3) ou(false, true).
```

**Teste de cada consulta (unificação com os fatos):**

| Consulta | Substituindo | Resultado |
|---|---|---|
| `?- ou(true, true).` | casa com (1) | **true** |
| `?- ou(true, false).` | casa com (2) | **true** |
| `?- ou(false, true).` | casa com (3) | **true** |
| `?- ou(false, false).` | (1) exige 1º `true`; (2) exige 1º `true`; (3) exige 2º `true` → nenhum fato casa | **false** |

A única linha falsa é F,F → tabela da **disjunção**. (Se o único fato fosse `ou(true,true)`, seria conjunção — é a pegadinha do Sim1.)

### Q3 — `X is 2 ^ 3 + 1` → **D (Y = 9)**

Precedência (menor número liga mais forte): `^` tem 200, `+` tem 500 → o `^` primeiro:

```text
2 ^ 3 + 1  =  (2^3) + 1  =  8 + 1  =  9
```

Se alguém lesse `2 ^ (3+1)` daria 16 (alternativa E) — é o erro clássico.

### Q4 — Usar predicado próprio como função aritmética → **C (`:- arithmetic_function`)**

Receita completa (§5.4):

```prolog
:- use_module(library(arithmetic)).
:- arithmetic_function(meu_pred/1).    % aridade declarada = aridade do predicado − 1
meu_pred(X, Res) :- Res is X * 2.      % último argumento é o "retorno"
?- R is 1 + meu_pred(3).               % R = 7
```

### Q5 — Condicional `(A -> B ; C)` → **C (quando A falha)**

- `A` **sucede** → executa `B` (e só ele);
- `A` **falha** → executa o `;` → `C`;
- `B` falhar **não** cai em `C` (o teste já foi feito).

### Q6 — Base com único fato `cidade(df).` → **C (2 verdadeiras)**

| Consulta | Substituindo e executando | Resultado |
|---|---|---|
| `?- cidade(df).` | casa com o fato | **true** |
| `?- cidade(sp).` | `sp` ≠ `df` → nenhum fato | false |
| `?- cidade(X).` | unifica com o fato: **X = df** | **true** |
| `?- cidade(X), cidade(Y), X \= Y.` | `X = df`; `Y = df`; testa `df \= df` → falha (mesmo termo) | false |

Total: **2**. Detalhe da 4ª: como só há uma cidade, qualquer par de respostas é o mesmo termo — o `\=` nunca deixa passar.

### Q7 — Traço de `mdc(48, 18, X)` → **C (X = 6)**

> *Mesmo método de debug por fichas/substituição do Sim1 Q7.*

```prolog
(1) mdc(A, 0, A).
(2) mdc(A, B, X) :- B > 0, R is A mod B, mdc(B, R, X).
```

**Casamento das cláusulas, chamada por chamada:**

| Chamada | (1) `mdc(A, 0, A)` | (2) `mdc(A, B, X)` |
|---|---|---|
| `mdc(48, 18, X)` | 2º arg: `0 = 18` ✗ | `A = 48`, `B = 18` ✓ (usa esta) |
| `mdc(18, 12, X)` | `0 = 12` ✗ | ✓ |
| `mdc(12, 6, X)` | `0 = 6` ✗ | ✓ |
| `mdc(6, 0, X)` | `0 = 0` **✓ → BASE** (`X = A = 6`) | (nem tenta) |

**Passo 1 — chamada `mdc(48, 18, X)`**

- Cláusula (1): `mdc(A, 0, A)` casa? 2º argumento `0` com `18` → **não**. Tenta a (2).
- Cabeça: `A = 48`, `B = 18` (o `X` fica livre).
- Corpo (linha por linha):

  | Linha do corpo | Substituindo | Resultado |
  |---|---|---|
  | `B > 0` | `18 > 0` | ✓ |
  | `R is A mod B` | `R is 48 mod 18` | **R = 12** |
  | `mdc(B, R, X)` | `mdc(18, 12, X)` | **nova chamada → Passo 2** |

  Note: o corpo **acaba na chamada recursiva** — não há conta pendente depois dela. Quem
  descobrir o `X` é a chamada de baixo (isso é recursão de **cauda**).

**Passo 2 — chamada `mdc(18, 12, X)`**

| Linha | Substituindo | Resultado |
|---|---|---|
| `B > 0` | `12 > 0` | ✓ |
| `R is A mod B` | `R is 18 mod 12` | **R = 6** |
| `mdc(B, R, X)` | `mdc(12, 6, X)` | **nova chamada → Passo 3** |

**Passo 3 — chamada `mdc(12, 6, X)`**

| Linha | Substituindo | Resultado |
|---|---|---|
| `B > 0` | `6 > 0` | ✓ |
| `R is A mod B` | `R is 12 mod 6` | **R = 0** |
| `mdc(B, R, X)` | `mdc(6, 0, X)` | **nova chamada → Passo 4** |

**Passo 4 — chamada `mdc(6, 0, X)`**

- Cláusula (1): `mdc(A, 0, A)` casa com `mdc(6, 0, X)` → **A = 6** e o 3º argumento é o próprio
  `A` → **X = 6**. Termina aqui.

**Volta:** nenhuma conta a fazer — `X = 6` **já sobe pronto** da base (compare com o Q7 do
Sim1, em que as contas só aconteciam na volta). Verificado no SWI: `?- mdc(48, 18, X).` →
`X = 6` ✓.

### Q8 — Quantas retornam **verdadeiro**? → **C (2)**

| Consulta | Substituindo e executando | Resultado |
|---|---|---|
| `?- f(X, X) = f(a, b).` | 1º arg: `X = a`; 2º arg: o **mesmo X** teria de ser `b` → contradição | false |
| `?- 5 =:= 5.` | `=:=` calcula os dois lados: `5 =:= 5` | **true** |
| `?- g(a) = g(A), A \= b.` | `A = a`; depois `a \= b` (átomos diferentes) | **true** |
| `?- 2 + 3 = 5.` | `=` não avalia: termo `+(2,3)` ≠ átomo `5` | false |

**2 verdadeiras.** A 1ª é a pegadinha da “mesma variável” (§3.1): `f(X,X)` só casa com fatos de argumentos iguais.

### Q9 — O que caracteriza um combinador → **C (termo fechado, sem variáveis livres)**

Combinador: $FV(M) = \emptyset$. As demais alternativas descrevem falsidades: combinador **não** possui variáveis livres (A), não é sempre binário (B), não existe só na base SK (D — $I$, $B$, $C$ existem fora dela) e não depende de valores externos (E).

### Q10 — Forma do tordo-imitador na base SK → **B (`SII`)**

Derivação (decore o resultado, entenda a conta):

```text
Mx = xx                    (definição do tordo-imitador)
Ma = aa = Ia(Ia) = SIIa    (Ix = x; Sfgx = (fx)(gx) com f=I e g=I)
→ M = SII
```

Memorize o trio: $I = SKK$ · $B = S(KS)K$ · $M = SII$.

### Q11 — Traço de `conta([2,3,4,5,6], X)` → **C (X = 3)**

```prolog
(1) conta([], 0).
(2) conta([H|T], X) :- conta(T, Y), (0 =:= H mod 2 -> X is Y+1 ; X = Y).
```

**Casamento das cláusulas, chamada por chamada:**

| Chamada | (1) `conta([], 0)` | (2) `conta([H\|T], X)` |
|---|---|---|
| `conta([2,3,4,5,6], X)` | `[] = [2,3,4,5,6]` ✗ | `H = 2`, `T = [3,4,5,6]` ✓ (usa esta) |
| `conta([3,4,5,6], Y)` | ✗ | `H = 3`, `T = [4,5,6]` ✓ |
| `conta([4,5,6], Y1)` | ✗ | ✓ |
| `conta([5,6], Y2)` | ✗ | ✓ |
| `conta([6], Y3)` | ✗ | `H = 6`, `T = []` ✓ |
| `conta([], Y4)` | `[] = []` **✓ → BASE** (`Y4 = 0`) | (nem tenta) |

**Passo 1 — chamada `conta([2,3,4,5,6], X)`**

- (1) casa? `[]` com `[2,3,4,5,6]` → não. (2) cabeça: **H = 2**, **T = [3,4,5,6]**.
- Corpo:

  | Linha do corpo | Substituindo | Resultado |
  |---|---|---|
  | `conta(T, Y)` | `conta([3,4,5,6], Y)` | **nova chamada → Passo 2** |
  | `0 =:= H mod 2` | `0 =:= 2 mod 2` → `0 =:= 0` | **verdadeiro** → ramo `then` |
  | `X is Y + 1` | `X is Y + 1` | **pendente** (espera o Passo 2) |

**Passo 2 — `conta([3,4,5,6], Y)`** → H = 3, T = [4,5,6]

| Linha | Substituindo | Resultado |
|---|---|---|
| `conta(T, Y)` | `conta([4,5,6], Y1)` | **nova chamada → Passo 3** |
| `0 =:= H mod 2` | `0 =:= 3 mod 2` → `0 =:= 1` | **falso** → ramo `else` |
| `X = Y` | `Y = Y1` | **pendente** |

**Passo 3 — `conta([4,5,6], Y1)`** → H = 4, T = [5,6]

| Linha | Substituindo | Resultado |
|---|---|---|
| `conta(T, Y)` | `conta([5,6], Y2)` | **nova chamada → Passo 4** |
| `0 =:= H mod 2` | `0 =:= 4 mod 2` → `0 =:= 0` | **verdadeiro** → `then` |
| `X is Y + 1` | `Y1 is Y2 + 1` | **pendente** |

**Passo 4 — `conta([5,6], Y2)`** → H = 5, T = [6]

| Linha | Substituindo | Resultado |
|---|---|---|
| `conta(T, Y)` | `conta([6], Y3)` | **nova chamada → Passo 5** |
| `0 =:= H mod 2` | `0 =:= 5 mod 2` → `0 =:= 1` | **falso** → `else` |
| `X = Y` | `Y2 = Y3` | **pendente** |

**Passo 5 — `conta([6], Y3)`** → H = 6, T = []

| Linha | Substituindo | Resultado |
|---|---|---|
| `conta(T, Y)` | `conta([], Y4)` | **nova chamada → Passo 6** |
| `0 =:= H mod 2` | `0 =:= 6 mod 2` → `0 =:= 0` | **verdadeiro** → `then` |
| `X is Y + 1` | `Y3 is Y4 + 1` | **pendente** |

**Passo 6 — `conta([], Y4)`**

- (1) `conta([], 0)` casa → **Y4 = 0**. Termina.

**Volta — cada nível decide pelo seu H:**

| Ficha | H | Conta | Resultado |
|---|---|---|---|
| Passo 5 | 6 | par → `Y3 is Y4 + 1` | **Y3 = 0 + 1 = 1** |
| Passo 4 | 5 | ímpar → `Y2 = Y3` | **Y2 = 1** |
| Passo 3 | 4 | par → `Y1 is Y2 + 1` | **Y1 = 1 + 1 = 2** |
| Passo 2 | 3 | ímpar → `Y = Y1` | **Y = 2** |
| Passo 1 | 2 | par → `X is Y + 1` | **X = 2 + 1 = 3** ✓ |

Contou os pares **2, 4 e 6** → `X = 3` (verificado).

### Q12 — Traço de `p(64, K)` → **C (K = 6)**

```prolog
(1) p(1, 0).
(2) p(N, K) :- N > 1, 0 =:= N mod 2, M is N div 2, p(M, K1), K is K1 + 1.
```

**Casamento das cláusulas, chamada por chamada:**

| Chamada | (1) `p(1, 0)` | (2) `p(N, K)` |
|---|---|---|
| `p(64, K)` | `1 = 64` ✗ | `N = 64` ✓ (usa esta) |
| `p(32, K1)` | ✗ | ✓ |
| `p(16, K1')` | ✗ | ✓ |
| `p(8, K1'')` | ✗ | ✓ |
| `p(4, K1''')` | ✗ | ✓ |
| `p(2, K1'''')` | ✗ | ✓ |
| `p(1, K1''''')` | `1 = 1` **✓ → BASE** (`K1''''' = 0`) | (nem tenta) |

**Passo 1 — chamada `p(64, K)`**

- (1) casa? `1` com `64` → não. (2) cabeça: **N = 64**.
- Corpo:

  | Linha do corpo | Substituindo | Resultado |
  |---|---|---|
  | `N > 1` | `64 > 1` | ✓ |
  | `0 =:= N mod 2` | `0 =:= 64 mod 2` → `0 =:= 0` | ✓ |
  | `M is N div 2` | `M is 64 div 2` | **M = 32** |
  | `p(M, K1)` | `p(32, K1)` | **nova chamada → Passo 2** |
  | `K is K1 + 1` | — | **pendente** |

**Passos 2 a 6** (mesmo padrão — só muda o valor):

| Ficha | Chamada | `M is N div 2` | Vai para |
|---|---|---|---|
| 2 | `p(32, K1)` | **16** | `p(16, K1')` |
| 3 | `p(16, K1')` | **8** | `p(8, K1'')` |
| 4 | `p(8, K1'')` | **4** | `p(4, K1''')` |
| 5 | `p(4, K1''')` | **2** | `p(2, K1'''')` |
| 6 | `p(2, K1'''')` | **1** | `p(1, K1''''')` |

**Passo 7 — chamada `p(1, K1''''')`**

- (1) `p(1, 0)` casa → **K1''''' = 0**. Termina.

**Volta — cada nível soma 1:**

| Ficha | Conta pendente | Resultado |
|---|---|---|
| 6 | `K1'''' is 0 + 1` | **1** |
| 5 | `K1''' is 1 + 1` | **2** |
| 4 | `K1'' is 2 + 1` | **3** |
| 3 | `K1' is 3 + 1` | **4** |
| 2 | `K1 is 4 + 1` | **5** |
| 1 | `K is 5 + 1` | **6** ✓ |

São **6 divisões**: 64 → 32 → 16 → 8 → 4 → 2 → 1 (verificado).

---

## Parte B

### Q13 — Linhas da tabela de $\lnot(p \land q) \leftrightarrow (\lnot p \lor \lnot q)$ → **004**

Variáveis simples distintas: só $p$ e $q$ → $2^2 = \mathbf{4}$ linhas → CDU **004**. (A proposição é a Lei de De Morgan, mas isso não muda a contagem.)

### Q14 — Quantas **regras**? → **003**

```prolog
1  a(1).                    fato
2  b(2).                    fato
3  c(X) :- a(X) ; b(X).     REGRA (1)
4  d(X) :- c(X), a(X).      REGRA (2)
5  e(X) :- c(X), b(X).      REGRA (3)
```

**3 regras** → CDU **003**. Note que `;` (ou) no corpo continua sendo **uma** regra.

---

> **O que treinar deste simulado:** traço do Euclides (Q7) e contagens com acumulador na volta (Q11, Q12), além das contagens de consultas verdadeiras (Q6, Q8).
