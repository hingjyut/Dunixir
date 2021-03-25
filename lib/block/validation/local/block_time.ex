defmodule Block.Validation.Local.BlockTime do
  require Logger

  # @default_avg_gen_time 16 * 60
  # @pow_difficulty_range_ratio 1.189
  # @median_time_blocks 20
  def valid(block) do
    time = block["time"]
    median_time = block["medianTime"]

    cond do
      block["number"] > 0 and (time < median_time or time > median_time + max_acceleration()) ->
        Logger.error(
          "A block must have its Time between MedianTime and MedianTime" <>
            to_string(max_acceleration())
        )

        false

      block["number"] == 0 and time != median_time ->
        Logger.error("Root block must have Time equal to MedianTime")
        false

      true ->
        true
    end
  end

  defp max_acceleration() do
    max_gen_time = Float.ceil(Constants.Contract.avgGenTime() * Constants.powDifficultyRangeRatio())
    Float.ceil(max_gen_time * Constants.Contract.medianTimeBlocks())
  end
end
