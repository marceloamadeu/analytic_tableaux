defmodule AnalyticTableaux.Rules do
  alias AnalyticTableaux.Formula

  @spec apply_rule(Formula.t()) :: {:atom | :branch | :linear, [Formula.t()]}
  def apply_rule(formula) do
    {type(formula), expansion(formula)}
  end

  @spec can_expand?(Formula.t()) :: boolean()
  def can_expand?(nil), do: false

  def can_expand?(formula) do
    case type(formula) do
      :atom -> false
      _ -> true
    end
  end

  # https://github.com/brunosimsenhor/analytic_tableaux/blob/main/lib/analytic_tableuax/signed_formula.ex
  # https://github.com/luissimas/analytic_tableaux/blob/master/lib/rules.ex
  @spec type(Formula.t()) :: :linear | :branch | :atom
  def type(%{sign: :T, formula: {:and, _, _}}), do: :linear
  def type(%{sign: :F, formula: {:or, _, _}}), do: :linear
  def type(%{sign: :F, formula: {:implies, _, _}}), do: :linear
  def type(%{sign: :T, formula: {:not, _}}), do: :linear
  def type(%{sign: :F, formula: {:not, _}}), do: :linear

  def type(%{sign: :F, formula: {:and, _, _}}), do: :branch
  def type(%{sign: :T, formula: {:or, _, _}}), do: :branch
  def type(%{sign: :T, formula: {:implies, _, _}}), do: :branch

  def type(%{formula: _}), do: :atom

  @spec expansion(Formula.t()) :: [Formula.t()]
  defp expansion(%{sign: :T, formula: {:and, p, q}}),
    do: [%Formula{sign: :T, formula: p}, %Formula{sign: :T, formula: q}]

  defp expansion(%{sign: :F, formula: {:and, p, q}}),
    do: [%Formula{sign: :F, formula: p}, %Formula{sign: :F, formula: q}]

  defp expansion(%{sign: :T, formula: {:or, p, q}}),
    do: [%Formula{sign: :T, formula: p}, %Formula{sign: :T, formula: q}]

  defp expansion(%{sign: :F, formula: {:or, p, q}}),
    do: [%Formula{sign: :F, formula: p}, %Formula{sign: :F, formula: q}]

  defp expansion(%{sign: :T, formula: {:implies, p, q}}),
    do: [%Formula{sign: :F, formula: p}, %Formula{sign: :T, formula: q}]

  defp expansion(%{sign: :F, formula: {:implies, p, q}}),
    do: [%Formula{sign: :T, formula: p}, %Formula{sign: :F, formula: q}]

  defp expansion(%{sign: :T, formula: {:not, p}}), do: [%Formula{sign: :F, formula: p}, nil]

  defp expansion(%{sign: :F, formula: {:not, p}}), do: [%Formula{sign: :T, formula: p}, nil]

  defp expansion(_), do: []
end
