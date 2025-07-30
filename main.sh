# main.sh should be sourced into .bashrc and will contain all export (source) of neoBashrc components

# $PS1 IMPORT ==============================================================
# mabe you should remove your bashrc ps1 first if you use this function

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	color_prompt=yes
else
	color_prompt=
fi

if [ "$color_prompt" = yes ]; then

# SOURCE CUSTOM PS1 HERE <----------------------------------------------
. ~/NEO_BASHRC/PS1/complex.sh
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    echo "color_prompt=no using segondary ps1"
fi
unset color_prompt


# ALIAS IMPORT =============================================================
. ~/NEO_BASHRC/lib/alias_manager.sh


# PLUGIN IMPORT =============================================================

for plugin in ~/NEO_BASHRC/plugin/*.sh; do
    [ -r "$plugin" ] && source "$plugin"
done

