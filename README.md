This needs a lot of improvements!

About
-------

node-whiteboard is the original implementation of whit537/pictionary, which was ported to use Aspen at the PGH Python Users Group Meeting.

Dependencies
------------
socket.io

How to Run
----------

You need to serve www/ from any web server. An easy way is to use the SimpleHTTPServer module built into python:

    cd www/
    python -m SimpleHTTPServer

You also need to run the node server:

    cd node/
    node app.js

You should be able to go to http://localhost:8000 and see the whiteboard running.
