VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{F856EC8B-F03C-4515-BDC6-64CBD617566A}#6.0#0"; "fpSpr60.ocx"
Begin VB.Form FTran084 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Detalle de Transacciones"
   ClientHeight    =   5325
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9300
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Index           =   2
      Left            =   1890
      TabIndex        =   11
      Top             =   700
      Width           =   915
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   960
      MaxLength       =   3
      TabIndex        =   2
      Top             =   30
      Width           =   675
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Index           =   1
      Left            =   7680
      TabIndex        =   0
      Top             =   0
      Width           =   675
   End
   Begin FPSpreadADO.fpSpread grdResultado 
      Height          =   4005
      Left            =   30
      TabIndex        =   1
      Top             =   1245
      Width           =   8310
      _Version        =   393216
      _ExtentX        =   14658
      _ExtentY        =   7064
      _StockProps     =   64
      AutoClipboard   =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaxCols         =   1
      MaxRows         =   1
      SpreadDesigner  =   "FTRAN084.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   3
      Top             =   4545
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
      Height          =   735
      Index           =   0
      Left            =   8415
      TabIndex        =   12
      Top             =   3050
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   1
      Left            =   8415
      TabIndex        =   13
      Top             =   3800
      WhatsThisHelpID =   2020
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Siguien&tes"
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
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2850
      TabIndex        =   10
      Top             =   700
      Width           =   5490
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Transacción:"
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
      Height          =   270
      Index           =   3
      Left            =   120
      TabIndex        =   9
      Top             =   700
      Width           =   1905
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   1890
      TabIndex        =   8
      Top             =   375
      Width           =   6450
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Transacción:"
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
      Height          =   270
      Index           =   1
      Left            =   120
      TabIndex        =   7
      Top             =   375
      Width           =   1665
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   0
      X2              =   8370
      Y1              =   1140
      Y2              =   1125
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Agencia:"
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
      Height          =   270
      Index           =   2
      Left            =   120
      TabIndex        =   6
      Top             =   30
      Width           =   945
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   1650
      TabIndex        =   5
      Top             =   30
      Width           =   3690
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5365
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Turno (TE)/Rol (ATX):"
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
      Height          =   270
      Index           =   0
      Left            =   5520
      TabIndex        =   4
      Top             =   30
      WhatsThisHelpID =   5077
      Width           =   2025
   End
End
Attribute VB_Name = "FTran084"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTRAN084.frm
' NOMBRE LOGICO:    FTran084
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
' Permite obtener un detalle de las transacciones
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VLPaso As Boolean
Dim VTTabla As String
Dim VTTipo As String
Dim VTCatalogo As Boolean

Private Sub cmdBoton_Click(Index As Integer)
Select Case Index%
    Case 0
        PLBuscar
    Case 1
        PLSiguientes
    Case 2
        Unload Me
End Select
End Sub

Private Sub Form_Load()
    Me.Left = 0   '15
    Me.Top = 0   '15
    Me.Width = 9450   '9420
    Me.Height = 5900   '5730
    
    PMLoadResStrings Me
    PMLoadResIcons Me
    
    VTTabla = ""
    VTTipo = ""
        
    If VGNumTransaccion = "2781" Then
       VTTabla = "cc_tipo_entidad"
       VTCatalogo = True
    ElseIf VGNumTransaccion = "2782" Then
       VTTabla = "cc_tipo_impuesto"
       VTCatalogo = True
    ElseIf VGNumTransaccion = "2783" Then
       VTTabla = "cc_tipo_tarjeta"
       VTCatalogo = True
    ElseIf VGNumTransaccion = "2790" Then
       VTTabla = "cc_causa_ing_varios"
       VTCatalogo = True
    Else
       VTCatalogo = False
       txtCampo(2).Enabled = False
    End If
    
    If txtCampo(2).Text <> "" Then
       VTTipo = txtCampo(2).Text
    Else
       If VGNumTransaccion = "2784" Then
           VTTipo = "4"
       ElseIf VGNumTransaccion = "2785" Then
           VTTipo = "6"
       ElseIf VGNumTransaccion = "2786" Then
           VTTipo = "7"
       ElseIf VGNumTransaccion = "2787" Then
           VTTipo = "8"
       End If
    End If

    grdResultado.CellType = 5
    grdResultado.EditMode = True
    grdResultado.Lock = False

    txtCampo(0).Text = VGCodAgencia
    txtCampo_LostFocus (0)
    txtCampo(1).Text = VGTurno
    lblDescripcion(1).Caption = VGTransaccion
''    txtCampo(2).Text = VGNumTransaccion
''    txtCampo_LostFocus (2)
    cmdBoton_Click (0)
    txtCampo(0).Enabled = False
    txtCampo(1).Enabled = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 1
        VLPaso = True
        FPrincipal!pnlHelpLine.Caption = " Tipo de Transacción [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
