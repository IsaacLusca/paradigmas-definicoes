# Simulado 1 — Explicação detalhada (debug das questões)

> Tente resolver primeiro; aqui está o raciocínio completo de cada questão.
> Códigos verificados no SWI-Prolog. Referências: `estudo/RESUMO_PROVA_1.md` (§).

**Gabarito:** A: `B, D, A, B, C, C, D, C, D, E, B, C` · B: **008**, **004**.

---

## Parte A

### Q1 — Conectivo falso só quando ambas são falsas → **B (∨)**

A **disjunção** é a única que "morre" com tudo falso. Cada conectivo tem seu caso especial:

| Conectivo | Único caso especial |
|---|---|
| ∧ | V só com V **e** V |
| **∨** | **F só com F e F** ← resposta |
| → | F só com V → F |
| ↔ | V só com valores iguais |
| ¬ | inverte |

### Q2 — `xor/2` na base fechada → **D (disjunção exclusiva)**

```prolog
(1) xor(true, false).
(2) xor(false, true).
```

**Teste de cada consulta (substituindo e verificando a unificação):**

| Consulta | Substituindo | Resultado |
|---|---|---|
| `?- xor(true, false).` | casa com o fato (1): `true=true`, `false=false` | **true** |
| `?- xor(false, true).` | casa com o fato (2) | **true** |
| `?- xor(true, true).` | (1): 2º arg `false` com `true` → não; (2): 1º arg `false` com `true` → não | **false** (não há fato) |
| `?- xor(false, false).` | nenhum fato casa | **false** |

A tabela que sobra é exatamente a do **XOR**: verdadeiro quando os valores **diferem**. Pegadinha: sem pensar em mundo fechado, alguém "completaria" a tabela e erraria.

### Q3 — `X is (2 + 3) * 2 - 1` → **A (Y = 9)**

Debug do `is/2` (avaliação da direita, passo a passo):

| Passo | Conta | Parcial |
|---|---|---|
| 1 | parênteses | $(2+3) = 5$ |
| 2 | multiplicação | $5 \times 2 = 10$ |
| 3 | subtração | $10 - 1 = 9$ |
| 4 | unifica | `X = 9` → `Y = 9` |

### Q4 — Consultar operador já definido → **B (`current_op/3`)**

- `op/3` **declara** (`:- op(500, yfx, +).`)
- `current_op(P, T, N)` **consulta** precedência, tipo e nome
- `dynamic/1` libera assert/retract; `is/2` avalia; `meta_predicate/1` declara meta-predicado

### Q5 — Consulta composta + `;` → **C (redo, na Q3)**

As 4 portas:

| Porta | Significado |
|---|---|
| **call** | começa a tentar um objetivo |
| **exit** | unificou (sucesso) |
| **fail** | não há (mais) cláusula que sirva |
| **redo** | "quero outra resposta": retoma da última escolha |

O `;` digitado após um sucesso = **redo**. Em `Q1, Q2, Q3` (conjunção), o redo reentra no **último** objetivo (Q3), desatando apenas as variáveis locais dele; Q1 e Q2 permanecem atados.

### Q6 — Aridade de `s` e nº de regras → **C (`s/3` e 1 regra)**

```prolog
r(a, 1).
s(2, b, c).
t(X) :- s(X, _, _).
```

Debug do código:

| Cláusula | Tipo | Aridade |
|---|---|---|
| `r(a, 1).` | fato | `r/2` (não interessa) |
| `s(2, b, c).` | fato | **`s/3`** ← 3 argumentos |
| `t(X) :- s(X, _, _).` | **regra** | `t/1` |

Regras = cláusulas com `:-` → só 1 (`t/1`). **Pegadinha:** `s` tem 1 fato e 0 regras; a aridade se lê do **fato**, o `_` não muda isso.

### Q7 — Traço de `h(4, X)` → **D (X = 10)**

```prolog
(1) h(0, 0).
(2) h(N, X) :- N > 0, M is N - 1, h(M, Y), X is Y + N.
```

**Casamento das cláusulas, chamada por chamada** (o Prolog testa na ordem e para na primeira que casa):

