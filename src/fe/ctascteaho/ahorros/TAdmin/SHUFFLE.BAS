Attribute VB_Name = "SHUFFLE"
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          SHUFFLE.BAS
' NOMBRE LOGICO:    SHUFFLE
' PRODUCTO:         Terminal Administrativa
'*************************************************************
'                       IMPORTANTE
' Esta aplicacion es parte de los paquetes bancarios propiedad
' de MACOSA S.A.
' Su uso no  autorizado queda  expresamente prohibido asi como
' cualquier  alteracion o  agregado  hecho por  alguno  de sus
' usuarios sin el debido consentimiento por escrito de MACOSA.
' Este programa esta protegido por la ley de derechos de autor
' y por las  convenciones  internacionales de  propiedad inte-
' lectual.  Su uso no  autorizado dara  derecho a  MACOSA para
' obtener ordenes  de secuestro o  retencion y para  perseguir
' penalmente a los autores de cualquier infraccion.
'*************************************************************
'                         PROPOSITO
'               Nuevo protector de pantalla con NCS
'*******************************************************************
'                       MODIFICACIONES
' FECHA             AUTOR                      RAZON
' 08-Jun-2001       Alfonso Duque A.           Modificación para NCS
'*******************************************************************


'Declara funciones válidas
Option Explicit


Public Declare Function SystemParametersInfo Lib "user32" Alias "SystemParametersInfoA" (ByVal uAction As Long, ByVal uParam As Long, lpvParam As Any, ByVal fuWinIni As Long) As Long
Public Declare Function GetWinPlatform Lib "VB5STKIT.DLL" () As Long
Public Declare Function isLLHookStarted Lib "Pantalla.dll" () As Boolean
Public Declare Function StartLLKeybHook Lib "Pantalla.dll" () As Long
Public Declare Function StopLLKeybHook Lib "Pantalla.dll" () As Long
Public Declare Function PolyBezier Lib "gdi32" (ByVal hDC As Long, lppt As POINTAPI, ByVal cPoints As Long) As Long

Public Const SPI_SCREENSAVERRUNNING = 97

Public ARCHIVOINIPAN As String
Global PreferenciasPan() As String
Public imagen As Image


Public Type POINTAPI
        X As Long
        Y As Long
End Type


Public p1(3) As POINTAPI
Public p2(3) As POINTAPI
Public p3(3) As POINTAPI
Public p4(3) As POINTAPI               ' Declara los puntos de las curvas bezier.
Public p5(3) As POINTAPI
Public p6(3) As POINTAPI
Public p7(3) As POINTAPI
Public p8(3) As POINTAPI
Public p9(3) As POINTAPI
'FIXIT: Declare 'intCol1' and 'intCol2' and 'intCol3' with an early-bound data type        FixIT90210ae-R1672-R1B8ZE
Public intCol1 As Integer
Public intCol2 As Integer
Public intCol3 As Integer
'FIXIT: Declare 'colDir1' and 'colDir2' and 'colDir3' with an early-bound data type        FixIT90210ae-R1672-R1B8ZE
Public colDir1 As String
Public colDir2 As String
Public colDir3 As String      ' Dirección de los valores RGBmientras se mueve.

Private Type PointDir
    XDirection As String
    YDirection As String
    XValue As Integer
    YValue As Integer
    XIncrement As Integer
    YIncrement As Integer
    pX As POINTAPI
    pY As POINTAPI
End Type

Public Points(9) As PointDir

Public color As Long

Public X As Integer
Public Y As Integer
Public VTcont As Integer

Public bandera(1 To 4) As Boolean


'-----------------------------------------------------------
' FUNCION: EsWindows95
' Retorne un valor de verdadero si el protector de pantalla
' se corre bajo Windows 95 o su sucesor
'-----------------------------------------------------------

Function EsWindows95() As Boolean
    Const dwMask95 = &H2&
    If GetWinPlatform() And dwMask95 Then
        EsWindows95 = True
    Else
        EsWindows95 = False
    End If
End Function

Public Sub Bezier()
Dim r As Integer
Randomize

If App.PrevInstance Then End


fpantalla.WindowState = 2

Randomize 1
intCol1 = Int(Rnd * 255)
Randomize 1
intCol2 = Int(Rnd * 255)
Randomize 255
intCol3 = Int(Rnd * 255)

Randomize

