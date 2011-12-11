' ********************************************************************
' **  Rhiteboard - Easy remote whiteboards
' **  December 2011
' **  Copyright (c) 2011 Jordan Messina
' ********************************************************************

'returns list of points:
'[
'   [232, 523],
'   [324, 234],
'   [15, 34],
']
Function FindAllPoints (pattern As String, subject As String, flags As String) As Object

   regex = CreateObject("roRegex", pattern, flags)

   response = Left(subject, Len(subject))

   values = []
   matches = regex.Match( response )

   While matches.Count() > 1
      values.Push( [matches[1], matches[2]])
      ' remove this instance, so we can get the next match
      response = regex.Replace( response, "" )
      matches = regex.Match( response )
   End While

   Return values

End Function


sub Main()

  ' globals
  canvasItems = []
  time = CreateObject("roDateTime")
  remote = CreateObject("roUrlTransfer")

  ' example "192.168.1.2:8080"
  nodeServerIP = "INSERT YOUR NODE SERVER IP HERE"

  ' create our canvas
  canvas = CreateObject("roImageCanvas")
  canvas.AllowUpdates(true)
  canvas.SetLayer(0, {Color:"#FFCCCCCC", CompositionMode:"Source"})
  canvas.SetLayer(1, canvasItems)
  canvas.Show()


  remote.SetUrl("http://" + nodeServerIP + "/socket.io/1/xhr-polling/")
  result = remote.GetToString()
  session_id = left(result, Instr(1, result, ":")-1)
   
  loop_counter = 1
  while true
      'do shit here
      canvasItems = []
      remote.SetUrl("http://" + nodeServerIP + "/socket.io/1/xhr-polling/"+session_id+"?t="+STR(time.asSeconds()*100))
      response = remote.GetToString()
      points = FindAllPoints("\[([0-9]{1,3}),([0-9]{1,3})\]", response, "")
      if points.Count() > 0 then
          for each point in points
              canvasItems.push({ Text: "."
                                 TextAttrs:{Color:"#FF000000", Font:"Small", 
                                            HAlign:"HCenter", VAlign:"VCenter",
                                            Direction:"LeftToRight"}
                                 TargetRect:{x:point[0].ToInt(),y:point[1].ToInt(),w:1,h:1}
              })
          end for
          canvas.SetLayer(loop_counter, canvasItems)
          canvas.Show()
          loop_counter = loop_counter + 1
      end if
    canvas.Show()
  end while

  screen.Close()
  ' any time all screens in a channel are closed, the channel will exit
end sub
