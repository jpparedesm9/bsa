VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran098 
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Liberación Anticipada de Reserva Local en Ahorros"
   ClientHeight    =   5325
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9300
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Tag             =   "3122"
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8040
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   1
      Top             =   1080
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7800
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   0
      Top             =   1080
      Visible         =   0   'False
      Width           =   195
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2280
      TabIndex        =   2
      Top             =   75
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8400
      TabIndex        =   3
      Top             =   4560
      WhatsThisHelpID =   2008
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Salir"
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8400
      TabIndex        =   4
      Top             =   3795
      WhatsThisHelpID =   2003
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Limpiar"
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8400
      TabIndex        =   5
      Top             =   3030
      WhatsThisHelpID =   2007
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Transmitir"
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
      Enabled         =   0   'False
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   1950
      Left            =   45
      TabIndex        =   6
      TabStop         =   0   'False
      Top             =   1365
      Width           =   8250
      _Version        =   65536
      _ExtentX        =   14552
      _ExtentY        =   3440
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8400
      TabIndex        =   7
      Top             =   2260
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
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSMask.MaskEdBox mskMonto 
      Height          =   285
      Left            =   2280
      TabIndex        =   8
      Top             =   720
      Visible         =   0   'False
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSGrid.Grid grdCheques 
      Height          =   1680
      Left            =   45
      TabIndex        =   15
      TabStop         =   0   'False
      Top             =   3555
      Width           =   8250
      _Version        =   65536
      _ExtentX        =   14552
      _ExtentY        =   2963
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cheques Devueltos:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   15
      TabIndex        =   16
      Top             =   3330
      WhatsThisHelpID =   5342
      Width           =   1800
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   0
      Left            =   2280
      TabIndex        =   14
      Top             =   375
      UseMnemonic     =   0   'False
      Width           =   6000
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta corriente:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   15
      TabIndex        =   13
      Top             =   75
      WhatsThisHelpID =   5016
      Width           =   2175
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la chequera:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   0
      TabIndex        =   12
      Top             =   375
      WhatsThisHelpID =   5017
      Width           =   2130
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Reservas Posibles a Liberar de la Cuenta:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   60
      TabIndex        =   11
      Top             =   1125
      WhatsThisHelpID =   5347
      Width           =   3660
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8350
      X2              =   8350
      Y1              =   0
      Y2              =   5315
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8350
      Y1              =   1065
      Y2              =   1080
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   1
      Left            =   5760
      TabIndex        =   10
      Top             =   720
      Visible         =   0   'False
      Width           =   2520
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Monto a Liberar:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   30
      TabIndex        =   9
      Top             =   705
      Visible         =   0   'False
      WhatsThisHelpID =   5346
      Width           =   1485
   End
End
Attribute VB_Name = "FTran098"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTRAN098.frm
' NOMBRE LOGICO:    FTran098
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
' Permite la liberación anticipada de las reservas locales
' en una Cuenta de Ahorros.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Dic-02      J. Hidalgo      Emisión Inicial
'*************************************************************

Dim VLRespaldo As String
Dim HayRegistro As Boolean
Dim VTNuevaFila As Integer
Dim VTCiudad As String
Dim VTFechaDepo As String
Dim VTFechaEfe As String

Private Sub cmdBoton_Click(Index As Integer)
    Dim i As Integer
    Select Case Index%
    Case 0
        'Buscar
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El número de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "331"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "R"
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_reten_locales_ah", True, " Ok... Reservas de Cuenta [ " + mskCuenta.Text + " ]") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMMapeaGrid sqlconn&, grdCheques, False
             PMChequea sqlconn&
             For i = 1 To grdRegistros.Rows - 1
                 grdRegistros.Row = i
                 grdRegistros.Col = 0
                 grdRegistros.Picture = picVisto(1)
             Next i
             lblDescripcion(1).Caption = ""
             mskMonto.Visible = False
             mskMonto.Text = ""
             lblEtiqueta(1).Visible = False
             cmdBoton(3).Enabled = False
         Else
           PMLimpiaGrid grdRegistros
           PMLimpiaGrid grdCheques
         End If
    Case 1
        'Limpiar
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        lblDescripcion(0).Caption = ""
        lblDescripcion(1).Caption = ""
        mskMonto.Visible = False
        mskMonto.Text = ""
        lblEtiqueta(1).Visible = False
        PMLimpiaGrid grdRegistros
        PMLimpiaGrid grdCheques
        grdRegistros.Col = 0
        grdRegistros.Row = 1
        grdRegistros.Picture = LoadPicture()
        mskCuenta.SetFocus
        cmdBoton(3).Enabled = False
    Case 2
        'Salir
        Unload FTran098
    Case 3
        'Transmitir
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El número de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

        If CDbl(mskMonto.Text) < 0 Or CDbl(lblDescripcion(1).Caption) < CDbl(mskMonto.Text) Then
            MsgBox "El monto debe ser mayor a 0 y menor o igual al monto seleccionado.", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "332"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "L"
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
         PMPasoValores sqlconn&, "@i_monto", 0, SQLMONEY, CDbl(mskMonto.Text)
         PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4, VTCiudad
         PMPasoValores sqlconn&, "@i_fecha_depo", 0, SQLDATETIME, FMConvFecha(VTFechaDepo, VGFormatoFecha, "mm/dd/yyyy")
         PMPasoValores sqlconn&, "@i_fecha_efe", 0, SQLDATETIME, FMConvFecha(VTFechaEfe, VGFormatoFecha, "mm/dd/yyyy")
         
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_reten_locales_ah", True, " Ok... Reservas Locales de la Cuenta [ " + mskCuenta.Text + " ]") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
             cmdBoton_Click (0)
             lblDescripcion(1).Caption = ""
             mskMonto.Text = ""
             mskMonto.Visible = False
             lblEtiqueta(1).Visible = False
         End If
    End Select
