% ============================================================================
% precedencia_conectivos.pl - Aula 01/04 (Prolog)
% ----------------------------------------------------------------------------
% Associa a TABELA DE PRECEDENCIA dos operadores de controle aos conectivos
% logicos e mostra EXEMPLOS de consulta -> resultado.
%
% Regra de ouro: quanto MENOR o numero, MAIOR a precedencia (liga mais forte).
%
%   Prec | Operador | Tipo | Conectivo        | Leitura
%   -----+----------+------+------------------+----------------------
%    900 |  \+      | fy   | nao a            | negacao
%   1000 |  ,       | xfy  | a e b            | conjuncao
%   1050 |  ->      | xfy  | se a entao b     | if-then
%   1100 |  ;       | xfy  | a ou b           | disjuncao
%   1200 |  :-      | xfx  | cabeca :- corpo  | REGRA
%   1200 |  :-      | fx   | :- Objetivo.     | DIRETIVA
%   1200 |  ?-      | fx   | ?- Consulta.     | CONSULTA (listener)
%
% O operador ':-' tem DOIS papeis (ambos 1200):
%   - xfx: REGRA   "cabeca :- corpo"  -> leia "cabeca SE corpo"
%          (o corpo IMPLICA a cabeca: corpo -> cabeca)
%   - fx : DIRETIVA ":- Objetivo."     -> executado ao CARREGAR o arquivo
%          (ex.: :- op(...), :- dynamic p/1, :- use_module(...))
% E o '?-' (fx) e o operador que o listener usa para as consultas.
%
% Ordem de forca:   \+  >  ,  >  ->  >  ;
%   a ; b, c   =  a ; (b, c)          (o ',' liga mais forte que o ';')
%   \+ a, b    =  (\+ a), b           (o '\+' liga mais forte que o ',')
%   a ; b -> c =  a ; (b -> c)        (o '->' liga mais forte que o ';')
%
% Como executar:
%     swipl -s precedencia_conectivos.pl
%     ?- demo.
% ============================================================================

% --- Fatos base: a e b verdadeiros; c sempre falha (representa "falso") -------
% (um predicado inexistente daria erro de existencia; por isso c :- fail.)
a.
b.
c :- fail.

% --- Regras (operador :-) para mostrar o papel xfx ----------------------------
% "cabeca :- corpo" le-se "cabeca SE corpo" (o corpo IMPLICA a cabeca).
par(X)   :- 0 =:= X mod 2.
impar(X) :- 1 =:= X mod 2.

% --- Helpers: avalia um objetivo -> true/false --------------------------------
res(G, R) :- ( call(G) -> R = true ; R = false ).

mostra(Texto, G) :-
    res(G, R),
    format('  ~w~n      -> ~w~n', [Texto, R]).

% transcricao estilo listener: "?- consulta." seguido da resposta
pergunta(Texto, G) :-
    res(G, R),
    format('?- ~w.~n~w.~n', [Texto, R]).

% --- Demonstracao ------------------------------------------------------------
demo :-
    nl, writeln('=== 1) Conectivos diretos   (a, b = true ; c = false) ==='),
    mostra('a, b            (a e b)',              (a, b)),
    mostra('a ; b           (a ou b)',             (a ; b)),
    mostra('\\+ a            (nao a)',              (\+ a)),
    mostra('\\+ c            (nao c)',              (\+ c)),
    mostra('\\+ a ; b        (a -> b  material)',   (\+ a ; b)),
    mostra('a -> b          (se a entao b)',        (a -> b)),
    mostra('a xor b         (so se diferentes)',    (a, \+ b ; \+ a, b)),
    mostra('a sse b         (mesmo valor)',         (a, b ; \+ a, \+ b)),

    nl, writeln('=== 2) Como o Prolog agrupa SEM parenteses ==='),
    mostra('a ; b, c          =  a ; (b, c)',       (a ; b, c)),
    mostra('a, b -> c         =  (a, b) -> c',      (a, b -> c)),
    mostra('\\+ a, b          =  (\\+ a), b',       (\+ a, b)),

    nl, writeln('=== 3) As MESMAS ideias com parenteses explicitos ==='),
    mostra('a ; (b, c)          (mesmo que a ; b, c)',   (a ; (b, c))),
    mostra('(a, b) -> c         (mesmo que a, b -> c)',  ((a, b) -> c)),
    mostra('(\\+ a), b          (mesmo que \\+ a, b)',    ((\+ a), b)),

    nl, writeln('=== 4) Pares que dao resultados DIFERENTES ==='),
    mostra('a ; b, c     (sem parens)',   (a ; b, c)),
    mostra('(a ; b), c   (com parens)',   ((a ; b), c)),
    mostra('a ; b -> c   (sem parens)',   (a ; b -> c)),
    mostra('(a ; b) -> c (com parens)',   ((a ; b) -> c)),
    mostra('\\+ a, c      (sem parens)',   (\+ a, c)),
    mostra('\\+ (a, c)    (com parens)',   (\+ (a, c))),

    nl, writeln('=== 5) current_op/3 (tabela oficial do SWI-Prolog) ==='),
    lista_ops,

    nl, writeln('=== 6) Operador de regra  :-   (1200 xfx: regra / 1200 fx: diretiva) ==='),
    writeln('    "cabeca :- corpo"  le-se  "cabeca SE corpo" (corpo IMPLICA cabeca)'),
    pergunta('par(4)', par(4)),
    pergunta('par(3)', par(3)),
    pergunta('impar(3)', impar(3)),
    pergunta('impar(4)', impar(4)),
    pergunta('a', a),
    pergunta('c', c),
    nl.

lista_ops :-
    forall(member(Op, ['\\+', ',', '->', ';', ':-', '?-']),
           forall(current_op(P, T, Op),
                  format('  current_op(~w, ~w, ~w)~n', [P, T, Op])))
    ;
    true.

% ---------------------------------------------------------------------------
% Transcricao esperada da sessao (consulta -> resultado)
% ---------------------------------------------------------------------------
% ?- a, b.              true.     % a e b
% ?- a ; b.             true.     % a ou b
% ?- \+ a.              false.    % nao a
% ?- a -> b.            true.     % se a entao b
% ?- (a ; b, c).        true.     % = a ; (b, c)
% ?- ((a ; b), c).      false.    % parenteses mudam o agrupamento
% ?- (\+ a, c).         false.    % = (\+ a), c   (a e c: c falha)
% ?- (\+ (a, c)).       true.     % nega o 'e' inteiro
% ?- (a ; b -> c).      true.     % = a ; (b -> c)
% ?- ((a ; b) -> c).    false.
%
% Sobre o ':-' (regra):
% par(X) :- 0 =:= X mod 2.
% ?- par(4).            true.
% ?- par(3).            false.
% ?- ((par(4)) ; par(3)).   true.
% ?- par(4), par(3).        false.
