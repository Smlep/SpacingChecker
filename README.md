# TypoChecker
Here is a simple bash program which checks if spacing around punctuation is respected.

Usage
=====
```
./check.sh language.lg file
```


Languages files are in the *languages/* directory.

*file* is the file to check.

Errors will be printed as a result.

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
- 1: One or more errors were found

Misc
====
Make sure that grep is installed and supports -n and --colour or TypoChecker will not work.
