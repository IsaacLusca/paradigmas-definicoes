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
| Q11 | **B** | Trace: $81 \to 27 \to 9 \to 3 \to 1$ — são **4** divisões por 3 até o caso base → `K = 4` (seções 6.1 e 9.3). |
| Q12 | **C** | Pares com $A < B$ e $A+B=5$: $(1,4)$ e $(2,3)$ → **2 soluções distintas** (seção 9.2). |

## Parte B

| Q | Resp. (CDU) | Explicação |
|---|---|---|
| Q13 | **008** | Proposições simples: $p, q, r$ → $2^3 = 8$ linhas (seção 1.2). |
| Q14 | **004** | Regras (cláusulas com `:-`): `q/1` (linha 3), `r/1` (5), `s/1` (6) e `s/1` (7) → **4**. Os fatos `p(a)`, `p(b)`, `q(c)` não contam (seções 2.1 e 10). |