For VTcont = 0 To 7 Step 2
    r = Int(Rnd * fpantalla.ScaleHeight)
    Points(VTcont).YValue = IIf(r > 0, r, r + 150)
    r = Int(Rnd * 5)
    Points(VTcont).YIncrement = IIf(r > 0, r, r + 10)
Next VTcont

For VTcont = 0 To 7 Step 2
    r = Int(Rnd * fpantalla.ScaleWidth)
    Points(VTcont).XValue = IIf(r > 0, r, r + 150)
    r = Int(Rnd * 5)
    Points(VTcont).XIncrement = IIf(r > 0, r, r + 10)
Next VTcont

For VTcont = 1 To 6 Step 2
    r = Int(Rnd * fpantalla.ScaleWidth)
    Points(VTcont).XValue = IIf(r > 0, r, r + 150)
    r = Int(Rnd * 5)
    Points(VTcont).XIncrement = IIf(r > 0, r, r + 10)
Next VTcont

For VTcont = 1 To 6 Step 2
    r = Int(Rnd * fpantalla.ScaleHeight)
    Points(VTcont).YValue = IIf(r > 0, r, r + 150)
    r = Int(Rnd * 5)
    Points(VTcont).YIncrement = IIf(r > 0, r, r + 10)
Next VTcont

For VTcont = 0 To 7 Step 2
    r = Int(Rnd * 2)
    If r = 1 Then
        Points(VTcont).YDirection = "Up"
        If r = 1 Then
            Points(VTcont).XDirection = "Right"
        Else
            Points(VTcont).XDirection = "Left"
        End If
    Else
        Points(VTcont).YDirection = "Down"
        If r = 1 Then
            Points(VTcont).XDirection = "Right"
        Else
            Points(VTcont).XDirection = "Left"
        End If
    End If
Next VTcont
For VTcont = 1 To 6 Step 2
    r = Int(Rnd * 2)
    If r = 1 Then
        Points(VTcont).XDirection = "Right"
        If r = 1 Then
            Points(VTcont).YDirection = "Down"
        Else
            Points(VTcont).YDirection = "Up"
        End If
    Else
        Points(VTcont).XDirection = "Left"
        If r = 1 Then
            Points(VTcont).YDirection = "Down"
        Else
            Points(VTcont).YDirection = "Up"
        End If
    End If
Next VTcont
End Sub


'FIXIT: Declare 'HitSide' with an early-bound data type                                    FixIT90210ae-R1672-R1B8ZE
Public Sub HitSide()


For VTcont = 0 To 7 Step 2
    If Points(VTcont).XValue >= fpantalla.ScaleWidth Then
        Points(VTcont).XDirection = "Left"
        Points(VTcont).XIncrement = Rnd * 20
    End If
    
    If Points(VTcont).XValue <= 0 Then
        Points(VTcont).XDirection = "Right"
        Points(VTcont).XIncrement = Rnd * 20
    End If
    
    If Points(VTcont).YValue >= fpantalla.ScaleHeight Then
        Points(VTcont).YDirection = "Up"
        Points(VTcont).YIncrement = Rnd * 20
    End If
    If Points(VTcont).YValue <= 0 Then
        Points(VTcont).YDirection = "Down"
        Points(VTcont).YIncrement = Rnd * 20
    End If
Next VTcont
For VTcont = 1 To 6 Step 2
    If Points(VTcont).YValue >= fpantalla.ScaleHeight Then
        Points(VTcont).YDirection = "Up"
        Points(VTcont).YIncrement = Rnd * 20
    End If
    If Points(VTcont).YValue <= 0 Then
        Points(VTcont).YDirection = "Down"
        Points(VTcont).YIncrement = Rnd * 20
    End If
    If Points(VTcont).XValue >= fpantalla.ScaleWidth Then
        Points(VTcont).XDirection = "Left"
        Points(VTcont).XIncrement = Rnd * 20
    End If
    If Points(VTcont).XValue <= 0 Then
        Points(VTcont).XDirection = "Right"
        Points(VTcont).XIncrement = Rnd * 20
    End If
Next VTcont

End Sub


'FIXIT: Declare 'DrawBeziers' with an early-bound data type                                FixIT90210ae-R1672-R1B8ZE
Public Sub DrawBeziers()

PolyBezier fpantalla.hDC, p1(0), 4
PolyBezier fpantalla.hDC, p2(0), 4
PolyBezier fpantalla.hDC, p3(0), 4
PolyBezier fpantalla.hDC, p4(0), 4
PolyBezier fpantalla.hDC, p5(0), 4
PolyBezier fpantalla.hDC, p6(0), 4
PolyBezier fpantalla.hDC, p7(0), 4
PolyBezier fpantalla.hDC, p8(0), 4
PolyBezier fpantalla.hDC, p9(0), 4

