VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{F856EC8B-F03C-4515-BDC6-64CBD617566A}#6.0#0"; "fpSpr60.ocx"
Begin VB.Form FHistoricoAS 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Histórico de Transacciones de Servicio (Ctas. Ahorros)"
   ClientHeight    =   5325
   ClientLeft      =   2205
   ClientTop       =   2505
   ClientWidth     =   9300
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
   HelpContextID   =   1090
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Tag             =   "3865"
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1680
      MaxLength       =   4
      TabIndex        =   3
      Top             =   645
      Width           =   690
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1680
      MaxLength       =   4
      TabIndex        =   4
      Top             =   945
      Width           =   690
   End
   Begin VB.TextBox txtCampo 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Enabled         =   0   'False
      Height          =   285
      Index           =   4
      Left            =   1860
      Locked          =   -1  'True
      TabIndex        =   27
      Top             =   5040
      Visible         =   0   'False
      Width           =   1770
   End
   Begin VB.TextBox txtCampo 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Enabled         =   0   'False
      Height          =   285
      Index           =   5
      Left            =   6480
      Locked          =   -1  'True
      TabIndex        =   26
      Top             =   5040
      Visible         =   0   'False
      Width           =   1770
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   1680
      MaxLength       =   2
      TabIndex        =   7
      Top             =   1560
      Width           =   690
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1680
      TabIndex        =   8
      Top             =   1860
      Width           =   1605
      _ExtentX        =   2831
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   10
      Top             =   765
      WhatsThisHelpID =   2020
      Width           =   870
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
      Enabled         =   0   'False
   End
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   285
      Left            =   1680
      TabIndex        =   1
      Top             =   330
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      MaxLength       =   10
      Mask            =   "##/##/####"
      PromptChar      =   "_"
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1680
      MaxLength       =   4
      TabIndex        =   0
      Top             =   30
      Width           =   690
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   9
      Top             =   0
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   12
      Top             =   3810
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
      Left            =   8415
      TabIndex        =   13
      Top             =   4575
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
   Begin MSMask.MaskEdBox mskfechahasta 
      Height          =   285
      Left            =   5760
      TabIndex        =   2
      Top             =   330
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      MaxLength       =   10
      Mask            =   "##/##/####"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   0
      Left            =   1680
      TabIndex        =   5
      Top             =   1260
      Width           =   1770
      _ExtentX        =   3122
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      MaxLength       =   15
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   1
      Left            =   5775
      TabIndex        =   6
      Top             =   1260
      Width           =   1770
      _ExtentX        =   3122
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      MaxLength       =   15
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   11
      Top             =   3050
      WhatsThisHelpID =   2009
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Imprimir"
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
   Begin FPSpreadADO.fpSpread grdRegistros 
      Height          =   2745
      Left            =   0
      TabIndex        =   14
      Top             =   2415
      Width           =   8355
      _Version        =   393216
      _ExtentX        =   14737
      _ExtentY        =   4842
      _StockProps     =   64
      AutoClipboard   =   0   'False
      BackColorStyle  =   1
      ColHeaderDisplay=   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaxCols         =   13
      MaxRows         =   0
      RetainSelBlock  =   0   'False
      ScrollBarExtMode=   -1  'True
      SpreadDesigner  =   "FHISTAHS.frx":0000
      UserResize      =   1
      VisibleCols     =   12
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2385
      TabIndex        =   33
      Top             =   645
      Width           =   5970
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Oficina desde:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   2
      Left            =   30
      TabIndex        =   32
      Top             =   660
      WhatsThisHelpID =   5040
      Width           =   1425
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Oficina hasta:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   6
      Left            =   30
      TabIndex        =   31
      Top             =   945
      WhatsThisHelpID =   5170
      Width           =   1620
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2385
      TabIndex        =   30
      Top             =   945
      Width           =   5970
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Total:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   5895
      TabIndex        =   29
      Top             =   5040
      Visible         =   0   'False
      WhatsThisHelpID =   5178
      Width           =   585
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Total de Registros:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   120
      TabIndex        =   28
      Top             =   5040
      Visible         =   0   'False
      WhatsThisHelpID =   5177
      Width           =   1710
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto Bancario:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   9
      Left            =   0
      TabIndex        =   25
      Top             =   1560
      WhatsThisHelpID =   5176
      Width           =   1785
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   4
      Left            =   2385
      TabIndex        =   24
      Top             =   1560
      Width           =   5970
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Monto desde:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   7
      Left            =   0
      TabIndex        =   23
      Top             =   1260
      WhatsThisHelpID =   5174
      Width           =   1305
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Monto Hasta:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   8
      Left            =   4440
      TabIndex        =   22
      Top             =   1260
      WhatsThisHelpID =   5175
      Width           =   1305
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha hasta:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   5
      Left            =   4440
      TabIndex        =   21
      Top             =   330
      WhatsThisHelpID =   5173
      Width           =   1395
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "No. de Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   0
      TabIndex        =   20
      Top             =   1860
      Width           =   1305
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   2
      Left            =   3300
      TabIndex        =   19
      Top             =   1860
      UseMnemonic     =   0   'False
      Width           =   5055
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Transacciones Realizadas:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   3
      Left            =   0
      TabIndex        =   18
      Top             =   2205
      WhatsThisHelpID =   5344
      Width           =   2505
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha desde:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   1
      Left            =   30
      TabIndex        =   16
      Top             =   330
      WhatsThisHelpID =   5172
      Width           =   1395
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Tipo Transacción:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   0
      Left            =   30
      TabIndex        =   17
      Top             =   30
      WhatsThisHelpID =   5171
      Width           =   1725
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2385
      TabIndex        =   15
      Top             =   30
      Width           =   5970
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   9300
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   0
      X2              =   8385
      Y1              =   2190
      Y2              =   2190
   End
