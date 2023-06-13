Const ForReading = 1
Const ForWriting = 2

Dim inputFile, outputFile, objFSO, objInputFile, objOutputFile
Dim ipAddress, result

 

' File paths
inputFile = "C:\Users\RPanovsky\OneDrive - Sempra North American Infrastructure\Desktop\IPList.txt"
outputFile = "C:\Users\RPanovsky\OneDrive - Sempra North American Infrastructure\Desktop\OutputFile.txt"

 

' Create File System Object

 

Set objFSO = CreateObject("Scripting.FileSystemObject")

 

' Open input file for reading
Set objInputFile = objFSO.OpenTextFile(inputFile, ForReading)

' Open output file for writing
Set objOutputFile = objFSO.OpenTextFile(outputFile, ForWriting, True)

' Process each IP address in the input file
Do Until objInputFile.AtEndOfStream
    ipAddress = Trim(objInputFile.ReadLine())
    result = RunCommand("nslookup " & ipAddress)

    ' Check if DNS record found or not
    If InStr(result, "Name:") > 0 Then
        ' Extract the DNS record from the result
        dnsRecord = Trim(Split(result, vbCrLf)(3))
        objOutputFile.WriteLine(ipAddress & ", " & dnsRecord)
    Else
        objOutputFile.WriteLine(ipAddress & ": FAILED")
    End If
Loop

' Close the files
objInputFile.Close
objOutputFile.Close

' Clean up objects
Set objInputFile = Nothing
Set objOutputFile = Nothing
Set objFSO = Nothing

' Function to run a command and return the output
Function RunCommand(command)
    Dim objShell, objExec, output

    Set objShell = CreateObject("WScript.Shell")
    Set objExec = objShell.Exec("%comspec% /c " & command)

    ' Read the command output
    output = objExec.StdOut.ReadAll

    ' Clean up objects
    Set objExec = Nothing
    Set objShell = Nothing

    ' Return the output
    RunCommand = output

 

End Function