End Sub

'FIXIT: Declare 'AssignValues' with an early-bound data type                               FixIT90210ae-R1672-R1B8ZE
Public Sub AssignValues()

p1(0).X = Points(0).XValue
p1(0).Y = Points(0).YValue
p1(1).X = Points(1).XValue
p1(1).Y = Points(1).YValue
p1(2).X = Points(2).XValue
p1(2).Y = Points(2).YValue
p1(3).X = Points(3).XValue
p1(3).Y = Points(3).YValue

p2(0).X = Points(0).XValue
p2(0).Y = Points(0).YValue
p2(1).X = Points(1).XValue + 15
p2(1).Y = Points(1).YValue + 15
p2(2).X = Points(2).XValue + 15
p2(2).Y = Points(2).YValue + 15
p2(3).X = Points(3).XValue
p2(3).Y = Points(3).YValue

p3(0).X = Points(0).XValue
p3(0).Y = Points(0).YValue
p3(1).X = Points(1).XValue + 30
p3(1).Y = Points(1).YValue + 30
p3(2).X = Points(2).XValue + 30
p3(2).Y = Points(2).YValue + 30
p3(3).X = Points(3).XValue
p3(3).Y = Points(3).YValue

p4(0).X = Points(0).XValue
p4(0).Y = Points(0).YValue
p4(1).X = Points(1).XValue + 45
p4(1).Y = Points(1).YValue + 45
p4(2).X = Points(2).XValue + 45
p4(2).Y = Points(2).YValue + 45
p4(3).X = Points(3).XValue
p4(3).Y = Points(3).YValue

p5(0).X = Points(0).XValue
p5(0).Y = Points(0).YValue
p5(1).X = Points(1).XValue + 60
p5(1).Y = Points(1).YValue + 60
p5(2).X = Points(2).XValue + 60
p5(2).Y = Points(2).YValue + 60
p5(3).X = Points(3).XValue
p5(3).Y = Points(3).YValue

p6(0).X = Points(0).XValue
p6(0).Y = Points(0).YValue
p6(1).X = Points(1).XValue + 75
p6(1).Y = Points(1).YValue + 75
p6(2).X = Points(2).XValue + 75
p6(2).Y = Points(2).YValue + 75
p6(3).X = Points(3).XValue
p6(3).Y = Points(3).YValue

p7(0).X = Points(0).XValue
p7(0).Y = Points(0).YValue
p7(1).X = Points(1).XValue + 90
p7(1).Y = Points(1).YValue + 90
p7(2).X = Points(2).XValue + 90
p7(2).Y = Points(2).YValue + 90
p7(3).X = Points(3).XValue
p7(3).Y = Points(3).YValue

p8(0).X = Points(0).XValue
p8(0).Y = Points(0).YValue
p8(1).X = Points(1).XValue + 105
p8(1).Y = Points(1).YValue + 105
p8(2).X = Points(2).XValue + 105
p8(2).Y = Points(2).YValue + 105
p8(3).X = Points(3).XValue
p8(3).Y = Points(3).YValue

p9(0).X = Points(0).XValue
p9(0).Y = Points(0).YValue
p9(1).X = Points(1).XValue + 120
p9(1).Y = Points(1).YValue + 120
p9(2).X = Points(2).XValue + 120
p9(2).Y = Points(2).YValue + 120
p9(3).X = Points(3).XValue
p9(3).Y = Points(3).YValue

End Sub


'FIXIT: Declare 'ChangeColour' with an early-bound data type                               FixIT90210ae-R1672-R1B8ZE
Public Sub ChangeColour()

If colDir1 = "down" Then
    intCol1 = intCol1 - 1
Else
    intCol1 = intCol1 + 1
End If
If colDir2 = "down" Then
    intCol2 = intCol2 - 1
Else
    intCol2 = intCol2 + 1
End If
If colDir3 = "down" Then
    intCol3 = intCol3 - 1
Else
    intCol3 = intCol3 + 1
End If

fpantalla.ForeColor = RGB(intCol1, intCol2, intCol3)

If intCol1 = 254 Then
    colDir1 = "down"
ElseIf intCol1 = 1 Then
    colDir1 = "up"
End If
If intCol2 = 254 Then
    colDir2 = "down"
