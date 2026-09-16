# Lista — Programação Lógica · Explicação detalhada

> Respostas comentadas e **debug** de cada questão da lista (partes A–D).
> Códigos verificados no SWI-Prolog. Referências: `estudo/RESUMO_PROVA_1.md` (§).

---

## Parte A — Lógica Proposicional Booleana

### 1. "Ao mesmo tempo verdadeira e falsa" viola qual princípio?

**Resposta: falsa como está — viola a NÃO-CONTRADIÇÃO.**

- **Não-contradição:** uma proposição **não pode** ser V **e** F ao mesmo tempo.
- **Terceiro excluído:** não existe terceira possibilidade (nem V nem F) — "ou é V, ou é F".

A frase "ao mesmo tempo V **e** F" é literalmente o enunciado da não-contradição; o terceiro excluído trata de *outro* caso ("nem V nem F"). A banca troca os dois de propósito.

### 2. "Se fizer bom tempo amanhã eu vou" — única situação impossível

**Resposta: "Fez bom tempo e ele não foi".**

A frase é a condicional $p \to q$ ($p$ = fez bom tempo, $q$ = ele foi), assumida **verdadeira**. Complete a tabela:

| p (bom tempo) | q (ele foi) | $p \to q$ | Situação |
|---|---|---|---|
| V | V | V | possível |
| **V** | **F** | **F** | **IMPOSSÍVEL** (única que falsifica) |
| F | V | V | possível ("vacuamente verdadeira") |
| F | F | V | possível |

Só o caso **V → F** quebra a promessa.

### 3. Menor natural que torna "$x/2 > \pi$" verdadeira

**Resposta: x = 7.**

```text
x/2 > π   ⇔   x > 2π   ⇔   x > 2 × 3,14159... = 6,283...
```

O menor natural maior que 6,283 é **7** (6 não serve, é menor que o limite).

---

## Parte B — Fundamentos da programação lógica

### 4. Código `time/3`, `campeao/1`, `selecionado/1`

```prolog
time('5am, wood again', 2, 'mg').
time('Amigos do Mortandela', 3, 'mg').
time('C++ ou uma linguagem misteriosa?', 2, 'go').
time('Lone Wolves', 2, 'df').
time('Monkeys', 1, 'go').
time('Teorema de Offson', 1, 'df').
time('Teorema do Chinês Viajante', 3, 'df').
time('Torcida Pão de Alho', 1, 'mg').

campeao(X) :- time(X, 1, _).

selecionado(X) :- campeao(X).
selecionado(X) :- time(X, _, 'mg').
```

**(a) Predicados:** `time/3` (8 fatos), `campeao/1` (1 regra), `selecionado/1` (2 regras).

**(b) Contagem: 8 fatos + 3 regras = 11 cláusulas.**

**(c) A saída lista um time duplicado.** Debug: quem é "selecionado" pelas duas cláusulas?

| Cláusula | Times |
|---|---|
| `campeao(X)` (posição 1) | Monkeys (go), Teorema de Offson (df), **Torcida Pão de Alho (mg)** |
| `time(X, _, 'mg')` | 5am wood again, Amigos do Mortandela, **Torcida Pão de Alho** |

A **Torcida Pão de Alho** é campeã **e** de mg → sai duas vezes. Saída crua (verificada):

```text
?- selecionado(X), write(X), nl, fail.
Monkeys
Teorema de Offson
Torcida Pão de Alho
5am, wood again
Amigos do Mortandela
Torcida Pão de Alho      ← repetido
```

**Correção** (evita a repetição com um guard `\+`):

```prolog
selecionado(X) :- campeao(X).
selecionado(X) :- time(X, _, 'mg'), \+ campeao(X).
```

Saída corrigida (verificada): `Monkeys, Teorema de Offson, Torcida Pão de Alho, 5am..., Amigos...` — cada um **uma vez** (campeões primeiro; depois os de mg não-campeões).

### 5. Consultas sobre `p/2`, `p/1` e `g/2` (com `g/1`)

```prolog
p(a, b).
p(a, c).
p(b).

g(a).
g(b).
g(a, b).
```

| Consulta | Resultado | Debug |
|---|---|---|
| (a) `?- p(b, a).` | **false** | o fato é `p(a, b)` — a **ordem** dos argumentos importa |
| (b) `?- p(a, b).` | **true** | casa direto com o fato |
| (c) `?- g(X).` | **X = a ; X = b** | só valem os fatos `g/1`; `g(a, b)` tem **aridade 2** e não casa com `g(X)` |
| (d) `?- p(a, Y).` | **Y = b ; Y = c** | as duas cláusulas com `p(a, _)` |

Pegadinha do (c): parece que `a` aparece duas vezes (em `g(a)` e em `g(a,b)`), mas `g(a,b)` não responde a `g(X)` — **aridade diferente**.

### 6. Consulta composta, variáveis e o ponto-e-vírgula

**Quando a saída mostra variáveis e valores?** Quando a consulta termina com **exit** e ainda tem variáveis **livres** (não atadas) que o interpretador pode exibir: `?- g(X).` → `X = a`.

