call_recipe := just_executable() + " --justfile=" + justfile()

_default:
    @just --list

[doc("Stow a specific program's config files")]
stow dir:
    @stow {{ dir }}

[doc("Unstow a specific program's config files")]
unstow dir:
    @stow -D {{ dir }}

[doc("List all directories available for stowing")]
list:
    @find . -maxdepth 1 -type d -not -path "*/.*" -not -name "." \
    | sed "s/^.\///" \
    | sort

[confirm('This will overwrite existing config files and do a git reset. Are you sure? [y/N]')]
[doc("Stow all directories as listed by `list`")]
stow-all:
    @{{ call_recipe }} list | xargs stow --adopt
    @git reset --hard
    @echo All config files have been stowed.

[doc("Unstow all directories as listed by `list`")]
unstow-all:
    @{{ call_recipe }} list | xargs stow -D
    @echo All config files have been unstowed.
