VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "Msmask32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FAyuda2 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "*Lista de Cuentas de Movimiento"
   ClientHeight    =   3555
   ClientLeft      =   2970
   ClientTop       =   1770
   ClientWidth     =   6360
   ControlBox      =   0   'False
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00FFFFFF&
   Icon            =   "FAYUDA2.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3555
   ScaleWidth      =   6360
   Tag             =   "3872"
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1710
      TabIndex        =   0
      Top             =   15
      Width           =   2850
      _ExtentX        =   5027
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdSeleccion 
      Height          =   870
      Index           =   3
      Left            =   5475
      TabIndex        =   4
      Top             =   2670
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      RoundedCorners  =   0   'False
      Picture         =   "FAYUDA2.frx":000C
   End
   Begin Threed.SSCommand cmdSeleccion 
      Height          =   870
      Index           =   2
      Left            =   5475
      TabIndex        =   3
      Top             =   1785
      WhatsThisHelpID =   2002
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Escoger"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
      RoundedCorners  =   0   'False
      Picture         =   "FAYUDA2.frx":0028
   End
   Begin Threed.SSCommand cmdSeleccion 
      Height          =   870
      Index           =   1
      Left            =   5475
      TabIndex        =   2
      Top             =   900
      WhatsThisHelpID =   2020
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Sig&tes."
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
      RoundedCorners  =   0   'False
      Picture         =   "FAYUDA2.frx":0044
   End
   Begin Threed.SSCommand cmdSeleccion 
      Height          =   870
      Index           =   0
      Left            =   5475
      TabIndex        =   1
      Top             =   15
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Buscar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      RoundedCorners  =   0   'False
      Picture         =   "FAYUDA2.frx":0060
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3180
      Left            =   15
      TabIndex        =   5
      Top             =   360
      Width           =   5400
      _Version        =   65536
      _ExtentX        =   9526
      _ExtentY        =   5610
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   15
      X2              =   5430
      Y1              =   330
      Y2              =   330
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   0
      Left            =   0
      TabIndex        =   6
      Top             =   45
      WhatsThisHelpID =   5016
      Width           =   1515
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   5445
      X2              =   5445
      Y1              =   0
      Y2              =   3540
   End
End
Attribute VB_Name = "FAyuda2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit   
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Private Sub cmdSeleccion_Click(Index As Integer)
    Select Case Index%
    Case 0
        PLBuscar VGOperacion$
    Case 1
        PLSiguientes VGOperacion$
    Case 2
        PLSeleccionar
    Case 3
        PLSalir
    End Select
End Sub
Private Sub Form_KeyPress(KeyAscii As Integer)
    If KeyAscii% = 27 Then
        PLSalir
    End If
End Sub
Private Sub Form_Load()
 PMLoadResStrings Me
 PMLoadResIcons Me
    
    mskCuenta.Mask = VGMascaraConta$
    Select Case VGOperacion$
    Case "sp_busca_cuenta"
       If Trim$(VGAyuda(4)) <> "" Then
          mskCuenta.Text = FMMascara(VGAyuda(4), VGMascaraConta$)
       End If
    End Select
End Sub
Private Sub grdRegistros_Click()
    grdRegistros.Col = 0
    grdRegistros.SelStartCol = 1
    grdRegistros.SelEndCol = grdRegistros.Cols - 1
    If grdRegistros.Row = 0 Then
        grdRegistros.SelStartRow = 1
        grdRegistros.SelEndRow = 1
    Else
        grdRegistros.SelStartRow = grdRegistros.Row
        grdRegistros.SelEndRow = grdRegistros.Row
    End If
End Sub
Private Sub grdregistros_DblClick()
    PLSeleccionar
End Sub
Private Sub grdRegistros_KeyDown(Keycode As Integer, Shift As Integer)
'    If KeyCode% = 115 Then
'        PMCopyClip grdRegistros
'    End If
End Sub
Private Sub grdRegistros_KeyPress(KeyAscii As Integer)
    If KeyAscii% = 13 Then
        PLSeleccionar
    End If
End Sub
Private Sub mskCuenta_Change()
    PMLimpiaGrid grdRegistros
    cmdSeleccion(1).Enabled = False
    cmdSeleccion(2).Enabled = False
End Sub
Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Busqueda de cuentas de movimiento"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub
Private Sub PLBuscar(tipo As String)
    Select Case tipo$
    Case "sp_busca_cuenta"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6017"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
         PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText) & "%"
         PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR, "%"
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, "%"
         PMPasoValores sqlconn&, "@i_movimiento", 0, SQLCHAR, "S"
                    
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_conta", "sp_busca_cuenta", True, "Ok Busqueda de movimientos") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
            grdRegistros.ColWidth(1) = 1155
        End If
    End Select
    If Val(grdRegistros.Tag) > 0 Then
        cmdSeleccion(2).Enabled = True
        If Val(grdRegistros.Tag) >= 20 Then
            cmdSeleccion(1).Enabled = True
        Else
            cmdSeleccion(1).Enabled = False
        End If
    Else
        cmdSeleccion(2).Enabled = False
    End If
End Sub
Private Sub PLSalir()
    ReDim VGAyuda(5) As String
    For i% = 1 To 5
        VGAyuda(i%) = ""
    Next i%
    Unload FAyuda2
End Sub
Private Sub PLSeleccionar()
    If (grdRegistros.Cols - 1) = 1 Or grdRegistros.Row = 0 Then
        ReDim VGAyuda(5) As String
        For i% = 1 To 5
            VGAyuda(i%) = ""
        Next i%
    Else
        ReDim VGAyuda(grdRegistros.Cols - 1) As String
        For i% = 1 To grdRegistros.Cols - 1
            grdRegistros.Col = i%
            VGAyuda(i%) = grdRegistros.Text
        Next i%
    End If
    Unload FAyuda2
End Sub
Private Sub PLSiguientes(tipo As String)
    Select Case tipo$
    Case "sp_busca_cuenta"

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6017"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
         PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText) & "%"
         PMPasoValores sqlconn&, "@i_nombre", 0, SQLVARCHAR, "%"
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, "%"
         PMPasoValores sqlconn&, "@i_movimiento", 0, SQLCHAR, "S"
         grdRegistros.Col = 1
         grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_cuenta1", 0, SQLVARCHAR, (grdRegistros.Text)
                    
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_conta", "sp_busca_cuenta", True, "Ok Busqueda de movimientos") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
            grdRegistros.ColWidth(1) = 1155
        End If
    End Select
    If Val(grdRegistros.Tag) >= 20 Then
        cmdSeleccion(1).Enabled = True
    Else
        cmdSeleccion(1).Enabled = False
    End If
End Sub

