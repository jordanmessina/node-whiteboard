Rhiteboard is a Roku application.

How To Install
--------------

- You must put your Roku in the dev mode

- Set your Roku IP toSet the variable ROKU_DEV_TARGET in 
your environment to the IP address of your Roku box.

    export ROKU_DEV_TARGET=<YOUR ROKU IP>

- Modify rhiteboard/source/appMain.brs var 'nodeServerIP' to your 
Node Server IP. For example:


    nodeServerIP = "192.168.1.2:8080"


- Install the Rhiteboard app on your Roku


    make install

