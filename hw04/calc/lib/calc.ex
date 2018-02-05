defmodule Calc do
  @moduledoc """
  This module is for HW4 in Nat Tuck's Web Dev class.
  Calc is a four-function calculator which takes
  parentheses and order of operations into account.

  Currently broken for all operations involving multiplication
  and division and parentheses because I can't figure out how 
  to have add_sub or mult_div actually return a value. Works
  for any number of additions and subtractions with any spaces.
  Does not throw errors for invalid syntax.

  Author: William Coconato
  Date: 2/3/18
  """

  #Parses and evaluates an arithmetic expression from a string
  def eval(expression) do
    str_exp = no_spaces(expression)
    parse(str_exp, String.length(str_exp)-1, 0)
  end

  #Repeatedly prints a prompt, reads one line, evaluates it,
  # and prints the result
  def main() do
    #Taken from Nat Tuck's lecture notes 07-elixir/rw.exs
    case IO.gets(">") do
      {:error, reason} ->
        IO.puts "Error: #{reason}"
      exp ->
        eval(exp)
        main()
    end
  end

  #Gets rid of all spaces in the string
  defp no_spaces(exp) do
    String.split(exp)
    |> List.to_string
  end

  defp parse(expression, loops, index) do
    expression = parens_first(expression, index, String.length(expression))
    tokens = split_operator(expression, loops, [index, index], [])
    tokens = mult_div(tokens, 0, Enum.count(tokens))
    add_sub(tokens, 0, Enum.count(tokens))
  end

  #Checks for any expression inside parentheses
  defp parens_first(expression, index, len) when index < len do
    left = String.at(expression, index)
    if left == "(" do
      num_loops = String.length(expression)-1
      last = parens_end(expression, num_loops, index)
      paren_exp = String.slice(expression, (index+1)..(last-1))
      exp_len = String.length(paren_exp)-1
      val = parse(paren_exp, exp_len, 0)
      new_str = String.slice(expression, 0..(index-1)) <> val
      expression = new_str <> String.slice(expression, (last+1)..-1)
    else
      parens_first(expression, index+1, len)
    end
    expression
  end

  #Return the expression
  defp parens_first(expression, index, len) when index == len do
    expression
  end

  #If there are no closing parentheses, act as though there is one
  # at the end of the string
  defp parens_end(expression, loops, index) when loops == index do
    String.length(expression)-1
  end

  #Returns the index of the expression of the right-most closing
  # parenthesis
  defp parens_end(expression, loops, index) when loops > index do
    right = String.at(expression, loops)
    if right == ")" do
      loops
    else
      parens_end(expression, loops-1, index)
    end
  end

  #Splits the given expression into a list(acc) of numbers separated
  # by operators
  defp split_operator(expression, loops, index, acc) when loops > 0 do
    char = String.at(expression, Enum.at(index, 0))
    [new_acc, new_idx] = operators(char, expression, index, acc)
    index = [Enum.at(new_idx, 0)+1, Enum.at(new_idx, 1)]
    split_operator(expression, loops-1, index, new_acc)
  end

  #Returns the accumulator
  defp split_operator(expression, loops, index, acc) when loops == 0 do
    cur_idx = Enum.at(index, 0)
    num_idx = Enum.at(index, 1)
    left = String.slice(expression, num_idx..cur_idx)
    acc ++ [left]
  end

  #Grabs the numbers before the operator and the operator and adds
  # them to the accumulator, number and operator are separate
  defp operators(char, expression, index, acc) do
    if (char == "+") || (char == "-") || (char == "*") || (char == "/") do
      cur_idx = Enum.at(index, 0)
      num_idx = Enum.at(index, 1)
      left = String.slice(expression, num_idx..(cur_idx-1))
      op = String.at(expression, cur_idx)
      acc = acc ++ [left, op]
      new_num_idx = cur_idx + 1
      new_idx = [cur_idx, new_num_idx]
      [acc, new_idx]
    else
      [acc, index]
    end
  end

  #Iterates over the list, when it finds * or / computes the value
  # and replaces in the list
  defp mult_div(tokens, index, len) when index < len do
    element = Enum.at(tokens, index)
    if element == "*" do
      left = Enum.at(tokens, index-1)
      |> Float.parse()
      |> elem(0)
      right = Enum.at(tokens, index+1)
      |> Float.parse()
      |> elem(0)
      new_val = left*right
                |> Float.to_string()
      new_tok = List.delete_at(tokens, index-1)
      |> List.delete_at(index-1)
      |> List.replace_at(index-1, new_val)
      mult_div(new_tok, index, Enum.count(new_tok))
    end
    if element == "/" do
      left = Enum.at(tokens, index-1)
      |> Float.parse()
      |> elem(0)
      right = Enum.at(tokens, index+1)
      |> Float.parse()
      |> elem(0)
      new_val = left/right
                |> Float.to_string()
      new_tok = List.delete_at(tokens, index-1)
      |> List.delete_at(index-1)
      |> List.replace_at(index-1, new_val)
      mult_div(new_tok, index, Enum.count(new_tok))
    end
    if element != "*" && element != "/" do
      mult_div(tokens, index+1, len)
    end
  end

  #Return the list of tokens with no * or / operators
  defp mult_div(tokens, index, len) when index == len do
    tokens
  end

  #Iterates over the list, when it finds + or - computes the value
  # and replaces in the list
  defp add_sub(tokens, index, len) when index < len do
    element = Enum.at(tokens, index)
    if element == "+" do
      left = Enum.at(tokens, index-1)
      |> Float.parse()
      |> elem(0)
      right = Enum.at(tokens, index+1)
      |> Float.parse()
      |> elem(0)
      new_val = left+right
                |> Float.to_string()
      new_tok = List.delete_at(tokens, index-1)
      |> List.delete_at(index-1)
      |> List.replace_at(index-1, new_val)
      add_sub(new_tok, index, Enum.count(new_tok))
    end
    if element == "-" do
      left = Enum.at(tokens, index-1)
      |> Float.parse()
      |> elem(0)
      right = Enum.at(tokens, index+1)
      |> Float.parse()
      |> elem(0)
      new_val = left-right
                |> Float.to_string()
      new_tok = List.delete_at(tokens, index-1)
      |> List.delete_at(index-1)
      |> List.replace_at(index-1, new_val)
      add_sub(new_tok, index, Enum.count(new_tok))
    end
    if element != "+" && element != "-" do
      add_sub(tokens, index+1, len)
    end
  end

  #Return the list of tokens with no + or - operators
  defp add_sub(tokens, index, len) when index == len do
    IO.puts(tokens)
    tokens
  end

end
