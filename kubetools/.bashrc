export PS1='\[\033[38;5;2m\]kubetools\[\033[00m\]:[\[\033[38;5;4m\]\w\[\033[00m\]]\$ '
export EDITOR="vim"
export PATH=~/.krew/bin:$PATH

source /etc/profile.d/bash_completion.sh
source <(kubectl completion bash)
source <(helm completion bash)

source ~/.complete_alias

alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kgp="kubectl get pods"
alias kga="kubectl get all"

alias kctx="kubectx"
alias kns="kubens"

alias kubeval="kubeconform"

complete -F _complete_alias k
complete -F _complete_alias kg
complete -F _complete_alias kd
complete -F _complete_alias ns

_kube_contexts()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "- $(kubectl config get-contexts --output='name')" -- $curr_arg ) );
}
complete -F _kube_contexts kubectx kctx

_kube_namespaces()
{
  local curr_arg;
  curr_arg=${COMP_WORDS[COMP_CWORD]}
  COMPREPLY=( $(compgen -W "- $(kubectl get namespaces -o=jsonpath='{range .items[*].metadata.name}{@}{"\n"}{end}')" -- $curr_arg ) );
}

complete -F _kube_namespaces kubens kns
