defmodule AnalyticTableauxTest do
  use ExUnit.Case

  alias AnalyticTableaux.Valuator
  import AnalyticTableaux

  TestHelpers.SequentExamples.valid()
  |> Enum.each(fn sequent ->
    @tag sequent: sequent
    @tag :pending
    test "The sequent #{sequent} is valid", context do
      assert AnalyticTableaux.Prove.prove(context.sequent).status == :valid
    end
  end)

  TestHelpers.SequentExamples.invalid()
  |> Enum.each(fn sequent ->
    @tag sequent: sequent
    @tag :pending
    test "The sequent #{sequent} is NOT valid", context do
      assert AnalyticTableaux.Prove.prove(context.sequent).status == :not_valid
    end
  end)

end
