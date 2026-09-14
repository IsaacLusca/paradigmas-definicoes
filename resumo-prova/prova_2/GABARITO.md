# Gabarito — Prova 2 (704C60) — trecho relevante para a Prova 1

> Da Prova 2 antiga, interessam para a Prova 1 as questões de **Combinadores/Base SK**
> (Q1, Q2, Q3, Q13). Lambda (Q4, Q5, Q12) e Haskell (Q6–Q11, Q14–Q16) não caem.

## Respostas oficiais

### Parte A (múltipla escolha)

| Q | Resp. | Tema | Justificativa |
|---|---|---|---|
| Q1 | **D** | Combinadores | Schönfinkel usava **Z** para a função de **composição** |
| Q2 | **E** | Base SK | `SKSabc` = `(Ka(Sa))bc` = `abc` |
| Q3 | **D** | Definição | combinador = termo fechado, **`FV(M) = ∅`** |
| Q4 | A | Lambda | (não cai) conjunção = `λxy.xyx` |
| Q5 | B | Lambda | (não cai) 1 variável livre (`c`) em `λabde.abacabcdeee` |
| Q6 | C | Haskell | (não cai) `last [2..5]` = 5 |
| Q7 | C | Haskell | (não cai) `map (*2) [0,1,2,3]` = [0,2,4,6] |
| Q8 | C | Haskell | (não cai) |
| Q9 | B | Haskell | (não cai) `cost (A 3) = 5` |
| Q10 | D | Haskell | (não cai) `hTell` = 75+50 = 125 |

### Parte B

| Q | Resp. (CDU) | Tema | Justificativa |
|---|---|---|---|
| Q11 | **700** | Haskell | (não cai) `sum [138..142]` = 700 |
| Q12 | **049** | Lambda | (não cai) |
| Q13 | **370** | Base SK | redução em cadeia até a aplicação `3 7 0` → dígitos na ordem: **370** |
| Q14 | **042** | Haskell | (não cai) |

### Parte C (Haskell — não cai)

| Q | Predicado |
|---|---|
| Q15 | `f` — conta pares < 25 (`even_lt_25`) |
| Q16 | `second` — 2º elemento da lista (`second`) |

## Consolidação da Prova 1 (código 4BAE41) — gabarito oficial

`E,B,A,A,A,D,A,C,B,A,004,003,is_sum_of_5,power_of_5`
