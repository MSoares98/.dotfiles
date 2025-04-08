#!/usr/bin/env zsh

# comprehensive-neovim-keymaps.sh - Extract and document all Neovim keymaps

OUTPUT_FILE="$HOME/comprehensive-nvim-keymaps.md"

echo "# Comprehensive Neovim Keymap Reference" > $OUTPUT_FILE
echo "Generated on $(date)" >> $OUTPUT_FILE
echo "" >> $OUTPUT_FILE

# Add a section header
add_section() {
  echo -e "\n## $1\n" >> $OUTPUT_FILE
}

# Add table header
add_table_header() {
  echo "| Mode | Key | Description |" >> $OUTPUT_FILE
  echo "|------|-----|-------------|" >> $OUTPUT_FILE
}

# Extract keymap information directly from Neovim
extract_nvim_keymaps() {
  add_section "Custom Configured Keymaps"
  add_table_header
  
  # Use Neovim to output all custom keymaps in JSON format for parsing
  nvim --headless -c "lua
    local results = {}
    for _, mode in ipairs({'n', 'i', 'v', 'x', 's', 'o', 't', 'c'}) do
      local maps = vim.api.nvim_get_keymap(mode)
      for _, map in ipairs(maps) do
        if not map.rhs and not map.callback then
          -- Skip if no rhs or callback (likely a built-in or <Plug> mapping)
          goto continue
        end
        
        -- Skip some default mappings and plugin internal mappings
        if map.lhs:match('^<Plug>') or map.lhs:match('^<SNR>') then
          goto continue
        end
        
        local desc = map.desc or (map.rhs and map.rhs or 'No description')
        if desc == '' then desc = map.rhs or 'No description' end
        
        -- Format the mode abbreviation to full name
        local mode_name = {
          n = 'Normal', i = 'Insert', v = 'Visual', x = 'Visual Line',
          s = 'Select', o = 'Operator', t = 'Terminal', c = 'Command'
        }
        
        table.insert(results, {
          mode = mode_name[mode] or mode,
          lhs = map.lhs,
          desc = desc
        })
        ::continue::
      end
    end
    
    -- Output as JSON for easier parsing
    local json_str = vim.json.encode(results)
    
    -- Print to stdout for capturing
    print(json_str)
  " -c "qa!" 2>/dev/null | grep -v '^$' > /tmp/nvim_keymaps_output.json
  
  # Process the JSON output and add it to the markdown file
  if [ -f /tmp/nvim_keymaps_output.json ]; then
    # Use jq to parse the JSON, format the output, and sort by mode and key
    jq -r '.[] | "\(.mode)|\(.lhs)|\(.desc)"' /tmp/nvim_keymaps_output.json | 
    sort | 
    while IFS='|' read -r mode key desc; do
      # Escape backticks in key representation
      key=$(echo "$key" | sed 's/`/\\`/g')
      echo "| $mode | \`$key\` | $desc |" >> $OUTPUT_FILE
    done
    
    rm /tmp/nvim_keymaps_output.json
  else
    echo "| Error | Error | Could not extract keymaps from Neovim |" >> $OUTPUT_FILE
  fi
}

