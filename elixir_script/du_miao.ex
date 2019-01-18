defmodule DuMiao do
  def count(0) do
    IO.write("\r开抢...")
  end

  def count(current) do
    IO.write("\r还有 #{current} 秒")
    Process.sleep(1000)
    count(current - 1)
  end
end

DuMiao.count(10)
