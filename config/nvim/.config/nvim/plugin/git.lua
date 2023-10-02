require("git").setup({
  -- NOTE: `quit_blame` and `blame_commit` are still merged to the keymaps even if `default_mappings = false`
  default_mappings = true,

  keymaps = {
    -- Open blame window
    blame = "<Leader>ao",

    -- Close blame window
    quit_blame = "q",

    -- Open blame commit
    blame_commit = "<CR>",

    -- Open file/folder in git repository
    browse = "<Leader>af",

    -- Open pull request of the current branch
    open_pull_request = "<Leader>ap",

    -- Create a pull request with the target branch is set in the `target_branch` option
    create_pull_request = "<Leader>an",

    -- Opens a new diff that compares against the current index
    diff = "<Leader>ad",

    -- Close git diff
    diff_close = "<Leader>ac",

    -- Revert to the specific commit
    revert = "<Leader>gr",

    -- Revert the current file to the specific commit
    revert_file = "<Leader>gR",
  },

  -- Default target branch when create a pull request
  target_branch = "main",
})

require('gitsigns').setup()
