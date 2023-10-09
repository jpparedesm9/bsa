VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form Ftran2657 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Cuentas Concentradoras"
   ClientHeight    =   5325
   ClientLeft      =   225
   ClientTop       =   1665
   ClientWidth     =   9300
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
   ForeColor       =   &H80000008&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Index           =   1
      Left            =   5130
      MaxLength       =   1
      TabIndex        =   2
      Top             =   420
      Width           =   480
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   855
      MaxLength       =   10
      TabIndex        =   0
      Top             =   90
      Width           =   975
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   2
      Left            =   8400
      TabIndex        =   13
      Tag             =   "2516"
      Top             =   3030
      WhatsThisHelpID =   2006
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Eliminar"
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
   Begin MSGrid.Grid grdCuentas 
      Height          =   2685
      Left            =   90
      TabIndex        =   10
      Top             =   2580
      Width           =   8145
      _Version        =   65536
      _ExtentX        =   14368
      _ExtentY        =   4736
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
      Enabled         =   0   'False
   End
   Begin Threed.SSFrame frmTipocuenta 
      Height          =   1260
      Left            =   90
      TabIndex        =   3
      Top             =   840
      Width           =   1950
      _Version        =   65536
      _ExtentX        =   3440
      _ExtentY        =   2223
      _StockProps     =   14
      Caption         =   "Tipo de Cuenta"
      ForeColor       =   255
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
      Begin Threed.SSOption optTipo 
         Height          =   210
         Index           =   1
         Left            =   120
         TabIndex        =   5
         Tag             =   "R"
         Top             =   495
         Width           =   1680
         _Version        =   65536
         _ExtentX        =   2964
         _ExtentY        =   370
         _StockProps     =   78
         Caption         =   "Concentradora"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
      End
      Begin Threed.SSOption optTipo 
         Height          =   210
         Index           =   0
         Left            =   120
         TabIndex        =   4
         TabStop         =   0   'False
         Tag             =   "N"
         Top             =   270
         Width           =   1290
         _Version        =   65536
         _ExtentX        =   2276
         _ExtentY        =   370
         _StockProps     =   78
         Caption         =   "Receptora"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optTipo 
         Height          =   210
         Index           =   2
         Left            =   120
         TabIndex        =   6
         TabStop         =   0   'False
         Tag             =   "N"
         Top             =   720
         Width           =   1350
         _Version        =   65536
         _ExtentX        =   2381
         _ExtentY        =   370
         _StockProps     =   78
         Caption         =   "Generadora"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optTipo 
         Height          =   210
         Index           =   3
         Left            =   120
         TabIndex        =   7
         TabStop         =   0   'False
         Tag             =   "N"
         Top             =   945
         Width           =   1260
         _Version        =   65536
         _ExtentX        =   2223
         _ExtentY        =   370
         _StockProps     =   78
         Caption         =   "Pagadora"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8400
      TabIndex        =   15
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
      Height          =   750
      Index           =   3
      Left            =   8400
      TabIndex        =   14
      Top             =   3780
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
      Index           =   1
      Left            =   8400
      TabIndex        =   12
      Top             =   2265
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8400
      TabIndex        =   11
      Top             =   15
      WhatsThisHelpID =   2000
      Width           =   875
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   4080
      TabIndex        =   8
      Top             =   930
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      PromptChar      =   "_"
   End
   Begin VB.TextBox txtSaldo 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Left            =   4080
      MaxLength       =   15
      TabIndex        =   9
      Top             =   1530
      Width           =   1500
   End
   Begin VB.TextBox txtContrato 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   855
      MaxLength       =   10
      TabIndex        =   1
      Top             =   420
      Width           =   2205
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Transferencia:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   3150
      TabIndex        =   26
      Top             =   420
      Width           =   1950
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   5620
      TabIndex        =   25
      Top             =   420
      Width           =   2610
   End
   Begin VB.Label lblNombreCuenta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   2190
      TabIndex        =   21
      Top             =   1230
      WhatsThisHelpID =   5017
      Width           =   1935
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   1845
      TabIndex        =   20
      Top             =   90
      UseMnemonic     =   0   'False
      Width           =   6390
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Cliente:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   60
      TabIndex        =   24
      Top             =   135
      Width           =   660
   End
   Begin VB.Label lblSecuencial 
      Appearance      =   0  'Flat
      BackColor       =   &H00FFFFFF&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   6345
      TabIndex        =   23
      Top             =   930
      Visible         =   0   'False
      Width           =   1110
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8370
      X2              =   8370
      Y1              =   5295
      Y2              =   -90
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   30
      X2              =   8370
      Y1              =   780
      Y2              =   765
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cuentas y sus Relaciones:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   90
      TabIndex        =   22
      Top             =   2310
      Width           =   2265
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   30
      X2              =   8355
      Y1              =   2235
      Y2              =   2220
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   4080
      TabIndex        =   19
      Top             =   1230
      Width           =   4185
   End
   Begin VB.Label lblCuenta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   2190
      TabIndex        =   18
      Top             =   930
      WhatsThisHelpID =   5016
      Width           =   750
   End
   Begin VB.Label lblSaldo 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Saldo Mínimo:"
      ForeColor       =   &H00800000&
      Height          =   285
      Left            =   2190
      TabIndex        =   17
      Top             =   1530
      Width           =   1230
   End
   Begin VB.Label lblContratro 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Contrato:"
      ForeColor       =   &H00800000&
      Height          =   270
      Left            =   45
      TabIndex        =   16
      Top             =   435
      Width           =   795
   End
