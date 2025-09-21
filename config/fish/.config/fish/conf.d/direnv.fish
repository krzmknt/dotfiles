
# fish 起動時にのみ、direnv が存在する場合だけフックする
status is-interactive; and type -q direnv; and direnv hook fish | source
