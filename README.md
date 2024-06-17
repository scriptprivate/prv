<p align="center">
  <img src="./images/logo.jpg" width="120px" height="120px">
  <h3 align="center"><b>prv</b></h3>
  <p align="center"><i>A terminal-based utility for mass-renaming files in Perl.</i></p>

---

### Summary

This Perl utility allows users to easily mass-rename files in a directory through a terminal interface. You can interactively edit filenames and choose to keep file extensions unchanged using the `-k` or `--keep` option.

---

### Download and Install

```bash
# Download
$ git clone https://github.com/scriptprivate/prv && cd prv

# Install dependencies
$ cpanm --installdeps .
```

---

### Commands

```
COMMAND           FUNCTION
/path/to/dir      Specify the directory containing files to rename
-k, --keep        Keep the file extensions unchanged during renaming

Examples:

perl prv.pl /path/to/directory
perl prv.pl /path/to/directory -k
perl prv.pl /path/to/directory --keep
```

---
