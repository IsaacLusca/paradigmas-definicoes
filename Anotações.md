
Q 07.

```
f(N, M, X) :- g(M, N, X).

g(M, N, X) :-
    N > 0,
    (N mod 2 =:= 0
     -> NewN is N div 2
     ; NewN is 3*N + 1),
    succ(NewM, M),
    g(NewM, NewN, X).

g(0, X, X).
```

f(N, M, X).
f(10, 4, X).
g(M, N, X).
g(4, 10, X).
		
	10 > 0 ok
	10 mod 2 =:= 0 verdade, então vai para o ->, não o ;
	NewN is 10 div 2 = 5
	succ(newM, 4) - 3, 4

g(3, 5, X)
	
	5 > 0 ok
	5 mod 2 =:= 0 falso, então vai para o ;, não ->
	NewN 3 * 5 + 1 = 16
	succ(newM,3) - 2, 3

g(2, 16, X)

	16 > 0 ok
	16 mod 2 =:= 0 é V;
	newN is 16 div 2 = 8
	succ(newM, 2) = 1, 2

g(1, 8, X)

	8 > 0 ok
	8 mod 2 =:= 0 é V
	newN is 8 div 2 = 4
	succ(newM, 1) = 0, 1
	
g(0, 4, X)


g(0, X, X) = g(0, 4, X)


Q 10.
```
p([_|[]], X) :- p([], X).
p([], 0).

p([A,B|C], X) :-
    p(C, NewX),
    X is NewX + (B - A).
```

p([2,3,5], X)

1 regra:

compara com p([_|[]], X)
_ = 2 ok
[ ] = [3, 5] falso (lista vazia com cheia.)

2 regra:
p([ ], 0)

[ ] = [2, 3, 5] falso

3 regra:

	p([A, B | C], X)

	p([2, 3, [5]], X) ok.
		p(5, newX),
		X is NewX + (3 - 2)

Recomparando com as regras

1 regra:

p(5, newX)

compara com p([_|[ ]], X)

primeiro [5] = [5, [ ]]
_ = 5 ok
[ ] = [ ] v.

p([ ], X)

X seria NewX
p([ ], NewX))

voltando 1 regra:
p([_ | [ ]], X)

3 regra:

p([ ], 0) = p([ ], newX)

NewX = 0

Voltando


-----------
xor(true, false)
xor(false, true)


Q7 sim 1 — h/2 (soma 1..N)

```
h(0, 0).
h(N, X) :-
    N > 0,
    M is N - 1,
    h(M, Y),
    X is Y + N.
```

Fluxo correto (testa a cláusula 1 antes de cada descida):

```
h(4, X)
  (1) h(0,0) = h(4,X) -> 0 = 4 ✗
  (2) N = 4
      N > 0      -> 4 > 0 ✓
      M is N - 1 -> M = 3
      h(3, Y)    -> desce   | pendente: X is Y + 4

h(3, Y)
  (1) 0 = 3 ✗
  (2) N = 3 ; 3 > 0 ✓ ; M = 2
      h(2, Y1)   -> desce   | pendente: Y is Y1 + 3

h(2, Y1)
  (1) 0 = 2 ✗
  (2) N = 2 ; 2 > 0 ✓ ; M = 1
      h(1, Y2)   -> desce   | pendente: Y1 is Y2 + 2

h(1, Y2)
  (1) 0 = 1 ✗
  (2) N = 1 ; 1 > 0 ✓ ; M = 0
      h(0, Y3)   -> desce   | pendente: Y2 is Y3 + 1

h(0, Y3)
  (1) h(0, 0) casa -> Y3 = 0    (BASE - sem corpo)

VOLTA (as contas pendentes acontecem de baixo para cima):
  Y2 is Y3 + 1 -> Y2 = 0 + 1 = 1
  Y1 is Y2 + 2 -> Y1 = 1 + 2 = 3
  Y  is Y1 + 3 -> Y  = 3 + 3 = 6
  X  is Y  + 4 -> X  = 6 + 4 = 10

Resposta: X = 10 ✓
```


Q11Parte A · 2 pts

Considere o predicado abaixo. Qual é o resultado da consulta `?- p(81, K).`?

```
p(1, 0).
p(N, K) :-
    N > 1,
    0 =:= N mod 3,
    M is N div 3,
    p(M, K1),
    K is K1 + 1.
```