| Chamada | (1) `h(0, 0)` | (2) `h(N, X)` |
|---|---|---|
| `h(4, X)` | `0 = 4` ✗ | `N = 4` ✓ (usa esta) |
| `h(3, Y)` | `0 = 3` ✗ | `N = 3` ✓ |
| `h(2, Y1)` | `0 = 2` ✗ | `N = 2` ✓ |
| `h(1, Y2)` | `0 = 1` ✗ | `N = 1` ✓ |
| `h(0, Y3)` | `0 = 0` **✓ → BASE** | (nem tenta) |

> **Método de debug por substituição** (vamos usar este formato daqui em diante): para cada
> chamada, monte uma **ficha**: (1) a cláusula que casou; (2) as variáveis da cabeça substituídas
> pelos argumentos; (3) o corpo executado **linha por linha**, anotando cada valor; (4) ao
> encontrar uma chamada ao próprio predicado, **abra outra ficha** (descida) — o resto do corpo
> fica *pendente*; (5) no caso base, **volte** preenchendo as pendências (subida).

**Passo 1 — chamada `h(4, X)`**

- Cláusula (1): `h(0, 0)` casa com `h(4, X)`? `0` com `4` → **não**. Tenta a (2).
- Cabeça: `h(N, X)` com `h(4, X)` → **N = 4** (o `X` continua livre).
- Corpo (linha por linha):

  | Linha do corpo | Substituindo | Resultado |
  |---|---|---|
  | `N > 0` | `4 > 0` | **verdadeiro** ✓ |
  | `M is N - 1` | `M is 4 - 1` | **M = 3** |
  | `h(M, Y)` | `h(3, Y)` | **nova chamada → Passo 2** (o `X` fica esperando) |
  | `X is Y + N` | `X is Y + 4` | **pendente** (Y ainda não tem valor) |

**Passo 2 — chamada `h(3, Y)`**

- (1) casa? `0` com `3` → não. (2) cabeça: `h(N, X)` com `h(3, Y)` → **N = 3**; nesta ficha, o
  `X` da cláusula é o **`Y` do Passo 1** (cada chamada tem suas próprias variáveis).
- Corpo:

  | Linha | Substituindo | Resultado |
  |---|---|---|
  | `N > 0` | `3 > 0` | ✓ |
  | `M is N - 1` | `M is 3 - 1` | **M = 2** |
  | `h(M, Y)` | `h(2, Y1)` | **nova chamada → Passo 3** |
  | `X is Y + N` | `Y is Y1 + 3` | **pendente** |

**Passo 3 — chamada `h(2, Y1)`**

| Linha | Substituindo | Resultado |
|---|---|---|
| `N > 0` | `2 > 0` | ✓ |
| `M is N - 1` | `M is 2 - 1` | **M = 1** |
| `h(M, Y)` | `h(1, Y2)` | **nova chamada → Passo 4** |
| `X is Y + N` | `Y1 is Y2 + 2` | **pendente** |

**Passo 4 — chamada `h(1, Y2)`**

| Linha | Substituindo | Resultado |
|---|---|---|
| `N > 0` | `1 > 0` | ✓ |
| `M is N - 1` | `M is 1 - 1` | **M = 0** |
| `h(M, Y)` | `h(0, Y3)` | **nova chamada → Passo 5** |
| `X is Y + N` | `Y2 is Y3 + 1` | **pendente** |

**Passo 5 — chamada `h(0, Y3)`**

- Cláusula (1): `h(0, 0)` casa com `h(0, Y3)` → **Y3 = 0**. Não há corpo → a chamada termina
  devolvendo **Y3 = 0**.

**Volta (subida) — agora as contas pendentes acontecem, do fundo para o topo:**

| Ficha | Conta pendente | Substituindo | Resultado |
|---|---|---|---|
| Passo 4 | `Y2 is Y3 + 1` | `Y2 is 0 + 1` | **Y2 = 1** |
| Passo 3 | `Y1 is Y2 + 2` | `Y1 is 1 + 2` | **Y1 = 3** |
| Passo 2 | `Y is Y1 + 3` | `Y is 3 + 3` | **Y = 6** |
| Passo 1 | `X is Y + 4` | `X is 6 + 4` | **X = 10** ✓ |

O predicado **soma 1..N** (no fundo a base devolve 0; cada nível soma o seu `N` na volta).
Verificado no SWI: `?- h(4, X).` → `X = 10`.

### Q8 — Quantas consultas **retornam verdadeiro**? → **C (2)**