**Quando posso digitar `;` e o que significa?** Depois de um sucesso, se ainda houver **pontos de escolha** (outra cláusula/solução para tentar). O `;` = **redo**: o fluxo volta à última marcação e tenta a próxima alternativa, desatando as variáveis locais. Exemplo:

```text
?- g(X).
X = a          ← exit
;              ← usuário pede redo
X = b          ← exit (próxima cláusula)
;              ← redo
false.         ← fail: acabaram as alternativas
```

As portas, em uma frase cada: **call** começa a tentar; **exit** unificou (sucesso); **fail** não há (mais) cláusula; **redo** retoma a busca desfazendo a última atação.

### 7. Regras dos estudantes (`tem_calouros/1`, `turma_mista/1`, `software/0`)

**(a) Disciplinas com calouros (semestre 1):**

```prolog
tem_calouros(D) :- matricula(D, E), estudante(E, 1, _).
```

Debug — quem é calouro? Só **beto** (sem 1) e **euler** (sem 1). Cruzando com as matrículas (verificado):

| Disciplina | Calouros matriculados |
|---|---|
| Cálculo 1 | **euler** |
| IAL | **beto, euler** |
| APC | nenhum |

Saída (com `findall`): `[Cálculo 1, IAL, IAL]` — **IAL aparece 2×** porque são 2 calouros nela. Para deduplicar: `setof(D, E^tem_calouros(D), L)` → `[Cálculo 1, IAL]`.

**(b) Disciplinas mistas (ao menos um estudante de CADA curso):**

```prolog
turma_mista(D) :-
    matricula(D, E1), estudante(E1, _, 'Engenharias'),
    matricula(D, E2), estudante(E2, _, 'Engenharia de Software'),
    matricula(D, E3), estudante(E3, _, 'Engenharia de Energia').
```

Debug por disciplina:

| Disciplina | Engenharias | Eng. Software | Eng. Energia | Mista? |
|---|---|---|---|---|
| Cálculo 1 | euler, ian | ana, fabio, gustavo | **ninguém** | não |
| IAL | beto, diane, euler | ninguém | ninguém | não |
| **APC** | ian | fabio, gustavo | carlos | **SIM** |

Saída (verificada): `[APC, APC]` — 2 soluções (com fabio **ou** com gustavo). Para deduplicar: `setof`.

**(c) Imprimir todos os estudantes de Eng. de Software (um por linha):**

```prolog
software :-
    estudante(E, _, 'Engenharia de Software'),
    writeln(E),
    fail.
software.                        % cláusula final: sucesso no fim da enumeração
```

Saída (verificada): **ana, fabio, gustavo** (na ordem da base). Sem o `fail`, sairia só o 1º; sem a cláusula final, a consulta terminaria em `false`.

### 8. Família dos Simpsons

O enunciado manda declarar os fatos **conforme a figura da folha** (você preenche os nomes/relações). Estrutura esperada:

```prolog
male(homer).  male(bart).  male(abraham).  % ...
female(marge). female(lisa). female(maggie). % ...

father(homer, bart).      % pai do respectivo membro
mother(marge, bart).      % mãe do respectivo membro
% ... complete com os demais
```

Regras:

```prolog
uncle(X, Y) :- (father(P, Y) ; mother(P, Y)), siblings(X, P).
grandmother(X, Y) :- mother(X, P), (father(P, Y) ; mother(P, Y)).
```

- `uncle(X, Y)`: X é **irmão de um dos pais** de Y (`;` porque o pai pode ser o father ou a mother).
- `grandmother(X, Y)`: X é **mãe de um dos pais** de Y.

Valide com consultas do tipo `?- grandmother(marge, lisa).` e confira contra a figura.

### 9. `distance/5`

$S = I + V T + \frac{A T^2}{2}$ — o último argumento é o "retorno":

```prolog
distance(I, V, A, T, S) :- S is I + V*T + A*T*T/2.
```

Exemplo (verificado): `?- distance(10, 5, 2, 3, S).` → $10 + 15 + 9 = 34$.

### 10. `divisores/2` + função aritmética + operador

```prolog
:- use_module(library(arithmetic)).
:- arithmetic_function(divisores/1).      % aridade declarada = aridade do predicado − 1
:- op(700, xfx, divisores).               % infixado, sem associatividade

divisores(N, X) :- divisores_(N, 1, 0, X).
divisores_(N, D, Acc, X) :-
    D =< N,
    (0 =:= N mod D -> NewAcc is Acc + 1 ; NewAcc = Acc),
    NewD is D + 1,
    divisores_(N, NewD, NewAcc, X).
divisores_(N, D, Acc, Acc) :- D > N.
```

Debug passo a passo de `?- divisores(12, X).` (troque 12 por 60 ou 20 para os outros exemplos):

**Passo 0** — `divisores(12, X)` → cláusula wrapper: `divisores_(12, 1, 0, X)`.

**Passo 1 — `divisores_(12, 1, 0, X)`** (o `D` começa em 1 e o acumulador em 0)

