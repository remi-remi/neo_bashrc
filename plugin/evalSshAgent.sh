# launch ssh agent by default to manage ssh key

#it can be usefull to avoid typing multiple times encrypted key password
# with this ssh config :
#
#   Host *
#     AddKeysToAgent yes

# normal
eval "$(ssh-agent -s)"
 
# silent
#eval "$(ssh-agent -s)" 2>&1 > /dev/null
