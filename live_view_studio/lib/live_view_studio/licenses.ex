defmodule LiveViewStudio.Licenses do

  def amount(seats) do
    if(seats < 5) do
      seats * 20
    else
      100 + (seats - 5) * 15
    end
  end
end
