local M = {}
local l = {}

l.fn_idx = 0

M.fn = {}

function M.plugin(name, spec)
  vim.fn['textobj#user#plugin'](name, l.wrap(spec))
end

function l.wrap(spec)
  local t = type(spec)

  if t == 'table' then
    for key, value in pairs(spec) do
      spec[key] = l.wrap(value)
    end
  elseif t == 'function' then
    return l.wrapFn(spec)
  end

  return spec
end

function l.wrapFn(fn)
  l.fn_idx = l.fn_idx + 1
  local name = 'fn_' .. l.fn_idx

  M.fn[name] = fn

  vim.cmd([[
    function! Textobj_]] .. name .. [[()
      return v:lua.require('textobj-user').fn.]] .. name .. [[()
    endfunction
  ]])

  return 'Textobj_' .. name
end

return M
