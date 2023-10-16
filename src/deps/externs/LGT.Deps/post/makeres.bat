@echo off
del "post\LGT.Deps.dll"
copy /Y /V ".\x64\Release\LGT.Deps.dll" ".\post\LGT.Deps.dll"
IF EXIST "..\..\..\..\tools\upx.exe" (
    "..\..\..\..\tools\upx.exe" -9 --ultra-brute ".\post\LGT.Deps.dll"
  ) ELSE (
      echo UPX was not found.
  )
call brcc32.exe ".\post\res.rc" -v -fo..\..\..\..\src\LGT.Deps.res