End
Attribute VB_Name = "FHistoricoAS"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FHISTAHS.frm
' NOMBRE LOGICO:    FHistoricoAS
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
' Permite mostrar el historico de las transacciones de servicio
' Cuentas de ahorro
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
' 05-Abr-05      L. Bernuil      Personalizacion y Ajustes.
'*************************************************************
Option Explicit
Dim VLPaso As Integer
Dim VLcompara As Integer
Dim VLVista As String
Dim VLTran As String
Dim VLSP As String
Dim VLPosGrid As Long
Dim VTModo As Integer
Dim VLBandera As Boolean
Dim VTColumna As Integer
Dim VT As Integer
Dim VLError As Integer
Dim VTFecha1 As String
Dim VTFecha2 As String
Private Sub Form_Activate()
    VGProducto$ = "AHO"
    VGTipoHis$ = "S"
End Sub
Private Sub Form_Load()
    FHistoricoAS.Left = 0   '15
    FHistoricoAS.Top = 0   '15
    FHistoricoAS.Width = 9450   '9420
    FHistoricoAS.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me

'CloVargas Oct/19/01 Manejo de Formato Fecha
    mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
    mskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
    mskfechahasta.Mask = FMMascaraFecha(VGFormatoFecha$)
    mskfechahasta.Text = Format$(VGFecha$, VGFormatoFecha$)
    
    mskCuenta.Mask = VGMascaraCtaAho$
    
    mskValor(0).Format = VGDecimales$
    mskValor(0).Text = Format$(0, VGDecimales$)
    
    mskValor(1).Format = VGDecimales$
    mskValor(1).Text = Format$(0, VGDecimales$)
    
    txtCampo(4).Text = Format$(0, "#,###,###,##0")
    txtCampo(5).Text = Format$(0, VGDecimales$)
    
    'Inicializar variables
    VLPosGrid& = 1
    VLBandera = False
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Dim VLTabla As String
    Select Case Index%
        Case 0  'Transmitir
        
            txtCampo(4).Text = Format$(0, "#,###,###,##0")
            txtCampo(5).Text = Format$(0, VGDecimales$)
            If Not VLBandera Then
                VTModo% = False
            End If
                       
            If txtCampo(1).Text = "" Then
                MsgBox "Tipo de transacción monetaria mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(1).SetFocus
                Exit Sub
            ElseIf mskFecha.ClipText = "" Then
                MsgBox "La Fecha Desde de transacción mandatoria", 0 + 16, "Mensaje de Error"
                mskFecha.SetFocus
                Exit Sub
            ElseIf mskfechahasta.ClipText = "" Then
                MsgBox "La Fecha Hasta de transacción mandatoria", 0 + 16, "Mensaje de Error"
                mskfechahasta.SetFocus
                Exit Sub
            Else
                VLcompara% = Val(txtCampo(1).Text)
                If mskFecha.Text = Format$(VGFecha$, VGFormatoFecha$) And CDate(mskFecha.Text) = CDate(mskfechahasta.Text) _
                Or VLBandera Then
                VLBandera = False
                    'ah_tran_servicio
                    VLTran$ = "282"
                    VLSP$ = "sp_qry_trnsrv_ah"
                ElseIf CDate(mskFecha.Text) <= CDate(mskfechahasta.Text) Then
                    VLBandera = True
                    'ah_his_servicio
                    VLTran$ = "283"
                    VLSP$ = "sp_qry_hists_ah"
                Else
                    mskfechahasta.Text = Format$(VGFecha$, VGFormatoFecha$)
                    VLTran$ = "283"
                    VLSP$ = "sp_qry_hists_ah"
    
                End If
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VLTran$
                 
                 If txtCampo(0).Text <> "" Then
                     'PMPasoValores SqlConn&, "@i_ofi", 0, SQLINT2, (txtCampo(0).Text)
                     PMPasoValores sqlconn&, "@i_ofi_desde", 0, SQLINT2, (txtCampo(0).Text)
                 End If
                 
                 If txtCampo(2).Text <> "" Then
                     'PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(0).Text)
                     PMPasoValores sqlconn&, "@i_ofi_hasta", 0, SQLINT2, (txtCampo(2).Text)
                 End If
                 
                If CCur(Trim$(mskValor(0).Text)) > 0 Then
                    PMPasoValores sqlconn&, "@i_monto_desde", 0, SQLMONEY, (mskValor(0).Text)
                End If

                If CCur(Trim$(mskValor(1).Text)) > 0 Then
                    PMPasoValores sqlconn&, "@i_monto_hasta", 0, SQLMONEY, (mskValor(1).Text)
                End If
                 
                If txtCampo(3).Text <> "" Then
                    PMPasoValores sqlconn&, "@i_prod_banc", 0, SQLINT2, (txtCampo(3).Text)
                End If
                 
                 PMPasoValores sqlconn&, "@i_tipotrn", 0, SQLINT4, (txtCampo(1).Text)
            'CloVargas Oct/19/01 Agregar manejo Formato Fecha
                 PMPasoValores sqlconn&, "@i_fechatrn", 0, SQLDATETIME, FMConvFecha((mskFecha.Text), VGFormatoFecha$, CGFormatoBase$)
                 PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha((mskfechahasta.Text), VGFormatoFecha$, CGFormatoBase$)
                 PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
                 
                 PMPasoValores sqlconn&, "@i_vista", 0, SQLINT2, VLVista$
                 PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, VGMoneda$
                 'PMPasoValores SqlConn&, "@i_ultimo", 0, SQLINT4, "0"
                 PMPasoValores sqlconn&, "@i_alt", 0, SQLINT4, "0"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText$
                ' If mskCuenta.ClipText <> "" Then PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", VLSP$, True, "Ayuda de Estado") Then
                     PMMapeaGrid sqlconn&, grdRegistros, VTModo%
                     If VLBandera Then
                        VTModo% = False
                     End If

                     PMChequea sqlconn&
                    If Val(grdRegistros.Tag) = 20 Then
                        cmdBoton(1).Enabled = True
                    End If
                    
                    If VLTran$ = "282" And VLSP$ = "sp_qry_trnsrv_ah" And Val(grdRegistros.Tag) < 20 Then
                          cmdBoton(1).Enabled = False
                    End If
                    'cambiar fila activa
                    grdRegistros.Col = 1
                    grdRegistros.Row = VLPosGrid&
                    grdRegistros.Action = 0
                    'Marcar fila seleccionada
                    PMMarcaFilaGrid grdRegistros, VLPosGrid&
                    'Bloquear edición en el grid
                    PMBloqueaGrid grdRegistros
                    ' habilita boton de impresion
                    If grdRegistros.MaxRows > 0 Then
                        cmdBoton(4).Enabled = True
                    Else
                        cmdBoton(4).Enabled = False
                    End If
                    'txtCampo(0).Enabled = False
                    
                    txtCampo(4).Text = Format$(grdRegistros.MaxRows, "#,###,###,##0")
                    Select Case VLVista$
                        Case "2", "5", "6", "7", "9", "10", "11", "12", "13", "14", "15", "19"
                            txtCampo(5).Text = Format$(FLObtenerTotalMonto(2), VGDecimales$)
                    End Select
                    
                End If
            End If
              If VLBandera And Val(grdRegistros.Tag) < 20 And CDate(mskFecha.Text) <= CDate(mskfechahasta.Text) Then
              VTModo% = True
                
            Call cmdBoton_Click(0)
            
                      
            End If
            VLBandera = False
        Case 1   'Siguientes
        
        
            txtCampo(4).Text = Format$(0, "#,###,###,##0")
            txtCampo(5).Text = Format$(0, VGDecimales$)
        
            VTModo% = True
            VLBandera = True
            grdRegistros.Col = grdRegistros.MaxCols
            grdRegistros.Row = grdRegistros.MaxRows
            
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VLTran$
             
             If txtCampo(0).Text <> "" Then
                PMPasoValores sqlconn&, "@i_ofi_desde", 0, SQLINT2, (txtCampo(0).Text)
             End If
             
             If txtCampo(2).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_ofi_hasta", 0, SQLINT2, (txtCampo(2).Text)
             End If
             
             If CCur(Trim$(mskValor(0).Text)) > 0 Then
                PMPasoValores sqlconn&, "@i_monto_desde", 0, SQLMONEY, (mskValor(0).Text)
             End If

             If CCur(Trim$(mskValor(1).Text)) > 0 Then
                PMPasoValores sqlconn&, "@i_monto_hasta", 0, SQLMONEY, (mskValor(1).Text)
             End If
             
             If txtCampo(3).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_prod_banc", 0, SQLINT2, (txtCampo(3).Text)
             End If
             
             PMPasoValores sqlconn&, "@i_tipotrn", 0, SQLINT4, (txtCampo(1).Text)
         'CloVargas Oct/19/01 Agregar formato Fecha
             PMPasoValores sqlconn&, "@i_fechatrn", 0, SQLDATETIME, FMConvFecha((mskFecha.Text), VGFormatoFecha$, CGFormatoBase$)
             PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha((mskfechahasta.Text), VGFormatoFecha$, CGFormatoBase$)
             PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
             PMPasoValores sqlconn&, "@i_vista", 0, SQLINT2, VLVista$
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, VGMoneda$
             PMPasoValores sqlconn&, "@i_alt", 0, SQLINT4, (grdRegistros.Text)
            
           
             VTColumna = grdRegistros.MaxCols
             grdRegistros.Col = VTColumna - 1
             PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, (grdRegistros.Text)
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", VLSP$, True, "Ayuda de Estado") Then
                PMMapeaGrid sqlconn&, grdRegistros, VTModo%
                PMChequea sqlconn&
                
                If Val(grdRegistros.Tag) = 20 Then
                    Call cmdBoton_Click(1)
                Else
                    cmdBoton(1).Enabled = False
                End If
                
                txtCampo(4).Text = Format$(grdRegistros.MaxRows, "#,###,###,##0")
                
                Select Case VLVista$
                    Case "2", "5", "6", "7", "9", "10", "11", "12", "13", "14", "15", "19"
                        txtCampo(5).Text = Format$(FLObtenerTotalMonto(2), VGDecimales$)
                End Select
            End If
        Case 2   'Limpiar
            PLLimpiar
        Case 3   'Salir
            Unload FHistoricoAS
        Case 4
            PLConfigurarImpresion
    End Select
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta de Ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaCte((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_val_inac", 0, SQLCHAR, "N"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(2)
            Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(2).Caption = ""
            End If
             PMChequea sqlconn&
        Else
            MsgBox "El dígito verificador de la cuenta de ahorro está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
            lblDescripcion(2).Caption = ""
        End If
    Else
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        lblDescripcion(2).Caption = ""
    End If
End Sub
Private Sub mskFechahasta_GotFocus()

    FPrincipal!pnlHelpLine.Caption = " Fecha fin de rango, en la que se registró la transacción [" & VGFormatoFecha & "]"
    mskfechahasta.SelStart = 0
    mskfechahasta.SelLength = Len(mskfechahasta.Text)

End Sub

Private Sub mskFechahasta_KeyPress(KeyAscii As Integer)

   KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)

End Sub
Private Sub mskFechahasta_LostFocus()
'CloVargas Oct/19/2001 Manejo de Formato Fecha
    Dim VTDias As Long
    If mskfechahasta.ClipText <> "" Then
        VT% = FMVerFormato((mskfechahasta.FormattedText), VGFormatoFecha)
        If Not VT% Then
            MsgBox "Formato de Fecha Inválido", 48, "Control Ingreso de Datos"
            VLError% = True
            mskfechahasta.SetFocus
            Exit Sub
        Else
        'Verficar que fecha de consulta sea menor que la fecha del sistema
           VTFecha1$ = Format(mskfechahasta.Text, VGFormatoFecha$)
           VTFecha2$ = Format(VGFecha$, VGFormatoFecha$)
           If FMDateDiff("d", VTFecha1, VTFecha2$, VGFormatoFecha) <= 0 Then
                mskfechahasta.Text = Format(VGFecha$, VGFormatoFecha$)
           End If
        End If
    End If
    
        If mskFecha.ClipText <> "" And mskfechahasta.ClipText <> "" Then
            VTDias& = FMDateDiff("d", (mskFecha.FormattedText), (mskfechahasta.FormattedText), VGFormatoFecha$)
            If VTDias& < 0 Then
                MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
                mskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
                mskFecha.SetFocus
                Exit Sub
            End If
        End If

End Sub
Private Sub mskFecha_GotFocus()

    FPrincipal!pnlHelpLine.Caption = " Fecha inicio de rango, en la que se registró la transacción [" & VGFormatoFecha & "]"
    mskFecha.SelStart = 0
    mskFecha.SelLength = Len(mskFecha.Text)

End Sub

Private Sub mskFecha_KeyPress(KeyAscii As Integer)

   KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)