p(81, K) 
	p(1, 0) = p(81, K) -> falso, 81 com 1

	81 > 1 ok
	0 =:= 81 mod 3 V
	M is 81 div 3 = 27
	P(27, K1) -> desce. pendente: K is K1 + 1.

	p(1, 0) = p(27, K1) false.
	0 =:= 27 mod 3 V
	M is 27 div 3 = 9
	P(9, K2) - > desce. pendente: K1 is K2 + 1.

	p(1, 0) = p(27, K2) false.
	0 =:= 9 mod 3 V
	M is 9 div 3 = 3
	P(3, K3) -> desce. pendente: K2 is K3 + 1.

	p(1, 0) = p(3, K3) false
	0 =:= 3 mod 3 V
	M is 3 div 3 = 1
	P(1, K4) -> desce. pendente: K3 is K4 + 1.

	p(1, 0) = p(1, K4) -> K4 = 0

	K3 is K4 + 1 -> 0 + 1 = 1
	K2 is K3 + 1 -> 1 + 1 = 2
	K1 is K2 + 1 -> 2 + 1 = 3
	K is K1 + 1 -> 3 + 1 = 4
K = 4.

Q12
Considere o predicado abaixo. Quantas **soluções distintas** produz a consulta `?- soma(5).`?

```
soma(N) :-
    between(1, N, A),
    between(A, N, B),
    A < B,
    N =:= A + B.
```
soma (5)
	between (1, 5, A) -> A = 1, 2, 3, 4, 5
	between (A, 5, B) -> B = A, A+1, ..., 5

Como o backtracking anda (o B varia mais rápido; quando B esgota, o A avança):

A = 1
	B = 1 -> A < B? 1 < 1 ✗
	B = 2 -> 1 < 2 ✓ ; 5 =:= 1 + 2 = 3 ✗
	B = 3 -> 1 < 3 ✓ ; 5 =:= 1 + 3 = 4 ✗
	B = 4 -> 1 < 4 ✓ ; 5 =:= 1 + 4 = 5 ✓   <- SOLUÇÃO 1: (1, 4)
	B = 5 -> 1 < 5 ✓ ; 5 =:= 1 + 5 = 6 ✗
	(B esgotou -> o between de A avança)

A = 2
	B = 2 -> 2 < 2 ✗
	B = 3 -> 2 < 3 ✓ ; 5 =:= 2 + 3 = 5 ✓   <- SOLUÇÃO 2: (2, 3)
	B = 4 -> 2 < 4 ✓ ; 5 =:= 2 + 4 = 6 ✗
	B = 5 -> 2 < 5 ✓ ; 5 =:= 2 + 5 = 7 ✗

A = 3
	B = 3 ✗ ; B = 4 -> 5 =:= 7 ✗ ; B = 5 -> 5 =:= 8 ✗

A = 4
	B = 4 ✗ ; B = 5 -> 5 =:= 9 ✗

A = 5
	B = 5 ✗
	(A esgotou também -> a consulta termina em false)

Resposta: 2 soluções distintas -> (A=1, B=4) e (A=2, B=3) -> alternativa C


Q12
Considere o predicado abaixo. Quantas **soluções distintas** produz a consulta `?- soma(5).`?

```
soma(N) :-
    between(1, N, A),
    between(A, N, B),
    A < B,
    N =:= A + B.
```
soma (5)

Debug objetivo por objetivo (os 4 goals na ordem; quando um falha, o backtracking volta
para o between anterior):

