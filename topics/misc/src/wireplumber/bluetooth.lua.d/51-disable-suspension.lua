-- Note: bluez_monitor, not alsa_monitor
table.insert (bluez_monitor.rules, {
  matches = {
    {
      -- Matches all sources.
      -- Note: bluez_input, not alsa_input
      { "node.name", "matches", "bluez_input.*" },
    },
    {
      -- Matches all sinks.
      -- Note: bluez_output, not alsa_output
      { "node.name", "matches", "bluez_output.*" },
    },
  },
  apply_properties = {
    ["session.suspend-timeout-seconds"] = 0,  -- 0 disables suspend
  },
})
