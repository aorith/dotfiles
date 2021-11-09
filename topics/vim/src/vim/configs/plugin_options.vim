" VIM-SIGNIFY
let g:signify_sign_change = '~'
let g:signify_priority = 9

" MUCOMPLETE
let g:mucomplete#enable_auto_at_startup = 1

" ALE
let g:ale_enabled = 1
let g:ale_completion_enabled = 1 " disable for deoplete
let g:ale_completion_autoimport = 1
let g:ale_set_highlights = 1
let g:ale_exclude_highlights = ['line too long']
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_delay = 400
let g:ale_lint_on_save = 1
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_echo_msg_format = '[%linter%][%severity%] %s'
let g:ale_list_window_size = 5
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0

" VIM-PANDOC
let g:pandoc#formatting#mode = 'h'
let g:pandoc#formatting#textwidth = 72
let g:pandoc#syntax#conceal#use = 1
let g:pandoc#syntax#conceal#urls = 1
let g:pandoc#syntax#codeblocks#embeds#use = 1
let g:pandoc#syntax#conceal#blacklist = ['atx', 'codeblock_start', 'codeblock_delim' ]
let g:pandoc#syntax#codeblocks#embeds#langs = [
      \'bash',
      \'lua',
      \'makefile=make',
      \'python',
      \'sh',
      \'vcl',
      \'yaml',
      \]

" FZF
let g:fzf_layout = { 'window': { 'width': 0.90, 'height': 0.90 } }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
