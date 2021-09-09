defmodule AnalyticTableaux.Parser do

  alias AnalyticTableaux.Formula
    
  @spec parse(String.t()) :: [Formula.t()]
  def parse(input) do
    input
    |> String.split([",", "|-"])
    |> Enum.reject(fn x -> x == "" end)
    |> Enum.map(&formula/1)
    |> sign_formulas
  end
  
  @spec formula(String.t()) :: Formula.formula()    
  def formula(str) do
    {:ok, tokens, _} = str |> String.to_charlist() |> :lexer.string() 
    {:ok, list} = :parser.parse(tokens)
    list
  end   


  @spec sign_formulas([Formula.formula()]) :: [Formula.t()]
  defp sign_formulas([formula | []]), do: [%Formula{formula: formula, sign: :F}]

  defp sign_formulas([formula | tail]),
    do: [%Formula{formula: formula, sign: :T} | sign_formulas(tail)]
        
end
