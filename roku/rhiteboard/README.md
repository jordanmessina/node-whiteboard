Rhiteboard is a Roku application.

1. You must put your Roku into the dev mode

2. Set your Roku IP toSet the variable ROKU_DEV_TARGET in 
your environment to the IP address of your Roku box.

3. Modify source/appMain.brs var 'nodeServerIP' to your 
Node Server IP. For example:

    nodeServerIP = "192.168.1.2:8080"

4. Install the Rhiteboard app on your Roku

    make install
