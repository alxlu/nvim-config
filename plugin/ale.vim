let g:ale_fixers = {
\  'javascript': ['prettier', 'eslint'],
\  'javascriptreact': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'eslint'],
\  'typescriptreact': ['prettier', 'eslint'],
\}

let g:ale_linters = {
\  'javascript': ['eslint'],
\  'javascriptreact': ['eslint'],
\  'typescript': ['eslint'],
\  'typescriptreact': ['eslint'],
\}

let g:ale_disable_lsp = 1
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