End Sub

Private Sub MskFecha_LostFocus()
'CloVargas Oct/19/2001 Manejo de Formato Fecha
    If mskFecha.ClipText <> "" Then
        VT% = FMVerFormato((mskFecha.FormattedText), VGFormatoFecha)
        If Not VT% Then
            MsgBox "Formato de Fecha Inválido", 48, "Control Ingreso de Datos"
            VLError% = True
            mskFecha.SetFocus
            Exit Sub
        Else
        'Verficar que fecha de consulta sea menor que la fecha del sistema
           VTFecha1$ = Format(mskFecha.Text, VGFormatoFecha$)
           VTFecha2$ = Format(VGFecha$, VGFormatoFecha$)
           If FMDateDiff("d", VTFecha1, VTFecha2$, VGFormatoFecha) <= 0 Then
                mskFecha.Text = Format(VGFecha$, VGFormatoFecha$)
           End If
        End If
    End If

End Sub

Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Permite limpiar todos los campos de la forma
' INPUT    : ninguna
' OUTPUT   : ninguna
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
   
   mskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
   mskfechahasta.Text = Format$(VGFecha$, VGFormatoFecha$)
   lblDescripcion(0).Caption = ""
   lblDescripcion(1).Caption = ""
   'PMLimpiaGrid grdRegistros
   PMBorrarGrid grdRegistros
   
   txtCampo(0).Enabled = True
   txtCampo(0).Text = ""
   txtCampo(1).Text = ""
   txtCampo(2).Text = ""
   txtCampo(3).Text = ""
   
   txtCampo(0).SetFocus
   If cmdBoton(1).Enabled = True Then
      cmdBoton(1).Enabled = False
   End If
   mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
   lblDescripcion(2).Caption = ""
   lblDescripcion(3).Caption = ""
   lblDescripcion(4).Caption = ""

   mskValor(0).Format = VGDecimales$
   mskValor(0).Text = Format$(0, VGDecimales$)

   mskValor(1).Format = VGDecimales$
   mskValor(1).Text = Format$(0, VGDecimales$)

   txtCampo(4).Text = Format$(0, "#,###,###,##0")
   txtCampo(5).Text = Format$(0, VGDecimales$)

   cmdBoton(4).Enabled = False
    'Inicializar variables
    VLPosGrid& = 1
