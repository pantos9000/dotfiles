set -gx BROWSER 'firefox'
set -gx PAGER 'most'
set -gx VISUAL 'nvim'
set -gx EDITOR 'nvim'
if command -q sccache
    set -gx RUSTC_WRAPPER 'sccache'
end
