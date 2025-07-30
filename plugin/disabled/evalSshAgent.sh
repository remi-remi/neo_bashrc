# launch ssh agent by default to manage ssh key

# normal
eval "$(ssh-agent -s)"
 
# silent
#eval "$(ssh-agent -s)" 2>&1 > /dev/null
