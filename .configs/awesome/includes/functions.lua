function maximize_all_clients()
  local t = awful.screen.focused().selected_tag

  local clients = t:clients()

  local s = not clients[1].maximized

  for p = 1, #clients do
    clients[p].maximized = s
  end
end
