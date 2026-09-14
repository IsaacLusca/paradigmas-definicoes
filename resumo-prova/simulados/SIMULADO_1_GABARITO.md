# Gabarito Comentado — Simulado 1 (SIM1)

## Parte A

| Q | Resp. | Explicação (onde estudar no `RESUMO_PROVA_1.md`) |
|---|---|---|
| Q1 | **B** | A **disjunção** ($\lor$) é falsa **só** quando ambas são falsas (seção 1.1). |
| Q2 | **D** | Base fechada: só `xor(true,false)` e `xor(false,true)` são verdadeiros; `(true,true)` e `(false,false)` não estão declarados → false. Verdadeiro **só** quando os valores **diferem** → **disjunção exclusiva** (seções 1.1 e 2.2). |
| Q3 | **A** | Parênteses primeiro: $(2+3) = 5$; $5 \times 2 = 10$; $10 - 1 = 9$ (seção 5.1). |
| Q4 | **B** | `current_op/3` consulta operador definido; `op/3` **declara** (seção 5.2). |
| Q5 | **C** | O `;` força `redo` no **último** predicado (Q3), desatando apenas as variáveis locais (seção 4.2). |
| Q6 | **C** | `s(2, b, c)` → **s/3**; a única regra é `t(X) :- ...` (os demais são fatos) (seções 2.1 e 10). |
| Q7 | **D** | Trace: `h(0,0)`; `h(1): X=0+1=1`; `h(2): X=1+2=3`; `h(3): X=3+3=6`; `h(4): X=6+4=10` → **10** (seção 6.1). |
| Q8 | **C** | (1) `1+1 =:= 2` → **true**; (2) `3 =:= 4` → false; (3) `f(a) = f(b)` → false (átomos distintos); (4) `X=1, Y=2, X \= Y` → **true** (`1 \= 2`). Falsas: 2 → 2 verdadeiras → **C** (seções 3.2 e 3.3). |
| Q9 | **D** | Schönfinkel usou **Z** para a **função de composição** ($Z\varphi\chi x = \varphi(\chi x)$), hoje $B$ (seção 8.1). |
| Q10 | **E** | $S(KS)K = B$ e $Bfgx = f(gx)$ → $B\,a\,b\,c = a(bc)$ (seção 8.2). |

## Parte B

| Q | Resp. (CDU) | Explicação |
|---|---|---|
| Q11 | **008** | Proposições simples: $p, q, r$ → $2^3 = 8$ linhas (seção 1.2). |
| Q12 | **004** | Regras (cláusulas com `:-`): `q/1` (linha 3), `r/1` (5), `s/1` (6) e `s/1` (7) → **4**. Os fatos `p(a)`, `p(b)`, `q(c)` não contam (seções 2.1 e 10). |

## Parte C

### Q13 — `is_sum_of_4/1`

```prolog
is_sum_of_4(N) :-
    N >= 10,                    % menor soma possível: 1+2+3+4
    between(1, N, A),
    between(A, N, B), A < B,    % distintos e crescentes (evita permutações)
    between(B, N, C), B < C,
    between(C, N, D), C < D,
    N =:= A + B + C + D.
```

- `is_sum_of_4(9)` → falha em `N >= 10` → **false** ✓
- `is_sum_of_4(10)` → 1+2+3+4 = 10 → **true** ✓
- `is_sum_of_4(100)` → 1+2+3+94 = 100 → **true** ✓

> Mesmo padrão da Q13 da Prova 1 (`is_sum_of_5`), só mudam a quantidade de parcelas e o mínimo
> (seção 9.2). Alternativa sem `between`: gerar com `numlist(1, N, L)` e combinar.

### Q14 — `power_of_3/1`

```prolog
power_of_3(1).                   % caso base: 3^0 = 1
power_of_3(N) :-
    N > 1,
    0 =:= N mod 3,               % divisível por 3
    M is N div 3,
    power_of_3(M).               % recursão
```

- `power_of_3(1)` → base → **true** ✓
- `power_of_3(81)` → 81 → 27 → 9 → 3 → 1 → **true** ✓
- `power_of_3(100)` → 100 não é divisível por 3 → **false** ✓

> Mesmo padrão da Q14 da Prova 1 (`power_of_5`), trocando a base (seção 9.3).
