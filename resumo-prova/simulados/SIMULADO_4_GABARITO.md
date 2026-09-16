# Gabarito Comentado — Simulado 4 (SIM4)

> **Prova 1 aplicada (4BAE41)** + questões de **Combinadores** da antiga Prova 2 (704C60).
> Respostas oficiais da prova real: `E,B,A,A,A,D,A,C,B,A | 004 | 003 | is_sum_of_5 | power_of_5`.
> Estudar pelas seções indicadas do `estudo/RESUMO_PROVA_1.md`.

## Parte A (10 MC · 2 pts cada)

| Q | Resp. | Explicação |
|---|---|---|
| Q1 | **E** | A bicondicional é `↔` (verdadeira quando os valores são iguais) (seção 1.1). |
| Q2 | **B** | Mundo fechado: só `op(true,true)` é verdadeiro; `(V,F)`, `(F,V)` e `(F,F)` não estão declarados → false. Essa é a tabela da **conjunção** (seção 2.2). |
| Q3 | **A** | `*` (400) liga antes de `+` (500): `1*3 = 3` → `2 + 3 = 5` → `Y = 5` (seção 5.1). |
| Q4 | **A** | A diretiva `:- op` define precedência, associatividade e posição (`current_op/3` só consulta) (seção 5.2). |
| Q5 | **A** | O `;` no listener força **redo** no **último** predicado (Q3), desatando apenas as variáveis locais (seção 4.2). |
| Q6 | **D** | `alfa(a, 1, True)` tem 3 argumentos → **aridade 3** (`alfa/3`) (seção 2.1). |
| Q7 | **A** | Traço: `g(4,10) → g(3,5) → g(2,16) → g(1,8) → g(0,4)`; na base `g(0,X,X)`, o 2º argumento já é `X = 4` (seção 6.2). |
| Q8 | **C** | Falsas: `2+2 = 4` (o `=` não avalia) e `f(_) = f(x, x)` (aridades 1 vs 2). `X = Y` é true (variáveis sempre unificam) e a 4ª é true (`b \= c`) → **2 falsas** (seções 3.2 e 3.3). |
| Q9 | **B** | `\=` = “não unifica”. `\+` nega um objetivo; `=:=`/`=\=` comparam valores (seção 3.2). |
| Q10 | **A** | `p([2,3,5],X)`: a 1ª cláusula manda `p([5],X)` para `p([],X)` → `X = 0`; na volta, `X = 0 + (3-2) = 1` (seção 7.3). |

## Parte B (2 abertas · 2 pts cada)

| Q | Resp. (CDU) | Explicação |
|---|---|---|
| Q11 | **004** | Só há duas proposições simples distintas (`p` e `q`) — as repetições e subexpressões não contam → `2² = 4` linhas (seção 1.2). |
| Q12 | **003** | Regras (cláusulas com `:-`): `f/2` (linha 10), `f/2` (linha 11) e `g/1` (linha 12) → **3**. As outras 7 cláusulas são fatos (seções 2.1 e 10). |

## Parte C (6 questões · 1 pt cada) — Combinadores e análise

| Q | Resp. | Explicação |
|---|---|---|
| Q13 | **D** | Schönfinkel usou **Z** para a **função de composição** (`Zφχx = φ(χx)`), hoje chamada `B` (seção 8.1). |
| Q14 | **E** | `SKSabc = ((SKS)a)bc = (Ka(Sa))bc = abc` → **E** (seção 8.2). |
| Q15 | **D** | Combinador = termo **fechado**: `FV(M) = ∅` (sem variáveis livres) (seção 8.1). |
| Q16 | **C** | `is_sum_of_5(5)` → **false** (o guard `N >= 15` falha); `is_sum_of_5(15)` → **true** (`1+2+3+4+5`); `is_sum_of_5(30)` → **true** (ex.: `1+2+3+4+20`) → **2 true** (seção 9.2). |
| Q17 | **B** | `power_of_5(1)` → **true** (base, `5⁰`); `power_of_5(25)` → **true** (`25→5→1`); `power_of_5(100)` → **false** (`100→20→4`, e `4 mod 5 ≠ 0`) (seção 9.3). |
| Q18 | **370** | `S(US)(KK)3 = (US 3)(KK 3)`; `US 3 = B(S3)`; `KK 3 = K`; `B(S3)K0 = (S3)(K0)`; `(S3)(K0)7 = (3 7)0` → dígitos **3, 7, 0** (seção 8.5). |

---

**Observação didática:** as questões de **escrita de código** da prova real (`is_sum_of_5` e
`power_of_5`) aparecem aqui como **análise** (Q16 e Q17) — na sua prova não haverá escrita de
código. As implementações completas estão na seção 9 do `estudo/RESUMO_PROVA_1.md`.