1º objetivo: between (1, 5, A)
	A = 1

	2º objetivo: between (1, 5, B)   (com A = 1)
		B = 1
	3º objetivo: A < B -> 1 < 1 -> FALHA
		(volta/redo no 2º objetivo)

		B = 2
	3º objetivo: 1 < 2 -> V
	4º objetivo: 5 =:= A + B -> 5 =:= 1 + 2 = 3 -> FALHA
		(volta/redo no 2º objetivo)

		B = 3
	3º objetivo: 1 < 3 -> V
	4º objetivo: 5 =:= 1 + 3 = 4 -> FALHA
		(volta/redo no 2º objetivo)

		B = 4
	3º objetivo: 1 < 4 -> V
	4º objetivo: 5 =:= 1 + 4 = 5 -> V   <- SOLUÇÃO 1: (A=1, B=4)

		B = 5
	3º objetivo: 1 < 5 -> V
	4º objetivo: 5 =:= 1 + 5 = 6 -> FALHA
		(B esgotou: 5 era o último) -> volta/redo no 1º objetivo

	A = 2

	2º objetivo: between (2, 5, B)
		B = 2
	3º objetivo: 2 < 2 -> FALHA
		B = 3
	3º objetivo: 2 < 3 -> V
	4º objetivo: 5 =:= 2 + 3 = 5 -> V   <- SOLUÇÃO 2: (A=2, B=3)
		B = 4
	3º objetivo: 2 < 4 -> V
	4º objetivo: 5 =:= 2 + 4 = 6 -> FALHA
		B = 5
	3º objetivo: 2 < 5 -> V
	4º objetivo: 5 =:= 2 + 5 = 7 -> FALHA
		(B esgotou) -> redo no 1º objetivo

	A = 3

	2º objetivo: between (3, 5, B)
		B = 3 -> 3 < 3 FALHA
		B = 4 -> 3 < 4 V ; 5 =:= 3 + 4 = 7 FALHA
		B = 5 -> 3 < 5 V ; 5 =:= 3 + 5 = 8 FALHA
		(B esgotou) -> redo no 1º objetivo

	A = 4

		B = 4 -> 4 < 4 FALHA
		B = 5 -> 4 < 5 V ; 5 =:= 4 + 5 = 9 FALHA
		(B esgotou) -> redo no 1º objetivo

	A = 5

		B = 5 -> 5 < 5 FALHA
		(B esgotou) e (A esgotou também) -> FALHA geral = false
		(não há mais respostas)

Resposta: 2 soluções distintas -> (A=1, B=4) e (A=2, B=3) -> alternativa C


```
soma(N) :-
    between(1, N, A),
    between(A, N, B),
    A < B,
    N =:= A + B.
```
soma (5)
	between (1, 5, A) -> A = 1, 2, 3, 4, 5
	between (A, 5, B) -> B = A, A+1, ..., 5

	(A, 5, B) = (1, 5, A) -> V, A = 1, B = A = 1.

A = 1

	1 < 1 Falha
	1 < 2 V.
	5 =:= A + B = 1 + 2 F.

	1 < 3 V.
	5 =:= 1 + 3. F.

	1 < 4 V.
	5 =:= 1 + 4. V.

(1, 4)


A = 2

	2 < 2 F
	2 < 3 V.
	5 =:= A + B = 2 + 3 V

(2, 3)

A = 3

	3 < 3 F
	3 < 4 V.
	5 =:= 3 + 4 F.

	3 < 5 V.
	5 =:= 3 + 5. F

B esgotou.


Simulado 2

Q7

Q7Parte A · 2 pts

Considere o predicado `mdc/3` abaixo. Qual é o resultado de `?- mdc(48, 18, X).`?

```
mdc(A, 0, A).
mdc(A, B, X) :-
    B > 0,
    R is A mod B,
    mdc(B, R, X).
```

mdc(A, 0, A).

mdc(A, B, X).
mdc(48, 18, X).

mdc(A, 0, A) = mdc(48, 18, X). F

	18 > 0. V
	R is 48 mod 18 = 12
	mdc(18, 12, X)

	12 > 0. V
	R is 18 mod 12 = 6
	mdc(12, 6, X)

	6 > 0.
	R is 12 mod 6 = 0
	mdc(6, 0, X)

mdc(A, 0, A) = mdc(6, 0, X)

A = 6, X = A, X = 6.


Q 11.

Considere o predicado abaixo. Qual é o resultado da consulta `?- conta([2, 3, 4, 5, 6], X).`?

```
conta([], 0).
conta([H|T], X) :-
    conta(T, Y),
    (0 =:= H mod 2 -> X is Y + 1 ; X = Y).
```



Como ler a lista (cada [H|T] "quebra" a lista em 1º elemento + resto):
	[2, 3, 4, 5, 6]  ->  H = 2, T = [3,4,5,6]
	[3, 4, 5, 6]     ->  H = 3, T = [4,5,6]
	[4, 5, 6]        ->  H = 4, T = [5,6]
	[5, 6]           ->  H = 5, T = [6]
	[6]              ->  H = 6, T = []
	[]               ->  só casa com a 1ª regra (base)

1ª chamada: conta([2,3,4,5,6], X)
	1ª regra: conta([], 0) = conta([2,3,4,5,6], X) -> [] ≠ [2,...] F
	2ª regra: [H|T] = [2,3,4,5,6] -> H = 2, T = [3,4,5,6]
	corpo da 2ª regra, na ordem:
		conta(T, Y) -> conta([3,4,5,6], Y)   [DESCE; o if-then-else com H = 2 fica pendente]
		(0 =:= H mod 2 -> X is Y + 1 ; X = Y) -> ainda não (espera o Y)

