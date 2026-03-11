## Test environments
* local Windows 10 install, R 4.5.2
* win-builder (devel and release)
* R-hub (ubuntu-gcc-release, fedora-clang-devel, windows-x86_64-devel)

## R CMD check results
0 errors | 0 warnings | 0 notes

## Downstream dependencies
There are currently no downstream dependencies for this package.

## Changes in this version
This is a major update to v0.2.0:
* Added comprehensive testing using `testthat` (>30 test categories).
* Added many new scientific utility functions (e.g., PCR simulators, motif finding, plotting).
* Improved code efficiency by replacing loops with vectorized base R functions.
* Ensured graceful handling of NA and NULL objects across all package components.
