# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# initialize zplug
source ${XDG_CONFIG_HOME:-$HOME/.config}/zplug/init.zsh

# import plugins
zplug romkatv/powerlevel10k, as:theme, depth:1
# zplug basics:
# - `zplug status` to see if packages are up to date
# - `zplug update` to update packages
# - `zplug list` to see currently managed packages
# - `zplug clean` to clear out now unmanaged packages
# - `zplug 'owner/repo'` to use a plugin from https://github.com/$owner/$repo
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# (defer:2 means syntax-highlighting gets loaded after completions)
zplug 'zsh-users/zsh-syntax-highlighting', defer:2 # (like fish)
# (defer:3 means history-substring search gets loaded after syntax-highlighting)
zplug 'zsh-users/zsh-history-substring-search', defer:3 # (like fish)
zplug 'zsh-users/zsh-autosuggestions' # (like fish)
# End plugins 

zplug load 

export LANG='en_US.UTF-8'
export LANGUAGE='en_US:en'
export LC_ALL='en_US.UTF-8'
export TERM=screen-256color


bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey "\033[1~" beginning-of-line
bindkey "\033[4~" end-of-line
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_last"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs status)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=()
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_STATUS_CROSS=true

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