# Document plugin-specific keymaps
document_plugin_keymaps() {
  # Telescope
  add_section "Telescope"
  add_table_header
  cat << EOF >> $OUTPUT_FILE
| Normal | \`<C-p>\` | Find files |
| Normal | \`<leader>fg\` | Live grep |
| Normal | \`<leader><leader>\` | Recent files |
| Inside Telescope | \`<C-c>\` | Close telescope |
| Inside Telescope | \`<Esc>\` | Close telescope |
| Inside Telescope | \`<CR>\` | Confirm selection |
| Inside Telescope | \`<C-x>\` | Go to file selection as split |
| Inside Telescope | \`<C-v>\` | Go to file selection as vsplit |
| Inside Telescope | \`<C-t>\` | Go to a file in a new tab |
| Inside Telescope | \`<C-u>\` | Scroll up in preview window |
| Inside Telescope | \`<C-d>\` | Scroll down in preview window |
| Inside Telescope | \`<Tab>\` | Toggle selection + move to next |
| Inside Telescope | \`<S-Tab>\` | Toggle selection + move to prev |
| Inside Telescope | \`<C-q>\` | Send all items to quickfix list |
EOF

  # Neo-tree
  add_section "Neo-tree"
  add_table_header
  cat << EOF >> $OUTPUT_FILE
| Normal | \`<C-n>\` | Toggle file explorer |
| Normal | \`<leader>bf\` | Show buffers in float |
| Inside Neo-tree | \`<CR>\` | Open file/directory |
| Inside Neo-tree | \`o\` | Open file/directory |
| Inside Neo-tree | \`<C-v>\` | Open file in vertical split |
| Inside Neo-tree | \`<C-s>\` | Open file in horizontal split |
| Inside Neo-tree | \`<C-t>\` | Open file in new tab |
| Inside Neo-tree | \`A\` | Add directory |
| Inside Neo-tree | \`a\` | Add file |
| Inside Neo-tree | \`d\` | Delete |
| Inside Neo-tree | \`r\` | Rename |
| Inside Neo-tree | \`y\` | Copy to clipboard |
| Inside Neo-tree | \`x\` | Cut to clipboard |
| Inside Neo-tree | \`p\` | Paste from clipboard |
| Inside Neo-tree | \`c\` | Copy |
| Inside Neo-tree | \`m\` | Move |
| Inside Neo-tree | \`q\` | Close window |
| Inside Neo-tree | \`R\` | Refresh |
| Inside Neo-tree | \`?\` | Show help |
EOF

  # nvim-surround
  add_section "nvim-surround"
  add_table_header
  cat << EOF >> $OUTPUT_FILE
| Normal | \`ys{motion}{char}\` | Add surround around motion |
| Normal | \`yss{char}\` | Add surround around line |
| Normal | \`ds{char}\` | Delete surround |
| Normal | \`cs{target}{replacement}\` | Change surround |
| Visual | \`S{char}\` | Add surround around visual selection |
EOF

  # LSP functions
  add_section "LSP Functions"
  add_table_header
  cat << EOF >> $OUTPUT_FILE
| Normal | \`K\` | Show hover documentation |
| Normal | \`<leader>gd\` | Go to definition |
| Normal | \`<leader>gr\` | Find references |
| Normal | \`<leader>ca\` | Code actions |
| Normal | \`<leader>tld\` | Toggle diagnostics |
| Normal | \`<leader>gf\` | Format document |
EOF

  # Oil.nvim
  add_section "Oil.nvim"
  add_table_header
  cat << EOF >> $OUTPUT_FILE
| Normal | \`-\` | Toggle oil file explorer |
| Inside Oil | \`<CR>\` | Open file/directory |
| Inside Oil | \`-\` | Go up a directory |
| Inside Oil | \`<C-c>\` | Cancel/close |
| Inside Oil | \`<C-l>\` | Refresh |
| Inside Oil | \`~\` | Go to home directory |
EOF

  # Copilot
  add_section "Copilot"
  add_table_header
  cat << EOF >> $OUTPUT_FILE
| Insert | \`<Tab>\` | Accept completion |
| Insert | \`<C-]>\` | Dismiss current suggestion |
| Insert | \`<M-]>\` | Next suggestion |
| Insert | \`<M-[>\` | Previous suggestion |
| Insert | \`<C-\\>\` | Toggle copilot |
EOF

  # Git (fugitive & gitsigns)
  add_section "Git Integration (Fugitive & Gitsigns)"
  add_table_header
  cat << EOF >> $OUTPUT_FILE
| Normal | \`<leader>gp\` | Preview git hunk |
| Normal | \`<leader>gt\` | Toggle git blame |
| Normal | \`:G\` | Git status (Fugitive) |
| Normal | \`:Gdiffsplit\` | Git diff (Fugitive) |
| Normal | \`:Gcommit\` | Git commit (Fugitive) |
| Normal | \`:Gpush\` | Git push (Fugitive) |
| Normal | \`:Gpull\` | Git pull (Fugitive) |
| Normal | \`:Gblame\` | Git blame (Fugitive) |
EOF

  # Python venv selector
  add_section "Python venv-selector"
  add_table_header
  cat << EOF >> $OUTPUT_FILE
| Normal | \`<leader>vs\` | Select Python venv |
| Normal | \`<leader>vc\` | Select cached Python venv |
EOF

  # nvim-cmp (Completions)
  add_section "nvim-cmp (Completions)"
  add_table_header
  cat << EOF >> $OUTPUT_FILE
| Insert | \`<C-Space>\` | Open completion menu |
| Insert | \`<C-b>\` | Scroll docs up |
| Insert | \`<C-f>\` | Scroll docs down |
| Insert | \`<C-e>\` | Close completion menu |
| Insert | \`<CR>\` | Confirm completion |
| Insert | \`<Tab>\` | Select next suggestion (when menu open) |
| Insert | \`<S-Tab>\` | Select previous suggestion (when menu open) |
EOF

  # Which-key
  add_section "Which-key"
  add_table_header
  cat << EOF >> $OUTPUT_FILE
| Normal | \`<leader>\` | Show which-key menu |
| Normal | \`:WhichKey\` | Show which-key menu for all keys |
| Normal | \`:WhichKey <leader>\` | Show which-key menu for leader key |
EOF
}

# Document vim native commands
document_vim_native() {
  add_section "Essential Vim Commands"
  add_table_header
  cat << EOF >> $OUTPUT_FILE
| Normal | \`:w\` | Save file |
| Normal | \`:q\` | Quit |
| Normal | \`:wq\` or \`:x\` | Save and quit |
| Normal | \`:e {file}\` | Edit file |
| Normal | \`:bnext\` or \`:bn\` | Next buffer |
| Normal | \`:bprev\` or \`:bp\` | Previous buffer |
| Normal | \`:bd\` | Delete buffer |
| Normal | \`:ls\` | List buffers |
| Normal | \`:split\` or \`:sp\` | Horizontal split |
| Normal | \`:vsplit\` or \`:vs\` | Vertical split |
| Normal | \`<C-w>_\` | Maximize height of split |
| Normal | \`<C-w>|\` | Maximize width of split |
| Normal | \`<C-w>=\` | Make splits equal size |
| Normal | \`<C-w>s\` | Split horizontally |
| Normal | \`<C-w>v\` | Split vertically |
| Normal | \`<C-w>o\` | Close all other windows |
| Normal | \`<C-w>c\` | Close current window |
| Normal | \`:tab split\` | Open current buffer in new tab |
| Normal | \`:tabnew\` | Open new tab |
| Normal | \`:tabclose\` | Close current tab |
| Normal | \`:tabnext\` or \`gt\` | Next tab |
| Normal | \`:tabprevious\` or \`gT\` | Previous tab |
| Normal | \`/pattern\` | Search for pattern |
| Normal | \`?pattern\` | Search backward for pattern |
| Normal | \`n\` | Repeat search forward |
| Normal | \`N\` | Repeat search backward |
| Normal | \`:noh\` | Clear search highlighting |
| Normal | \`:%s/old/new/g\` | Replace all occurrences in file |
| Normal | \`:s/old/new/g\` | Replace all occurrences in line |
| Normal | \`u\` | Undo |
| Normal | \`<C-r>\` | Redo |
| Normal | \`..\` | Repeat last command |
| Normal | \`v\` | Visual mode (character-wise) |
| Normal | \`V\` | Visual mode (line-wise) |
| Normal | \`<C-v>\` | Visual mode (block-wise) |
| Normal | \`y\` | Yank (copy) |
| Normal | \`d\` | Delete |
| Normal | \`c\` | Change |
| Normal | \`p\` | Paste after cursor |
| Normal | \`P\` | Paste before cursor |
| Normal | \`>>\` | Indent line |
| Normal | \`<<\` | Unindent line |
| Normal | \`gg=G\` | Auto-indent whole file |
EOF
}

# Add tips
add_tips() {
  add_section "Tips for Navigating Keymaps"
  cat << EOF >> $OUTPUT_FILE
- Use \`:map\` to see all mappings
- Use \`:verbose map <key>\` to see where a mapping was defined
- Use \`:help key-notation\` to understand key notations
- Try \`:Telescope keymaps\` to search through keymaps interactively
- Use Which-key (\`<leader>\`) to discover available key sequences
- If you forget a keymap, press \`<leader>\` and browse through the categories

### Leader Key Prefixes
- \`<leader>g\` - Git/LSP operations
- \`<leader>f\` - Find/Search operations
- \`<leader>v\` - Python virtualenv
- \`<leader>t\` - Toggle options
- \`<leader>c\` - Code actions
- \`<leader>b\` - Buffer operations

### Most Useful Commands
1. \`<C-p>\` - Find files (Telescope)
2. \`<leader>fg\` - Search text within files
3. \`<C-n>\` - Toggle file explorer
4. \`<leader>gd\` - Go to definition
5. \`<leader>ca\` - Code actions
6. \`<leader>gf\` - Format document
7. \`:w\` - Save file
8. \`<leader>h\` - Clear search highlights
9. \`<leader>y\` - Copy to system clipboard
10. \`K\` - Show documentation at cursor
EOF
}

# Function to add command to extract current keymaps
add_extract_command() {
  add_section "Adding a Neovim Command to Show Keymaps"
  cat << EOF >> $OUTPUT_FILE
Add this to your Neovim config to create a \`:Keymaps\` command that will show this cheatsheet in a floating window:

\`\`\`lua
vim.api.nvim_create_user_command('Keymaps', function()
    local buf = vim.api.nvim_create_buf(false, true)
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        col = math.floor((vim.o.columns - width) / 2),
        row = math.floor((vim.o.lines - height) / 2),
        style = 'minimal',
        border = 'rounded',
    })
    
    -- Load content from your cheatsheet file
    local lines = vim.fn.readfile(vim.fn.expand('$HOME/comprehensive-nvim-keymaps.md'))
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(buf, 'filetype', 'markdown')
    vim.api.nvim_buf_set_option(buf, 'modifiable', false)
    
    -- Close with q
    vim.api.nvim_buf_set_keymap(buf, 'n', 'q', ':close<CR>', {noremap = true, silent = true})
end, {})
\`\`\`
EOF
}

# Main script execution
echo "Extracting keymaps from Neovim..."
extract_nvim_keymaps

echo "Documenting plugin-specific keymaps..."
document_plugin_keymaps

echo "Adding Vim native commands..."
document_vim_native

echo "Adding tips and recommendations..."
add_tips

echo "Adding Neovim command for keymap reference..."
add_extract_command

echo "Cheatsheet generated at $OUTPUT_FILE"
chmod +x "$0"