ElseIf intCol2 = 1 Then
    colDir2 = "up"
End If
If intCol3 = 254 Then
    colDir3 = "down"
ElseIf intCol3 = 1 Then
    colDir3 = "up"
End If

End Sub


Sub Iniciar_PreferenciasPan(Filename As String)
'*********************************************************
'PROPOSITO: Dado un nombre de Archivo, copia el contenido
'           del archivo en el arreglo Preferencias()
'INPUT   :  FileName            Nombre del archivo .ini
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'*********************************************************
Dim FNum As Integer

    ReDim PreferenciasPan(5, 2)
    PreferenciasPan(1, 1) = "CURVAS"
    PreferenciasPan(2, 1) = "COBIS"
    PreferenciasPan(3, 1) = "MACOSA"
    PreferenciasPan(4, 1) = "OTRO"
    PreferenciasPan(5, 1) = "ARCHIVO"
    FNum = Abrir_Archivo(Filename) 'abrir un archivo
    If FNum > 0 Then              'apuntador del archivo
        PreferenciasPan(1, 2) = Buscar_Token(FNum, "CURVAS")
        PreferenciasPan(2, 2) = Buscar_Token(FNum, "COBIS")
        PreferenciasPan(3, 2) = Buscar_Token(FNum, "MACOSA")
        PreferenciasPan(4, 2) = Buscar_Token(FNum, "OTRO")
        PreferenciasPan(5, 2) = Buscar_Token(FNum, "ARCHIVO")
        Close #FNum
        Forma_PreferenciasPan
    Else
        bandera(1) = False
        bandera(2) = True
        bandera(3) = False
        bandera(4) = False
    End If
    
End Sub

Sub Forma_PreferenciasPan()
'*********************************************************
'PROPOSITO: Toma los datos del arreglo PreferenciasPan()
'           Verifica los datos obtenidos y activa las opciones
'           del protector
'INPUT   :  ninguno
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'*********************************************************
Dim nombre As String

'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
bandera(1) = IIf(Trim$(PreferenciasPan(1, 2)) = "1", True, False)
If Trim(PreferenciasPan(5, 2)) <> "" Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    nombre = Dir(Trim$(PreferenciasPan(5, 2)))
    If nombre <> "" Then
        On Error GoTo Salir
        Set imagen = fpantalla.Image1(3)
        bandera(4) = True
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        Set imagen.Picture = LoadPicture(Trim$(PreferenciasPan(5, 2)))
        If imagen.Height > 300 Or imagen.Width > 300 Then
            fpantalla.Image1(3) = LoadPicture()
            bandera(4) = False
            nombre = ""
        End If
    End If
End If

If Trim(PreferenciasPan(2, 2)) = "1" Then
    bandera(2) = True
    bandera(3) = False
    bandera(4) = False
Else
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(PreferenciasPan(3, 2)) = "1" Then
        bandera(2) = False
        bandera(3) = True
        bandera(4) = False
    Else
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If Trim$(PreferenciasPan(4, 2)) = "1" And nombre <> "" Then
            bandera(2) = False
            bandera(3) = False
            bandera(4) = True
        Else
            bandera(2) = False
            bandera(3) = False
            bandera(4) = False
        End If
    End If
End If

Exit Sub

Salir:
    bandera(4) = False
    Exit Sub

End Sub

Sub Escribir_ini_Pan(Filename As String)
'*********************************************************
'PROPOSITO: Dado el nombre del archivo .ini escribe el
'           contenido del Arreglo Preferencias() en
'           el archivo .ini en forma TOKEN=Valor
'INPUT   :  FileName        Nombre del Archivo
'OUTPUT  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Ago/93  M.Davila            Emisión Inicial
'*********************************************************
    Dim FNum As Integer
    Dim Linea As String
    Dim i As Integer
    
'Actualización de preferencias
For i = 1 To 4
    PreferenciasPan(i, 2) = IIf(bandera(i), "1", "0")
Next i

    On Error GoTo Salir
    FNum = FreeFile
    Open Filename For Output As #FNum
    If FNum > 0 Then
            Linea = "[PREFERENCIAS]"
            Print #FNum, Linea
        For i% = 1 To UBound(PreferenciasPan, 1)
            Linea = PreferenciasPan(i%, 1) + "=" + PreferenciasPan(i%, 2)
            Print #FNum, Linea
        Next i%
        Close (FNum)
    End If
Salir:
    Exit Sub
End Sub