2ª chamada: conta([3,4,5,6], Y)
	1ª regra: [] ≠ [3,...] F
	2ª regra: H = 3, T = [4,5,6]
	conta([4,5,6], Y1)   [DESCE; pendente com H = 3]

3ª chamada: conta([4,5,6], Y1)
	2ª regra: H = 4, T = [5,6]
	conta([5,6], Y2)   [DESCE; pendente com H = 4]

4ª chamada: conta([5,6], Y2)
	2ª regra: H = 5, T = [6]
	conta([6], Y3)   [DESCE; pendente com H = 5]

5ª chamada: conta([6], Y3)
	2ª regra: H = 6, T = []
	conta([], Y4)   [DESCE; pendente com H = 6]

6ª chamada: conta([], Y4)
	1ª regra: conta([], 0) = conta([], Y4) -> Y4 = 0   [BASE; sem corpo]
	(a 2ª regra nem é tentada: [] não casa com [H|T])

VOLTA (agora cada nível decide o SEU H; o resultado vai subindo):
	5ª chamada (H=6): 0 =:= 6 mod 2 -> 0 =:= 0 V -> Y3 is Y4 + 1 = 0 + 1 = 1
	4ª chamada (H=5): 0 =:= 5 mod 2 -> 0 =:= 1 F -> Y2 = Y3 = 1
	3ª chamada (H=4): V -> Y1 is Y2 + 1 = 1 + 1 = 2
	2ª chamada (H=3): F -> Y = Y1 = 2
	1ª chamada (H=2): V -> X is Y + 1 = 2 + 1 = 3

X = 3.   (contou os pares: 2, 4 e 6)   -> alternativa C

Q 11.

Considere o predicado abaixo. Qual é o resultado da consulta `?- conta([2, 3, 4, 5, 6], X).`?

```
conta([], 0).
conta([H|T], X) :-
    conta(T, Y),
    (0 =:= H mod 2 -> X is Y + 1 ; X = Y).
```


conta([ ], 0) = conta([2, 3...]).F

	H = 2, T = 3, 4, 5, 6
	conta([3, 4, 5, 6], Y).
	0 =:= 2 mod 2 V. pendente X is Y + 1

	H2 = 3, T = 4, 5, 6
	conta([4, 5, 6], Y).
	0 =:= 3 mod 2 F. pentende X2 = Y

	H3 = 4, T = 5, 6
	conta([5, 6], Y).
	0 =:= 4 mod 2 V. pendente X3 is Y + 1.

	H4 = 5, T = 6
	conta(6, Y)
	0 =:= 5 mod 2 F. pendente X4 = Y

	H5 = 6, T = []
	conta([], Y)

	Y = 0.

	X4 = 0
	X3 = 1
	X2 = 0
	X = 1


Q 11 — versão direta (corrigida)

conta([], 0) = conta([2,3,4,5,6], X) -> F  ([] ≠ lista cheia)

	H = 2, T = [3,4,5,6]
	conta([3,4,5,6], Y1)      | pendente: X is Y1 + 1
	0 =:= 2 mod 2 -> V

	H = 3, T = [4,5,6]
	conta([4,5,6], Y2)        | pendente: Y1 = Y2
	0 =:= 3 mod 2 -> F

	H = 4, T = [5,6]
	conta([5,6], Y3)          | pendente: Y2 is Y3 + 1
	0 =:= 4 mod 2 -> V

	H = 5, T = [6]
	conta([6], Y4)            | pendente: Y3 = Y4
	0 =:= 5 mod 2 -> F

	H = 6, T = []
	conta([], Y5)             | pendente: Y4 is Y5 + 1
	0 =:= 6 mod 2 -> V

	conta([], 0) = conta([], Y5) -> Y5 = 0   (BASE)

VOLTA (de baixo para cima — o sinal de cada H decide):
	Y4 is Y5 + 1 -> 0 + 1 = 1      (H = 6, par)
	Y3 = Y4      -> 1              (H = 5, ímpar)
	Y2 is Y3 + 1 -> 1 + 1 = 2      (H = 4, par)
	Y1 = Y2      -> 2              (H = 3, ímpar)
	X  is Y1 + 1 -> 2 + 1 = 3      (H = 2, par)

X = 3   (pares: 2, 4, 6)   -> alternativa C



COMBINADORES

p ∧ q

(p ↓ p) ↓ (q ↓ q).