# dotfiles
my .dotfiles

## Git Aliases
- Common
    - `cm` for `commit`
    - `cme` to add everything and commit
    - `co` for `checkout`
    - `cob` for `checkout -b`
    - `amend` for `commit --amend`
    - `st` for `status`
    - `br` for `branch`
- Specific for my development
    - `cobf` for `checkout -b feature/<arg name of the branch>`
    - `cobb` for `checkout -b hotfix/<arg name of the branch>`
    - `cobh` for `checkout -b bugfix/<arg name of the branch>`
    - `cof` for `checkout feature/<arg name of the branch>`
    - `cof` for `checkout hotfix/<arg name of the branch>`
    - `return` to checkout to the main branch
    - `glog` to get a good log using `log --graph --oneline --decorate --all`
    - `save` to add all changes including untracked files and do a temporal commit, I typically use this along with `undo` or `amend`
    - `wip`same to save but doesn't add untracked files
    - `undo` to reset the previous commit
    - `wipe` to commit everything in the working directory and then does a hard reset to remove that commit, but that commit can be restored.
    - `up` to update the current branch, it's possible this will removed and instead use `ruffwd` or `rupffwd`
    - Complex
        - `ruffwd` and `rupffwd` do `remote update`, the later one with `--prune` and updates all tracking branches, see helper `ffwd`
        - `brclean` deletes every branch that’s been merged into the specified branch except the branch, when no branch is specified, it uses the main branch
        - `brdone` goes to the main branch, updates with `git up` and cleans with `brclean`
- Helpers
	- `default` prints the main branch
    - `ffwd` to update all tracking branches, [more info](http://stackoverflow.com/questions/9076361)

## References

- For `brdone`, `brclean`, `wip`, `save`, `wipe`, `up`, `amend`
https://haacked.com/archive/2014/07/28/github-flow-aliases


## License