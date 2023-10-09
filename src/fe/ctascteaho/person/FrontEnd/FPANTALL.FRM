VERSION 5.00
Begin VB.Form fpantalla 
   BorderStyle     =   0  'None
   ClientHeight    =   11520
   ClientLeft      =   -195
   ClientTop       =   -195
   ClientWidth     =   15360
   ClipControls    =   0   'False
   FillColor       =   &H8000000F&
   ForeColor       =   &H8000000F&
   Icon            =   "FPANTALL.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   768
   ScaleMode       =   0  'User
   ScaleWidth      =   1024
   ShowInTaskbar   =   0   'False
   WindowState     =   2  'Maximized
   Begin VB.Timer Timer2 
      Left            =   0
      Top             =   360
   End
   Begin VB.Timer Timer1 
      Left            =   0
      Top             =   0
   End
   Begin VB.Image Image1 
      Height          =   2400
      Index           =   3
      Left            =   5520
      Top             =   3240
      Visible         =   0   'False
      Width           =   3720
   End
   Begin VB.Image Image2 
      Appearance      =   0  'Flat
      Height          =   735
      Left            =   0
      Top             =   0
      Visible         =   0   'False
      Width           =   1815
   End
   Begin VB.Image Image1 
      Height          =   2400
      Index           =   1
      Left            =   5520
      Picture         =   "FPANTALL.frx":0442
      Top             =   0
      Visible         =   0   'False
      Width           =   3720
   End
   Begin VB.Image Image1 
      Height          =   810
      Index           =   2
      Left            =   5520
      Picture         =   "FPANTALL.frx":201A
      Top             =   2400
      Visible         =   0   'False
      Width           =   3990
   End
End
Attribute VB_Name = "fpantalla"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Public ban As Boolean
Public dx As Integer
Public dy As Integer

Dim m_TaskBar As cTaskBar


Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)
Call Form_MouseDown(1, 0, 0, 0)
End Sub

Private Sub Form_Load()

Dim dTask As Integer
Dim junk As Boolean
Dim i As Integer
Dim isStarted As Boolean
Dim startErr  As Long
Set m_TaskBar = New cTaskBar


ARCHIVOINIPAN$ = VGPath$ + "\pantalla.ini"

Iniciar_PreferenciasPan ARCHIVOINIPAN$

'Verifica el sistema operativo bajo el cual se esta
'corriendo el protector de pantalla

ban = EsWindows95

If ban Then
    dTask = SystemParametersInfo(SPI_SCREENSAVERRUNNING, True, junk, 0)
Else
    isStarted = isLLHookStarted()
    
    If Not isStarted Then
       startErr = StartLLKeybHook()
    End If

End If

color = RGB(255, 255, 255)
'P_FIXIT: Replace 'Me.ForeColor=[Value]' function with 'Me.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: Me.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
Me.ForeColor = color
Me.BackColor = color
'FIXIT: Me.Cls method has no Visual Basic .NET equivalent and will not be upgraded.        FixIT90210ae-R7594-R67265
Me.Cls

    m_TaskBar.AlwaysOnTop = False

ValidarInicio 1
For i = 2 To 4
If bandera(i) Then
    ValidarInicio i
End If
Next i

End Sub

Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
FControl.Show
FControl.txtCampo(0).SetFocus
End Sub

Private Sub Form_Terminate()
    Final
End Sub



Private Sub Form_Unload(Cancel As Integer)
    Escribir_ini_Pan ARCHIVOINIPAN$
    Final
End Sub

Private Sub Timer1_Timer()
Dim i As Integer
For i = 0 To 7 Step 2                'Y
    If Points(i).YDirection = "Down" Then
        Points(i).YValue = Points(i).YValue + Points(i).YIncrement
        If Points(i).XDirection = "Right" Then
            Points(i).XValue = Points(i).XValue + Points(i).XIncrement
        Else
            Points(i).XValue = Points(i).XValue - Points(i).XIncrement
        End If
    Else
        Points(i).YValue = Points(i).YValue - Points(i).YIncrement
        If Points(i).XDirection = "Right" Then
            Points(i).XValue = Points(i).XValue + Points(i).XIncrement
        Else
            Points(i).XValue = Points(i).XValue - Points(i).XIncrement
        End If
    End If
