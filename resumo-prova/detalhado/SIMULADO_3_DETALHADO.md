# Simulado 3 — Explicação detalhada (debug das questões)

> Tente resolver primeiro; aqui está o raciocínio completo de cada questão.
> Códigos verificados no SWI-Prolog. Referências: `estudo/RESUMO_PROVA_1.md` (§).

**Gabarito:** A: `B, A, C, B, A, E, D, C, B, B, C, C` · B: **008**, **034**.

---

## Parte A

### Q1 — Falso só quando ambas são verdadeiras → **B (NAND)**

NAND ($\uparrow$, `p ↑ q ≡ ¬(p ∧ q)`) só dá falso com V,V. A **NOR** ($\downarrow$) é o oposto: só dá verdadeiro com F,F (e por isso "é falsa quando ao menos uma é verdadeira"). Fixe a diferença — a prova troca as duas de propósito.

### Q2 — Qual igualdade está correta → **A (`I = SKK`)**

| Fórmula | Correta? |
|---|---|
| **`I = SKK`** | ✔ |
| `I = KK` | ✘ |
| `B = SII` | ✘ (o certo é `M = SII`) |
| `M = SKK` | ✘ (o certo é `I = SKK`) |
| `C = KK` | ✘ (o certo é `C = S(BBS)(KK)`) |

Decore: $I = SKK$ · $M = SII$ · $B = S(KS)K$ · $C = S(BBS)(KK)$.

### Q3 — Qual consulta é verdadeira para `car(honda, red, 4).` → **C**

Debug de cada alternativa:

| Consulta | Unifica? | Por quê |
|---|---|---|
| (A) `car(honda, color(red), 4)` | ✘ | `color(red)` ≠ `red` |
| (B) `car(honda, red, doors(4))` | ✘ | `doors(4)` ≠ `4` |
| **(C) `car(honda, red, 4)`** | ✔ | idêntico ao fato |
| (D) `car(red, honda, 4)` | ✘ | ordem dos argumentos importa |
| (E) `car(honda, red, 4, extra)` | ✘ | aridade diferente (`car/4` ≠ `car/3`) |

### Q4 — Adiciona ao **final** da base → **B (`assertz/1`)**

- `assertz(fato)` → fim da base (responde **por último**)
- `asserta(fato)` → início (responde **primeiro**)
- `retract/1` remove; `consult/1` carrega arquivo; `dynamic/1` libera a modificação

### Q5 — `include(is_odd, [1,2,3,4], L)` → **A (`L = [1, 3]`)**

`include(Objetivo, Lista, Filtrada)` **mantém** quem satisfaz o objetivo. Com `is_odd(X) :- 1 =:= X mod 2.`:

| Elemento | `1 =:= X mod 2`? | Fica? |
|---|---|---|
| 1 | 1 = 1 → sim | ✔ |
| 2 | 1 = 0 → não | ✘ |
| 3 | 1 = 1 → sim | ✔ |
| 4 | 1 = 0 → não | ✘ |

→ `L = [1, 3]`. (`exclude/3` faria o contrário.)

### Q6 — `X is 2 ^ 3 ^ 2` → **E (X = 512)**

`^` é **xfy** (associa à **direita**, §5.1): resolve primeiro o expoente da direita.

```text
2 ^ 3 ^ 2  =  2 ^ (3 ^ 2)  =  2 ^ 9  =  512
```

Se fosse associativo à esquerda daria $(2^3)^2 = 64$ (alternativa B — a armadilha).

### Q7 — Traço de `acc([1,2,3,4], 0, X)` → **D (X = 10)**

> *Mesmo método de debug por fichas/substituição do Sim1 Q7.*

```prolog
(1) acc([], Acc, Acc).
(2) acc([H|T], A, X) :- NewA is A + H, acc(T, NewA, X).
```

**Passo 1 — chamada `acc([1,2,3,4], 0, X)`**

- Cláusula (1): `acc([], Acc, Acc)` casa? 1º argumento `[]` com `[1,2,3,4]` → **não** (a lista não
  é vazia). Tenta a (2).
- Cabeça: `acc([H|T], A, X)` com `acc([1,2,3,4], 0, X)` → **H = 1**, **T = [2,3,4]**, **A = 0**.
- Corpo (linha por linha):

  | Linha do corpo | Substituindo | Resultado |
  |---|---|---|
  | `NewA is A + H` | `NewA is 0 + 1` | **NewA = 1** |
  | `acc(T, NewA, X)` | `acc([2,3,4], 1, X)` | **nova chamada → Passo 2** |

**Passo 2 — chamada `acc([2,3,4], 1, X)`** → H = 2, T = [3,4], A = 1

| Linha | Substituindo | Resultado |
|---|---|---|
| `NewA is A + H` | `NewA is 1 + 2` | **NewA = 3** |
| `acc(T, NewA, X)` | `acc([3,4], 3, X)` | **nova chamada → Passo 3** |

**Passo 3 — chamada `acc([3,4], 3, X)`** → H = 3, T = [4], A = 3

