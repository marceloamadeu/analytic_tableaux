% http://erlang.org/doc/man/leex.html

% Macro Definitions
% NAME = VALUE
Definitions.

% E.g.   https://andrealeopardi.com/posts/tokenizing-and-parsing-in-elixir-using-leex-and-yecc/
%        https://pl-rants.net/posts/leex-yecc-in-elixir/
%        https://cameronp.svbtle.com/how-to-use-leex-and-yecc   
%        https://notes.eellson.com/2017/01/22/html-parsing-in-elixir-with-leex-and-yecc/


% Token Rules
% <Regexp> : <Erlang code>.
Rules.

[a-zA-Z0-9]+    : {token, {atom, TokenLine, list_to_atom(TokenChars)}}.
\(              : {token, {'(', TokenLine}}.
\)              : {token, {')', TokenLine}}.
,               : {token, {',', TokenLine}}.

% Conjuction - and - ∧
(\&|AND)        : {token, {'and', TokenLine}}.

% Disjunction - or - V
(\||OR)         : {token, {'or', TokenLine}}.

% Negation - not - ¬
(\!|NOT)        : {token, {'not', TokenLine}}.

% Conditional - ->
(\-\>|IMPLIES)  : {token, {'implies', TokenLine}}.

% Turnstile - https://en.wikipedia.org/wiki/Turnstile_(symbol)
(\|\-)          : {token, {'|-',   TokenLine}}.

[\s\t\n\r]+     : skip_token.


% The Erlang code in the "Erlang code." section is written into the 
% output file directly after the module declaration and predefined 
% exports declaration so it is possible to add extra exports, define 
% imports and other attributes which are then visible in the whole file.
Erlang code.
