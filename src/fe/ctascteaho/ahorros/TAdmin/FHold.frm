VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FHold 
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Aumentar días de hold para reservas locales"
   ClientHeight    =   4320
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9300
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   4320
   ScaleWidth      =   9300
   Tag             =   "3127"
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   1785
      Style           =   2  'Dropdown List
      TabIndex        =   15
      Top             =   40
      Width           =   2430
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
      TabIndex        =   14
      Top             =   1440
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8040
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   13
      Top             =   1440
      Visible         =   0   'False
      Width           =   195
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1800
      TabIndex        =   0
      Top             =   435
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
      TabIndex        =   2
      Top             =   3360
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
      TabIndex        =   3
      Top             =   2595
      WhatsThisHelpID =   2003
      Width           =   870
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
      TabIndex        =   4
      Top             =   1830
      WhatsThisHelpID =   2007
      Width           =   870
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
      Height          =   2460
      Left            =   45
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   1725
      Width           =   8250
      _Version        =   65536
      _ExtentX        =   14552
      _ExtentY        =   4339
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
      TabIndex        =   10
      Top             =   1065
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
   Begin MSMask.MaskEdBox mskDias 
      Height          =   285
      Left            =   1800
      TabIndex        =   1
      Top             =   1080
      Visible         =   0   'False
      Width           =   645
      _ExtentX        =   1138
      _ExtentY        =   503
      _Version        =   393216
      MaxLength       =   2
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "##"
      PromptChar      =   "_"
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto:"
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
      Index           =   3
      Left            =   15
      TabIndex        =   16
      Top             =   90
      WhatsThisHelpID =   5048
      Width           =   915
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Días de Aumento:"
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
      TabIndex        =   12
      Top             =   1065
      Visible         =   0   'False
      WhatsThisHelpID =   5395
      Width           =   1620
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
      TabIndex        =   11
      Top             =   1080
      Visible         =   0   'False
      Width           =   2520
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8350
      Y1              =   1425
      Y2              =   1440
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
      TabIndex        =   9
      Top             =   1485
      WhatsThisHelpID =   5396
      Width           =   3660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Descripcion:"
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
      TabIndex        =   8
      Top             =   735
      WhatsThisHelpID =   5017
      Width           =   1155
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta:"
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
      Left            =   0
      TabIndex        =   7
      Top             =   435
      WhatsThisHelpID =   5016
      Width           =   1365
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
      Left            =   1800
      TabIndex        =   6
      Top             =   735
      UseMnemonic     =   0   'False
      Width           =   6480
   End
End
Attribute VB_Name = "FHold"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FHold.frm
' NOMBRE LOGICO:    FHold
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
' en una Cuenta Corriente.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Dic-02      J. Hidalgo      Emisión Inicial
'*************************************************************
Option Explicit
Dim VLRespaldo As String
Dim HayRegistro As Boolean
Dim VTNuevaFila As Integer
Dim VTCiudad As String
Dim VTFechaDepo As String
Dim VTFechaEfe As String
Dim i As Integer


Private Sub cmbTipo_GotFocus()
     FPrincipal!pnlHelpLine.Caption = " Tipo de Producto"
End Sub

Private Sub cmbTipo_LostFocus()
  If cmbTipo.Text = "CUENTA CORRIENTE" Then
        mskCuenta.Mask = VGMascaraCtaCte$
  Else
        mskCuenta.Mask = VGMascaraCtaAho$
  End If
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Dim VTProd As Integer
    Select Case Index%
    Case 0
        'Buscar
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El número de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

        If cmbTipo.ListIndex = 0 Then
            VTProd% = 3
        Else
            VTProd% = 4
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "710"  '638
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "S"
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VTProd%
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_addhold_locales", True, " Ok... Reservas de Cuenta [ " + mskCuenta.Text + " ]") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
             For i% = 1 To grdRegistros.Rows - 1
                 grdRegistros.Row = i%
                 grdRegistros.Col = 0
                 grdRegistros.Picture = picVisto(1)
             Next i%
             lblDescripcion(1).Caption = ""
             mskDias.Visible = False
             mskDias.Text = ""
             lblEtiqueta(1).Visible = False
             cmdBoton(3).Enabled = False
         Else
             PMLimpiaGrid grdRegistros
         End If
    Case 1
        'Limpiar
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        lblDescripcion(0).Caption = ""
        lblDescripcion(1).Caption = ""
        mskDias.Visible = False
        mskDias.Text = ""
        lblEtiqueta(1).Visible = False
        PMLimpiaGrid grdRegistros
        grdRegistros.Col = 0
        grdRegistros.Row = 1
        grdRegistros.Picture = LoadPicture()
        mskCuenta.SetFocus
        cmdBoton(3).Enabled = False
    Case 2
        'Salir
        Unload FHold
    Case 3
        'Transmitir
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El número de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If
        If CDbl(mskDias.Text) <= 0 Then
            MsgBox "El monto debe ser mayor a 0.", 0 + 16, "Mensaje de Error"
            mskDias.SetFocus
            Exit Sub
        End If
        If cmbTipo.ListIndex = 0 Then
            VTProd% = 3
        Else
            VTProd% = 4
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "710"  '638
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "A"
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
         PMPasoValores sqlconn&, "@i_dias_add", 0, SQLMONEY, CDbl(mskDias.Text)
         PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4, VTCiudad
         PMPasoValores sqlconn&, "@i_fecha_depo", 0, SQLDATETIME, Format$(VTFechaDepo, "mm/dd/yyyy") ''registro del grid
         PMPasoValores sqlconn&, "@i_fecha_efe", 0, SQLDATETIME, Format$(VTFechaEfe, "mm/dd/yyyy") ''registro del grid
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VTProd%
         
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_addhold_locales", True, " Ok... Reservas Locales de la Cuenta [ " + mskCuenta.Text + " ]") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
             cmdBoton_Click (0)
             lblDescripcion(1).Caption = ""
             mskDias.Text = ""
             mskDias.Visible = False
             lblEtiqueta(1).Visible = False
         End If
    End Select