| Linha | Substituindo | Resultado |
|---|---|---|
| `NewA is A + H` | `NewA is 3 + 3` | **NewA = 6** |
| `acc(T, NewA, X)` | `acc([4], 6, X)` | **nova chamada → Passo 4** |

**Passo 4 — chamada `acc([4], 6, X)`** → H = 4, T = [], A = 6

| Linha | Substituindo | Resultado |
|---|---|---|
| `NewA is A + H` | `NewA is 6 + 4` | **NewA = 10** |
| `acc(T, NewA, X)` | `acc([], 10, X)` | **nova chamada → Passo 5** |

**Passo 5 — chamada `acc([], 10, X)`**

- Cláusula (1): `acc([], Acc, Acc)` casa → **Acc = 10** e o 3º argumento é o mesmo `Acc` →
  **X = 10**. Termina aqui.

**Volta:** nenhuma conta a fazer — a soma inteira já foi feita **na descida** (o acumulador
carregou o total de passo em passo). É por isso que esse padrão **não cresce a pilha**
(recursão de cauda). Verificado no SWI: `?- acc([1,2,3,4], 0, X).` → `X = 10` ✓.

### Q8 — Quantas retornam **verdadeiro**? → **C (2)**

```prolog
?- [H|T] = [1,2,3], H = 1.        → true   (H=1, T=[2,3])
?- X = f(Y), Y = 2, X = f(2).     → true   (Y=2; X=f(2); casa consigo mesmo)
?- [A, B | C] = [1], A = 1.       → false  ([A,B|C] exige ≥ 2 elementos; a lista tem 1)
?- X \= X.                        → false  (X unifica com X — sempre)
```

**2 verdadeiras.**

### Q9 — `findall(X, member(X, [a,b,a]), L)` → **B (`[a, b, a]`)**

`findall/3` **coleta todas** as soluções, **mantendo duplicatas e a ordem**:

| Solução | X |
|---|---|
| 1ª | a |
| 2ª | b |
| 3ª | a |

→ `L = [a, b, a]` ✓. Se quisesse sem repetição, seria `setof/3` (ordenado e sem duplicatas).

### Q10 — Qual redução **não termina** → **B (`SII(SII)`)**

$SII = M$ (tordo-imitador) e $Mx = xx$ → $M(M) = MM$ **se reproduz para sempre** (análogo do paradoxo da autorreferência).

As outras terminam: `SKK` = $I$; `KS(SII(SII))` = $S$ (o $K$ **descarta** o 2º argumento **sem avaliá-lo** — avaliação preguiçosa); `K a b = a`; `S K K a = a`.

### Q11 — Traço de `maior([4,9,2,9], X)` → **C (X = 9)**

```prolog
(1) maior([X], X).
(2) maior([H|T], X) :- maior(T, Y), (H > Y -> X = H ; X = Y).
```

**Passo 1 — chamada `maior([4,9,2,9], X)`**

- (1) `maior([X], X)` casa? A lista `[4,9,2,9]` **não** tem 1 elemento (tem 4) → não.
- (2) cabeça: **H = 4**, **T = [9,2,9]**.
- Corpo:

  | Linha do corpo | Substituindo | Resultado |
  |---|---|---|
  | `maior(T, Y)` | `maior([9,2,9], Y)` | **nova chamada → Passo 2** |
  | `H > Y` | `4 > Y` | **pendente** (espera o Passo 2) |
  | `X = H` ou `X = Y` | — | **pendente** |

**Passo 2 — `maior([9,2,9], Y)`** → H = 9, T = [2,9]

| Linha | Substituindo | Resultado |
|---|---|---|
| `maior(T, Y1)` | `maior([2,9], Y1)` | **nova chamada → Passo 3** |
| `H > Y1` | `9 > Y1` | **pendente** |

**Passo 3 — `maior([2,9], Y1)`** → H = 2, T = [9]

| Linha | Substituindo | Resultado |
|---|---|---|
| `maior(T, Y2)` | `maior([9], Y2)` | **nova chamada → Passo 4** |
| `H > Y2` | `2 > Y2` | **pendente** |

**Passo 4 — chamada `maior([9], Y2)`**

- (1) `maior([X], X)` casa → **Y2 = 9**. Termina.

**Volta — cada ficha compara o seu H com o maior do resto:**

| Ficha | H | Teste `H > Y` | Resultado |
|---|---|---|---|
| Passo 3 | 2 | `2 > 9` → **falso** | `Y1 = Y2 = 9` (mantém o maior do resto) |
| Passo 2 | 9 | `9 > 9` → **falso** | `Y = Y1 = 9` (empate: fica o do resto) |
| Passo 1 | 4 | `4 > 9` → **falso** | `X = Y = 9` |

**X = 9** ✓ (verificado). Observe que o "maior" descoberto na base **sobe** por todos os
níveis — cada um só troca se o seu H for estritamente maior.

### Q12 — Traço de `nd(12, X)` → **C (X = 6)**

```prolog
(0) nd(N, X) :- nd_(N, 1, 0, X).
(1) nd_(N, D, A, X) :- D =< N, (0 =:= N mod D -> B is A + 1 ; B = A),
                       D1 is D + 1, nd_(N, D1, B, X).
(2) nd_(N, D, A, A) :- D > N.
```