| Linha | Substituindo | Resultado |
|---|---|---|
| `D =< N` | `1 =< 12` | ✓ |
| `0 =:= N mod D` | `0 =:= 12 mod 1` → `0 =:= 0` | verdadeiro → `NewAcc is 0 + 1` → **1** |
| `NewD is D + 1` | `NewD is 1 + 1` | **2** |
| `divisores_(N, NewD, NewAcc, X)` | `divisores_(12, 2, 1, X)` | **próximo passo** |

**Passos seguintes** (só muda D e o acumulador):

| D | `D =< 12`? | `12 mod D` | divisor? | Acumulador | Próxima chamada |
|---|---|---|---|---|---|
| 2 | ✓ | 0 | ✓ | **2** | `divisores_(12, 3, 2, X)` |
| 3 | ✓ | 0 | ✓ | **3** | `divisores_(12, 4, 3, X)` |
| 4 | ✓ | 0 | ✓ | **4** | `divisores_(12, 5, 4, X)` |
| 5 | ✓ | 2 | ✗ | 4 | `divisores_(12, 6, 4, X)` |
| 6 | ✓ | 0 | ✓ | **5** | `divisores_(12, 7, 5, X)` |
| 7 a 11 | ✓ | ≠ 0 | ✗ | 5 | ... até `divisores_(12, 12, 5, X)` |
| 12 | ✓ | 0 | ✓ | **6** | `divisores_(12, 13, 6, X)` |
| 13 | **✗** (`13 =< 12` falha) | — | — | — | vai para a base |

**Base — `divisores_(12, 13, 6, X)`** → 2ª cláusula: `D > N` → `13 > 12` ✓ → `X` unifica com o
acumulador → **X = 6**. Divisores de 12: 1, 2, 3, 4, 6, 12 ✓

Verificados: `?- 60 divisores X.` → `X = 12` · `?- R is divisores(20).` → `R = 6`.

> **Atenção (bug que estava no material):** a base precisa ter **`N` na cabeça**:
> `divisores_(N, D, Acc, Acc) :- D > N.` Se ficar `divisores_(_, D, Acc, Acc) :- D > N.`,
> o `N` do corpo fica **livre** e o SWI dá `instantiation_error` quando D passa de N
> (o `_` é variável anônima: casa com tudo, mas **não tem nome para ser referenciado**).
> Testado: com a cabeça correta → 12 e 6; com `_` → erro (e o SWI ainda avisa
> `Singleton variables: [N]`).

> **Detalhe do SWI (verificado na versão 10.0.2):** a função aritmética usa *goal expansion* em
> **tempo de compilação** — funciona em cláusulas de arquivo e no prompt do SWI
> (`?- R is divisores(20).` → `R = 6`). Se o objetivo for montado **em runtime** (termo
> construído dinamicamente, ex. via `-g`/meta-chamada), não há expansão e o SWI acusa
> `type_error(evaluable, divisores/1)`; para esses casos existe `arithmetic_expression_value/2`
> (`arithmetic_expression_value(divisores(20), V)` → `V = 6`).

### 11. `is_set(1, 2, 3)` com `is_set/1`

**Resposta: dá ERRO — aridade incompatível.**

`is_set/1` espera **1 argumento** (uma lista). A consulta tenta chamar `is_set/3` (três argumentos) — predicado que não existe → `Unknown procedure: is_set/3`. A chamada correta é:

```prolog
?- is_set([1, 2, 3]).
```

### 12. `X = Y, Y \= Z, Z = W, X = a, W = b`

**Resposta: a consulta FALHA; para dar o esperado, é preciso instanciar antes de comparar.**

Debug da falha:

```text
X = Y        → X e Y são a MESMA variável (apelidos)
Y \= Z       → NESTE momento, Y e Z ainda estão LIVRES
               duas variáveis livres SEMPRE unificam → Y \= Z é FALSE → consulta falha aqui.
```

Ou seja: `\=` testa **não-unificação**; duas variáveis livres unificam (uma com a outra), então o teste falha — mesmo que depois os valores viessem a ser diferentes.

**Correção** (instanciar antes de comparar):

```prolog
?- X = Y, Z = W, X = a, W = b, Y \= Z.
```

Agora `Y = a` e `Z = b` estão atados → `a \= b` → **true**.

### 13. `same_parity/2` retornando falso para `same_parity(2, 4)`

```prolog
same_parity(X, Y) :- mod(X, 2) = mod(Y, 2).
```

**Problema:** o `=` **não avalia** — apenas unifica termos. `mod(2, 2)` e `mod(4, 2)` são **estruturas diferentes** (`mod(2,2)` ≠ `mod(4,2)`) → a unificação falha → false.

**Correção** (comparar **valores** com `=:=`):

```prolog
same_parity(X, Y) :- mod(X, 2) =:= mod(Y, 2).
```

Agora `mod(2,2)` e `mod(4,2)` calculam **0 =:= 0** → **true** ✓.

---

> **Resumo de ouro da lista:** `\=` compara termos **sem instanciar** (cuidado com variáveis livres), `=` unifica sem calcular, `=:=` calcula e compara valores, aridade é parte da identidade do predicado, e `\+` serve para evitar repetições em enumerações.
