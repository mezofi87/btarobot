# Robot Framework installation

* download and install python 3.7.4
* download the fitted geckodriver (to firefox) and chromedriver (to chrome)
* add the drivers to path (system environment variable)
* add the python installation root dir to path
* add the python\Scripts dir to path
* install the following packages from command line
 * pip install robotframework==4.0.3
 * pip install robotframework-seleniumlibrary==5.1.3

## Test execution

* checkout the source from the given git repository
* use the following command to execute the test: <br />
robot --variable browser:Chrome (your path)/BTA\_HOMEWORK/BTA\_ROBOT/BTA\_TESTS/BTA\_SMOKE.robot 
 * if you want to run on firefox, use --variable browser:Firefox switch