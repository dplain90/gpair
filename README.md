> CLI Tool for co-authoring commits.

## Installation

  1. `git clone git@github.com:dplain90/gpair.git`  
  2. Add the path for `/gpair/bin` to your `$PATH` variable in your `bash_profile`  OR  `.zshrc`
  3. `source ~/.bash_profile`  OR  `source ~/.zshrc`
  4. `gpair`

## Setup

  - In the root directory of your repository add a file called `.pairs`. This file stores pair data for authors participating in that repo. Add all the co-authors for your repo to this file.
  
    **EXAMPLE:**
    
    The format for each author is: ```[<Initials>]: <Name>; <Github Email>```
  ```
  pairs:
    [dp]: Danny Plain; dplain@gmail.com
    [js]: Jane Smith; jsmith@yahoo.com
  ```

  - Add `.current-pair` to your `.gitignore`.

## Usage

  At the beginning of a pairing session, run `gpair set <pair_initials>`

  When you are ready to commit just run `gpair commit "commit message" [git options]`. Gpair will append the co-authoring lines to your commit message, then create the commit. 
  
  NOTE: You can pass any available `git commit` options after the commit message. EX: `--no-verify`

  When you are done pairing, run `gpair clear` to remove your current pair.

## Available Commands

Gpair supports several commands, each accessible through the `gpair` command. For help on individual commands, add `--help` or `-h` following the command name. The commands are:

### `gpair set`

Sets a current pair 

### `gpair commit` 

Creates a commit, appending your pair's information as the co-author.


### `gpair clear` 

Clears your current pair.

### `gpair ls`

Lists all available pairs in the repository

### `gpair pair`

Displays your current pair's information

### `gpair add`

Adds a new author to the repository's pair list
