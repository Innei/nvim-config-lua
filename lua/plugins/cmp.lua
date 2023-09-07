local icons = {
  Keyword = "󰌋",
  Operator = "󰆕",

  Text = "",
  Value = "󰎠",
  Constant = "󰏿",

  Method = "",
  Function = "󰊕",
  Constructor = "",

  Class = "",
  Interface = "",
  Module = "",

  Variable = "",
  Property = "󰜢",
  Field = "󰜢",

  Struct = "󰙅",
  Enum = "",
  EnumMember = "",

  Snippet = "",

  File = "",
  Folder = "",

  Reference = "󰈇",
  Event = "",
  Color = "",
  Unit = "󰑭",
  TypeParameter = "",
}

return {
  {
    "petertriho/cmp-git",
    event = "VeryLazy",
    config = function()
      local format = require("cmp_git.format")
      local sort = require("cmp_git.sort")

      require("cmp_git").setup({
        -- defaults
        filetypes = { "gitcommit", "octo", "NeogitCommitMessage" },
        remotes = { "upstream", "origin" }, -- in order of most to least prioritized
        enableRemoteUrlRewrites = false, -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
        git = {
          commits = {
            limit = 100,
            sort_by = sort.git.commits,
            format = format.git.commits,
          },
        },
        github = {
          hosts = {}, -- list of private instances of github
          issues = {
            fields = { "title", "number", "body", "updatedAt", "state" },
            filter = "all", -- assigned, created, mentioned, subscribed, all, repos
            limit = 100,
            state = "open", -- open, closed, all
            sort_by = sort.github.issues,
            format = format.github.issues,
          },
          mentions = {
            limit = 100,
            sort_by = sort.github.mentions,
            format = format.github.mentions,
          },
          pull_requests = {
            fields = { "title", "number", "body", "updatedAt", "state" },
            limit = 100,
            state = "open", -- open, closed, merged, all
            sort_by = sort.github.pull_requests,
            format = format.github.pull_requests,
          },
        },
        gitlab = {
          hosts = {}, -- list of private instances of gitlab
          issues = {
            limit = 100,
            state = "opened", -- opened, closed, all
            sort_by = sort.gitlab.issues,
            format = format.gitlab.issues,
          },
          mentions = {
            limit = 100,
            sort_by = sort.gitlab.mentions,
            format = format.gitlab.mentions,
          },
          merge_requests = {
            limit = 100,
            state = "opened", -- opened, closed, locked, merged
            sort_by = sort.gitlab.merge_requests,
            format = format.gitlab.merge_requests,
          },
        },
        trigger_actions = {
          {
            debug_name = "git_commits",
            trigger_character = ":",
            action = function(sources, trigger_char, callback, params, git_info)
              return sources.git:get_commits(callback, params, trigger_char)
            end,
          },
          {
            debug_name = "gitlab_issues",
            trigger_character = "#",
            action = function(sources, trigger_char, callback, params, git_info)
              return sources.gitlab:get_issues(callback, git_info, trigger_char)
            end,
          },
          {
            debug_name = "gitlab_mentions",
            trigger_character = "@",
            action = function(sources, trigger_char, callback, params, git_info)
              return sources.gitlab:get_mentions(callback, git_info, trigger_char)
            end,
          },
          {
            debug_name = "gitlab_mrs",
            trigger_character = "!",
            action = function(sources, trigger_char, callback, params, git_info)
              return sources.gitlab:get_merge_requests(callback, git_info, trigger_char)
            end,
          },
          {
            debug_name = "github_issues_and_pr",
            trigger_character = "#",
            action = function(sources, trigger_char, callback, params, git_info)
              return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
            end,
          },
          {
            debug_name = "github_mentions",
            trigger_character = "@",
            action = function(sources, trigger_char, callback, params, git_info)
              return sources.github:get_mentions(callback, git_info, trigger_char)
            end,
          },
        },
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = { "hrsh7th/cmp-emoji", "zbirenbaum/copilot.lua", "petertriho/cmp-git" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")
      opts.sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "git" },
        { name = "luasnip" },
        {
          name = "buffer",
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                local buffer_byte_size = vim.api.nvim_buf_get_offset(buf, vim.api.nvim_buf_line_count(buf))
                if buffer_byte_size > 1024 * 100 then -- 100 kb max
                  return {}
                end
                bufs[buf] = true
              end
              return vim.tbl_keys(bufs)
            end,
          },
        },

        { name = "path" },
      })

      -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      opts.formatting.format = function(entry, item)
        if item.kind == "Color" then
          item = require("cmp-tailwind-colors").format(entry, item)

          if item.kind ~= "Color" then
            item.menu = nil
            return item
          end
        end

        item.kind = icons[item.kind] or item.kind
        item.menu = nil

        local truncated = vim.fn.strcharpart(item.abbr, 0, 30)
        if truncated ~= item.abbr then
          item.abbr = truncated .. "…"
        end

        return item
      end

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
            cmp.confirm({
              select = true,
            })
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- this way you will only jump inside the snippet region
          elseif require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Esc>"] = cmp.mapping({
          i = function(fallback)
            fallback()
          end,
        }),
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<c-e>"] = cmp.mapping({
          i = function(fallback)
            fallback()
          end,
        }),

        ["<CR>"] = cmp.mapping({
          i = function(fallback)
            if cmp.visible() then
              cmp.confirm()
            else
              fallback()
            end
          end,
        }),
      })
    end,
  },
}
