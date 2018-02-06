defmodule Calc do
  @moduledoc """
  This module is for HW4 in Nat Tuck's Web Dev class.
  Calc is a four-function calculator which takes
  parentheses and order of operations into account.
  Author: William Coconato
  Date: 2/3/18
  """

  #Parses and evaluates an arithmetic expression from a string
  def eval(expression) do
    str_exp = no_spaces(expression)
    final = parse(str_exp)
    |> Enum.at(0)
    IO.puts(final)
    final
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

  defp parse(expression) do
    loops = String.length(expression)-1
    new_exp = parens_first(expression, 0, String.length(expression))
    tokens = split_operator(new_exp, loops, [loops, loops], [])
    tokens = mult_div(tokens, 0, Enum.count(tokens)-1)
    add_sub(tokens, 0, Enum.count(tokens)-1)
  end

  #Checks for any expression inside parentheses
  defp parens_first(expression, index, len) when index < len do
    first = String.at(expression, 0)
    if first == "*" || first == "/" || first == "-" || first == "+" do
      IO.puts "Error: Operation at beginning of string!"
    end
    last = String.at(expression, -1)
    if last == "*" || last == "/" || last == "-" || last == "+" do
      IO.puts "Error: Operation at end of string!"
    end

    left = String.at(expression, index)
    left_paren?(left, expression, index)
  end

  #Return the expression
  defp parens_first(expression, index, len) when index == len do
    expression
  end

  #Checks if the given string is the left parenthesis, and if so
  # grabs everything until the end of the parentheses
  defp left_paren?("(", expression, index) do
    num_loops = String.length(expression)-1
    last = parens_end(expression, num_loops, index)
    paren_exp = String.slice(expression, (index+1)..(last-1))
    val = parse(paren_exp)
          |> Enum.at(0)
          |> Float.to_string()
    paren_string(expression, val, index, last, num_loops)
  end
  defp left_paren?(_, expression, index) do
    parens_first(expression, index+1, String.length(expression))
  end

  defp paren_string(expression, val, 0, last, num_loops) when last != num_loops do
    val <> String.slice(expression, (last+1)..-1)
  end
  defp paren_string(_, val, 0, last, num_loops) when last == num_loops do
    val
  end
  defp paren_string(expression, val, index, last, _) do
    new_str = String.slice(expression, 0..(index-1)) <> val
    new_str <> String.slice(expression, (last+1)..-1)
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
    index = [Enum.at(new_idx, 0)-1, Enum.at(new_idx, 1)]
    split_operator(expression, loops-1, index, new_acc)
  end

  #Returns the accumulator
  defp split_operator(expression, loops, index, acc) when loops == 0 do
    cur_idx = Enum.at(index, 0)
    num_idx = Enum.at(index, 1)
    left = String.slice(expression, cur_idx..num_idx)
           |> Float.parse()
           |> elem(0)
    acc ++ [left]
  end

  #Grabs the numbers before the operator and the operator and adds
  # them to the accumulator, number and operator are separate
  defp operators(char, expression, index, acc) do
    if (char == "+") || (char == "-") || (char == "*") || (char == "/") do
      cur_idx = Enum.at(index, 0)
      num_idx = Enum.at(index, 1)
      left = String.slice(expression, (cur_idx+1)..num_idx)
      |> Float.parse()
      |> elem(0)
      op = String.at(expression, cur_idx)
      acc = [op] ++ acc
      acc = acc ++ [left]
      new_num_idx = cur_idx - 1
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
    left = Enum.at(tokens, len)
    right = Enum.at(tokens, len-1)
    md_op(element, left, right, tokens, index, len)
  end

  #Return the list of tokens with no * or / operators
  defp mult_div(tokens, index, len) when index == len do
    tokens
  end

  defp md_op("*", left, right, tokens, index, len) do
    new_val = left*right
    tokens = List.delete_at(tokens, index)
             |> List.delete_at(len-1)
             |> List.replace_at(len-2, new_val)
    mult_div(tokens, index, len-2)
  end
  defp md_op("/", left, right, tokens, index, len) do
    new_val = left/right
    tokens = List.delete_at(tokens, index)
             |> List.delete_at(len-1)
             |> List.replace_at(len-2, new_val)
    mult_div(tokens, index, len-2)
  end
  defp md_op(_, _, _, tokens, index, len) do
    mult_div(tokens, index+1, len-1)
  end

  #Iterates over the list, when it finds + or - computes the value
  # and replaces in the list
  defp add_sub(tokens, index, len) when index < len do
    element = Enum.at(tokens, index)
    left = Enum.at(tokens, len)
    right = Enum.at(tokens, len-1)
    as_op(element, left, right, tokens, index, len)
  end

  #Return the list of tokens with no + or - operators
  defp add_sub(tokens, index, len) when index == len do
    tokens
  end

  defp as_op("+", left, right, tokens, index, len) do
    new_val = left+right
    tokens = List.delete_at(tokens, index)
             |> List.delete_at(len-1)
             |> List.replace_at(len-2, new_val)
    add_sub(tokens, index, len-2)
  end
  defp as_op("-", left, right, tokens, index, len) do
    new_val = left-right
    tokens = List.delete_at(tokens, index)
             |> List.delete_at(len-1)
             |> List.replace_at(len-2, new_val)
    add_sub(tokens, index, len-2)
  end
  defp as_op(_, _, _, tokens, index, len) do
    add_sub(tokens, index+1, len-1)
  end

end