End Sub

Private Sub Form_Load()
    FTran098.Left = 0   '15
    FTran098.Top = 0   '15
    FTran098.Width = 9450   '9420
    FTran098.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaCte$
    mskMonto.Format = VGDecimales$
    VLRespaldo = "N"
    HayRegistro = False
    cmdBoton(3).Enabled = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
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
Dim i As Integer
' Verificar que existan reservas por liberar
If grdRegistros.Rows <= 2 Then
    grdRegistros.Row = 1
    grdRegistros.Col = 1
    If Trim$(grdRegistros.Text) = "" Then
        MsgBox "No existen reservas por liberar", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If
End If
grdRegistros.Col = 0
If HayRegistro = False Then
    VTNuevaFila% = grdRegistros.Row
    PMMarcarRegistro (True)
    HayRegistro = True
    grdRegistros.Col = 3
    lblDescripcion(1).Caption = grdRegistros.Text
    mskMonto.Text = grdRegistros.Text
    grdRegistros.Col = 1
    VTFechaDepo = grdRegistros.Text
    grdRegistros.Col = 4
    VTFechaEfe = grdRegistros.Text
    grdRegistros.Col = 5
    VTCiudad = grdRegistros.Text
    mskMonto.Visible = True
    lblEtiqueta(1).Visible = True
    cmdBoton(3).Enabled = True
Else
    VTNuevaFila% = grdRegistros.Row
    ''Si ya existe un registro marcado, y este coincide con el
    ''registro que se desea marcar
    If HayRegistro = True And grdRegistros.Picture = picVisto(0) Then
        PMMarcarRegistro (False)
        HayRegistro = False
        lblDescripcion(1).Caption = ""
        mskMonto.Text = ""
        mskMonto.Visible = False
        lblEtiqueta(1).Visible = False
        cmdBoton(3).Enabled = False
    End If
    
    ''Si ya existe un registro marcado, y este NO coincide con el
    ''registro que se desea marcar
    If HayRegistro = True And grdRegistros.Picture <> picVisto(0) Then
        For i = 1 To grdRegistros.Rows - 1
            grdRegistros.Row = i
            grdRegistros.Picture = picVisto(1)
        Next i
        grdRegistros.Row = VTNuevaFila%
        grdRegistros.Col = 3
        lblDescripcion(1).Caption = grdRegistros.Text
        mskMonto.Text = grdRegistros.Text
        grdRegistros.Col = 1
        VTFechaDepo = grdRegistros.Text
        grdRegistros.Col = 4
        VTFechaEfe = grdRegistros.Text
        grdRegistros.Col = 5
        VTCiudad = grdRegistros.Text
        PMMarcarRegistro (True)
        HayRegistro = True
        mskMonto.Visible = True
        lblEtiqueta(1).Visible = True
        cmdBoton(3).Enabled = True
    End If
End If
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
            Else
                cmdBoton_Click (1)
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
            cmdBoton_Click (1)
            Exit Sub
        End If
    Else
     lblDescripcion(0).Caption = ""
     PMLimpiaGrid grdRegistros
     PMLimpiaGrid grdCheques
    End If
End Sub
Private Sub PMMarcarRegistro(Opcion As Boolean)
'*************************************************************
' PROPOSITO: Seleccionar y quitar la Seleccion de una fila del
'            grid de Posibles Reservas a Liberar.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    grdRegistros.Col = 0
    If Opcion = True Then
        grdRegistros.Picture = picVisto(0)
    Else
        grdRegistros.Picture = picVisto(1)
    End If
End Sub

Private Sub mskMonto_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Monto a Liberar"
    mskMonto.SelStart = 0
    mskMonto.SelLength = Len(mskMonto.Text)
End Sub

Private Sub mskMonto_KeyPress(KeyAscii As Integer)
    If KeyAscii% = Asc("+") Then
        SendKeys "{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
    If KeyAscii% = Asc("-") Then
        SendKeys "+{TAB}"
        KeyAscii% = 0
        Exit Sub
    End If
    If VGDecimales$ = "#,##0" Then
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Else
        If (KeyAscii% <> 8) And (KeyAscii% <> 46) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End If
End Sub


