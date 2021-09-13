defmodule ProveTest do
    use ExUnit.Case

    alias AnalyticTableaux.Prove

    test "prove" do
        assert Prove.prove("p -> q, p |- q") == {:valid, []}
        assert Prove.prove("p -> q, !q |- !p") == {:valid, []}
    end

end
