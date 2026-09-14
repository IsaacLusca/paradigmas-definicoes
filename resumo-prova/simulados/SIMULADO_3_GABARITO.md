# Gabarito Comentado — Simulado 3 (SIM3)

## Parte A

| Q | Resp. | Explicação (onde estudar no `RESUMO_PROVA_1.md`) |
|---|---|---|
| Q1 | **B** | **NAND** (negação disjunta, $\uparrow$) é falsa **só** quando ambas são verdadeiras ($p \uparrow q \equiv \overline{p \land q}$). A NOR ($\downarrow$) é o oposto (seção 8.3). |
| Q2 | **A** | $I = SKK$ (seção 8.2). $M = SII$; $B = S(KS)K$; $C = S(BBS)(KK)$. |
| Q3 | **C** | A estrutura aninhada **não** unifica com a simples: `color(red)` ≠ `red` e `doors(4)` ≠ `4`; ordem dos argumentos importa (A, B e D falham; E tem aridade diferente) (seção 6.3). |
| Q4 | **B** | `assertz/1` insere no **fim**; `asserta/1` no início; `retract/1` remove (seção 2.5). |
| Q5 | **A** | `include/3` mantém os elementos para os quais o objetivo é verdadeiro → ímpares [1, 3] (seção 7.2). |
| Q6 | **E** | `^` é **xfy** (associa à direita): $2^{(3^2)} = 2^9 = 512$ (seção 5.1). |
| Q7 | **D** | Acumulador soma os elementos: $0+1+2+3+4 = 10$ (seções 6.1 e 7.3). |
| Q8 | **C** | (1) `[H\|T] = [1,2,3], H = 1` → **true**; (2) `X = f(Y), Y = 2, X = f(2)` → **true**; (3) `[A,B\|C] = [1]` → false (lista curta: `[A,B\|C]` exige ≥ 2 elementos); (4) `X \= X` → false (X unifica consigo mesma). → **2 verdadeiras** (seções 7.1 e 3.2/3.3). |
| Q9 | **B** | `findall/3` **mantém duplicatas e ordem** → `[a, b, a]` (seção 7.2). |
| Q10 | **B** | $SII = M$ (tordo-imitador); $M(M) = MM$ se reproduz indefinidamente. Já $KS(SII(SII)) = S$ porque $K$ descarta o 2º argumento sem avaliá-lo (*lazy evaluation*) (seção 8.2). |
| Q11 | **C** | O maior de `[9, 2, 9]` é 9; `4 > 9`? não → `X = 9` (seção 9.4). |
| Q12 | **C** | Divisores de 12: 1, 2, 3, 4, 6, 12 → **6** (seção 9.4). |

## Parte B

| Q | Resp. (CDU) | Explicação |
|---|---|---|
| Q13 | **008** | Cláusulas = fatos + regras: 5 fatos (linhas 1–5) + 3 regras (linhas 6–8) = **8** (seção 10). |
| Q14 | **034** | $SKS34 = ((SKS)3)4$; $SKS\,3 = (K3)(S3) = 3$ (pois $K$ devolve o 1º); logo $3\,4$ → dígitos **3, 4** → **034** (seção 8.2). |
