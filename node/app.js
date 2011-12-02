var io = require('socket.io').listen(8080);

io.sockets.on('connection', function (socket) {
  socket.on('draw-coords', function (data) {
    console.log(data);
    socket.broadcast.emit('draw', data);
  });

  socket.on('clear', function(data){
    socket.broadcast.emit('clear', {});
  });
});
