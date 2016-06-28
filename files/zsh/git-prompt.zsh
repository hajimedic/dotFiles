autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least
autoload -Uz colors

zstyle ':vcs_info:*' max-exports 4
zstyle ":vcs_info:*" enable git

if is-at-least 4.3.10; then
	# git 用のフォーマット
	# git のときはステージしているかどうかを表示
	zstyle ':vcs_info:git:*' check-for-changes true
	zstyle ":vcs_info:git:*" formats '%r/%b' '%m' '%c%u'
	zstyle ":vcs_info:git:*" actionformats '%r/%b' '%m' '%c%u' ' !%a'
	# zstyle ":vcs_info:git:*" stagedstr "*"
	# zstyle ":vcs_info:git:*" unstagedstr "+"
fi

# hooks 設定
if is-at-least 4.3.11; then
	# git のときはフック関数を設定する

	zstyle ':vcs_info:git+set-message:*' hooks \
											git-hook-begin \
											git-staged \
											git-unstaged \
											git-untracked \
											git-check-stage \
											git-pull-status \
											git-push-status \
											git-stash-count

	# フックの最初の関数
	# git の作業コピーのあるディレクトリのみフック関数を呼び出すようにする
	# (.git ディレクトリ内にいるときは呼び出さない)
	# .git ディレクトリ内では git status --porcelain などがエラーになるため
	function +vi-git-hook-begin() {
		if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
			# 0以外を返すとそれ以降のフック関数は呼び出されない
			return 1
		fi

		return 0
	}

	# staged ファイル表示
	function +vi-git-staged() {
		# zstyle formats, actionformats の2番目のメッセージのみ対象にする
		if [[ "$1" != "1" ]]; then
			return 0
		fi

		# commit していないファイル数を取得する
		local git_status
		git_status=$(command git status --porcelain 2>/dev/null)
		local staged
		staged=$(echo $git_status | command grep '^[A-Z]' | wc -l | tr -d ' ')

		if [[ "$staged" -gt 0 ]]; then
			# staged (%u) に追加
			hook_com[staged]=" %F{green}*$staged%f"
		fi
	}

	# unstaged ファイル表示
	function +vi-git-unstaged() {
		# zstyle formats, actionformats の2番目のメッセージのみ対象にする
		if [[ "$1" != "1" ]]; then
			return 0
		fi

		# add していないファイル数を取得する
		local git_status
		git_status=$(command git status --porcelain 2>/dev/null)
		local unstaged
		unstaged=$(echo $git_status | command grep '^.[A-Z]' | wc -l | tr -d ' ')

		if [[ "$unstaged" -gt 0 ]]; then
			# unstaged (%u) に追加
			hook_com[unstaged]=" %F{magenta}+$unstaged%f"
		fi
	}

	# untracked ファイル表示
	function +vi-git-untracked() {
		# zstyle formats, actionformats の2番目のメッセージのみ対象にする
		if [[ "$1" != "1" ]]; then
			return 0
		fi

		# add していないファイル数を取得する
		local git_status
		git_status=$(command git status --porcelain 2>/dev/null)
		local untracked
		untracked=$(echo $git_status | command grep '^??' | wc -l | tr -d ' ')

		if [[ "$untracked" -gt 0 ]]; then
			# unstaged (%u) に追加
			hook_com[unstaged]+=" ?$untracked"
		fi
	}

	# status 確認
	function +vi-git-check-stage() {
		# zstyle formats, actionformats の2番目のメッセージのみ対象にする
		if [[ "$1" != "1" ]]; then
			return 0
		fi

		if [[ -z ${hook_com[staged]} ]] && [[ -z ${hook_com[unstaged]} ]]; then
			# staged (%u) に追加
			hook_com[staged]=" %F{green}✔ %f"
		fi
	}

	# push していないコミットの件数表示
	function +vi-git-push-status() {
		# zstyle formats, actionformats の2番目のメッセージのみ対象にする
		if [[ "$1" != "1" ]]; then
			return 0
		fi

		# push していないコミット数を取得する
		local ahead
		ahead=$(command git rev-list origin/${hook_com[branch]}..${hook_com[branch]} 2>/dev/null \
			| wc -l \
			| tr -d ' ')

		if [[ "$ahead" -gt 0 ]]; then
			# misc (%m) に追加
			hook_com[misc]+=" %F{green}↑ ${ahead}%f"
		fi
	}

	# pull していないコミットの件数表示
	function +vi-git-pull-status() {
		# zstyle formats, actionformats の2番目のメッセージのみ対象にする
		if [[ "$1" != "1" ]]; then
			return 0
		fi

		# pull していないコミット数を取得する
		local ahead
		ahead=$(command git rev-list ${hook_com[branch]}..origin/${hook_com[branch]} 2>/dev/null \
			| wc -l \
			| tr -d ' ')

		if [[ "$ahead" -gt 0 ]]; then
			# misc (%m) に追加
			hook_com[misc]+=" %F{magenta}↓ ${ahead}%f"
		fi
	}

	# stash 件数表示
	function +vi-git-stash-count() {
		# zstyle formats, actionformats の2番目のメッセージのみ対象にする
		if [[ "$1" != "1" ]]; then
			return 0
		fi

		local stash
		stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
		if [[ "${stash}" -gt 0 ]]; then
			# misc (%m) に追加
			hook_com[misc]+=" @${stash}"
		fi
	}

