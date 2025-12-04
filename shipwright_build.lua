local lushwright = require("shipwright.transform.lush")

run(
    require("theme.catppuccin"),
    lushwright.to_lua,
    {patchwrite, "colors/catppuccin.lua", "-- PATCH_OPEN", "-- PATCH_CLOSE"}
)
