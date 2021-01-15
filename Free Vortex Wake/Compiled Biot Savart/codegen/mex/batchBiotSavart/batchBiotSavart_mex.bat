@echo off
set MATLAB=F:\PROGRA~2\MATLAB\R2020b
call "F:\Program Files\MATLAB\R2020b\sys\lcc64\lcc64\mex\lcc64opts.bat"
"F:\Program Files\MATLAB\R2020b\toolbox\shared\coder\ninja\win64\ninja.exe" -t compdb cc cxx cudac > compile_commands.json
"F:\Program Files\MATLAB\R2020b\toolbox\shared\coder\ninja\win64\ninja.exe" -v %*
