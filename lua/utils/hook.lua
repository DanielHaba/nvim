return function (module, fn)
  if package.loaded[module] then
    return fn(package.loaded[module])
  end

  package.preload[module] = function()
    package.preload[module] = nil
    for _, loader in pairs(package.loaders) do
      local ret = loader(module)
      if type(ret) == "function" then
        local mod = ret()
        fn(mod)
        return mod
      end
    end
  end
end
