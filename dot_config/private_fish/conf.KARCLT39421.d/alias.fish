# alias sshb 'begin; set -x TERM "xterm-256color"; sshb'
#
function sshb
    set -x TERM 'xterm-256color'
    command sshb $argv
end
