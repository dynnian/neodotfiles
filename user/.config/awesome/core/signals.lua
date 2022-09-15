local gears = require("gears")

client.connect_signal("manage", function (c)
    c.shape = function(cr,w,h)
        gears.shape.rounded_rect(cr,w,h,10)
    end
end)
