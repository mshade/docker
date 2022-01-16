export PS1='\[\033[38;5;2m\]kubetools\[\033[00m\]:[\[\033[38;5;4m\]\w\[\033[00m\]]\$ '

source /etc/profile.d/bash_completion.sh
source <(kubectl completion bash)
source <(helm completion bash)
source ~/.complete_alias

alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kgp="kubectl get pods"
alias kga="kubectl get all"

complete -F _complete_alias k
complete -F _complete_alias kg
complete -F _complete_alias kd
