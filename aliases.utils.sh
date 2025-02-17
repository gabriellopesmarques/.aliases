alias bat='batcat --style="changes" --theme="TokyoNordStorm"'
alias l='exa -lhF'
alias ll='exa -lhaF'
alias ls='exa'
alias lsa='exa -a'
alias glow="glow -s ~/.config/glow/nord.json"
alias fd='cd $(find -type d 2>/dev/null | fzf); pwd'
alias calendar="dialog --calendar 'calendar' 0 0"

ai(){
    if [[ -z "$GROQ_API_KEY" ]]; then
        echo "declare GROQ_API_KEY to use this function"
        return 64
    fi

    echo -n "how can i help you?: "
    read question

    curl --silent -X POST "https://api.groq.com/openai/v1/chat/completions" \
         -H "Authorization: Bearer $GROQ_API_KEY" \
         -H "Content-Type: application/json" \
         -d '{"messages": [{"role": "user", "content": "'"$question"'"}], "model": "llama3-8b-8192"}' | jq -r '.choices[0].message.content' | glow -
}
