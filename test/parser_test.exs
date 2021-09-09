defmodule ParserTest do
    use ExUnit.Case

    test "parse sequent with no premise |-p and |-q:" do    
      assert AnalyticTableaux.Parser.parse("|-p") == [
        %AnalyticTableaux.Formula{formula: :p, sign: :F}
      ]
      assert AnalyticTableaux.Parser.parse("|-q") == [
        %AnalyticTableaux.Formula{formula: :q, sign: :F}
      ]      
    end

    test "parses a simple sequent" do
      assert AnalyticTableaux.Parser.parse("p |- q") == [       
        %AnalyticTableaux.Formula{formula: :p, sign: :T},
        %AnalyticTableaux.Formula{formula: :q, sign: :F}
      ]
    end

    test "sequent with multiple atomic premises and conclusions: p,r |- q" do
      assert AnalyticTableaux.Parser.parse("p, r |- q") == [
        %AnalyticTableaux.Formula{formula: :p, sign: :T},
        %AnalyticTableaux.Formula{formula: :r, sign: :T},
        %AnalyticTableaux.Formula{formula: :q, sign: :F}
      ]
    end
  
    test "should parse binary formulas with atomic children" do
      assert AnalyticTableaux.Parser.parse("|- (p & q)") == [
        %AnalyticTableaux.Formula{formula: {:and, :p, :q}, sign: :F}
      ]
      assert AnalyticTableaux.Parser.parse("|- (p | q)") == [
        %AnalyticTableaux.Formula{formula: {:or, :p, :q}, sign: :F}
      ]
      assert AnalyticTableaux.Parser.parse("|- (p -> q)") == [
        %AnalyticTableaux.Formula{formula: {:implies, :p, :q}, sign: :F}
      ]
    end

end