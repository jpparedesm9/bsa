VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form grid_valores 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
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
   Begin Threed.SSCommand bb_cancelar 
      Height          =   375
      Left            =   4305
      TabIndex        =   4
      Top             =   2070
      WhatsThisHelpID =   2012
      Width           =   900
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Cancelar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   3
   End
   Begin Threed.SSCommand bb_escoger 
      Height          =   375
      Left            =   3390
      TabIndex        =   3
      Top             =   2070
      WhatsThisHelpID =   2042
      Width           =   900
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Escoger"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   3
   End
   Begin Threed.SSCommand bb_siguiente 
      Height          =   375
      Left            =   930
      TabIndex        =   1
      Top             =   2070
      WhatsThisHelpID =   2040
      Width           =   900
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Si&guiente"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   3
   End
   Begin Threed.SSCommand bb_buscar 
      Height          =   375
      Left            =   15
      TabIndex        =   0
      Top             =   2070
      WhatsThisHelpID =   2061
      Width           =   900
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Buscar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      BevelWidth      =   3
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
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label dl_sp 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FHELPG.frm
' NOMBRE LOGICO:    grid_valores
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
' Permite indicar un listado de los registros seleccionados
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Private Sub bb_buscar_Click()
     PMPasoValores sqlconn&, AGBuscar(1).nombre, 0, AGBuscar(1).tipo, AGBuscar(1).valor
     PMPasoValores sqlconn&, AGBuscar(2).nombre, 0, AGBuscar(2).tipo, AGBuscar(2).valor
     PMPasoValores sqlconn&, AGBuscar(3).nombre, 0, AGBuscar(3).tipo, AGBuscar(3).valor
    For i% = 4 To VGPBuscar%
         PMPasoValores sqlconn&, AGBuscar(i%).nombre, 0, AGBuscar(i%).tipo, AGBuscar(i%).valor
    Next i%
     If FMTransmitirRPC(sqlconn&, ServerName$, VGBaseDatos$, (dl_sp.Caption), True, "Help") Then
         PMMapeaGrid sqlconn&, gr_SQL, False
         PMChequea sqlconn&
        If (dl_sp.Caption) <> "sp_hp_catalogo" Then
            If gr_SQL.Rows >= VGMaximoRows% Then
                bb_siguiente.Enabled = True
            Else
                bb_siguiente.Enabled = False
            End If
        Else
            bb_siguiente.Enabled = False
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

Private Sub bb_siguiente_Click()
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
             PMMapeaGrid sqlconn&, gr_SQL, True
             PMChequea sqlconn&
            If gr_SQL.Tag >= VGMaximoRows% - 1 Then
                bb_siguiente.Enabled = True
            Else
                bb_siguiente.Enabled = False
            End If
            If (gr_SQL.Rows >= (VGMaximoRows%)) Then
                gr_SQL.TopRow = gr_SQL.Rows - VGMaximoRows%
            End If
        End If
    End If
End Sub

Private Sub Form_Load()
PMLoadResStrings Me
    PMLoadResIcons Me
End Sub

Private Sub gr_SQL_Click()
    PMLineaG gr_SQL
End Sub

Private Sub gr_SQL_DblClick()
    If Val(gr_SQL.Tag) > 0 Then
        ReDim Temporales(gr_SQL.Cols - 1)
        For C% = 1 To gr_SQL.Cols - 1
            gr_SQL.Col = C%
            Temporales(C%) = gr_SQL.Text
        Next C%
        PMLimpiaG gr_SQL
    Else
        ReDim Temporales(10)
    End If
    grid_valores.Hide
End Sub

Private Sub gr_SQL_KeyPress(KeyAscii As Integer)
    'If KeyAscii = 13 Then
    '    ReDim Temporales(gr_SQL.Cols)
    '    For C% = 1 To gr_SQL.Cols - 1
    '        gr_SQL.Col = C%
    '        Temporales(C%) = gr_SQL.Text
    '    Next C%
    '    PMLimpiaG gr_SQL
    '    grid_valores.Hide
    'Else
    If KeyAscii = KEY_ESCAPE Then
        ReDim Temporales(10)
        PMLimpiaG gr_SQL
        grid_valores.Hide
    End If
    'End If

End Sub