End Sub

Private Sub Form_Load()
    Me.Left = 0   '15
    Me.Top = 0   '15
    Me.Width = 9450   '9420
    Me.Height = 4725   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaCte$
    mskDias.Format = VGDecimales$
    VLRespaldo = "N"
    HayRegistro = False
    cmdBoton(3).Enabled = False
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 0
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
    grdRegistros.Col = 2
    lblDescripcion(1).Caption = grdRegistros.Text
    mskDias.Text = "0"
    grdRegistros.Col = 1
    VTFechaDepo = grdRegistros.Text
    grdRegistros.Col = 3
    VTFechaEfe = grdRegistros.Text
    grdRegistros.Col = 4
    VTCiudad = grdRegistros.Text
    mskDias.Visible = True
    lblEtiqueta(1).Visible = True
    cmdBoton(3).Enabled = True
    mskDias.SetFocus
Else
    VTNuevaFila% = grdRegistros.Row
    ''Si ya existe un registro marcado, y este coincide con el
    ''registro que se desea marcar
    If HayRegistro = True And grdRegistros.Picture = picVisto(0) Then
        PMMarcarRegistro (False)
        HayRegistro = False
        lblDescripcion(1).Caption = ""
        mskDias.Text = "0"
        mskDias.Visible = False
        lblEtiqueta(1).Visible = False
        cmdBoton(3).Enabled = False
    End If
    
    ''Si ya existe un registro marcado, y este NO coincide con el
    ''registro que se desea marcar
    If HayRegistro = True And grdRegistros.Picture <> picVisto(0) Then
        For i% = 1 To grdRegistros.Rows - 1
            grdRegistros.Row = i%
            grdRegistros.Picture = picVisto(1)
        Next i%
        grdRegistros.Row = VTNuevaFila%
        grdRegistros.Col = 2
        lblDescripcion(1).Caption = grdRegistros.Text
        mskDias.Text = "0"
        grdRegistros.Col = 1
        VTFechaDepo = grdRegistros.Text
        grdRegistros.Col = 3
        VTFechaEfe = grdRegistros.Text
        grdRegistros.Col = 4
        VTCiudad = grdRegistros.Text
        PMMarcarRegistro (True)
        HayRegistro = True
        mskDias.Visible = True
        lblEtiqueta(1).Visible = True
        cmdBoton(3).Enabled = True
        mskDias.SetFocus
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
    Dim VLBaseD As String
    Dim VLSP As String
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaCte((mskCuenta.ClipText)) Then
            If cmbTipo.ListIndex = 0 Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                VLBaseD$ = "cob_cuentas"
                VLSP$ = "sp_tr_query_nom_ctacte"
            Else
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
                VLBaseD$ = "cob_ahorros"
                VLSP$ = "sp_tr_query_nom_ctahorro"
            End If
           PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
           PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
           PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
         
           If FMTransmitirRPC(sqlconn&, ServerName$, VLBaseD$, VLSP$, True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
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

Private Sub mskDias_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Monto a Liberar"
    mskDias.SelStart = 0
    mskDias.SelLength = Len(mskDias.Text)
End Sub

Private Sub mskDias_KeyPress(KeyAscii As Integer)
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

