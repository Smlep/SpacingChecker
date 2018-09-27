# SpacingChecker
Here is a simple bash program which checks if spacing around punctuation is respected.

Usage
=====
```
$ ./check.sh language file
```

*language* can be either a shortname (see ```./check.sh -l```) or a language file.
Language files are in the *languages/* directory.

*file* is the file to check.

Errors will be printed as a result.

Example
=======
```
$ ./check.sh us tests/file.txt

Looking for a language file...
Searching files corresponding to us
Loading English (US)
1:Here is an english error !
```

Options
=======
- ```-h```, ```--help``` display help
- ```-s```, ```--silent``` do not write anything to standard output
- ```-l```, ```--lg```, ```--languages``` display available languages and their shortnames
```
$ ./check.sh -l

Short names for available languages:
fr: French
gb: English (GB)
it: Italian
us: English (US)
```

Supported languages
===================
- French
- English
- Italian

Feel free to create a Pull Request with new languages files.

You can also create new issues for languages not done yet.

Exit status
===========
- 0: No error found
- 1: One or more errors were found while checking
- 2: ```-l```, ```-h```, ```--lg```, ```--help``` or ```--languages``` were used
- 3: An error occured which prevented checking

Installation
============
You can clone this repository and then use the script with ```./check.sh```:
```
$ git clone https://github.com/Smlep/SpacingChecker.git
$ cd SpacingChecker
$ ./check.sh us anamericanfile
...
```

Or you can install it globally with homebrew and then use it as ```spaceCheck:
```
$ brew tap smlep/spacingchecker
$ brew install spacingchecker
$ spaceCheck gb abritishfile
...
```

Misc
====
Make sure that grep is installed and supports -n and --colour or SpacingChecker will not work.
