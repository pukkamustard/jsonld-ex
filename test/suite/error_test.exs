defmodule JSON.LD.TestSuite.ErrorTest do
  use ExUnit.Case, async: false

  import JSON.LD.TestSuite

  setup_all do
    [base_iri: manifest("error")["baseIri"]]
  end

  test_cases("error")
  |> Enum.each(fn %{"name" => name, "input" => input} = test_case ->
      if input in ~w[error-0002-in.jsonld error-0003-in.jsonld error-0004-in.jsonld error-0005-in.jsonld] do
        @tag skip: "TODO: remote contexts not implemented yet"
      end
      @tag :test_suite
      @tag :flatten_test_suite
      @tag :error_test
      @tag data: test_case
      test "#{input}: #{name}",
          %{data: %{"input" => input, "expect" => error} = test_case, base_iri: base_iri} do
        context =
          case test_case["context"] do
            nil     -> nil
            context -> j(context)
          end

        assert_raise exception(error), fn ->
          JSON.LD.flatten(j(input), context, test_case_options(test_case, base_iri))
        end

      end
    end)

end