**Passo 0 — `nd(12, X)`** → cláusula (0): **N = 12** → chama `nd_(12, 1, 0, X)`.

**Passo 1 — `nd_(12, 1, 0, X)`**

- (2) casa? `D > N` → `1 > 12` → não. Tenta (1): **D = 1**, **A = 0**.
- Corpo:

  | Linha do corpo | Substituindo | Resultado |
  |---|---|---|
  | `D =< N` | `1 =< 12` | ✓ |
  | `0 =:= N mod D` | `0 =:= 12 mod 1` → `0 =:= 0` | **verdadeiro** → `then` |
  | `B is A + 1` | `B is 0 + 1` | **B = 1** |
  | `D1 is D + 1` | `D1 is 1 + 1` | **D1 = 2** |
  | `nd_(N, D1, B, X)` | `nd_(12, 2, 1, X)` | **nova chamada → Passo 2** |

**Passo 2 — `nd_(12, 2, 1, X)`**

| Linha | Substituindo | Resultado |
|---|---|---|
| `D =< N` | `2 =< 12` | ✓ |
| `0 =:= N mod D` | `0 =:= 12 mod 2` → `0 =:= 0` | **verdadeiro** → `then` |
| `B is A + 1` | `B is 1 + 1` | **B = 2** |
| `D1 is D + 1` | `D1 is 2 + 1` | **D1 = 3** |
| `nd_(12, 3, 2, X)` | — | **nova chamada → Passo 3** |

**Passos 3 a 13** (mesmo padrão; repare que quando `12 mod D ≠ 0`, o contador **não** sobe):

| D | `12 mod D` | `0 =:= ...`? | B (contador) | Próxima chamada |
|---|---|---|---|---|
| 3 | 0 | ✓ | **3** | `nd_(12, 4, 3, X)` |
| 4 | 0 | ✓ | **4** | `nd_(12, 5, 4, X)` |
| 5 | 2 | ✗ | **4** (não mudou) | `nd_(12, 6, 4, X)` |
| 6 | 0 | ✓ | **5** | `nd_(12, 7, 5, X)` |
| 7 | 5 | ✗ | 5 | `nd_(12, 8, 5, X)` |
| 8 | 4 | ✗ | 5 | `nd_(12, 9, 5, X)` |
| 9 | 3 | ✗ | 5 | `nd_(12, 10, 5, X)` |
| 10 | 2 | ✗ | 5 | `nd_(12, 11, 5, X)` |
| 11 | 1 | ✗ | 5 | `nd_(12, 12, 5, X)` |
| 12 | 0 | ✓ | **6** | `nd_(12, 13, 6, X)` |

**Passo 14 — `nd_(12, 13, 6, X)`**

- (1) `D =< N` → `13 =< 12` → **falha**.
- (2) `nd_(N, D, A, A) :- D > N` → `13 > 12` → ✓ **base**: os 3º e 4º argumentos são o mesmo
  `A` → **X = 6**. Termina.

**Volta:** nada a calcular — o contador já subiu na descida; o valor sobe pronto. Divisores de 12:
1, 2, 3, 4, 6, 12 → **X = 6** ✓ (verificado).

> **Importante (bug corrigido no material):** a cláusula base precisa ser
> `nd_(N, D, A, A) :- D > N.` — com `N` **na cabeça**. Se fosse `nd_(_, D, A, A) :- D > N.`,
> o `N` do corpo ficaria livre e o SWI daria `instantiation_error` ao chegar em D = 13.
> Verificado: com a cabeça correta, `?- nd(12, X).` → `X = 6`; com `_`, o SWI acusa erro.

---

## Parte B

### Q13 — Quantas **cláusulas** (fatos + regras) → **008**

```prolog
1  filme('Matrix', 1999).                fato
2  filme('Interestelar', 2014).          fato
3  filme('Duna', 2021).                  fato
4  diretor('Matrix', 'Wachowski').       fato
5  diretor('Interestelar', 'Nolan').     fato
6  classico(X) :- filme(X, A), A < 2000.     regra
7  recente(X) :- filme(X, A), A >= 2020.     regra
8  indicado(X, Y) :- filme(X, _), diretor(X, Y).  regra
```

5 fatos + 3 regras = **8 cláusulas** → CDU **008**. (O `_` e as vírgulas do corpo não criam cláusulas.)

### Q14 — Redução de `SKS34` → **034**

```text
S K S 3 4
= ((S K S) 3) 4          (aplicação associa à esquerda)
= (K 3 (S 3)) 4          (regra do S: Sfgx = (fx)(gx), com f=K e g=S, x=3)
= 3 4                    (Kxy = x: K descarta o (S 3))
```

Os dígitos remanescentes são **3** e **4**, na ordem → CDU **034** ✓.

---

> **O que treinar deste simulado:** associatividade de `^` (Q6), acumulador na descida (Q7), a diferença `findall` × `setof` (Q9), lazy evaluation (Q10) e o padrão contador com `D =< N` / `D > N` (Q12 — com a cabeça correta!).
