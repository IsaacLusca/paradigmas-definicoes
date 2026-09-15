% ============================================================================
% proposicoes_compostas.pl - Aula 01 (Logica Proposicional Booleana)
% ----------------------------------------------------------------------------
% Mostra as PRINCIPAIS proposicoes compostas que caem na prova, com EXEMPLO DE
% CONSULTA e RESULTADO.
%
% Regra de ouro: PREDICADO NAO E FUNCAO. Para COMBINAR conectivos usam-se os
% predicados de CONTROLE:  ',' (E)  ';' (OU)  '\+' (NAO)  '->' (se-entao).
% NUNCA se aninha um predicado como argumento de outro:
%     ?- f_and(f_or(true,false), true).   -> false  (nao avalia; unifica)
%     ?- (false ; true), true.            -> true    (controle avalia)
%
% Como executar:
%     swipl -s proposicoes_compostas.pl
%     ?- demo.                 % imprime as tabelas: consulta -> resultado
%     ?- sessao.               % transcricao estilo listener: "?- consulta." + resposta
%     ?- linhas(3, L).         % L = 8  (2^3 linhas da tabela-verdade)
%     ?- conta_linhas('(p /\ ~q) \/ (~p -> (q /\ r))').
%
% Conectivos (simbolo | leitura | quando e verdadeiro):
%     ~   NOT    nega o valor
%     /\  AND    so se AMBOS verdadeiros
%     \/  OR     falso so se AMBOS falsos
%     ->  IMPL   falso so se V -> F
%     <-> IFF    mesmo valor logico
%     xor XOR    so se valores DIFERENTES
%     nand NAND  falso so se AMBOS verdadeiros (negacao do AND)
%     nor  NOR   verdadeiro so se AMBOS falsos (negacao do OR)
% ============================================================================

% ---------------------------------------------------------------------------
% 1) Valores logicos (atomos minusculos, como no curso)
% ---------------------------------------------------------------------------
bool(true).
bool(false).

% ---------------------------------------------------------------------------
% 2) Conectivos como PREDICADOS QUE AVALIAM (sucedem ou falham)
%    Os argumentos sao objetivos true/false; o corpo usa os de controle.
% ---------------------------------------------------------------------------
c_not(A)     :- \+ call(A).

c_and(A, B)  :- call(A), call(B).
c_or(A, B)   :- ( call(A) ; call(B) ).
c_xor(A, B)  :- ( call(A), \+ call(B) ; \+ call(A), call(B) ).
c_impl(A, B) :- ( \+ call(A) ; call(B) ).                        % A -> B = ~A v B
c_iff(A, B)  :- ( call(A), call(B) ; \+ call(A), \+ call(B) ).   % mesmo valor
c_nand(A, B) :- \+ ( call(A), call(B) ).
c_nor(A, B)  :- \+ ( call(A) ; call(B) ).

% ---------------------------------------------------------------------------
% 3) Conectivos como FATOS (base fechada / mundo fechado)
%    So o que esta declarado e verdadeiro. Versao dos slides (conectivos.pl).
% ---------------------------------------------------------------------------
f_and(true, true).

f_or(true, true).
f_or(true, false).
f_or(false, true).

f_xor(true, false).
f_xor(false, true).

f_not(false).

% ---------------------------------------------------------------------------
% 4) Impressao "consulta -> resultado"
% ---------------------------------------------------------------------------
imp_bin(Op, S, A, B) :-
    ( call(Op, A, B) -> R = true ; R = false ),
    format("  ?- ~w ~w ~w   ->   ~w.~n", [A, S, B, R]).

imp_un(Op, S, A) :-
    ( call(Op, A) -> R = true ; R = false ),
    format("  ?- ~w~w      ->   ~w.~n", [S, A, R]).

tabela_bin(Op, S) :- bool(A), bool(B), imp_bin(Op, S, A, B), fail.
tabela_bin(_, _).

tabela_un(Op, S) :- bool(A), imp_un(Op, S, A), fail.
tabela_un(_, _).

% ---------------------------------------------------------------------------
% 5) Numero de linhas da tabela-verdade
%    n = numero de proposicoes simples DISTINTAS  =>  linhas = 2^n
% ---------------------------------------------------------------------------
linhas(NVars, L) :- integer(NVars), NVars >= 0, L is 2^NVars.

% ---------------------------------------------------------------------------
% 6) Sessao no estilo do listener:  "?- consulta."  seguido da resposta.
%    Foco nos operadores de CONTROLE (nativos):  true false fail  ,  ;  \+  ->
% ---------------------------------------------------------------------------
pergunta(Texto, G) :-
    ( catch(call(G), _, fail) -> R = true ; R = false ),
    format('?- ~w.~n~w.~n~n', [Texto, R]).

