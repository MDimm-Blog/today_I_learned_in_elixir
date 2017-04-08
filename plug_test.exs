defmodule PlugTest do
  use ExUnit.Case
  doctest Plug
#    setup do
#        Code.require_file("test/other.ex") 
#    end 

  test "the truth" do
    #assert 1 + 1  == 2
    IO.puts "foo" ; IEx.Helpers.c("/myplug.ex"); 
	assert {:ok, _} = Plug.Adapters.Cowboy.http MyPlug, [] #== {:ok, PID<0.180.0>}
	IO.puts "A unique and single instance is running!"
	:timer.sleep(1000); IO.puts "bar"
	IO.puts "hi"
  end
 
  test "should work" do    
    #IEx.Helpers.c "/myplug.ex" 
#== [MyPlug]
  end

end
