defmodule JSON.LD.TestSuite.ExpandTest do
  use ExUnit.Case, async: false

  import JSON.LD.TestSuite

  setup_all do
    [base_iri: manifest("expand")["baseIri"]]
  end

  test_cases("expand")
  |> Enum.each(fn %{"name" => name, "input" => input} = test_case ->
      @tag :test_suite
      @tag :expand_test_suite
      @tag data: test_case
      test "#{input}: #{name}",
          %{data: %{"input" => input, "expect" => output} = test_case, base_iri: base_iri} do
        assert JSON.LD.expand(j(input), test_case_options(test_case, base_iri)) == j(output)
      end
    end)

end
