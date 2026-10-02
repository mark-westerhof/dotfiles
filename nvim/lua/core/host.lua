-- Same host identity as tmux.conf's @host_accent: orange on the Mac,
-- lavender on the dev server.
return { accent = vim.fn.has('mac') == 1 and '#d19a66' or '#b4befe' }
