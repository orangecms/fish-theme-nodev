# Theme based on Bira theme from oh-my-zsh: https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/bira.zsh-theme
# Some code stolen from oh-my-fish clearance theme: https://github.com/bpinto/oh-my-fish/blob/master/themes/clearance/

function __user_host
  set -l content 
  if [ (id -u) = "0" ];
    echo -n (set_color --bold white --background red)
  else
    echo -n (set_color --bold purple)
  end
  echo -n $USER@(hostname|cut -d . -f 1) (set color normal)
end

function __current_path
  echo -n (set_color --bold blue) (pwd)(set_color normal) 
end

function _git_branch_name
  echo (command git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
  echo (command git status -s --ignore-submodules=dirty ^/dev/null)
end

function __git_status
  if [ (_git_branch_name) ]
    set -l git_branch (_git_branch_name)

    if [ (_git_is_dirty) ]
      set git_color red
    else
      set git_color cyan
    end

    echo -n (set_color $git_color) ‹$git_branch›(set_color normal) 
  end
end

function __node_version
  set node_version (node -v)
  set npm_profile ''
  test -e ~/.npmrc; and set npm_profile ' '(ls -l ~/.npmrc | sed 's/^.*\.npmrcs\/profiles\/\(.*\)\/npmrc$/\1/')
  echo -n (set_color green) ‹node $node_version$npm_profile›(set_color normal)
end

function fish_prompt
  __user_host
  __current_path
  __node_version
  __git_status
  echo -e ''
  echo (set_color --bold white)"🐢"(set_color normal)"  " 
end

function fish_right_prompt
  set -l st $status

  if [ $st != 0 ];
    echo (set_color red) ↵ $st(set_color normal)
  end
end
