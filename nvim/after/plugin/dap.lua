local dap = require('dap');

dap.adapters.coreclr = {
    type = "executable",
    command = "/home/jayesh/.local/share/netcoredbg/netcoredbg",
    args = {"--interpreter=vscode"}
}

dap.configurations.cs = {
    {
        type = "coreclr",
        name = "launch - netcoredbg",
        request = "launch",
        program = function() 
            return vim.fn.input('Path to dll ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
    },
}
vim.keymap.set('n', '<F5>', function() dap.continue() end, { silent = true })
vim.keymap.set('n', '<F10>', function() dap.step_over() end, { silent = true })
vim.keymap.set('n', '<F11>', function() dap.step_into() end, { silent = true })
vim.keymap.set('n', '<F12>', function() dap.step_out() end, { silent = true })
vim.keymap.set('n', '<leader>dtb', function() dap.toggle_breakpoint() end, { silent = true })
vim.keymap.set('n', '<leader>dsbp', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { silent = true })
vim.keymap.set('n', '<leader>lp', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, { silent = true })
vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end, { silent = true })
vim.keymap.set('n', '<leader>dl', function() dap.run_last() end, { silent = true })