End Sub
Private Sub mskValor_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Monto desde de la Transacción "
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Monto Hasta de la Transacción  "
    End Select
    mskValor(Index%).SelStart = 0
    mskValor(Index%).SelLength = Len(mskValor(Index%).Text)

    'Borra el Pegar del Click Derecho
     Clipboard.Clear
     Clipboard.SetText ""
End Sub
Private Sub mskValor_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii <> 46 And KeyAscii <> 8 And (KeyAscii < 48 Or KeyAscii > 57) Then
        KeyAscii = 0
    End If
    If KeyAscii = 46 Then
        If InStr(1, mskValor(Index).Text, ".") Then
            KeyAscii = 0
        End If
    End If
End Sub
Private Sub mskValor_LostFocus(Index As Integer)
    If mskValor(Index).ClipText = "" Then
        mskValor(Index).Text = "0.00"
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
        Case 0, 1, 2, 3
           VLPaso% = False
    End Select
    
    If Index% = 0 Then lblDescripcion(0).Caption = ""
    If Index% = 2 Then lblDescripcion(3).Caption = ""
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    
    VLPaso% = True
    Select Case Index%
        Case 0
          FPrincipal!pnlHelpLine.Caption = " Código de la Oficina desde [F5 Ayuda]"
        Case 1
          FPrincipal!pnlHelpLine.Caption = " Código del tipo de transacción [F5 Ayuda]"
        Case 2
          FPrincipal!pnlHelpLine.Caption = " Código de la Oficina Hasta [F5 Ayuda]"
        Case 3
            FPrincipal!pnlHelpLine.Caption = " Producto Bancario [F5 Ayuda]"
          
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda% Then
       VLPaso% = True
       Select Case Index%
          Case 0
             VGOperacion$ = "sp_oficina"
             txtCampo(Index%).Text = ""
              PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
              PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
              If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la agencia " & "[" & txtCampo(0).Text & "]") Then
                 PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(0).Text = VGACatalogo.Codigo$
                lblDescripcion(0).Caption = VGACatalogo.Descripcion$
                If txtCampo(Index%).Text <> "" Then
                   txtCampo(1).SetFocus
                End If
               Else
                  txtCampo(Index%).Text = ""
                  lblDescripcion(0).Caption = ""
                  txtCampo(Index%).SetFocus
             End If
          Case 1
             VGOperacion$ = "sp_tranhistoricos"
             txtCampo(Index%).Text = ""
              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2576"
              PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, VGProducto$
              PMPasoValores sqlconn&, "@i_qry", 0, SQLCHAR, "T"            'Total
              PMPasoValores sqlconn&, "@i_tipotrn", 0, SQLINT4, "0"
              PMPasoValores sqlconn&, "@i_tipohis", 0, SQLCHAR, VGTipoHis$ 'Servicios
              PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, "0"
              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_qry_tranms", True, " Ok... Consulta de Tipos de Transacciones Monetarias") Then
                 PMMapeaGrid sqlconn&, FRegistros!grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                If Val(FRegistros!grdRegistros.Tag) = VGMaxRows% Then
                   FRegistros!cmdSiguientes.Enabled = True
                  Else
                     FRegistros!cmdSiguientes.Enabled = False
                End If
                txtCampo(1).Text = VGACatalogo.Codigo$
                lblDescripcion(1).Caption = VGACatalogo.Descripcion$
                If txtCampo(Index%).Text <> "" Then
                   mskFecha.SetFocus
                End If
             Else
                   PMChequea sqlconn&
                  txtCampo(Index%).Text = ""
                  lblDescripcion(1).Caption = ""
                  txtCampo(Index%).SetFocus
            End If
        Case 2
             VGOperacion$ = "sp_oficina"
             txtCampo(Index%).Text = ""
              PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
              PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
              If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la Oficina " & "[" & txtCampo(2).Text & "]") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(Index%).Text = VGACatalogo.Codigo$
                lblDescripcion(3).Caption = VGACatalogo.Descripcion$
                If txtCampo(Index%).Text <> "" Then
                   txtCampo(1).SetFocus
                End If
              Else
                 txtCampo(Index%).Text = ""
                 lblDescripcion(3).Caption = ""
                 txtCampo(Index%).SetFocus
             End If
        Case 3
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
            PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "4"
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_productoban", True, " Ok... Consulta de Productos Bancarios") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                VLPaso% = True
                FCatalogo.Show 1
                txtCampo(3).Text = VGACatalogo.Codigo$
                lblDescripcion(4).Caption = VGACatalogo.Descripcion$
                mskCuenta.SetFocus
            End If
       End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)

   Select Case Index%
      Case 0, 1, 2, 3
         KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
   End Select

