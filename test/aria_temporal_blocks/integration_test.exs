# SPDX-License-Identifier: MIT
# Copyright (c) 2025-present K. S. Ernest (iFire) Lee

defmodule AriaTemporalBlocks.IntegrationTest do
  use ExUnit.Case

  alias AriaTemporalBlocks.Domain
  alias AriaHybridPlanner

  @tag :integration
  test "temporal logging integration with AriaHybridPlanner" do
    # Create domain and initial state
    domain = Domain.create()

    state = AriaState.new()
    |> AriaState.set_fact("block_a", "pos", "table")
    |> AriaState.set_fact("block_a", "clear", true)
    |> AriaState.set_fact("block_b", "pos", "table")
    |> AriaState.set_fact("block_b", "clear", true)
    |> AriaState.set_fact("hand", "holding", false)

    # Define planning goals
    todos = [
      {"pos", "block_a", "block_b"},  # Put block_a on block_b
      {:wait, [2.0]}                  # Wait for 2 seconds
    ]

    # Enable debug logging and plan with temporal logging
    import ExUnit.CaptureLog

    log = capture_log([level: :debug], fn ->
      # Use run_lazy which does both planning and execution
      case AriaHybridPlanner.run_lazy(domain, state, todos, verbose: 1) do
        {:ok, {solution_tree, _final_state}} ->
          # Log the planned timeline explicitly after execution
          AriaTemporalBlocks.TimeLogger.log_planned_timeline(solution_tree, domain)
        {:error, reason} ->
          IO.puts("Planning/execution failed: #{reason}")
      end
    end)

    # Verify that both planned timeline and execution timing logs were generated
    assert log =~ "=== PLANNED TIMELINE ==="
    assert log =~ "Total planned duration:"
    assert log =~ "Actions sequence:"
    assert log =~ "=== END PLANNED TIMELINE ==="

    # Should contain action names in the timeline
    assert log =~ "pickup"
    assert log =~ "stack"
    assert log =~ "wait"

    # Should show the wait action with parametric duration
    assert log =~ "wait(2.0)"
    
    # Should show proper durations
    assert log =~ "[2.0s]"  # pickup duration
    assert log =~ "[3.0s]"  # stack duration
  end
end
