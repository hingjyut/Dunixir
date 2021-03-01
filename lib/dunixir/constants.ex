defmodule Constants do
  def version, do: "1.0"
  def forkWindowSize, do: 10
  def sandboxTxSize, do: 200
  def sandboxIdSize, do: 5000
  def sandboxMemberSize, do: 5000
  def medianTime, do: 10
  def msValidity, do: 10
  def msPeriod, do: 10
  def sigValidity, do: 10
  def sigPeriod, do: 10
  def sigReplay, do: 10
end

defmodule Constants.Contract do
  def c, do: 0.007376575
  def dt, do: 30.4375 * 24 * 3600
  def dtReeval, do: 30.4375 * 24 * 3600
  def ud0, do: 100
  def stepMax, do: 3
  def msValidity, do: 3600 * 24 * 365
  def sigValidity, do: 3600 * 24 * 365
  def sigPeriod, do: 0
  def sigReplay, do: 0
  def sigWindow, do: 3600 * 24 * 7
  def sigQty, do: 5
  def xpercent, do: 0.9
  def percentRot, do: 2/3
  def powDelay, do: 0
  def avgGenTime, do: 16 * 60
  def dtDiffEval, do: 10
  def medianTimeBlocks, do: 20
  def forSize, do: 100
  def switchOnHeadAdvance, do: 3
  def nonWoTPeersLimit, do: 100
  def txsMempoolSize, do: 200
  def sigStock, do: 40
  def idtyWindow, do: 3600 * 24 * 7
  def msWindow, do: 3600 * 24 * 7
end

defmodule Constants.PoW do
  def cpu, do: 0.6
  def prefix, do: 1
end
