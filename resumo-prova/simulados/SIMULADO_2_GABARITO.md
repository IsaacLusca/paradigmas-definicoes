# Gabarito Comentado — Simulado 2 (SIM2)

## Parte A

| Q | Resp. | Explicação (onde estudar no `RESUMO_PROVA_1.md`) |
|---|---|---|
| Q1 | **D** | **Disjunção exclusiva** (XOR): verdadeira só se os valores **diferem** (seção 1.1). |
| Q2 | **B** | Base fechada: `ou(true,false)` e `ou(false,true)` verdadeiros; `(false,false)` não declarado → false. Verdadeiro quando **ao menos um** é verdadeiro → **disjunção** (seções 1.1 e 2.2). |
| Q3 | **D** | `^` tem precedência 200 (liga mais forte que `+`, 500): $2^3 = 8$; $8 + 1 = 9$ (seção 5.1). |
| Q4 | **C** | `:- arithmetic_function` (com `:- use_module(library(arithmetic))`) — último argumento é o "retorno" (seção 5.4). |
| Q5 | **C** | Em `(A -> B ; C)`, se `A` for falso, segue para `C` (seção 4.4). |
| Q6 | **C** | (1) `cidade(df)` → **true**; (2) `cidade(sp)` → false (não declarado); (3) `cidade(X)` → **true** (`X = df`); (4) `cidade(X), cidade(Y), X \= Y` → $X=Y=df$, `df \= df` falha → false. Total: **2** (seções 2.2 e 3.2). |
| Q7 | **C** | `mdc(48,18)` → $R=48 \bmod 18=12$ → `mdc(18,12)` → $R=6$ → `mdc(12,6)` → $R=0$ → `mdc(6,0)` → base: **X = 6** (seção 6.1). |
| Q8 | **C** | (1) `f(X,X) = f(a,b)` → exige $X=a$ **e** $X=b$ → false; (2) `5 =:= 5` → **true**; (3) `g(a)=g(A)` → $A=a$; `a \= b` → **true**; (4) `2+3 = 5` → `=` não avalia → false. Total: **2** (seções 3.2 e 3.3). |
| Q9 | **C** | Combinador = termo **fechado**, sem variáveis livres ($FV(M)=\emptyset$) (seção 8.1). |
| Q10 | **B** | $Ma = aa = Ia(Ia) = SIIa$ → $M = SII$ (seção 8.2). |

## Parte B

| Q | Resp. (CDU) | Explicação |
|---|---|---|
| Q11 | **004** | Proposições simples: $p, q$ → $2^2 = 4$ linhas (seção 1.2). |
| Q12 | **003** | Regras: `c/1` (linha 3), `d/1` (4) e `e/1` (5) → **3**. Os fatos `a(1)`, `b(2)` não contam (seções 2.1 e 10). |

## Parte C

### Q13 — `count_odds/2`

```prolog
count_odds([], 0).
count_odds([H|T], X) :-
    count_odds(T, Y),
    (1 =:= H mod 2 -> X is Y + 1 ; X = Y).
```

- `count_odds([1,2,3,4], X)` → conta 1 e 3 → **X = 2** ✓
- `count_odds([2,4,6], X)` → **X = 0** ✓
- `count_odds([], X)` → base → **X = 0** ✓

**Alternativa com meta-predicados** (aceita se a implementação estiver correta):
```prolog
is_odd(X) :- 1 =:= X mod 2.

count_odds(L, N) :-
    include(is_odd, L, Odds),
    length(Odds, N).
```
(seções 7.2 e 9.4)

### Q14 — `power_of_2/1`

```prolog
power_of_2(1).                   % caso base: 2^0 = 1
power_of_2(N) :-
    N > 1,
    0 =:= N mod 2,               % divisível por 2
    M is N div 2,
    power_of_2(M).               % recursão
```

- `power_of_2(1)` → base → **true** ✓
- `power_of_2(64)` → 64 → 32 → 16 → 8 → 4 → 2 → 1 → **true** ✓
- `power_of_2(100)` → 100 → 50 → 25 → 25 é ímpar → **false** ✓

> Mesmo padrão da Q14 da Prova 1 (`power_of_5`) / Simulado 1 (`power_of_3`), trocando a base
> (seção 9.3).
