mkdir "temp" 2> nul
tools\armips AnyCrosses.s -sym bn6f-all-stars.sym -strequ ver "bn6f.s"
if errorlevel 1 pause
tools\armips AnyCrosses.s -sym bn6g-all-stars.sym -strequ ver "bn6g.s"
if errorlevel 1 pause
