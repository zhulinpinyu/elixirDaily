defmodule LiveViewStudio.Sales do
  def new_orders do
    Enum.random(10..30)
  end

  def sales_amount do
    Enum.random(100..300)
  end

  def satisfication do
    Enum.random(90..100)
  end
end
