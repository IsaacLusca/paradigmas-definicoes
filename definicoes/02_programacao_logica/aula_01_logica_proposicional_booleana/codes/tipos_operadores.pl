% ============================================================================
% tipos_operadores.pl - Aula 01/04 (Prolog)
% ----------------------------------------------------------------------------
% Explica a NOTACAO DE TIPO dos operadores (f, x, y) e mostra, com ENTRADAS e
% SAIDAS reais, COMO O PROLOG AGRUPA cada operador.
%
% Um tipo tem 3 caracteres para infixo e 2 para prefixo/posfixo:
%
%    f = posicao do OPERADOR (functor). Ex.:  x f y  =  a Op b
%    x = argumento com precedencia ESTRITAMENTE MENOR que a do operador (< P)
%        -> aquele lado NAO aceita o MESMO operador (quebra a associacao)
%    y = argumento com precedencia MENOR OU IGUAL (<= P)
%        -> aquele lado ACEITA o mesmo operador (permite encadear/associar)
%
%   Tipo | Forma  | Associacao              | Exemplos (SWI-Prolog)
%   -----+--------+-------------------------+--------------------------------
%   xfx  | a f b  | nenhuma (nao assoc.)    | =  ==  <  >  =:=  =\=  is  (700)
%   xfy  | a f b  | a DIREITA               | ,  ;  ->  :-  ^   (1000/1100/1050/1200/200)
%   yfx  | a f b  | a ESQUERDA              | +  -  *  /  //  mod  (500/400)
%   fy   | f a    | prefixo (pode repetir)  | \+  (900) ; - unario (200)
%   fx   | f a    | prefixo (NAO repete)    | :- diretiva (1200)
%   yf   | a f    | posfixo (pode repetir)  | raro
%   xf   | a f    | posfixo (NAO repete)    | raro
%
% Regra de ouro da precedencia: quanto MENOR o numero, MAIS FORTE o operador.
%
% Como executar:
%     swipl -s tipos_operadores.pl
%     ?- consult('codes/tipos_operadores.pl').   % (se ja nao veio pelo -s)
%     ?- demo.
% ============================================================================

% --- parse/1: le um TEXTO e mostra a ARVORE (forma canonica) -----------------
% Usa read_term_from_atom/3 para transformar texto em termo; se o texto tiver
% erro de sintaxe (ex.: a = b = c), o catch captura e avisa.
parse(Texto) :-
    ( catch(read_term_from_atom(Texto, T, []), Erro, T = erro(Erro)) -> true
    ; T = erro(erro) ),
    ( T = erro(_) ->
        format("?- ~w.~n   ERRO DE SINTAXE~n", [Texto])
    ; with_output_to(atom(Forma), write_canonical(T)),
      format("?- ~w.~n   ~w~n", [Texto, Forma])
    ).

% --- demonstracao (rode ?- demo.) -------------------------------------------
demo :-
    nl, writeln('=== 1) yfx (associa a ESQUERDA): + - * / ==='),
    parse('a - b - c'),
    parse('10 - 2 - 3'),
    ( X1 is 10 - 2 - 3,
      format('   valor: 10 - 2 - 3 = ~w   (= (10-2)-3 = 5)~n', [X1]) ),

    nl, writeln('=== 2) xfy (associa a DIREITA): , ; -> :- ^ ==='),
    parse('a , b , c'),
    parse('a ; b ; c'),
    parse('a -> b -> c'),
    parse('2 ^ 3 ^ 2'),
    ( X2 is 2 ^ 3 ^ 2,
      format('   valor: 2^3^2 = ~w   (= 2^(3^2) = 512)~n', [X2]) ),

    nl, writeln('=== 3) xfx (NAO associa): = == < =:=  ==='),
    parse('a = b = c'),
    parse('1 =:= 2 =:= 3'),
    parse('(a = b) = c'),

    nl, writeln('=== 4) fy (prefixo, pode repetir): \\+ , - unario ==='),
    parse('\\+ \\+ a'),
    parse('- - 5'),
    ( X3 is - - 5, format('   valor: - - 5 = ~w~n', [X3]) ),

    nl, writeln('=== 5) fx (prefixo, NAO repete): :- diretiva ==='),
    parse(':- op(500, yfx, foo)'),
    parse(':- :- a'),

    nl, writeln('=== 6) current_op/3 dos principais (precedencia e tipo) ==='),
    forall( ( member(Op, ['=', '==', '=:=', ',', ';', '->', ':-', '^',
                          '+', '-', '*', '/', '\\+']),
              current_op(P, T, Op) ),
            format('   ~w  ->  ~w/~w~n', [Op, P, T]) ),
    nl.

% ---------------------------------------------------------------------------
% Entradas e saidas esperadas (transcricao)
% ---------------------------------------------------------------------------
% ?- X = (a - b - c), write_canonical(X).     -(-(a,b),c)              (yfx)
% ?- X = (a , b , c), write_canonical(X).     ','(a,','(b,c))          (xfy)
% ?- X = (a -> b -> c), write_canonical(X).   '->'(a,'->'(b,c))        (xfy)
% ?- X = (2 ^ 3 ^ 2), write_canonical(X).     ^(2,^(3,2))              (xfy)
% ?- Y is 2 ^ 3 ^ 2.                          Y = 512.
% ?- X = (a = b = c).                         ERRO DE SINTAXE          (xfx)
% ?- X = (\+ \+ a), write_canonical(X).       \+(\+(a))                (fy)
% ?- current_op(P, T, '+').                   P = 500, T = yfx ; P = 200, T = fy.