End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    If VLPaso% = False And txtCampo(Index%).Text <> "" Then
       Select Case Index%
          Case 0
            If txtCampo(0).Text <> "" Then
              PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
              PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
              PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(0).Text)
              If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la agencia " & "[" & txtCampo(0).Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
              Else
                 txtCampo(0).Text = ""
                 lblDescripcion(0).Caption = ""
                 txtCampo(0).SetFocus
                 'PMLimpiaGrid grdRegistros
                 PMBorrarGrid grdRegistros
             End If
           End If
          Case 1
            If txtCampo(1).Text <> "" Then
              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2576"
              PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, VGProducto$
              PMPasoValores sqlconn&, "@i_qry", 0, SQLCHAR, "I"             'Individual
              PMPasoValores sqlconn&, "@i_tipohis", 0, SQLCHAR, VGTipoHis$ 'Servicios
              PMPasoValores sqlconn&, "@i_tipotrn", 0, SQLINT4, (txtCampo(1).Text)
              PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, "0"
              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_qry_tranms", True, " Ok... Consulta de Tipos de Transacciones Monetarias") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(1)
                 PMChequea sqlconn&
                mskFecha.SetFocus
             Else
                  PMChequea sqlconn&
                 txtCampo(1).Text = ""
                 lblDescripcion(1).Caption = ""
                 txtCampo(1).SetFocus
             End If
           End If
         Case 2
            If txtCampo(2).Text <> "" Then
              PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
              PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
              PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(2).Text)
              If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(2).Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(3)
                 PMChequea sqlconn&
              Else
                 txtCampo(2).Text = ""
                 lblDescripcion(3).Caption = ""
                 txtCampo(2).SetFocus
                 'PMLimpiaGrid grdRegistros
                 PMBorrarGrid grdRegistros
             End If
           Else
                lblDescripcion(3).Caption = ""
           End If
        Case 3
            If txtCampo(3).Text <> "" Then
                
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
                PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_prodfin", 0, SQLINT2, (txtCampo(3).Text)
                PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "4"
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                    
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_productoban", True, "Ok.. Consulta de Producto Bancaria") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(4)
                    PMChequea sqlconn&
                    VLPaso% = True
                Else
                    txtCampo(3).Text = ""
                    lblDescripcion(4).Caption = ""
                    txtCampo(3).SetFocus
                End If
            Else
                lblDescripcion(4).Caption = ""
            End If
       End Select
    End If
