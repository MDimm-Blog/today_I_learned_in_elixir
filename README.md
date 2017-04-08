# today_I_learned_in_elixir
basic things to bring up for discussion at jax.ex

<hr>
1.<br>
I was having a problem calling ... c function
to implement a test.
```
** (CompileError) test/plug_test.exs:6: undefined function c/1
```
changing the test file to ex will not work as described by Jose Valim

https://groups.google.com/forum/#!topic/elixir-lang-talk/M8hQumj_qF8
http://elixir-lang.readthedocs.io/en/latest/technical/scoping.html
```
defmodule TicTacToeTest do
  use ExUnit.Case

  test "prints a welcome message when the game start" do
    message = "Let's play Tic Tac Toe!"
    MockIO.write(message)
    assert message == MockIO.captured
  end
end
```

```
** (UndefinedFunctionError) undefined function: MockIO.write/1 (module MockIO is not available)
```	
10/10/14


I'm not claiming this is in any way the best or "right" solution, but this is what I used to test code that is outside the normal paths. 
```
defmodule TicTacToeTest do
  use ExUnit.Case
   
    setup do
        Code.require_file("test/mock_io.ex") 
    end 
end
```

- Booker C. Bense 

José Valim 	
10/10/14


Elixir can only *load* .beam files.

For the stuff in lib, everything ending with .ex is compiled to .beam files when you run mix compile. That's why when you start your app or run tests, we can find those modules.

However, for test, we don't compile the code, we load it dynamically. In this case, mix test is only going to load the test/test_helper.exs file and all files matching *_test.exs. Files in test are never compiled automatically (you could if you want) but it is easier to simply require the file with Code.require_file/1 as someone else posted.

<hr>
