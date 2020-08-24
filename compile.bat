mkdir "temp" 2> nul
tools\armips AnyCrosses.asm -sym any-crosses.sym
if errorlevel 1 pause
