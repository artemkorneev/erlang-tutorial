%%%-------------------------------------------------------------------
%%% @author tema
%%% @copyright (C) 2020, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. Feb 2020 11:43 PM
%%%-------------------------------------------------------------------
-module(tut8).
-author("tema").

%% API
-export([format_temps/1]).

format_temps(List_of_cities) ->
  Converted_list = convert_list_to_c(List_of_cities),
  print_temp(Converted_list),
  {Max_City, Min_City} = find_max_and_min(Converted_list),
  print_max_and_min(Max_City, Min_City).

convert_list_to_c([{Name, {f, F}} | Rest]) ->
  Converted_city = { Name, {c, (F-32) * 5 / 9}},
  [Converted_city | convert_list_to_c(Rest)];

convert_list_to_c([City|Rest]) ->
  [City|convert_list_to_c(Rest)];

convert_list_to_c([]) ->
  [].

print_temp([{City, {c, Temp}} | Rest]) ->
  io:format("~-15w ~w c~n", [City, Temp]),
  print_temp(Rest);

print_temp([]) ->
  ok.

find_max_and_min([City|Rest]) ->
  find_max_and_min(Rest, City, City).

find_max_and_min([{Name, {c, Temp}} | Rest],
                {Max_Name, {c, Max_Temp}},
                {Min_Name, {c, Min_Temp}}) ->
  if
    Temp > Max_Temp ->
      Max_City = {Name, {c, Temp}};
    true ->
      Max_City = {Max_Name, {c, Max_Temp}}
  end,

  if Temp < Min_Temp ->
      Min_City = {Name, {c, Temp}};
    true ->
      Min_City = {Min_Name, {c, Min_Temp}}
  end,
  find_max_and_min(Rest, Max_City, Min_City);

find_max_and_min([], Max_City, Min_Temp) ->
  {Max_City, Min_Temp}.

print_max_and_min({Max_Name, {c, Max_Temp}}, {Min_Name, {c, Min_Temp}}) ->
  io:format("Max temperature was ~w c in ~w~n", [Max_Temp, Max_Name]),
  io:format("Min temperature was ~w c in ~w~n", [Min_Temp, Min_Name]).