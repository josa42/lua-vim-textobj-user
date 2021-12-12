# Lua helper for [kana/vim-textobj-user](https://github.com/kana/vim-textobj-user)

## Usage

```lua
require('textobj-user').plugin("line", {
  ['-'] = {
    ['select-a'] = 'al',
    ['select-a-function'] = function()
      vim.cmd('normal! 0')
      local head = vim.fn.getpos('.')

      vim.cmd('normal! $')
      local tail = vim.fn.getpos('.')

      return { 'v', head, tail }
    end,
    ['select-i'] = 'il',
    ['select-i-function'] = function()
      vim.cmd('normal! ^')
      local head = vim.fn.getpos('.')

      vim.cmd('normal! g_')
      local tail = vim.fn.getpos('.')

      if vim.fn.getline('.'):sub(head[3], head[3]) ~= ' ' then
        return { 'v', head, tail }
      end

      return 0
    end
  },
})
```

## License

[MIT © Josa Gesell](LICENSE)