End
Attribute VB_Name = "Ftran2657"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTRA2657.frm
' NOMBRE LOGICO:    Ftran2657
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
' Permite realizar el mantenimiento de las Cuentas
' Concentradoras
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VLPosicion As Integer
Dim VLPaso As Boolean

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
        Case 0 'Buscar
            PLBuscar
        Case 1 'Transmitir
            PLTransmitir
        Case 2 'Eliminar
            PLEliminar
        Case 3 'Limpiar
            PLLimpiar
        Case 4 'Salir
            Unload Me
    End Select
End Sub

Private Sub cmdBoton_GotFocus(Index As Integer)
    Select Case Index
        Case 0 'Buscar
            FPrincipal!pnlHelpLine.Caption = "Búscar Cuentas Relacionadas al Contrato"
        Case 1 'Transmitir
            FPrincipal!pnlHelpLine.Caption = "Transmitir Cuentas Relacionadas al Contrato"
        Case 2 'Eliminar
            FPrincipal!pnlHelpLine.Caption = "Eliminar Cuentas Relacionadas al Contrato"
        Case 3 'Limpiar
            FPrincipal!pnlHelpLine.Caption = "Limpiar Pantalla"
        Case 4 'Salir
            FPrincipal!pnlHelpLine.Caption = "Salir de cuentas Concentradoras"
    End Select
End Sub

Private Sub Form_Load()
    Ftran2657.Height = 5900   '5730
    Ftran2657.Width = 9450   '9420
    Ftran2657.Top = 0
    Ftran2657.Left = 0
    PMLoadResStrings Me
    PMLoadResIcons Me
    VLPosicion = 0
    mskCuenta.Mask = VGMascaraCtaCte$
    frmTipocuenta.Tag = "C"
End Sub

Private Sub grdCuentas_DblClick()
    PLEscoger
End Sub

