defmodule AnalyticTableaux.Formula do

    @type formula ::
        atom()
        | {:and | :or | :implies, formula(), formula()}
        | {:not, atom()}

    # https://github.com/luissimas/analytic_tableaux/blob/master/lib/formula.ex
    @type t() :: %AnalyticTableaux.Formula{formula: AnalyticTableaux.Formula.formula(), sign: :T | :F}

    # https://elixirschool.com/pt/lessons/basics/modules/#structs
    defstruct [:formula, :sign]
end