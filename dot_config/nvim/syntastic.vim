let g:syntastic_enable_signs = 1
let g:syntastic_enable_highlighting = 0
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 2 "auto-close, but no auto-open
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "?"

let g:syntastic_cpp_checkers = ['clang_check', 'cppcheck', 'cpplint']
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_auto_refresh_includes = 1
let g:syntastic_cpp_no_include_search = 1

let g:syntastic_clang_check_config_file = ".syntastic_cpp_config"
let g:syntastic_clang_tidy_config_file = ".syntastic_cpp_config"
let g:syntastic_cpp_cpplint_exec = 'cpplint'

let g:syntastic_rust_checkers = ['rustc']

"disable syntastic on a per buffer basis (some work files blow it up)
let b:syntastic_skip_checks = 1
function! SyntasticDisableBuffer()
    let b:syntastic_skip_checks = 1
    SyntasticReset
endfunction
function! SyntasticEnableBuffer()
    let b:syntastic_skip_checks = 0
    SyntasticCheck
endfunction
command! SyntasticDisableBuffer call SyntasticDisableBuffer()
command! SyntasticEnableBuffer call SyntasticEnableBuffer()
