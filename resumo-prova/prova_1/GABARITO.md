# Gabarito — Prova 1 (4BAE41)

Respostas oficiais + justificativa (detalhes no `estudo/RESUMO_PROVA_1.md`).

## Parte A

| Q | Resp. | Justificativa |
|---|---|---|
| Q1 | **E** | bicondicional = ↔ |
| Q2 | **B** | mundo fechado: `op(true,true)` é o único true → conjunção |
| Q3 | **A** | `X is 2 + 1*3` → `*` (400) antes de `+` (500) → 2+3 = 5 |
| Q4 | **A** | `:- op` define precedência, associatividade e posição |
| Q5 | **A** | `;` reentra no último predicado pela porta **redo** |
| Q6 | **D** | `alfa(a, 1, True)` → aridade **3** |
| Q7 | **A** | traço: `g(4,10)→g(3,5)→g(2,16)→g(1,8)→g(0,4)`, base → `X = 4` |
| Q8 | **C** | falsas: `2+2 = 4` e `f(_) = f(x,x)` (aridades diferentes) → **2** |
| Q9 | **B** | `\=` = "não unifica" |
| Q10 | **A** | `p([2,3,5],X)`: `p([5])→p([])=0`; `X = 0 + (3-2) = 1` |

## Parte B

| Q | Resp. (CDU) | Justificativa |
|---|---|---|
| Q11 | **004** | 2 proposições simples ($p$, $q$) → $2^2 = 4$ linhas |
| Q12 | **003** | 3 regras (as outras 7 cláusulas são fatos) |

## Parte C

| Q | Predicado | Solução de referência |
|---|---|---|
| Q13 | `is_sum_of_5/1` | gerar 5 inteiros positivos **distintos e crescentes** com `between/3` e testar `N =:= A+B+C+D+E` |
| Q14 | `power_of_5/1` | caso base `power_of_5(1).`; recursão divide por 5 (`N mod 5 =:= 0`, `M is N div 5`) |

Código completo: seção 9 do `estudo/RESUMO_PROVA_1.md`.
