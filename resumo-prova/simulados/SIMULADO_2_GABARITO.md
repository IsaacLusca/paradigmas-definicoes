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
| Q11 | **C** | O predicado conta **pares**: 2, 4 e 6 → `X = 3` (seção 9.4). |
| Q12 | **C** | Trace: $64 \to 32 \to 16 \to 8 \to 4 \to 2 \to 1$ — **6** divisões por 2 → `K = 6` (seções 6.1 e 9.3). |

## Parte B

| Q | Resp. (CDU) | Explicação |
|---|---|---|
| Q13 | **004** | Proposições simples: $p, q$ → $2^2 = 4$ linhas (seção 1.2). |
| Q14 | **003** | Regras: `c/1` (linha 3), `d/1` (4) e `e/1` (5) → **3**. Os fatos `a(1)`, `b(2)` não contam (seções 2.1 e 10). |
