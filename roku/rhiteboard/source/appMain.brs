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
  time = CreateObject("roDateTime")
  remote = CreateObject("roUrlTransfer")

  ' example "192.168.1.2:8080"
  nodeServerIP = "192.168.1.2:8080"

  ' create our roScreen
  canvas = CreateObject("roScreen")
  canvas.Clear(&hFFFFFFFF)
  canvas.SetAlphaEnable(true)


  remote.SetUrl("http://" + nodeServerIP + "/socket.io/1/xhr-polling/")
  result = remote.GetToString()
  session_id = left(result, Instr(1, result, ":")-1)
   
  while true
      remote.SetUrl("http://" + nodeServerIP + "/socket.io/1/xhr-polling/"+session_id+"?t="+STR(time.asSeconds()*100))
      response = remote.GetToString()
      points = FindAllPoints("\[([0-9]{1,3}),([0-9]{1,3})\]", response, "")
      if points.Count() > 0 and (points.Count() MOD 2) = 0 then
          for i=0 to points.Count()-2 step 2
            canvas.DrawLine(points[i][0].ToInt(), points[i][1].ToInt(), points[i+1][0].ToInt(), points[i+1][1].ToInt(), &hFFFF)
          end for
          canvas.Finish()
      end if
  end while

end sub
