VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form grid_valores 
   Appearance      =   0  'Flat
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Listado de Registros Seleccionados"
   ClientHeight    =   2460
   ClientLeft      =   3825
   ClientTop       =   1425
   ClientWidth     =   5235
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00C0C0C0&
   LinkMode        =   1  'Source
   LinkTopic       =   "Form3"
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2460
   ScaleWidth      =   5235
   Begin VB.CommandButton bb_cancelar 
      Caption         =   "&Cancelar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   4320
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   2070
      Width           =   900
   End
   Begin VB.CommandButton bb_escoger 
      Caption         =   "&Escoger"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3390
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   2070
      Width           =   900
   End
   Begin VB.CommandButton bb_siguiente 
      Caption         =   "Si&guiente"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   930
      Style           =   1  'Graphical
      TabIndex        =   1
      Top             =   2070
      Width           =   900
   End
   Begin VB.CommandButton bb_buscar 
      Caption         =   "&Buscar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   15
      Style           =   1  'Graphical
      TabIndex        =   0
      Top             =   2070
      Width           =   900
   End
   Begin MSGrid.Grid gr_SQL 
      Height          =   2040
      Left            =   15
      TabIndex        =   2
      Top             =   15
      Width           =   5205
      _Version        =   65536
      _ExtentX        =   9182
      _ExtentY        =   3599
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label dl_sp 
      Appearance      =   0  'Flat
      ForeColor       =   &H00C0C0C0&
      Height          =   270
      Left            =   2295
      TabIndex        =   5
      Top             =   2085
      Width           =   2385
   End
End
Attribute VB_Name = "grid_valores"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010

Private Sub bb_buscar_Click()
Dim i%
Dim Verdadero%
Dim Falso%
     PMPasoValores sqlconn&, AGBuscar(1).nombre, 0, AGBuscar(1).tipo, AGBuscar(1).valor
     PMPasoValores sqlconn&, AGBuscar(2).nombre, 0, AGBuscar(2).tipo, AGBuscar(2).valor
     PMPasoValores sqlconn&, AGBuscar(3).nombre, 0, AGBuscar(3).tipo, AGBuscar(3).valor
    For i% = 4 To VGPBuscar%
         PMPasoValores sqlconn&, AGBuscar(i%).nombre, 0, AGBuscar(i%).tipo, AGBuscar(i%).valor
    Next i%
     If FMTransmitirRPC(sqlconn&, ServerName$, VGBaseDatos$, (dl_sp.Caption), True, "Help") Then
         PMMapeaGrid sqlconn&, gr_SQL, False
         PMChequea sqlconn&
        If gr_SQL.Rows >= VGMaximoRows% Then
            bb_siguiente.Enabled = Verdadero%
        Else
            bb_siguiente.Enabled = Falso%
        End If
    End If
End Sub

Private Sub bb_cancelar_Click()
    ReDim Temporales(10)
    PMLimpiaG gr_SQL
    grid_valores.Hide
End Sub

Private Sub bb_escoger_Click()
    gr_SQL_DblClick
End Sub

'! Private Sub bb_salir_Click()
'! End Sub
'!
Private Sub bb_siguiente_Click()
Dim i%
    If gr_SQL.Rows >= VGMaximoRows% Then
         PMPasoValores sqlconn&, AGBuscar(1).nombre, 0, AGBuscar(1).tipo, AGBuscar(1).valor
         PMPasoValores sqlconn&, AGBuscar(2).nombre, 0, AGBuscar(2).tipo, AGBuscar(2).valor
         PMPasoValores sqlconn&, AGBuscar(3).nombre, 0, AGBuscar(3).tipo, Str$(Val(AGBuscar(3).valor) + 1)
        For i% = 4 To VGPBuscar%
             PMPasoValores sqlconn&, AGBuscar(i%).nombre, 0, AGBuscar(i%).tipo, AGBuscar(i%).valor
        Next i%
        gr_SQL.Row = gr_SQL.Rows - 1
        For i% = 1 To VGPSiguiente%
            gr_SQL.Col = AGSiguiente(i%).Col
             PMPasoValores sqlconn&, AGSiguiente(i%).nombre, 0, AGSiguiente(i%).tipo, (gr_SQL.Text)
        Next i%
         If FMTransmitirRPC(sqlconn&, ServerName$, VGBaseDatos$, (dl_sp.Caption), True, "Help - Siguiente") Then
             PMMapeaGrid sqlconn&, gr_SQL, False
             PMChequea sqlconn&
            If gr_SQL.Rows >= VGMaximoRows% Then
                bb_siguiente.Enabled = True
            Else
                bb_siguiente.Enabled = False
            End If
        End If
    End If
End Sub

Private Sub gr_SQL_Click()
    PMLineaG gr_SQL
End Sub

Private Sub gr_SQL_DblClick()
Dim c%
    ReDim Temporales(gr_SQL.Cols - 1)
    For c% = 1 To gr_SQL.Cols - 1
        gr_SQL.Col = c%
        Temporales(c%) = gr_SQL.Text
    Next c%
    PMLimpiaG gr_SQL
    grid_valores.Hide
End Sub

Private Sub gr_SQL_KeyPress(KeyAscii As Integer)
Dim c%
Dim KEY_ESCAPE As Integer
    If KeyAscii = 13 Then
        ReDim Temporales(gr_SQL.Cols)
        For c% = 1 To gr_SQL.Cols - 1
            gr_SQL.Col = c%
            Temporales(c%) = gr_SQL.Text
        Next c%
        PMLimpiaG gr_SQL
        grid_valores.Hide
    Else
    If KeyAscii = KEY_ESCAPE Then
        ReDim Temporales(10)
        PMLimpiaG gr_SQL
        grid_valores.Hide
    End If
    End If

End Sub