Next i

For i = 1 To 6 Step 2
    If Points(i).XDirection = "Right" Then
        Points(i).XValue = Points(i).XValue + Points(i).XIncrement
        If Points(i).YDirection = "Down" Then
            Points(i).YValue = Points(i).YValue + Points(i).YIncrement
        Else
            Points(i).YValue = Points(i).YValue - Points(i).YIncrement
        End If
    Else
        Points(i).XValue = Points(i).XValue - Points(i).XIncrement
        If Points(i).YDirection = "Down" Then
            Points(i).YValue = Points(i).YValue + Points(i).YIncrement
        Else
            Points(i).YValue = Points(i).YValue - Points(i).YIncrement
        End If
    End If
Next i

HitSide
'P_FIXIT: Replace 'fpantalla.ForeColor=[Value]' function with 'fpantalla.ForeColor=System.Drawing.ColorTranslator.FromOle([Value])' function in .NET                                       FixIT90210ae-R9757-R1B8ZE
'FIXIT: fpantalla.ForeColor property has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
fpantalla.ForeColor = color
DrawBeziers
ChangeColour

AssignValues
DrawBeziers

'FIXIT: fpantalla.Line method has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
fpantalla.Line (p1(0).X, p1(0).Y)-(p6(0).X, p6(0).Y)


End Sub

Public Sub Final()
Dim dTask As Integer
Dim junk As Boolean
Dim isStarted As Boolean
Dim startErr As Long
If ban Then
    dTask = SystemParametersInfo(SPI_SCREENSAVERRUNNING, False, junk, 0)
Else
    isStarted = isLLHookStarted()
    If Not isStarted Then
       startErr = StopLLKeybHook()
    End If
End If

FPrincipal.Show

End Sub

Public Sub ValidarInicio(tipo As Integer)

Select Case tipo
    Case 1
        If bandera(1) Then
            Bezier
            fpantalla.Timer1.Interval = 10
        Else
'FIXIT: Timer1.Interval property = 0 can not be upgraded. Set Timer.Enabled = False instead.     FixIT90210ae-R7594-R67265
            fpantalla.Timer1.Interval = 0
'FIXIT: fpantalla.Cls method has no Visual Basic .NET equivalent and will not be upgraded.     FixIT90210ae-R7594-R67265
            fpantalla.Cls
        End If
    Case 2 To 4
        If bandera(tipo) Then
            Image2.Picture = Image1(tipo - 1).Picture
            Randomize
            X = Int(Rnd * (fpantalla.Width / 15 - Image2.Width - 1))
            Randomize
            Y = Int(Rnd * (fpantalla.Height / 15 - Image2.Height - 1))
            Randomize
            dx = IIf(Int(Rnd * 2) = 0, 10, -10)
            Randomize
            dy = IIf(Int(Rnd * 2) = 0, 10, -10)
            Image2.Top = Y
            Image2.Left = X
            Image2.Visible = True
            Timer2.Interval = 100
        Else
            Image2.Visible = False
'FIXIT: Timer2.Interval property = 0 can not be upgraded. Set Timer.Enabled = False instead.     FixIT90210ae-R7594-R67265
            Timer2.Interval = 0
        End If

End Select

End Sub


Private Sub Timer2_Timer()
If Image2.Left + Image2.Width + dx >= fpantalla.Width / 15 Or Image2.Left + dx <= 0 Then
    dx = dx * (-1)
End If
If Image2.Top + Image2.Height + dy >= fpantalla.Height / 15 Or Image2.Top + dy <= 0 Then
    dy = dy * (-1)
End If
Image2.Top = Image2.Top + dy
Image2.Left = Image2.Left + dx
End Sub


