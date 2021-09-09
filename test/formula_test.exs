defmodule FormulaTest do
    use ExUnit.Case
     
    test "atomic formulas" do         
      assert AnalyticTableaux.Rules.apply_rule(%{sign: :T, formula: {:not, :p}}) == {:linear, [%AnalyticTableaux.Formula{sign: :F, formula: :p}, nil]}
      assert AnalyticTableaux.Rules.apply_rule(%{sign: :F, formula: {:not, :p}}) == {:linear, [%AnalyticTableaux.Formula{sign: :T, formula: :p}, nil]}
    end
    
    test "formulas 'and', 'or' and 'implies' (branch)" do
      assert AnalyticTableaux.Rules.apply_rule(%{sign: :F, formula: {:and, :p, :q}}) == {
          :branch, [
            %AnalyticTableaux.Formula{sign: :F, formula: :p},             
            %AnalyticTableaux.Formula{sign: :F, formula: :q}
          ]
      }
      assert AnalyticTableaux.Rules.apply_rule(%{sign: :T, formula: {:or, :p, :q}}) == {
        :branch, [
          %AnalyticTableaux.Formula{sign: :T, formula: :p},             
          %AnalyticTableaux.Formula{sign: :T, formula: :q}
        ]
      }
      assert AnalyticTableaux.Rules.apply_rule(%{sign: :T, formula: {:implies, :p, :q}}) == {
        :branch, [
          %AnalyticTableaux.Formula{sign: :F, formula: :p},             
          %AnalyticTableaux.Formula{sign: :T, formula: :q}
        ]
      }
    end

    test "formulas 'and', 'or' and 'implies' (linear)" do
      assert AnalyticTableaux.Rules.apply_rule(%{sign: :T, formula: {:and, :p, :q}}) == {
          :linear, [
            %AnalyticTableaux.Formula{sign: :T, formula: :p},             
            %AnalyticTableaux.Formula{sign: :T, formula: :q}
          ]
      }
      assert AnalyticTableaux.Rules.apply_rule(%{sign: :F, formula: {:or, :p, :q}}) == {
        :linear, [
          %AnalyticTableaux.Formula{sign: :F, formula: :p},             
          %AnalyticTableaux.Formula{sign: :F, formula: :q}
        ]
      }
      assert AnalyticTableaux.Rules.apply_rule(%{sign: :F, formula: {:implies, :p, :q}}) == {
        :linear, [
          %AnalyticTableaux.Formula{sign: :T, formula: :p},             
          %AnalyticTableaux.Formula{sign: :F, formula: :q}
        ]
      }
    end
end