--      ████████╗██╗████████╗██╗     ███████╗██████╗  █████╗ ██████╗
--      ╚══██╔══╝██║╚══██╔══╝██║     ██╔════╝██╔══██╗██╔══██╗██╔══██╗
--         ██║   ██║   ██║   ██║     █████╗  ██████╔╝███████║██████╔╝
--         ██║   ██║   ██║   ██║     ██╔══╝  ██╔══██╗██╔══██║██╔══██╗
--         ██║   ██║   ██║   ███████╗███████╗██████╔╝██║  ██║██║  ██║
--         ╚═╝   ╚═╝   ╚═╝   ╚══════╝╚══════╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝

-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local wibox = require("wibox")
local dpi = require("beautiful").xresources.apply_dpi


-- ===================================================================
-- Titlebar Creation
-- ===================================================================


-- Add a titlebar
client.connect_signal("request::titlebars", function(c)
   local titlebar = awful.titlebar(c, {
      size = dpi(20)
   })

   titlebar: setup {
      { -- Left
         wibox.layout.margin(awful.titlebar.widget.iconwidget(c), dpi(5), dpi(1), dpi(1), dpi(1)),
         buttons = buttons,
         layout  = wibox.layout.fixed.horizontal
      },
      { -- Middle
         { -- Title
            align  = "center",
            widget = awful.titlebar.widget.titlewidget(c)
         },
         buttons = buttons,
         layout  = wibox.layout.flex.horizontal
      },
      { -- Right
         -- AwesomeWM native buttons (images loaded from theme)
         awful.titlebar.widget.floatingbutton (c),
         awful.titlebar.widget.stickybutton   (c),
         awful.titlebar.widget.ontopbutton    (c),
         wibox.layout.margin(awful.titlebar.widget.minimizebutton(c), dpi(4), dpi(1), dpi(1), dpi(1)),
         wibox.layout.margin(awful.titlebar.widget.maximizedbutton(c), dpi(4), dpi(1), dpi(1), dpi(1)),
         wibox.layout.margin(awful.titlebar.widget.closebutton(c), dpi(11), dpi(1), dpi(1), dpi(1)),
         layout = wibox.layout.fixed.horizontal
      },
      layout = wibox.layout.align.horizontal
   }
end)
