@echo off

rem 파이썬3 명령어가 실행 가능한지 확인합니다.
if exist "%ProgramFiles(x86)%\Python3\python.exe" goto :skip

rem 파이썬이 설치되어 있지 않으므로 설치를 준비합니다.
echo 파이썬이 설치되어 있지 않습니다. 설치를 준비합니다.

rem 권한 설정을 위해 powershell 복사본 활성화
powershell -NoExit -ExecutionPolicy Bypass -Command "& { Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('파이썬 설치를 위해 관리자 권한이 필요합니다. 확인 버튼을 클릭해 프로그램을 다시 실행하세요.', '관리자 권한 필요', [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Warning); exit }"

rem 권한 설정 후 bat 파일 다시 실행
start "" "%SystemRoot%\explorer.exe" "%~dp0"


:skip

powershell "(new-Object System.Net.WebClient).DownloadFile('https://www.python.org/ftp/python/3.9.6/python-3.9.6-amd64.exe', '%USERPROFILE%\Downloads\')"


start /wait "%USERPROFILE%\Downloads\python-3.9.6-amd64.exe" /passive InstallAllUsers=1 PrependPath=1 Include_test=0


del "%USERPROFILE%\Downloads\python-3.9.6-amd64.exe"

echo 구성 요소를 설치합니다.
python3 -m pip install mediapipe
powershell "(new-Object System.Net.WebClient).DownloadFile('https://github.com/helgisnw/ShoulderDetect/archive/refs/heads/main.zip', '%USERPROFILE%\Desktop\')"
powershell Expand-Archive %USERPROFILE%\Desktop\Shoulder-detect-main.zip %USERPROFILE%\Desktop\
echo main.py를 실행합니다.

python3 %USERPROFILE%\Desktop\main.py
