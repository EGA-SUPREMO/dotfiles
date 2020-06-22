# dotfiles
my .dotfiles

## Git Aliases
- Common
    - `cm` for `commit`
    - `cme` to add everything and commit
    - `co` for `checkout`
    - `cob` for `checkout -b`
    - `fixup` for `commit --amend`
    - `cp` for `cherry-pick`
    - `st` for `status`
    - `br` for `branch`
- Specific for my development
    - `cobf` for `checkout -b feature/<arg name of the branch>`
    - `cobb` for `checkout -b hotfix/<arg name of the branch>`
    - `cobh` for `checkout -b bugfix/<arg name of the branch>`
    - `cobr` for `checkout -b release/<arg name of the branch>`
    - `cof` for `checkout feature/<arg name of the branch>`
    - `coh` for `checkout hotfix/<arg name of the branch>`
    - `cor` for `checkout release/<arg name of the branch>`
    - `return` to checkout to the main branch
    - `glog` to get a good log
    - `slog` to get a good short log
    - `sdlog` same as above but includes dates
    - `save` to add all changes including untracked files and do a temporal commit, I typically use this along with `undo` or `amend`
    - `wip` same to `save` but doesn't add untracked files
    - `undo` to reset the previous commit
    - `wipe` to commit everything in the working directory and then does a hard reset to remove that commit, but that commit can be restored.
    - `up` to update the current branch, it's possible this will removed and instead use `ruffwd` or `rupffwd`
    - `sync` to synchronize the repo, it uses `up` to pull and `git push`
    - `aliases` shows all git aliases
    - Complex
        - `ruffwd` and `rupffwd` do `remote update`, the later one with `--prune` and updates all tracking branches, see helper `ffwd`
        - `brclean` deletes every branch that’s been merged into the specified branch except the branch, when no branch is specified, it uses the default branch
        - `brunsafed` deletes every branch using `-D` that aren't the default, 'master', 'development', 'develop' or 'dev', stands for **BR**anch **UNSAFE D**elete
        - `brd` deletes every branch whose remote tracking branch is gone, this also uses `-D`
        - `brdone` goes to the main branch, updates with `git up` and cleans with `brclean`
        - `migrate` [more info](https://haacked.com/archive/2015/06/29/git-migrate/)
- Helpers
	- `default` prints the main branch
    - `ffwd` to update all tracking branches, [more info](http://stackoverflow.com/questions/9076361)

## Bash Aliases
- `ist` for **I**nternet usage **ST**atistic, it requires `vnstat`
- `onegai` to execute the previous command as `sudo`
- `baka` for `git` e.g. `baka pull master`, `baka push master`.
- `gt` for `git`, this may overlap with other commands in your environment
- `phpl` for `php artisan`
- `d7`, `d4`, `d3`, `d2`, goes to Downloads folder and downloads videos using [youtube-dl](https://github.com/ytdl-org/youtube-dl) in 720p, 480p, 360p or 240p if available
- `dm7`, `dm4`, `dm3`, `dm2` same as above but goes to Music instead.

## References
- For `brdone`, `brclean`, `wip`, `save`, `wipe`, `up` and `migrate` are from [haacked](https://haacked.com/archive/2014/07/28/github-flow-aliases)
- For `ffwd`, `ruffwd` and `rupffwd` are from [muhqu](https://github.com/muhqu/dotfiles)


## License
MIT