End Sub
Private Sub grdregistros_LeaveCell(ByVal Col As Long, ByVal Row As Long, ByVal NewCol As Long, ByVal NewRow As Long, Cancel As Boolean)
'*************************************************************
' PROPOSITO: Marcar la fila seleccionada y no permitir
'            que se desmarque la selección
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 13-May-99      L. Chango       Emision Inicial
'*************************************************************

    If NewRow > -1 Then     'el grid no pierde el foco
        'marcar registro seleccionado
        PMMarcaFilaGrid grdRegistros, NewRow
        VLPosGrid& = NewRow
    End If
End Sub
Sub PLConfigurarImpresion()
'**************************************************************
' PROPOSITO: Configura los datos requeridos para la impresión de
'            reportes.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'**************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-05      D. Villagomez   Emision Inicial
' 05-Abr-05      L. Bernuil      Modificacion para los datos extraidos
'                                en esta pantalla.
'**************************************************************
'FIXIT: Declare 'VTColumnas' with an early-bound data type                                 FixIT90210ae-R1672-R1B8ZE
    Dim VTColumnas() As Integer         'Contiene los índices de las columnas a imprimir
'FIXIT: Declare 'VTSepColumnas' with an early-bound data type                              FixIT90210ae-R1672-R1B8ZE
    Dim VTSepColumnas() As Integer      'Contiene las separaciones en caracteres de las columnas