| Consulta                   | Substituindo e executando                 | Resultado |
| -------------------------- | ----------------------------------------- | --------- |
| `?- 1 + 1 =:= 2.`          | `=:=` calcula: `1+1` → `2`; `2 =:= 2`     | **true**  |
| `?- 3 =:= 4.`              | `3 =:= 4`                                 | false     |
| `?- f(a) = f(b).`          | `=` unifica: 2º arg `a` com `b` → não     | false     |
| `?- X = 1, Y = 2, X \= Y.` | `X = 1`; `Y = 2`; `1 \= 2` (não unificam) | **true**  |

São **2 verdadeiras**. Cuidado com o comando: `=:=` calcula; `=` só unifica (por isso `f(a) = f(b)` é false, mas `1+1 =:= 2` é true).

### Q9 — Letra **Z** de Schönfinkel → **D (composição)**

$Z\varphi\chi x = \varphi(\chi x)$ — a **função de composição** (hoje chamada $B$, “bluebird”). A letra $Z$ do artigo cai quase sempre em prova; é a mesma coisa que o $B$ moderno.

### Q10 — Redução de `S(KS)Kabc` → **E (`a(bc)`)**

Lembre da igualdade famosa: $S(KS)K = B$ (bluebird), e $Bfgx = f(gx)$.

```text
S (KS) K  a  b  c
= B a b c            (pois S(KS)K = B)
= a (b c)            (regra do B: Bfgx = f(gx))
```

Para conferir sem decorar: $S(KS)Kabc = (KSa)(Ka)bc = (Sa)(Ka)bc$... mais simples aplicar $Sfgx=(fx)(gx)$ com $f=KS$? O caminho curto e seguro é **memorizar $B = S(KS)K$** (§8.2).

### Q11 — Traço de `p(81, K)` → **B (K = 4)**

```prolog
(1) p(1, 0).
(2) p(N, K) :- N > 1, 0 =:= N mod 3, M is N div 3, p(M, K1), K is K1 + 1.
```

O predicado **conta quantas divisões por 3** cabem até N chegar a 1 (o `+1` acontece na volta).

**Casamento das cláusulas, chamada por chamada:**

| Chamada | (1) `p(1, 0)` | (2) `p(N, K)` |
|---|---|---|
| `p(81, K)` | `1 = 81` ✗ | `N = 81` ✓ (usa esta) |
| `p(27, K1)` | `1 = 27` ✗ | `N = 27` ✓ |
| `p(9, K1')` | `1 = 9` ✗ | `N = 9` ✓ |
| `p(3, K1'')` | `1 = 3` ✗ | `N = 3` ✓ |
| `p(1, K1''')` | `1 = 1` **✓ → BASE** (`K1''' = 0`) | (nem tenta) |

**Passo 1 — chamada `p(81, K)`**

- (1) casa? `1` com `81` → não. (2) cabeça: **N = 81** (K livre).
- Corpo:

  | Linha do corpo | Substituindo | Resultado |
  |---|---|---|
  | `N > 1` | `81 > 1` | ✓ |
  | `0 =:= N mod 3` | `0 =:= 81 mod 3` → `0 =:= 0` | ✓ |
  | `M is N div 3` | `M is 81 div 3` | **M = 27** |
  | `p(M, K1)` | `p(27, K1)` | **nova chamada → Passo 2** |
  | `K is K1 + 1` | `K is K1 + 1` | **pendente** |

**Passo 2 — chamada `p(27, K1)`**

| Linha | Substituindo | Resultado |
|---|---|---|
| `N > 1` | `27 > 1` | ✓ |
| `0 =:= N mod 3` | `0 =:= 27 mod 3` → `0 =:= 0` | ✓ |
| `M is N div 3` | `M is 27 div 3` | **M = 9** |
| `p(M, K1')` | `p(9, K1')` | **nova chamada → Passo 3** |
| `K1 is K1' + 1` | — | **pendente** |

**Passo 3 — chamada `p(9, K1')`**

| Linha | Substituindo | Resultado |
|---|---|---|
| `9 > 1` | ✓ | |
| `0 =:= 9 mod 3` | `0 =:= 0` | ✓ |
| `M is 9 div 3` | — | **M = 3** |
| `p(3, K1'')` | — | **nova chamada → Passo 4** |
| `K1' is K1'' + 1` | — | **pendente** |