Private Sub grdCuentas_GotFocus()
        FPrincipal!pnlHelpLine.Caption = "Cuentas Relacionadas al Contrato"
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    Dim VTBaseDatos As String
    Dim VTsp As String
    Dim VTResult As String
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaCte((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@i_cliente", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            If optTipo(2).Value Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                VTBaseDatos$ = "cob_ahorros"
                VTsp$ = "sp_tr_query_nom_ctahorro"
            Else
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                VTBaseDatos$ = "cob_cuentas"
                VTsp$ = "sp_tr_query_nom_ctacte"
            End If
             If FMTransmitirRPC(sqlconn&, ServerName$, VTBaseDatos$, VTsp$, True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(1)
                 PMMapeaVariable sqlconn&, VTResult$
                 PMChequea sqlconn&
                If VTResult$ <> txtCampo(0).Text Then 'se agrego indice
                    MsgBox "La Cuenta no pertenece al cliente que firmó el contrato", 0 + 16, "Mensaje de Error"
                    mskCuenta.Mask = ""
                    mskCuenta.Text = ""
                    mskCuenta.Mask = VGMascaraCtaCte$
                    lblDescripcion(1).Caption = ""
                    mskCuenta.SetFocus
                    Exit Sub
                End If
            Else
                mskCuenta.Mask = ""
                mskCuenta.Text = ""
                mskCuenta.Mask = VGMascaraCtaCte$
                lblDescripcion(1).Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            mskCuenta.Mask = VGMascaraCtaCte$
            lblDescripcion(1).Caption = ""
            mskCuenta.SetFocus
            Exit Sub
        End If
    Else
        lblDescripcion(1).Caption = ""
    End If
End Sub

Private Sub optTipo_Click(Index As Integer, Value As Integer)
    If frmTipocuenta.Tag = "G" Then
        mskCuenta.Mask = ""
        mskCuenta.Text = ""
        mskCuenta.Mask = VGMascaraCtaCte$
        lblDescripcion(1).Caption = ""
    End If
    Select Case Index
        Case 0
            frmTipocuenta.Tag = "R"
        Case 1
            frmTipocuenta.Tag = "C"
        Case 2
            frmTipocuenta.Tag = "G"
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            mskCuenta.Mask = VGMascaraCtaCte$
            lblDescripcion(1).Caption = ""
        Case 3
            frmTipocuenta.Tag = "P"
    End Select
    lblSecuencial.Caption = ""
End Sub

Private Sub optTipo_GotFocus(Index As Integer)
    FPrincipal!pnlHelpLine.Caption = "Tipo de Cuenta"
End Sub

Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Llena el grid con los datos retornados por el
'            stored procedure.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    If txtCampo(0).Text = "" Then 'se agrego indice
        MsgBox "Debe ingresar un Cliente", 48, "Mensaje del Servidor"
        txtCampo(0).SetFocus 'se agrego indice
        Exit Sub
    End If
    If txtContrato.Text = "" Then
        MsgBox "Debe ingresar un Número de Contrato", 48, "Mensaje del Servidor"
        txtContrato.SetFocus
        Exit Sub
    End If
    txtSaldo.Text = ""
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2657"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
     PMPasoValores sqlconn&, "@i_contrato", 0, SQLINT4, (txtContrato)
     PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCampo(0)) 'se agrego indice
     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, (VGMoneda)
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_ctas_concentradoras", True, " Ok... Consulta para Cuentas Concentradoras") Then
         PMMapeaObjetoAB sqlconn&, txtCampo(1), lblDescripcion(2)
         PMMapeaGrid sqlconn&, grdCuentas, False
         PMMapeaGrid sqlconn&, grdCuentas, True
         PMChequea sqlconn&
        VLPosicion = 0
        grdCuentas.ColWidth(1) = 1080
        grdCuentas.ColWidth(2) = 3620
        txtCampo(0).Enabled = False 'se agrego indice
        txtCampo(1).Enabled = False
        txtContrato.Enabled = False
        txtSaldo.Enabled = True
        frmTipocuenta.Enabled = True
        grdCuentas.Enabled = True
        cmdBoton(1).Enabled = True
        cmdBoton(2).Enabled = False
        'cmdBoton(3).Enabled = True
        'cmdBoton(4).Enabled = True
        mskCuenta.Enabled = True
        mskCuenta.Mask = ""
        mskCuenta.Text = ""
        mskCuenta.Mask = VGMascaraCtaCte$
        lblDescripcion(1).Caption = ""
        If frmTipocuenta.Enabled Then
            optTipo(1).Value = True
            frmTipocuenta.Tag = "C"
        End If
    Else
        txtCampo(0).Enabled = False 'se agrego indice
        txtCampo(1).Enabled = True
        txtContrato.Enabled = False
        txtCampo(1).SetFocus
        'frmTipocuenta.Enabled = True
        'txtSaldo.Enabled = True
        'mskCuenta.Enabled = True
        'mskCuenta.Mask = ""
        'mskCuenta.Text = ""
        'mskCuenta.Mask = VGMascaraCtaCte$
        'lblDescripcion(1).Caption = ""
        'cmdBoton(1).Enabled = True
        'cmdBoton(2).Enabled = False
        'cmdBoton(3).Enabled = True
        'cmdBoton(4).Enabled = True
        'PMLimpiaG grdCuentas
        'grdCuentas.ColWidth(1) = grdCuentas.ColWidth(0)
        'grdCuentas.Enabled = False
        'txtCampo(1).SetFocus
        'If frmTipocuenta.Enabled Then
        '    optTipo(1).Value = True
        '    frmTipocuenta.Tag = "C"
        'Else
        '    mskCuenta.SetFocus
        'End If
    End If
End Sub

Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Permite eliminar el registro de la cuenta
'            concentradora
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    Dim VTMensaje As String
    Dim VTResp As Integer
    If VLPosicion <> 0 Then
        VTMensaje$ = "Está seguro de ELIMINAR la Cuenta " & mskCuenta.Text
        VTMensaje$ = VTMensaje$ & " del Contrato " & txtContrato.Text & " ?"
        VTResp = MsgBox(VTMensaje$, 1 + 32, "Mensaje del Servidor")
        If VTResp = 1 Then 'Ok Eliminar
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2657"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
             PMPasoValores sqlconn&, "@i_contrato", 0, SQLINT4, (txtContrato)
             PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, (lblSecuencial.Caption)
             PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCampo(0)) 'se agrego indice
             PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_ctas_concentradoras", True, " Ok... Eliminación para Cuentas Concentradoras") Then
                 PMChequea sqlconn&
            End If
                VLPosicion = 0
                mskCuenta.Mask = ""
                mskCuenta.Text = ""
                mskCuenta.Mask = VGMascaraCtaCte$
                FPrincipal!pnlHelpLine.Caption = ""
                lblSecuencial.Caption = ""
                txtSaldo.Text = ""
                lblDescripcion(1).Caption = ""
                PLBuscar
        End If
    Else
        MsgBox "Debe seleccionar una Cuenta del Contrato", 48, "Mensaje del Servidor"
    End If
End Sub

Private Sub PLEscoger()
'*************************************************************
' PROPOSITO: Permite elegir un dato del grid y mapea sus datos
'            para realizar algunas actualizaciones
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    Dim VTValor As String
    If grdCuentas.Cols <= 2 Then
        MsgBox "No Hay Datos en el grid de Cuentas", 48, "Mensaje del Servidor"
        Exit Sub
    End If
    VLPosicion = grdCuentas.Row
    PMLineaG grdCuentas
    grdCuentas.Row = VLPosicion
    grdCuentas.Col = 3 'Columna de tipo
    Select Case grdCuentas.Text
        Case "R"
            optTipo(0).Value = True
            frmTipocuenta.Tag = "R"
        Case "C"
            optTipo(1).Value = True
            frmTipocuenta.Tag = "C"
        Case "G"
            optTipo(2).Value = True
            frmTipocuenta.Tag = "G"
        Case "P"
            optTipo(3).Value = True
            frmTipocuenta.Tag = "P"
    End Select
    grdCuentas.Col = 1 'Columna de cuentas
    VTValor$ = grdCuentas.Text
    mskCuenta.Mask = VGMascaraCtaCte$
    mskCuenta.Text = FMMascara(VTValor$, VGMascaraCtaCte$)
    grdCuentas.Col = 2 'Columna de nombre
    lblDescripcion(1).Caption = grdCuentas.Text
    grdCuentas.Col = 4 'Columna de saldo
    txtSaldo.Text = grdCuentas.Text
    grdCuentas.Col = 5 'Columna de secuencial
    lblSecuencial = grdCuentas.Text
    cmdBoton(2).Enabled = True
End Sub

Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia todos los valores de los objetos y del
'            grid de la forma.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    VLPosicion = 0
    txtCampo(0).Enabled = True 'se agrego indice
    txtCampo(1).Enabled = False
    txtContrato.Enabled = True
    txtSaldo.Enabled = False
    mskCuenta.Enabled = False
    frmTipocuenta.Enabled = False
    grdCuentas.Enabled = False
    cmdBoton(1).Enabled = False
    cmdBoton(2).Enabled = False
    'cmdBoton(3).Enabled = False
    'cmdBoton(4).Enabled = True
    optTipo(1).Value = True
    frmTipocuenta.Tag = "C"
    txtContrato.Text = ""
    mskCuenta.Mask = ""
    mskCuenta.Text = ""
    mskCuenta.Mask = VGMascaraCtaCte$
    FPrincipal!pnlHelpLine.Caption = ""
    lblSecuencial.Caption = ""
    PMLimpiaG grdCuentas
    grdCuentas.ColWidth(1) = grdCuentas.ColWidth(0)
    txtSaldo.Text = ""
    lblDescripcion(0).Caption = ""
    lblDescripcion(1).Caption = ""
    lblDescripcion(2).Caption = ""
    txtCampo(0).Text = "" 'seagrego indice
    txtCampo(1).Text = ""
    txtCampo(0).SetFocus 'se agrego indice
End Sub

Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Permite enviar los datos al servidor para crear
'            una cuenta concentradora
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    If mskCuenta.ClipText = "" Then
        MsgBox "Debe ingresar una cuenta", 0 + 16, "Mensaje de Error"
        mskCuenta.SetFocus
        Exit Sub
    End If
    If txtSaldo = "" Then
        MsgBox "El Saldo Mínimo es Mandatorio", 0 + 16, "Mensaje de Error"
        txtSaldo.SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(1).Text) = "" Then
        MsgBox "El Tipo de Transferencia es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(1).SetFocus
        Exit Sub
    End If

    If VLPosicion = 0 Then
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
    Else
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
        grdCuentas.Row = VLPosicion
        grdCuentas.Col = 5 'Columna de secuencial
         PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, (grdCuentas.Text)
    End If
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2657"
     PMPasoValores sqlconn&, "@i_contrato", 0, SQLINT4, (txtContrato)
     PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCampo(0)) 'se agrego indice
     PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (mskCuenta.ClipText)
     PMPasoValores sqlconn&, "@i_minimo", 0, SQLMONEY, (txtSaldo)
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, (frmTipocuenta.Tag)
     PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, (VGMoneda)
     PMPasoValores sqlconn&, "@i_tipo_transferencia", 0, SQLCHAR, (txtCampo(1).Text)

     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_ctas_concentradoras", True, " Ok... Transmisión para Cuentas Concentradoras") Then
         PMChequea sqlconn&
        txtCampo(0).Enabled = False 'se agrego indice
        mskCuenta.Mask = ""
        mskCuenta.Text = ""
        mskCuenta.Mask = VGMascaraCtaCte$
        lblSecuencial.Caption = ""
        txtSaldo.Text = ""
        lblDescripcion(1).Caption = ""
        PLBuscar
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index
    Case 0, 1
        VLPaso = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código del cliente [F5 Ayuda]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Código del tipo de transferencia [F5 Ayuda]"
    End Select

    txtCampo(Index).SelStart = 0
    txtCampo(Index).SelLength = Len(txtCampo(Index).Text)
    
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
If Keycode = VGTeclaAyuda% Then
    Select Case Index
    Case 0 ' Cliente
        ' F5 para ayuda de cliente
        ' Forma de busqueda de clientes
        txtCampo(0).Text = "" 'se agrego indice
        Load FBuscarCliente
        FBuscarCliente!optCliente(1).Value = True
        FBuscarCliente!optCliente(0).Enabled = False
        FBuscarCliente.Show 1
        If VGBusqueda(1) <> "" Then
            If VGBusqueda(0) = "P" Then
                txtCampo(0).Text = VGBusqueda(1) 'se agrego indice
                lblDescripcion(0).Caption = VGBusqueda(4) & " " & VGBusqueda(2) & " " & VGBusqueda(3)
                VLPaso = True
            Else
                txtCampo(0).Text = VGBusqueda(1) 'se agrego indice
                lblDescripcion(0).Caption = VGBusqueda(4) & " " & VGBusqueda(2) & " " & VGBusqueda(3)
                VLPaso = True
            End If
            txtContrato.SetFocus
        End If
    
    Case 1 ' Tipo de Transferencia
        VLPaso = True
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cc_tipo_transferencia"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " OK... Consulta de tipos de transferencia") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
             PMChequea sqlconn&
            FCatalogo.Show 1
            txtCampo(1).Text = VGACatalogo.Codigo$
            lblDescripcion(2).Caption = VGACatalogo.Descripcion$
        Else
            txtCampo(1).Text = ""
            lblDescripcion(2).Caption = ""
        End If

    End Select
