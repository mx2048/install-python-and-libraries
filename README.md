# install-python-and-libraries
A batch script installs Python and its libraries on a Windows user machine. 

Requirements:
- [Python release](https://www.python.org)
- [Python libraries](https://www.lfd.uci.edu/~gohlke/pythonlibs): numpy and lxml
- Put the downloaded files to the directory with the batch script.
- Initialize the filenames in the batch file, for example:
```
SET python_file="python-3.7.0.exe"
SET python_ver_expected="Python 3.7.0"
SET numpy_file="numpy-1.15.0+mkl-cp37-cp37m-win32.whl"
SET lxml_file="lxml-4.2.3-cp37-cp37m-win32.whl"
```