**Passo 4 — chamada `p(3, K1'')`**

| Linha | Substituindo | Resultado |
|---|---|---|
| `3 > 1` | ✓ | |
| `0 =:= 3 mod 3` | `0 =:= 0` | ✓ |
| `M is 3 div 3` | — | **M = 1** |
| `p(1, K1''')` | — | **nova chamada → Passo 5** |
| `K1'' is K1''' + 1` | — | **pendente** |

**Passo 5 — chamada `p(1, K1''')`**

- (1) `p(1, 0)` casa → **K1''' = 0**. Termina (sem corpo).

**Volta — as pendências `K is K1 + 1` acontecem de baixo para cima:**

| Ficha | Conta pendente | Substituindo | Resultado |
|---|---|---|---|
| Passo 4 | `K1'' is K1''' + 1` | `K1'' is 0 + 1` | **K1'' = 1** |
| Passo 3 | `K1' is K1'' + 1` | `K1' is 1 + 1` | **K1' = 2** |
| Passo 2 | `K1 is K1' + 1` | `K1 is 2 + 1` | **K1 = 3** |
| Passo 1 | `K is K1 + 1` | `K is 3 + 1` | **K = 4** ✓ |

São **4 divisões** (81 → 27 → 9 → 3 → 1). Verificado: `K = 4`.

### Q12 — Soluções de `soma(5)` → **C (2)**

```prolog
soma(N) :- between(1, N, A), between(A, N, B), A < B, N =:= A + B.
```

Aqui o "debug" é o do **backtracking**: cada `between` gera um valor e, quando uma linha
falha, o Prolog **volta** para tentar o próximo. Vamos tentar cada combinação, na ordem:

**A = 1** (1º `between`):

| B (2º between) | `A < B`? | `N =:= A + B` (5 =:= 1+B)? | Veredito |
|---|---|---|---|
| 1 | `1 < 1` ✗ | — | falha (A e B iguais) |
| 2 | ✓ | `5 =:= 3` ✗ | falha |
| 3 | ✓ | `5 =:= 4` ✗ | falha |
| **4** | ✓ | `5 =:= 5` **✓** | **SOLUÇÃO (A=1, B=4)** |
| 5 | ✓ | `5 =:= 6` ✗ | falha → o `between` esgota → volta para A |

**A = 2**:

| B | `A < B`? | `5 =:= 2+B`? | Veredito |
|---|---|---|---|
| 2 | ✗ | — | falha |
| **3** | ✓ | `5 =:= 5` **✓** | **SOLUÇÃO (A=2, B=3)** |
| 4 | ✓ | `5 =:= 6` ✗ | falha |
| 5 | ✓ | `5 =:= 7` ✗ | falha → esgota |

**A = 3**: B = 3 ✗; B = 4 → 7 ✗; B = 5 → 8 ✗ → esgota.
**A = 4**: B = 4 ✗; B = 5 → 9 ✗ → esgota.
**A = 5**: B = 5 ✗ → esgota → **false** (fim da busca).

São **2 soluções**: (1,4) e (2,3) ✓ (verificado no SWI). Note que o `A < B` é o que impede
contar a mesma soma duas vezes ((1,4) e (4,1) seriam a "mesma" dupla).

---

## Parte B

### Q13 — Linhas da tabela-verdade de $(p \land \lnot q) \lor (\lnot p \to (q \land r))$ → **008**

Conte as **variáveis simples distintas**: aparecem $p$, $q$ e $r$ (as repetições e subexpressões não contam) → $n = 3$ → $2^3 = \mathbf{8}$ linhas → CDU **008**.

### Q14 — Quantas **regras** no código? → **004**

```prolog
1  p(a).            fato
2  p(b).            fato
3  q(X) :- p(X).    REGRA  (1)
4  q(c).            fato
5  r(X) :- q(X).    REGRA  (2)
6  s(X) :- r(X).    REGRA  (3)
7  s(X) :- q(X).    REGRA  (4)
```

4 cláusulas têm `:-` → **4 regras** → CDU **004**. Não confunda com “cláusulas” (seriam 7) nem com “fatos” (3).

---

> **O que treinar deste simulado:** traços de recursão com acumulador na volta (Q7, Q11), conjunção + ports (Q5) e redução $B = S(KS)K$ (Q10).
