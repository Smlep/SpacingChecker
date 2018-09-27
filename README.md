# SpacingChecker
Here is a simple bash program which checks if spacing around punctuation is respected.

Usage
=====
```
./check.sh language file
```

*language* can be either a shortname (see ```./check.sh -l```) or a language file.
Language files are in the *languages/* directory.

*file* is the file to check.

Errors will be printed as a result.

Example
=======
```
./check.sh us tests/file.txt

Looking for a language file...
Searching files corresponding to us
Loading English (US)
1:Here is an english error !
```

Options
=======
- ```-h```, ```--help``` display help
- ```-l```, ```--lg```, ```--languages``` display available languages and their shortnames
- ```-s```, ```--silent``` do not write anything to standard output
```
./check.sh -l

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

Misc
====
Make sure that grep is installed and supports -n and --colour or SpacingChecker will not work.
