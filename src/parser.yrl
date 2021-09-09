% http://erlang.org/doc/man/yecc.html

% Categories to be used in the rules
Nonterminals formula.

% Categories of tokens produced by the scanner
Terminals atom 'and' 'or' 'not' 'implies' '(' ')'.

Rootsymbol formula.

Left 100 'implies'.
Left 200 'and'.
Left 200 'or'.
Unary 300 'not'.

% <nonterminal> -> <pattern> : <result>
formula  -> atom                      : extract_value('$1').
formula  -> '(' formula ')'           : '$2'.
formula  -> 'not' formula             : {extract_value('$1'), '$2'}.
formula  -> formula 'and' formula     : {extract_value('$2'), '$1', '$3'}.
formula  -> formula 'or' formula      : {extract_value('$2'), '$1', '$3'}.
formula  -> formula 'implies' formula : {extract_value('$2'), '$1', '$3'}.

Erlang code.

% https://gist.github.com/kwmiebach/ad0f883403dfbabea6e9
extract_value({_Token, _Line, Value}) -> Value;
extract_value({Value, _Line}) -> Value.