sessao :-
    writeln('% --- constantes de controle ---'),
    pergunta('true', true),
    pergunta('false', false),
    pergunta('fail', fail),

    writeln('% --- conjuncao  ,  (a e b) ---'),
    pergunta('true, true', (true, true)),
    pergunta('true, false', (true, false)),
    pergunta('false, true', (false, true)),
    pergunta('false, false', (false, false)),

    writeln('% --- disjuncao  ;  (a ou b) ---'),
    pergunta('true ; true', (true ; true)),
    pergunta('true ; false', (true ; false)),
    pergunta('false ; true', (false ; true)),
    pergunta('false ; false', (false ; false)),

    writeln('% --- negacao  \\+  (nao a) ---'),
    pergunta('\\+ true', (\+ true)),
    pergunta('\\+ false', (\+ false)),
    pergunta('\\+ fail', (\+ fail)),
    pergunta('\\+ (true, false)', (\+ (true, false))),
    pergunta('\\+ (true, true)', (\+ (true, true))),

    writeln('% --- condicional  ->  (se a entao b) ---'),
    pergunta('true -> true', (true -> true)),
    pergunta('true -> false', (true -> false)),
    pergunta('false -> true', (false -> true)),
    pergunta('(true -> false ; true)', (true -> false ; true)),
    pergunta('(false -> true ; false)', (false -> true ; false)),

    writeln('% --- misturando (precedencia) ---'),
    pergunta('(false ; true), true', ((false ; true), true)),
    pergunta('(true ; false), false', ((true ; false), false)),
    pergunta('\\+ true ; false', (\+ true ; false)),
    pergunta('(false ; true) -> true', ((false ; true) -> true)),
    pergunta('true ; false, false', (true ; false, false)),
    nl.

% ---------------------------------------------------------------------------
% 7) Demonstracao completa (rode ?- demo.)
% ---------------------------------------------------------------------------
demo :-
    nl, writeln('=== A) Conectivos como PREDICADOS (AVALIAM) ==='),
    writeln('--- NOT  (~)  ---'),  tabela_un(c_not, '~'),
    writeln('--- AND  (e)  ---'),  tabela_bin(c_and, '/\\'),
    writeln('--- OR   (ou) ---'),  tabela_bin(c_or, '\\/'),
    writeln('--- XOR  (xor)--'),  tabela_bin(c_xor, 'xor'),
    writeln('--- IMPL (->) ---'),  tabela_bin(c_impl, '->'),
    writeln('--- IFF  (<->)--'),  tabela_bin(c_iff, '<->'),
    writeln('--- NAND (nand)---'), tabela_bin(c_nand, 'nand'),
    writeln('--- NOR  (nor)--'),  tabela_bin(c_nor, 'nor'),

    nl, writeln('=== B) FATOS (base fechada) x CONTROLE ==='),
    ( f_and(f_or(true, false), true) -> R1 = true ; R1 = false ),
    format("  ?- f_and(f_or(true,false), true)  ->  ~w.   (fato aninhado NAO avalia)~n", [R1]),
    ( ((false ; true), true) -> R2 = true ; R2 = false ),
    format("  ?- (false ; true), true           ->  ~w.   (controle AVALIA)~n", [R2]),

    nl, writeln('=== C) Predicados da base fechada (estilo prova) ==='),
    ( f_and(true, false) -> R3 = true ; R3 = false ),
    ( f_or(false, true) -> R4 = true ; R4 = false ),
    ( f_xor(true, false) -> R5 = true ; R5 = false ),
    ( f_not(true) -> R6 = true ; R6 = false ),
    format("  ?- f_and(true, false)  ->  ~w.~n", [R3]),
    format("  ?- f_or(false, true)   ->  ~w.~n", [R4]),
    format("  ?- f_xor(true, false)  ->  ~w.~n", [R5]),
    format("  ?- f_not(true)         ->  ~w.~n", [R6]),

    nl, writeln('=== D) Numero de linhas da tabela-verdade ==='),
    forall(between(1, 3, N), ( linhas(N, L),
        format("  ~w variavel(is) -> 2^~w = ~w linhas~n", [N, N, L]) )),
    nl.

% ---------------------------------------------------------------------------
% Exemplos de consulta e resultado (transcricao da sessao) - estilo prova
% ---------------------------------------------------------------------------
% ?- c_and(true, true).                 true.
% ?- c_and(true, false).                false.
% ?- c_or(false, false).                false.
% ?- c_or(false, true).                 true.
% ?- c_not(true).                       false.
% ?- c_xor(true, false).                true.
% ?- c_xor(true, true).                 false.
% ?- c_impl(true, false).               false.
% ?- c_impl(false, false).              true.
% ?- c_iff(true, true).                 true.
% ?- c_iff(true, false).                false.
% ?- c_nand(true, true).                false.
% ?- c_nor(false, false).               true.
% ?- (false ; true), true.              true.
% ?- f_and(f_or(true, false), true).    false.   % predicado nao e funcao
% ?- linhas(4, L).                      L = 16.