fi

function _update_vcs_info_msg() {
	local -a messages
	local p_git_color_fg=$'%{\e[38;5;39m%}'
	local p_git_color_bg=$'%{\e[48;5;236m%}'
	local p_git_end_color_fg=$'%{\e[38;5;236m%}'
	local git_prompt=""

	LANG=en_US.UTF-8 vcs_info

	# vcs_info で何も取得していない場合はプロンプトを表示しない
	if [[ -n ${vcs_info_msg_0_} ]]; then
		[[ -n "$vcs_info_msg_0_" ]] && messages+=( "%f${vcs_info_msg_0_}${p_git_color_fg}" )
		[[ -n "$vcs_info_msg_1_" ]] && messages+=( "%f${vcs_info_msg_1_}${p_git_color_fg}" )
		[[ -n "$vcs_info_msg_2_" ]] && messages+=( "%f${vcs_info_msg_2_}${p_git_color_fg}" )
		[[ -n "$vcs_info_msg_3_" ]] && messages+=( "%F{red}${vcs_info_msg_3_}%f" )
		git_prompt="$p_git_color_bg⮀$p_git_color_fg ⭠ ${(j: ⮁:)messages} $p_git_end_color_fg"
	fi
	PROMPT="$p_cdir$git_prompt$p_cdir_end$p_base"
}
add-zsh-hook precmd _update_vcs_info_msg

## unicode characters selection
# ⭠
# ⮀
# ⮁
# ⮂
# ⮃
# ۞
# ◤
# ◢
# ◥
# ◣
# ⮐
# ⮑

## setting for git-prompt
# ZSH_THEME_GIT_PROMPT_PREFIX=" ⭠ "
# ZSH_THEME_GIT_PROMPT_SUFFIX=""
# ZSH_THEME_GIT_PROMPT_SEPARATOR=":"
# ZSH_THEME_GIT_PROMPT_BRANCH="%{\e[38;5;69m%}"
# ZSH_THEME_GIT_PROMPT_STAGED="%{$fg_bold[green]%} Staged:"
# ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg_bold[red]%} Conflicts:"
# ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg_bold[yellow]%} Unstaged:"
# ZSH_THEME_GIT_PROMPT_REMOTE="%{$fg_bold[yellow]%} "
# ZSH_THEME_GIT_PROMPT_UNTRACKED=" Untracked.."
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[green]%}✔ "
