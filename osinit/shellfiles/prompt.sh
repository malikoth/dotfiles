PROMPT=$'
[%{$purple%}%n${PR_RST}@%{$orange%}%m${PR_RST}] [%{$limegreen%}%~${PR_RST}] $vcs_info_msg_0_$(virtualenv_info)
%(?..[%F{1}%B!%?%b%f] )$ '
RPROMPT="[%*]"
