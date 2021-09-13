%% http://erlang.org/doc/man/leex.html

%% E.g.   https://andrealeopardi.com/posts/tokenizing-and-parsing-in-elixir-using-leex-and-yecc/
%%        https://pl-rants.net/posts/leex-yecc-in-elixir/
%%        https://cameronp.svbtle.com/how-to-use-leex-and-yecc   
%%        https://notes.eellson.com/2017/01/22/html-parsing-in-elixir-with-leex-and-yecc/


%% Macro Definitions
%% NAME = VALUE
Definitions.

%% Token Rules
%% <Regexp> : <Erlang code>.
Rules.

[a-zA-Z0-9]+    : {token, {atom, TokenLine, list_to_atom(TokenChars)}}.
\(              : {token, {'(', TokenLine}}.
\)              : {token, {')', TokenLine}}.
,               : {token, {',', TokenLine}}.


%% Conjuction - and - ∧
(\&|AND)        : {token, {'and', TokenLine}}.
%% Disjunction - or - V
(\||OR)         : {token, {'or', TokenLine}}.
%% Negation - not - ¬
(\!|NOT)        : {token, {'not', TokenLine}}.
%% Conditional - ->
(\-\>|IMPLIES)  : {token, {'implies', TokenLine}}.

% Turnstile - https://en.wikipedia.org/wiki/Turnstile_(symbol)
(\|\-)          : {token, {'|-',   TokenLine}}.

[\s\t\n\r]+     : skip_token.

Erlang code.
