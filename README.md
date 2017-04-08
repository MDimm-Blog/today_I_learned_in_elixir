# today_I_learned_in_elixir
basic things to bring up for discussion at jax.ex

<hr>
<br>
3.<br>
sockets/session in pheonix and elixir

<hr>
<br>
2.<br>
note regarding ... seperating concerns for tests in a mix project.<br>
to be recognized files need to include the .exs extension. .ex is not recognized.<br>
files also need "filename_test.exs" as ending.
This lets the mix project know what are tests in the test folder.

<hr>
1.<br>

I was having a problem calling ... c function
to implement a test.
<pre>
** (CompileError) test/plug_test.exs:6: undefined function c/1
</pre>

I figured it out!!

In the test I had to call:

<pre>
IEx.Helpers.c "filename"
</pre>
 
instead of:
<pre>
c "filename"
</pre>

changing the test file to ex will not work as described by Jose Valim

https://groups.google.com/forum/#!topic/elixir-lang-talk/M8hQumj_qF8
http://elixir-lang.readthedocs.io/en/latest/technical/scoping.html
https://media.pragprog.com/titles/elixir/ElixirCheat.pdf
https://hexdocs.pm/iex/IEx.Helpers.html#c/2```
defmodule TicTacToeTest do
  use ExUnit.Case

  test "prints a welcome message when the game start" do
    message = "Let's play Tic Tac Toe!"
    MockIO.write(message)
    assert message == MockIO.captured
  end
end

<pre>
** (UndefinedFunctionError) undefined function: MockIO.write/1 (module MockIO is not available)
</pre>	
10/10/14


I'm not claiming this is in any way the best or "right" solution, but this is what I used to test code that is outside the normal paths. 
<pre>
defmodule TicTacToeTest do
  use ExUnit.Case
   
    setup do
        Code.require_file("test/mock_io.ex") 
    end 
end
</pre>

- Booker C. Bense 

José Valim 	
10/10/14

Elixir can only *load* .beam files.

For the stuff in lib, everything ending with .ex is compiled to .beam files when you run mix compile. That's why when you start your app or run tests, we can find those modules.

However, for test, we don't compile the code, we load it dynamically. In this case, mix test is only going to load the test/test_helper.exs file and all files matching *_test.exs. Files in test are never compiled automatically (you could if you want) but it is easier to simply require the file with Code.require_file/1 as someone else posted.
<hr>
