# Robot Framework installation

* download and install python 3.7.4
* download the fitted geckodriver (to firefox) and chromedriver (to chrome)
* add the drivers to path (system environment variable)
* add the python installation root dir to path
* add the python\Scripts dir to path
* install the following packages from command line
 * pip install robotframework==4.0.3
 * pip install robotframework-seleniumlibrary==5.1.3

## Test execution - local machine

* checkout the source from the given git repository
* use the following command to execute the test: <br />
robot --variable browser:Chrome (your path)/BTA\_HOMEWORK/BTA\_ROBOT/BTA\_TESTS/BTA\_SMOKE.robot 
 * if you want to run on firefox, use --variable browser:Firefox switch
 
## Test execution - docker windows

* install docker desktop to your machine
* open windows power shell
* build docker image <br />
 docker build (your path)\docker-robot-framework-\
* check and get the image id <br />
 docker images
* run the container <br />
 docker run -v (your path to collect reports)\:/opt/robotframework/reports:Z -v (your robot scripts path)\BTA_HOMEWORK\BTA_TESTS\:/opt/robotframework/tests:Z  -e BROWSER=chrome (image id)