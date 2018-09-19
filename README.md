# TypoChecker
Here is a simple bash program which checks if spacing around punctuation is respected.

Usage
=====
```
./check.sh language.lg file
```


Languages files are in the languages/ directory.
*file* is the file to check.

Errors will be printed as a result.

Supported languages
===================
- French
- English

Exit status
===========
- 0: No error found
- 1: One or more errors were found

Misc
====
Make sure that grep is installed and supports -n and --colour or TypoChecker will not work.
