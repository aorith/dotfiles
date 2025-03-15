local wezterm = require("wezterm")
local config = wezterm.config_builder()
config:set_strict_mode(true)

wezterm.GLOBAL.is_linux = wezterm.target_triple:find("linux") ~= nil

require("bindings").apply(config)
require("appearance").apply(config)

if not wezterm.GLOBAL.is_linux then config.front_end = "WebGpu" end

config.max_fps = 160
config.scrollback_lines = 500
config.check_for_updates = false
config.window_padding = {
  left = 4,
  right = 4,
  top = 4,
  bottom = 4,
}

wezterm.on("open-uri", function(window, pane, uri)
  local editor = "nvim"
  -- wezterm.log_info(uri)

  if uri:find("^file:") == 1 then
    -- uri format is: file://[HOSTNAME]/PATH[#linenr]
    local url = wezterm.url.parse(uri)

    -- figure out what kind of file we're dealing with
    local success, stdout, _ = wezterm.run_child_process({ "file", url.file_path })
    if success then
      if stdout:find("directory") then
        pane:send_text(
          wezterm.shell_join_args({ "cd", url.file_path }) .. "\r" .. wezterm.shell_join_args({ "ls", "-a", "-p", "--group-directories-first" }) .. "\r"
        )
        return false
      end

      if stdout:find("text") then
        if url.fragment then
          pane:send_text(wezterm.shell_join_args({ editor, "+" .. url.fragment, url.file_path }) .. "\r")
        else
          pane:send_text(wezterm.shell_join_args({ editor, url.file_path }) .. "\r")
        end
        return false
      end
    end
  end

  -- without a return value, we allow default actions
end)

return config