End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR1 As Integer
Select Case Index
    Case 0 'Cliente
        If VLPaso = False Then
            If txtCampo(0).Text <> "" Then 'se agrego indice
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                 PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCampo(0).Text) 'se agrego indice
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2543"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_desc_cliente_cc", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then 'se agrego indice
                    ReDim VTValores(20) As String
                     VTR1 = FMMapeaArreglo(sqlconn&, VTValores())
                     PMChequea sqlconn&
                    lblDescripcion(0).Caption = VTValores(2)
                    If VTValores(3) <> "C" Then
                        MsgBox "El Cliente no es una Compañía", 64, "Mensaje del servidor"
                        txtCampo(0).Text = "" 'se agrego indice
                        lblDescripcion(0).Caption = ""
                        txtCampo(0).SetFocus 'se agrego indice
                        txtContrato.Text = ""
                        txtContrato.Enabled = True
                    End If
                Else
                    txtCampo(0).Text = "" 'se agrego indice
                    lblDescripcion(0).Caption = ""
                    txtCampo(0).SetFocus 'se agrego indice
                    txtContrato.Text = ""
                    txtContrato.Enabled = True
                End If
            Else
                lblDescripcion(0).Caption = ""
            End If
        End If
    Case 1 ' Tipos de Transferencia
        If VLPaso = False Then
            If txtCampo(1).Text <> "" Then
                PMCatalogo "V", "cc_tipo_transferencia", txtCampo(1), lblDescripcion(2)
                'txtCampo(1).Enabled = False
                If txtCampo(1).Text = "" Then
                    Exit Sub
                End If
                frmTipocuenta.Enabled = True
                txtSaldo.Enabled = True
                mskCuenta.Enabled = True
                'mskCuenta.Mask = ""
                'mskCuenta.Text = ""
                'mskCuenta.Mask = VGMascaraCtaCte$
                'lblDescripcion(1).Caption = ""
                cmdBoton(1).Enabled = True
                cmdBoton(2).Enabled = False
                'cmdBoton(3).Enabled = True
                'cmdBoton(4).Enabled = True
                PMLimpiaG grdCuentas
                grdCuentas.ColWidth(1) = grdCuentas.ColWidth(0)
                grdCuentas.Enabled = False
            
                If frmTipocuenta.Enabled Then
                    optTipo(1).Value = True
                    frmTipocuenta.Tag = "C"
                Else
                    mskCuenta.SetFocus
                End If
            Else
                lblDescripcion(2).Caption = ""
                frmTipocuenta.Enabled = False
                txtSaldo.Enabled = False
                mskCuenta.Enabled = False
                mskCuenta.Mask = ""
                mskCuenta.Text = ""
                mskCuenta.Mask = VGMascaraCtaCte$
                lblDescripcion(1).Caption = ""
                cmdBoton(1).Enabled = False
                cmdBoton(2).Enabled = False
                'PMLimpiaG grdCuentas
                'grdCuentas.ColWidth(1) = grdCuentas.ColWidth(0)
                grdCuentas.Enabled = False
            
                'If frmTipocuenta.Enabled Then
                '    optTipo(1).Value = True
                '    frmTipocuenta.Tag = "C"
                'Else
                '    mskCuenta.SetFocus
                'End If

            End If
        End If

