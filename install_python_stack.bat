@ECHO OFF

ECHO Installing Python packages and libraries...

:: NB! Wheels such as numpy and lxml depend on Python version.
:: You can download new wheels from
:: https://www.lfd.uci.edu/~gohlke/pythonlibs/
:: Put Python file, numpy and lxml wheels into the directory with the script.

:: NB! Module `lxml` must be installed via wheel,
:: otherwise `pip install python-docx` will raise an error.

SET python_file="python-3.7.0.exe"
SET python_ver_expected="Python 3.7.0"
SET numpy_file="numpy-1.15.0+mkl-cp37-cp37m-win32.whl"
SET lxml_file="lxml-4.2.3-cp37-cp37m-win32.whl"

:: Check if python exists in the PATH.
:: NB! The command `where` works only in cmd line. Use command `Get-Command` in PowerShell.
ECHO Trying 'where python' pattern to find Python's path, if any.
where python
IF %ERRORLEVEL% NEQ 0 (GOTO install_python) ELSE (GOTO check_python_version)

:check_python_version
FOR /F "tokens=* USEBACKQ" %%G IN (`python -V`) DO (SET python_ver=%%G)
IF "%python_ver%"==%python_ver_expected% (GOTO update_packages) ELSE (GOTO install_python)

:install_python
ECHO Installing Python...
:: Install Python automatically, the user will see the popup window.
:: Specify the path as to TargetDir.
"%~dp0\%python_file%" /quiet /passive InstallAllUsers=1 PrependPath=1 TargetDir=c:\python3

:update_packages
ECHO Updating Python libraries...
python -m pip install --upgrade pip

pip install pandas -U
pip install xlsxwriter -U
pip install xlrd -U
pip install scipy -U
pip install sklearn -U
pip install whoosh -U
pip install matplotlib -U
pip install plotly==2.7.0
pip install requests -U
pip install bs4 -U
pip install "%~dp0\%lxml_file%"
pip install gensim -U
pip install nltk -U
:: nltk.stem.WordNetLemmatizer
python -m nltk.downloader wordnet
:: nltk.word_tokenize
python -m nltk.downloader punkt
:: similar to "import ntlk; nltk.download('punkt')"
:: nltk.pos_tag
python -m nltk.downloader maxent_treebank_pos_tagger
python -m nltk.downloader averaged_perceptron_tagger
:: numpy must be the last in the list
:: because pandas and scipy have numpy dependencies
:: and they overwrite numpy mkl version for Windows.
pip install "%~dp0\%numpy_file%"

pip install flask -U
pip install selenium -U
pip install python-docx -U

:: Additional optional packages
pip install cx_freeze -U

:finished
ECHO ---------------------
ECHO FINISHED!
ECHO ---------------------

pause