If Keycode = VGTeclaAyuda% Then
        If Index% = 2 Then
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VTTabla
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la agencia " & "[" & txtCampo(1).Text & "]") Then
                 PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(2).Text = VGACatalogo.Codigo$
                lblDescripcion(2).Caption = VGACatalogo.Descripcion$
            End If
        VLPaso = True
        End If
    End If
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
        Case 0 ''Código de Agencia
            If txtCampo(0).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(0).Text)
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la agencia " & "[" & txtCampo(0).Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(0)
                     PMChequea sqlconn&
                Else
                    VLPaso = True
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                End If
            Else
                lblDescripcion(0).Caption = ""
            End If
        Case 2 ''Tipo de transaccion
''                VGNumTransaccion = txtCampo(2).Text
            If txtCampo(2).Text <> "" Then
                 If VTCatalogo = True Then
                     PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VTTabla
                     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                     PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, txtCampo(2).Text
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la transaccion " & "[" & txtCampo(2).Text & "]") Then
                         PMMapeaObjeto sqlconn&, lblDescripcion(2)
                         PMChequea sqlconn&
                     Else
                        VLPaso = True
                        txtCampo(2).Text = ""
                        lblDescripcion(2).Caption = ""
                     End If
                Else
                    lblDescripcion(2).Caption = VTTipo
                End If
            Else
                lblDescripcion(2).Caption = ""
            End If
        End Select
End Sub

Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Realiza la consulta de los primeros 20 registros
' INPUT    : ninguna
' OUTPUT   : ninguna
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    grdResultado.CellType = 5
    grdResultado.EditMode = True
    grdResultado.Lock = False
    
    VTTabla = ""
    VTTipo = ""
    
    If VGNumTransaccion = "2781" Then
       VTTabla = "cc_tipo_entidad"
       VTCatalogo = True
    ElseIf VGNumTransaccion = "2782" Then
       VTTabla = "cc_tipo_impuesto"
       VTCatalogo = True
    ElseIf VGNumTransaccion = "2783" Then
       VTTabla = "cc_tipo_tarjeta"
       VTCatalogo = True
    ElseIf VGNumTransaccion = "2790" Then
       VTTabla = "cc_causa_ing_varios"
       VTCatalogo = True
    Else
       VTCatalogo = False
       txtCampo(2).Enabled = False
    End If
    
    If txtCampo(2).Text <> "" Then
       VTTipo = txtCampo(2).Text
    Else
       If VGNumTransaccion = "2784" Then
           VTTipo = "04"
       ElseIf VGNumTransaccion = "2785" Then
           VTTipo = "06"
       ElseIf VGNumTransaccion = "2786" Then
           VTTipo = "07"
       ElseIf VGNumTransaccion = "2787" Then
           VTTipo = "08"
       End If
    End If
       
       
''       Else
''           VGNumTransaccion = ""
''       End If
    
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2794"
        PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "T"
        PMPasoValores sqlconn&, "@i_agencia", 0, SQLINT2, VGCodAgencia
        PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda
        PMPasoValores sqlconn&, "@i_operador", 0, SQLVARCHAR, VGOperador
        If VGTurno = "" Then ''Se origino en la pantalla de totales por agencia
        PMPasoValores sqlconn&, "@i_turno", 0, SQLINT2, VGRol$
        Else ''Se origino en la pantalla de totales por operador
        PMPasoValores sqlconn&, "@i_turno", 0, SQLINT2, VGTurno
        End If
        PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT4, VGNumTransaccion
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, VTTipo
        PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, "0"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_integra_totales", True, "Ok... Consulta Detalle de Transacciones.") Then
           PMMapeaGrid sqlconn&, grdResultado, False
           PMChequea sqlconn&
          If Val(grdResultado.MaxRows) >= 20 Then
             cmdBoton(1).Enabled = True
            Else
              cmdBoton(1).Enabled = False
          End If
          If grdResultado.MaxRows <= 2 Then
             grdResultado.Col = 1
             grdResultado.Row = 1
             If grdResultado.Text = "" Then
                PMLimpiaG grdResultado
                Exit Sub
             End If
          End If
          If cmdBoton(1).Enabled = True Then
             cmdBoton(0).Enabled = False
    ''         cmdBoton(1).SetFocus
          End If
    ''      txtCampo(2).SetFocus
        Else
           PMLimpiaG grdResultado
       End If
    grdResultado.CellType = 5
    grdResultado.EditMode = False
    grdResultado.Lock = True
End Sub

Private Sub PLSiguientes()
'*************************************************************
' PROPOSITO: Realiza la consulta de los siguientes 20 registros
'            despues de haber realizado ya una consulta
' INPUT    : ninguna
' OUTPUT   : ninguna
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Dim VTSecuencial As String
    
    grdResultado.CellType = 5
    grdResultado.EditMode = True
    grdResultado.Lock = False
   
   grdResultado.Row = grdResultado.MaxRows
   grdResultado.Col = 3
   VTSecuencial$ = grdResultado.Text
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2794"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "T"
    PMPasoValores sqlconn&, "@i_agencia", 0, SQLINT2, VGCodAgencia
    PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda
    PMPasoValores sqlconn&, "@i_operador", 0, SQLVARCHAR, VGOperador
    If VGTurno = "" Then
    PMPasoValores sqlconn&, "@i_turno", 0, SQLINT2, VGRol$
    Else
    PMPasoValores sqlconn&, "@i_turno", 0, SQLINT2, VGTurno
    End If
    PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT4, VGNumTransaccion
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, VTTipo
    PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, VTSecuencial$
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_integra_totales", True, "Ok... Consulta Detalle de Transacciones.") Then
       PMMapeaGrid sqlconn&, grdResultado, True
       PMChequea sqlconn&
      If Val(grdResultado.Tag) >= 20 Then
         cmdBoton(1).Enabled = True
        Else
          cmdBoton(1).Enabled = False
          cmdBoton(0).Enabled = True
      End If
      If grdResultado.MaxRows <= 2 Then
         grdResultado.Col = 1
         grdResultado.Row = 1
         If grdResultado.Text = "" Then
            PMLimpiaG grdResultado
            txtCampo(2).SetFocus
            Exit Sub
         End If
      End If
      If cmdBoton(1).Enabled = True Then
         cmdBoton(1).SetFocus
      End If
    Else
        PMLimpiaG grdResultado
        txtCampo(2).SetFocus
   End If
    grdResultado.CellType = 5
    grdResultado.EditMode = False
    grdResultado.Lock = True
End Sub