End Select
End Sub

Private Sub txtContrato_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número del Contrato"
    txtContrato.SelStart = 0
    txtContrato.SelLength = Len(txtContrato.Text)
End Sub

Private Sub txtcontrato_KeyPress(KeyAscii As Integer)
'Validacion de teclas numericas
    If ((KeyAscii < 48) Or (KeyAscii > 57)) And KeyAscii <> 8 Then
        KeyAscii = 0
    End If

End Sub

Private Sub txtContrato_LostFocus()
    'If txtContrato.Text <> "" Then
    '    PLBuscar
    'End If
End Sub

Private Sub txtSaldo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Saldo Minimo que debe poseer la Cuenta"
End Sub

Private Sub txtSaldo_KeyPress(KeyAscii As Integer)
'Validacion de teclas numericas
If (KeyAscii <> 44) And ((KeyAscii < 48) Or (KeyAscii > 57)) And (KeyAscii <> 46) And (KeyAscii <> 8) Then
    KeyAscii = 0
End If

End Sub

Private Sub txtSaldo_LostFocus()
    On Error GoTo errorsaldos
    If txtSaldo.Text <> "" Then
        txtSaldo.Text = Format(txtSaldo.Text, "###,###,###.00")
    End If
    Exit Sub
errorsaldos:
    MsgBox "El Formato no es Válido", 64, "Mensaje del servidor"
    txtSaldo.SetFocus
    Resume Next
End Sub