'FIXIT: Declare 'VTCapSubtitulos' with an early-bound data type                            FixIT90210ae-R1672-R1B8ZE
    Dim VTCapSubtitulos() As Integer    'Contiene los números de recursos para los Nombres de los subtítulos
'FIXIT: Declare 'VTValSubtitulos' with an early-bound data type                            FixIT90210ae-R1672-R1B8ZE
    Dim VTValSubtitulos() As String    'Contiene los números de recursos para los Valores de los subtítulos
    Dim VTNumColumnas As Integer      'Contiene el número de filas a imprimir
'FIXIT: Declare 'VTAlineacion' with an early-bound data type                               FixIT90210ae-R1672-R1B8ZE
    Dim VTAlineacion() As Integer

    VLcompara% = Val(txtCampo(1).Text)
    Select Case VLcompara%
            
       Case 201  'ah_tsapertura
            VLVista$ = "1"
            VTNumColumnas% = 11
            VTColumnas = Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 12)
            VTSepColumnas = Array(9, 7, 20, 9, 12, 9, 10, 8, 9, 12, 8)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_CENTER_ALIGN%)
            
       Case 202, 205
            VLVista$ = "1"  'ah_tsapertura
            VTNumColumnas% = 8
            VTColumnas = Array(1, 2, 3, 4, 5, 6, 9, 10)
            VTSepColumnas = Array(15, 12, 15, 12, 15, 12, 15, 12)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 280
            VLVista$ = "2"  'ah_tsanulalib
            VTNumColumnas% = 8
            VTColumnas = Array(1, 2, 3, 4, 5, 6, 8)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 203, 204, 267, 242
            VLVista$ = "3"  'ah_tscambia_estado
            VTNumColumnas% = 6
            VTColumnas = Array(1, 2, 3, 4, 5, 9)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 206, 207
            VLVista$ = "4"  'ah_tscliente_ctahorro
            VTNumColumnas% = 7
            VTColumnas = Array(1, 2, 3, 4, 5, 9, 10)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 211, 212, 217, 218, 327, 328
            VLVista$ = "5"  'ah_tsbloqueo
            VTNumColumnas% = 8
            VTColumnas = Array(1, 2, 3, 4, 5, 6, 8, 12)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 213
            VLVista$ = "6"  'ah_tsciere_cta
            VTNumColumnas% = 8
            VTColumnas = Array(1, 2, 3, 4, 12, 13, 5, 9)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 224, 225, 226, 227
            VLVista$ = "7"  'ah_tssobregiro
            VTNumColumnas% = 9
            VTColumnas = Array(1, 2, 3, 4, 5, 6, 7, 8, 9)
            VTSepColumnas = Array(12, 12, 12, 12, 12, 12, 12, 12, 12)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 234
            VLVista$ = "8"  'ah_tssolicita_ec
            VTNumColumnas% = 6
            VTColumnas = Array(1, 2, 3, 4, 5, 8)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 249, 250, 256, 257, 264
            VLVista$ = "9"  'ah_tsvalsuspenso
            VTNumColumnas% = 7
            VTColumnas = Array(1, 2, 3, 4, 5, 6, 9)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 259
            VLVista$ = "10"  'ah_tsgerencia
            VTNumColumnas% = 7
            VTColumnas = Array(1, 2, 3, 4, 5, 6, 9)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 268, 269
            VLVista$ = "11"  'ah_tspag_otrobanco
            VTNumColumnas% = 8
            VTColumnas = Array(1, 2, 3, 4, 5, 7, 8, 9)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 401
            VLVista$ = "12"  'ah_tsrem_ingresochq
            VTNumColumnas% = 8
            VTColumnas = Array(1, 2, 3, 4, 5, 6, 7, 10)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 402, 416
            VLVista$ = "13"  'ah_tsrem_chequedev
            VTNumColumnas% = 8
            VTColumnas = Array(1, 2, 3, 4, 5, 6, 7, 11)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 403, 404, 406
            VLVista$ = "14"  'ah_tsrem_chequeconf
            VTNumColumnas% = 8
            VTColumnas = Array(1, 2, 3, 4, 5, 6, 7, 11)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 271
            VLVista$ = "15"  'cc_tsjustifica_cheques
            VTNumColumnas% = 7
            VTColumnas = Array(1, 2, 3, 4, 5, 6, 8)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 220
            VLVista$ = "17"  'ah_tran_servicio
            VTNumColumnas% = 9
            VTColumnas = Array(1, 3, 4, 5, 6, 7, 8, 9, 10)
            VTSepColumnas = Array(12, 12, 12, 12, 12, 12, 12, 12, 12)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

        Case 230
            VLVista$ = "18"  'ah_tran_servicio
            VTNumColumnas% = 9
            VTColumnas = Array(1, 3, 4, 5, 6, 7, 8, 9, 10)
            VTSepColumnas = Array(12, 12, 12, 12, 12, 12, 12, 12, 12)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)
        
        Case 332
            VLVista$ = "19"  'ah_tran_servicio
            VTNumColumnas% = 7
            VTColumnas = Array(1, 2, 3, 4, 5, 6, 8)
            VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)
         
         Case 367
            VLVista$ = "20"  'ah_
            VTNumColumnas% = 5
            VTColumnas = Array(1, 2, 3, 4, 6)
            VTSepColumnas = Array(15, 15, 15, 8, 15)
            VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)
        Case Else
                VLVista$ = "21"  'En caso de no estar definido la transaccion
                VTNumColumnas% = 8
                VTColumnas = Array(1, 2, 3, 4, 5, 6, 7, 8)
                VTSepColumnas = Array(12, 9, 27, 15, 15, 12, 12, 15)
                VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)

    End Select

    'Tipo Ejecucion/Responsable/Oficinas/Transaccion/Fecha(s)/Monto(s)/ProductoBancario/Numero de Cuenta
    VTCapSubtitulos = Array(5122, 5123, 5005, 5084, 5179, 5180, 5176, 5016)  'Array(5122, 5123, 5016, 5005, 5084, 5065, 5066)

    'Configuración de los valores de los subtítulos
    VTValSubtitulos = Array("", "", "", "", "", "", "", "", "", "", "", "") 'Inicialización del arreglo
    VTValSubtitulos(0) = LoadResString(5121)    'Tipo de ejecución
    VTValSubtitulos(1) = VGLogin$

    If txtCampo(0).Text = "" And txtCampo(2).Text = "" Then
        VTValSubtitulos(2) = LoadResString(9037)
    Else
        If txtCampo(0).Text = "" And txtCampo(2).Text <> "" Then
            VTValSubtitulos(2) = "1 Hasta " + txtCampo(2).Text + " " + lblDescripcion(3).Caption
        Else
            If txtCampo(0).Text <> "" And txtCampo(2).Text = "" Then
                VTValSubtitulos(2) = txtCampo(0).Text + " " + lblDescripcion(0) + " en adelante"
            Else
                If txtCampo(0).Text <> "" And txtCampo(2).Text <> "" Then
                    VTValSubtitulos(2) = txtCampo(0).Text + " " + lblDescripcion(0) + " hasta " + txtCampo(2).Text + " " + lblDescripcion(3).Caption
                End If
            End If
        End If
    End If

    If txtCampo(1).Text = "" Then 'transaccion
        VTValSubtitulos(3) = LoadResString(9037)
    Else
        VTValSubtitulos(3) = txtCampo(1).Text + " " + lblDescripcion(1).Caption
    End If

    VTValSubtitulos(4) = "desde " + mskFecha.Text + " hasta " + mskfechahasta.Text

    If CCur(Trim$(mskValor(0).Text)) = 0 And CCur(Trim$(mskValor(1).Text)) = 0 Then
        VTValSubtitulos(5) = "desde 0 hasta 9999999999.99"
    Else
        If CCur(Trim$(mskValor(0).Text)) > 0 And CCur(Trim$(mskValor(1).Text)) = 0 Then
            VTValSubtitulos(5) = "desde " + Format$(mskValor(0).Text, VGDecimales$) + " hasta 9999999999.99"
        Else
            VTValSubtitulos(5) = "desde " + Format$(mskValor(0).Text, VGDecimales$) + " hasta " + Format$(mskValor(1).Text, VGDecimales$)
        End If
    End If

    If txtCampo(3).Text = "" Then 'Producto Bancario
        VTValSubtitulos(6) = LoadResString(9037)
    Else
        VTValSubtitulos(6) = txtCampo(3).Text + " " + lblDescripcion(4).Caption
    End If

    If mskCuenta.ClipText = "" Then
        VTValSubtitulos(7) = LoadResString(9037)
    Else
        VTValSubtitulos(7) = mskCuenta.Text + " " + lblDescripcion(2).Caption
    End If

    'Llamada al procedimiento de Impresión de Reportes
    PMImprimirReporte grdRegistros, VTNumColumnas%, VTColumnas, VTSepColumnas, 3865, VTCapSubtitulos, VTValSubtitulos, VTAlineacion, CG_LANDSCAPE%
End Sub
Private Function FLObtenerTotalMonto(ByVal parCol As Long) As Currency
Dim i As Integer
If grdRegistros.MaxRows <= 0 Then
    FLObtenerTotalMonto = 0
Else
    For i = 1 To grdRegistros.MaxRows
        grdRegistros.Row = i
        grdRegistros.Col = parCol
        If IsNumeric(grdRegistros.Text) Then
            FLObtenerTotalMonto = FLObtenerTotalMonto + CCur(grdRegistros.Text)
        End If
    Next i
End If
End Function

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
Select Case Index%
    Case 0, 1, 2, 3
        'Bloquea el Click Derecho
         Clipboard.Clear
         Clipboard.SetText ""
End Select
End Sub

