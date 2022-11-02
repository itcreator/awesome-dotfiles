--      ███╗   ███╗██╗██████╗  █████╗  ██████╗ ███████╗
--      ████╗ ████║██║██╔══██╗██╔══██╗██╔════╝ ██╔════╝
--      ██╔████╔██║██║██████╔╝███████║██║  ███╗█████╗
--      ██║╚██╔╝██║██║██╔══██╗██╔══██║██║   ██║██╔══╝
--      ██║ ╚═╝ ██║██║██║  ██║██║  ██║╚██████╔╝███████╗
--      ╚═╝     ╚═╝╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝

-- ===================================================================
-- Initialization
-- ===================================================================


local awful = require("awful")
local gears = require("gears")

local mirage = {}


-- ===================================================================
-- Mirage setup
-- ===================================================================

--function create_plugin()
--   local buttons_example = wibox {
--      visible = true,
--      bg = '#2E3440',
--      ontop = true,
--      height = 100,
--      width = 200,
--      shape = function(cr, width, height)
--         gears.shape.rounded_rect(cr, width, height, 3)
--      end
--   }
--   --
--   --local button = wibox.widget{
--   --   {
--   --      {
--   --         text = "I'm a button!",
--   --         widget = wibox.widget.textbox
--   --      },
--   --      top = 4, bottom = 4, left = 8, right = 8,
--   --      widget = wibox.container.margin
--   --   },
--   --   bg = '#4C566A', -- basic
--   --   bg = '#00000000', --tranparent
--   --   shape_border_width = 1, shape_border_color = '#4C566A', -- outline
--   --   shape = function(cr, width, height)
--   --      gears.shape.rounded_rect(cr, width, height, 4)
--   --   end,
--   --   widget = wibox.container.background
--   --}
--   --
--   buttons_example:setup {
--      --button,
--      valigh = 'center',
--      layout = wibox.layout.align.vertical
--   }
--
--   return buttons_example
--end
--
--
--
--awful.screen.connect_for_each_screen(function(s)
--   naughty.notify({text = tostring(s.index)})
--   awful.placement.top(create_plugin(), { margins = {top = 400}, parent = s})
--end)

mirage.initialize = function()
   -- Set Wallpaper
   --gears.wallpaper.maximized(gears.filesystem.get_configuration_dir() .. "/wallpaper/mirage.png")

   -- Import components
   require("components.exit-screen")
   require("components.volume-adjust")
   require("components.titlebar")

   -- Import panels
   local top_panel = require("components.top-panel")

   local icon_dir = gears.filesystem.get_configuration_dir() .. "/icons/tags/mirage/"
   -- Set up each screen (add tags & panels)
   awful.screen.connect_for_each_screen(function(s)
      for i = 1, 9, 1
      do
         awful.tag.add(i, {
            icon = icon_dir .. i .. ".png",
            icon_only = true,
            layout = awful.layout.suit.tile,
            screen = s,
            selected = i == 1
         })
      end

      -- Add the top panel to every screen
      top_panel.create(s)
   end)

   -- set initally selected tag to be active
   local initial_tag = awful.screen.focused().selected_tag
   awful.tag.seticon(icon_dir .. initial_tag.name .. ".png", initial_tag)

   -- updates tag icons
   local function update_tag_icons()
      -- get a list of all tags
      local atags = awful.screen.focused().tags

      -- update each tag icon
      for i, t in ipairs(atags) do
         -- don't update active tag icon
         if t == awful.screen.focused().selected_tag then
            goto continue
         end
         -- if the tag has clients use busy icon
         for _ in pairs(t:clients()) do
            awful.tag.seticon(icon_dir .. t.name .. "-busy.png", t)
            goto continue
         end
         -- if the tag has no clients use regular inactive icon
         awful.tag.seticon(icon_dir .. t.name .. "-inactive.png", t)

         ::continue::
      end
   end

   -- Update tag icons when tag is switched
   tag.connect_signal("property::selected", function(t)
      -- set newly selected tag icon as active
      awful.tag.seticon(icon_dir .. t.name .. ".png", t)
      update_tag_icons()
   end)
   -- Update tag icons when a client is moved to a new tag
   tag.connect_signal("tagged", function(c)
      update_tag_icons()
   end)
end

return mirage
