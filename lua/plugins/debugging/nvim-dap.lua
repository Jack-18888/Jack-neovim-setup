
return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
    keys = {
      { "<F5>", function() require("dap").continue() end, desc = "Debug: Start/Continue" },
      { "<F1>", function() require("dap").step_into() end, desc = "Debug: Step Into" },
      { "<F2>", function() require("dap").step_over() end, desc = "Debug: Step Over" },
      { "<F3>", function() require("dap").step_out() end, desc = "Debug: Step Out" },
      { "<leader>b", function() require("dap").toggle_breakpoint() end, desc = "Debug: Toggle Breakpoint" },
      { "<leader>B", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Debug: Set Breakpoint" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      local mason_nvim_dap = require("mason-nvim-dap")

      mason_nvim_dap.setup({
        automatic_installation = true,
        handlers = {},
        ensure_installed = { "cppdbg" },
      })

      -- Bypass OpenDebugAD7.CMD wrapper to prevent premature exit code 1
      local mason_path = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7.exe"

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = mason_path,
        options = {
          detached = false,
        },
      }

      local function compile_and_get_exe()
        -- Auto-save current file if modified
        if vim.bo.modified then
          vim.cmd("silent! write")
        end

        local src = vim.fn.expand("%:p")
        if src == "" then
          vim.notify("DAP: No active file to compile", vim.log.levels.ERROR, { title = "DAP" })
          return dap.ABORT
        end

        local exe = vim.fn.expand("%:p:r") .. ".exe"
        local is_c = (vim.bo.filetype == "c")
        local compiler = is_c and "gcc" or "g++"
        local cmd = { compiler, "-g", "-O0", src, "-o", exe }

        local co = coroutine.running()
        if co then
          local stderr_chunks = {}
          local stdout_chunks = {}
          vim.notify("Compiling " .. vim.fn.expand("%:t") .. "...", vim.log.levels.INFO, { title = "DAP" })
          local job = vim.fn.jobstart(cmd, {
            on_stdout = function(_, data)
              vim.list_extend(stdout_chunks, data)
            end,
            on_stderr = function(_, data)
              vim.list_extend(stderr_chunks, data)
            end,
            on_exit = function(_, exit_code)
              vim.schedule(function()
                if exit_code == 0 then
                  vim.notify("Compilation succeeded: " .. vim.fn.fnamemodify(exe, ":t"), vim.log.levels.INFO, { title = "DAP" })
                  coroutine.resume(co, vim.fs.normalize(exe))
                else
                  local err = table.concat(stderr_chunks, "\n")
                  if vim.trim(err) == "" then
                    err = table.concat(stdout_chunks, "\n")
                  end
                  vim.notify("Compilation failed:\n" .. vim.trim(err), vim.log.levels.ERROR, { title = "DAP" })
                  coroutine.resume(co, dap.ABORT)
                end
              end)
            end,
          })
          if job <= 0 then
            vim.notify("Failed to start compiler: " .. compiler, vim.log.levels.ERROR, { title = "DAP" })
            return dap.ABORT
          end
          return coroutine.yield()
        else
          vim.notify("Compiling " .. vim.fn.expand("%:t") .. "...", vim.log.levels.INFO, { title = "DAP" })
          local out = vim.fn.system(cmd)
          if vim.v.shell_error ~= 0 then
            vim.notify("Compilation failed:\n" .. vim.trim(out), vim.log.levels.ERROR, { title = "DAP" })
            return dap.ABORT
          end
          return vim.fs.normalize(exe)
        end
      end

      dap.configurations.cpp = {
        {
          name = "Compile & Launch active file",
          type = "cppdbg",
          request = "launch",
          program = compile_and_get_exe,
          cwd = "${fileDirname}",
          stopAtEntry = false,
          MIMode = "gdb",
          miDebuggerPath = "D:/msys64/ucrt64/bin/gdb.exe",
          setupCommands = {
            {
              text = "-enable-pretty-printing",
              description = "Enable pretty printing",
              ignoreFailures = true,
            },
          },
        },
      }
      dap.configurations.c = dap.configurations.cpp

      -- Dap UI setup
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

      -- Keymaps
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
      vim.keymap.set("n", "<F1>", dap.step_into, { desc = "Debug: Step Into" })
      vim.keymap.set("n", "<F2>", dap.step_over, { desc = "Debug: Step Over" })
      vim.keymap.set("n", "<F3>", dap.step_out, { desc = "Debug: Step Out" })
      vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
      vim.keymap.set("n", "<leader>B", function()
        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
      end, { desc = "Debug: Set Breakpoint" })
    end,
  },
}
