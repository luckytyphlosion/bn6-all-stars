mkdir "temp" 2> nul
tools\armips AnyCrosses.s -sym bn6f-all-stars.sym -strequ ver "bn6f.s"
if errorlevel 1 pause
