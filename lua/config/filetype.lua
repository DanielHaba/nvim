local options = {
    overrides = {
        function_extensions = {},
    },
}

local function image()
    vim.bo.filetype = "image"
end

for _, i in ipairs({ "png", "jpg", "jpeg", "bmp"}) do
    options.overrides.function_extensions[i] = image
end

return options
