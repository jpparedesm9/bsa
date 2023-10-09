VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{F856EC8B-F03C-4515-BDC6-64CBD617566A}#6.0#0"; "fpSpr60.ocx"
Begin VB.Form FHistoricoAM 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Histórico de Transacciones Monetarias (Ctas. Ahorros)"
   ClientHeight    =   5745
   ClientLeft      =   2295
   ClientTop       =   1950
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
   HelpContextID   =   1092
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5745
   ScaleWidth      =   9300
   Tag             =   "3120"
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   2040
      MaxLength       =   2
      TabIndex        =   5
      Top             =   1290
      Width           =   690
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2040
      TabIndex        =   4
      Top             =   990
      Width           =   1600
      _ExtentX        =   2831
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8400
      TabIndex        =   7
      Top             =   780
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
      Left            =   2040
      TabIndex        =   2
      Top             =   690
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      PromptChar      =   "_"
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   2040
      MaxLength       =   4
      TabIndex        =   1
      Top             =   390
      Width           =   690
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   6
      Top             =   20
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
      TabIndex        =   8
      Top             =   4170
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
      Left            =   8415
      TabIndex        =   9
      Top             =   4935
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
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   2040
      MaxLength       =   4
      TabIndex        =   0
      Top             =   90
      Width           =   690
   End
   Begin MSMask.MaskEdBox mskfechahasta 
      Height          =   285
      Left            =   5340
      TabIndex        =   3
      Top             =   690
      Width           =   1335
      _ExtentX        =   2355
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   19
      Top             =   3405
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
      Height          =   3615
      Left            =   120
      TabIndex        =   20
      Top             =   2040
      Width           =   8115
      _Version        =   393216
      _ExtentX        =   14314
      _ExtentY        =   6376
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
      SpreadDesigner  =   "FHISTAHM.frx":0000
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
      Index           =   2
      Left            =   2745
      TabIndex        =   22
      Top             =   1290
      Width           =   5610
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto Bancario:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   9
      Left            =   30
      TabIndex        =   21
      Top             =   1290
      WhatsThisHelpID =   5176
      Width           =   1785
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha hasta:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   5
      Left            =   3840
      TabIndex        =   18
      Top             =   690
      WhatsThisHelpID =   5173
      Width           =   1455
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   30
      TabIndex        =   17
      Top             =   990
      WhatsThisHelpID =   5016
      Width           =   1380
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   3
      Left            =   3660
      TabIndex        =   16
      Top             =   990
      Width           =   4695
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Transacciones Realizadas:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   3
      Left            =   30
      TabIndex        =   15
      Top             =   1800
      WhatsThisHelpID =   5344
      Width           =   2445
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
      TabIndex        =   13
      Top             =   690
      WhatsThisHelpID =   5172
      Width           =   2055
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Tipo de Transacción:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   0
      Left            =   30
      TabIndex        =   14
      Top             =   390
      WhatsThisHelpID =   5171
      Width           =   1965
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2745
      TabIndex        =   12
      Top             =   390
      Width           =   5610
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
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Sucursal Origen:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   30
      TabIndex        =   11
      Top             =   90
      WhatsThisHelpID =   5343
      Width           =   1500
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   0
      X2              =   8385
      Y1              =   1680
      Y2              =   1680
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2745
      TabIndex        =   10
      Top             =   90
      Width           =   5610
   End
End
Attribute VB_Name = "FHistoricoAM"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FHISTAHM.frm
' NOMBRE LOGICO:    FHistoricoAM
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
' Permite mostrar el historico de las transacciones monetarias
' Cuentas de Ahorros
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VLPaso As Integer
Dim VLcompara%
Dim VLVista$
Dim VLTabla$
Dim VLBandera As Boolean
Dim VTModo%
Private Sub Form_Activate()
    VGProducto$ = "AHO"
    VGTipoHis$ = "M"
End Sub

Private Sub Form_Load()
    FHistoricoAM.Left = 0   '15
    FHistoricoAM.Top = 0   '15
    FHistoricoAM.Width = 9450   '9420
    FHistoricoAM.Height = 6255  '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
'CloVargas Oct/19/01 Manejo de Formato Fecha
    MskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
    MskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
    mskfechahasta.Mask = FMMascaraFecha(VGFormatoFecha$)
    mskfechahasta.Text = Format$(VGFecha$, VGFormatoFecha$)
    
    mskCuenta.Mask = VGMascaraCtaAho$
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
        Case 0  'Transmitir
        If Not VLBandera Then
        
           VTModo% = False
        End If
            If txtCampo(1).Text = "" Then
                MsgBox "Tipo de transacción monetaria mandatorio", 0 + 16, "Mensaje de Error"
                If txtCampo(1).Enabled Then txtCampo(1).SetFocus
                Exit Sub
            ElseIf MskFecha.ClipText = "" Then
                MsgBox "La Fecha desde es mandatoria", 0 + 16, "Mensaje de Error"
                If MskFecha.Enabled Then MskFecha.SetFocus
                Exit Sub
            ElseIf mskfechahasta.ClipText = "" Then
                MsgBox "La Fecha hasta es mandatoria", 0 + 16, "Mensaje de Error"
                If mskfechahasta.Enabled Then mskfechahasta.SetFocus
                Exit Sub
'            ElseIf txtCampo(2).Text = "" Then
'                MsgBox "El Producto Bancario es mandatorio", 0 + 16, "Mensaje de Error"
'                txtCampo(2).SetFocus
'                Exit Sub
            Else
                VLcompara% = Val(txtCampo(1).Text)
                If MskFecha.Text = Format$(VGFecha$, VGFormatoFecha$) And (MskFecha.Text) = (mskfechahasta.Text) _
                 Or VLBandera Then
                   VLBandera = False
                    VLTabla$ = "S"     ' ah_tran_monet
                ElseIf CDate(MskFecha.Text) <= CDate(mskfechahasta.Text) Then
                    VLBandera = True
                    VLTabla$ = "N"   ' ah_his_movimiento
                Else
                    VLBandera = True
                    mskfechahasta.Text = Format$(VGFecha$, VGFormatoFecha$)
                    VLTabla$ = "N"   ' ah_his_movimiento
                End If
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "281"
                If txtCampo(0).Text <> "" Then
                     PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(0).Text)
                End If
                 PMPasoValores sqlconn&, "@i_tipotrn", 0, SQLINT4, (txtCampo(1).Text)
                 'CloVargas Oct/19/01 Cambio para manejo Formato Fecha
                 PMPasoValores sqlconn&, "@i_fechatrn", 0, SQLDATETIME, FMConvFecha((MskFecha.Text), VGFormatoFecha$, CGFormatoBase)
                 PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha((mskfechahasta.Text), VGFormatoFecha$, CGFormatoBase)
                 PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
                 PMPasoValores sqlconn&, "@i_vista", 0, SQLINT2, VLVista$
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
                 PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, VGMoneda$
                 PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, "-1000000000"
                 PMPasoValores sqlconn&, "@i_alt", 0, SQLINT4, "0"
                 'If mskCuenta.ClipText <> "" Then PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText$
                 PMPasoValores sqlconn&, "@i_prodbanc", 0, SQLINT2, txtCampo(2).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_qry_histm_ah", True, "Ayuda de Estado") Then
                     PMMapeaGrid sqlconn&, grdRegistros, VTModo%
                     If VLBandera Then
                     VTModo% = False
                     End If
                     PMChequea sqlconn&
                     If grdRegistros.MaxRows > 0 Then
                          PMAjustaColsGrid grdRegistros
                     End If
                    
                     If Val(grdRegistros.Tag) >= 20 Then
                        cmdBoton(1).Enabled = True
                     End If
                     If VLTabla$ = "S" And Val(grdRegistros.Tag) < 20 Then
                        cmdBoton(1).Enabled = False
                     End If
                     'cambiar fila activa
                     grdRegistros.col = 1
                     grdRegistros.Row = VLPosGrid&
                     grdRegistros.Action = 0
                     'Marcar fila seleccionada
                     PMMarcaFilaGrid grdRegistros, VLPosGrid&
                     'Bloquear edición en el grid
                     PMBloqueaGrid grdRegistros
                     If grdRegistros.MaxRows > 0 Then
                        cmdBoton(4).Enabled = True
                     Else
                        cmdBoton(4).Enabled = False
                     End If
                Else
                    PLLimpiar
                End If
            End If
            If VLBandera And Val(grdRegistros.Tag) < 20 Then ' And MskFecha.Text <= mskfechahasta.Text Then
                 
                   VTModo% = True
                   Call cmdBoton_Click(0)
               End If
              VLBandera = False
            
        Case 1   'Siguientes
         VLBandera = True
            VTModo% = True
            grdRegistros.col = grdRegistros.MaxCols - 1
             grdRegistros.Row = grdRegistros.MaxRows
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "281"
             If txtCampo(0).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(0).Text)
             End If
             PMPasoValores sqlconn&, "@i_tipotrn", 0, SQLINT4, (txtCampo(1).Text)
             PMPasoValores sqlconn&, "@i_fechatrn", 0, SQLDATETIME, FMConvFecha((MskFecha.Text), VGFormatoFecha$, CGFormatoBase$)
             PMPasoValores sqlconn&, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha((mskfechahasta.Text), VGFormatoFecha$, CGFormatoBase)
             PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
             PMPasoValores sqlconn&, "@i_vista", 0, SQLINT2, VLVista$
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, VGMoneda$
             PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, Val(grdRegistros.Text)
             If VLTabla$ = "S" Then
                VTColumna = grdRegistros.MaxCols
                PMPasoValores sqlconn&, "@i_alt", 0, SQLINT4, (grdRegistros.Text)
             End If
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText$
             PMPasoValores sqlconn&, "@i_prodbanc", 0, SQLINT2, txtCampo(2).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_qry_histm_ah", True, "Ayuda de Estado") Then
                PMMapeaGrid sqlconn&, grdRegistros, VTModo%
                PMChequea sqlconn&
                PMAjustaColsGrid grdRegistros
                
                If Val(grdRegistros.Tag) >= 20 Then
                    cmdBoton(1).Enabled = True
                End If
                
                If VLTabla$ = "S" And Val(grdRegistros.Tag) < 20 Then
                   cmdBoton(1).Enabled = False
                End If
                   
            End If
        Case 2   'Limpiar
            PLLimpiar
        Case 3   'Salir
            Unload FHistoricoAM
        Case 4   'imprimir
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
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(3)
            Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(3).Caption = ""
            End If
             PMChequea sqlconn&
        Else
            MsgBox "El dígito verificador de la cuenta de ahorro está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
            lblDescripcion(3).Caption = ""
        End If
    Else
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        lblDescripcion(3).Caption = ""
    End If
    PMBorrarGrid Me.grdRegistros
End Sub
Private Sub mskFechahasta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Formato Fecha Final [" & VGFormatoFecha & "]"
    mskfechahasta.SelStart = 0
    mskfechahasta.SelLength = Len(mskfechahasta.Text)
End Sub
Private Sub mskFechahasta_KeyPress(KeyAscii As Integer)

   If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
      KeyAscii% = 0
   End If

End Sub
Private Sub mskFechahasta_LostFocus()
'CloVargas Oct/19/2001 Manejo de Formato Fecha
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

End Sub
Private Sub mskFecha_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Formato Fecha Inicial [" & VGFormatoFecha & "]"
    MskFecha.SelStart = 0
    MskFecha.SelLength = Len(MskFecha.Text)
    
End Sub

Private Sub mskFecha_KeyPress(KeyAscii As Integer)

   If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
      KeyAscii% = 0
   End If

End Sub

Private Sub MskFecha_LostFocus()
'CloVargas Oct/19/2001 Manejo de Formato Fecha
    If MskFecha.ClipText <> "" Then
        VT% = FMVerFormato((MskFecha.FormattedText), VGFormatoFecha)
        If Not VT% Then
            MsgBox "Formato de Fecha Inválido", 48, "Control Ingreso de Datos"
            VLError% = True
            MskFecha.SetFocus
            Exit Sub
        Else
        'Verficar que fecha de consulta sea menor que la fecha del sistema
           VTFecha1$ = Format(MskFecha.Text, VGFormatoFecha$)
           VTFecha2$ = Format(VGFecha$, VGFormatoFecha$)
           If FMDateDiff("d", VTFecha1, VTFecha2$, VGFormatoFecha) <= 0 Then
                MskFecha.Text = Format(VGFecha$, VGFormatoFecha$)
           End If
        End If
    End If
        
'    If mskFecha.Text <> "" Then
'       VTMes% = Val(Mid$(mskFecha.Text, 1, 2))
'       VTDia% = Val(Mid$(mskFecha.Text, 4, 2))
'       VTAno% = Val(Mid$(mskFecha.Text, 7, 4))
'       If ((VTMes% > 12) Or (VTMes% < 1)) Then
'          mskFecha.Text = Format(VGFecha$, VGFormatoFecha$)
'         ElseIf ((VTDia% > 31) And (VTDia% < 1)) Then
'            mskFecha.Text = Format(VGFecha$, VGFormatoFecha$)
'           ElseIf ((VTAno% > 99) And (VTAno% < 1)) Then
'             mskFecha.Text = Format(VGFecha$, VGFormatoFecha$)
'       End If
'       VTFecha1$ = Format(mskFecha.Text, VGFormatoFecha$)
'       VTFecha2$ = Format(VGFecha$, VGFormatoFecha$)
'       If FMDateDiff("d", VTFecha1$, VTFecha2$, VGFormatoFecha$) <= 0 Then
'          mskFecha.Text = Format(VGFecha$, VGFormatoFecha$)
'       End If
'    End If
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
'**************************************************************

'FIXIT: Declare 'VTColumnas' with an early-bound data type                                 FixIT90210ae-R1672-R1B8ZE
    Dim VTColumnas() As Integer 'Contiene los índices de las columnas a imprimir
'FIXIT: Declare 'VTSepColumnas' with an early-bound data type                              FixIT90210ae-R1672-R1B8ZE
    Dim VTSepColumnas() As Integer 'Contiene las separaciones en caracteres de las columnas
'FIXIT: Declare 'VTCapSubtitulos' with an early-bound data type                            FixIT90210ae-R1672-R1B8ZE
    Dim VTCapSubtitulos() As Integer    'Contiene los números de recursos para los Nombres de los subtítulos
'FIXIT: Declare 'VTValSubtitulos' with an early-bound data type                            FixIT90210ae-R1672-R1B8ZE
    Dim VTValSubtitulos() As String 'Contiene los números de recursos para los Valores de los subtítulos
    Dim VTNumColumnas As Integer      'Contiene el número de filas a imprimir
'FIXIT: Declare 'VTAlineacion' with an early-bound data type                               FixIT90210ae-R1672-R1B8ZE
    Dim VTAlineacion() As Integer
    
    VLcompara% = Val(txtCampo(1).Text)
        Select Case VLcompara%
            Case 261, 263
                VLVista$ = "1"  'ah_retiro
                VTNumColumnas% = 8
                VTColumnas = Array(1, 2, 3, 4, 5, 6, 9, 10)
                VTSepColumnas = Array(15, 12, 15, 12, 15, 12, 15, 12)
                VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)
            Case 251, 252, 254
                VLVista$ = "2"  'ah_deposito
                VTNumColumnas% = 8
                VTColumnas = Array(1, 2, 3, 4, 5, 6, 9, 10)
                VTSepColumnas = Array(15, 12, 15, 12, 15, 12, 15, 12)
                VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)
                
            Case 221, 255, 253, 257, 262, 264, 265, 266
                VLVista$ = "3"  'ah_notcredeb
                VTNumColumnas% = 9
                VTColumnas = Array(1, 2, 3, 4, 5, 6, 8, 11, 12)
                VTSepColumnas = Array(15, 12, 15, 12, 15, 12, 15, 12, 15)
                VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)
            Case 215
                VLVista$ = "4"  'ah_apertura_caja
                VTNumColumnas% = 5
                VTColumnas = Array(1, 2, 3, 4, 5)
                VTSepColumnas = Array(15, 12, 15, 12, 15)
                VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)
            Case 213
                VLVista$ = "5"  'ah_cierre
                VTNumColumnas% = 9
                VTColumnas = Array(1, 2, 3, 4, 5, 6, 7, 12, 13)
                VTSepColumnas = Array(15, 12, 10, 12, 25, 12, 12, 12, 15)
                VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)
            Case 237, 239
                VLVista$ = "6"  'ah_transferencia
                VTNumColumnas% = 8
                VTColumnas = Array(1, 2, 3, 4, 5, 6, 9, 10)
                VTSepColumnas = Array(15, 12, 15, 12, 15, 12, 15, 12)
                VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)
            Case 309, 309
                VLVista$ = "7"  'ah
                VTNumColumnas% = 6
                VTColumnas = Array(1, 2, 3, 4, 5, 6)
                VTSepColumnas = Array(15, 15, 6, 15, 12, 15)
                VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)
            
            Case Else
                VLVista$ = "8"  'En caso de no estar definido la transaccion
                VTNumColumnas% = 8
                VTColumnas = Array(1, 2, 3, 4, 5, 6, 7, 8)
                VTSepColumnas = Array(15, 15, 15, 15, 15, 15, 15, 15)
                VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_LEFT_ALIGN%)
        End Select
        
        VTCapSubtitulos = Array(5122, 5123, 5016, 5005, 5084, 5065, 5066)
       
        'Configuración de los valores de los subtítulos
        VTValSubtitulos = Array("", "", "", "", "", "", "", "") 'Inicialización del arreglo
        VTValSubtitulos(0) = LoadResString(5121)    'Tipo de ejecución
        VTValSubtitulos(1) = "  " + VGLogin$
        If mskCuenta.ClipText = "" Then
            VTValSubtitulos(2) = "  " + LoadResString(9037)
        Else
            VTValSubtitulos(2) = "  " + mskCuenta.Text
        End If
        
        If txtCampo(0).Text = "" Then 'agencia
           VTValSubtitulos(3) = "  " + LoadResString(9037)
        Else
           VTValSubtitulos(3) = "  " + txtCampo(0).Text
        End If
        
        If txtCampo(1).Text = "" Then 'transaccion
           VTValSubtitulos(4) = "  " + LoadResString(9037)
        Else
           VTValSubtitulos(4) = "  " + txtCampo(1).Text + " " + lblDescripcion(1).Caption
        End If
        
        VTValSubtitulos(5) = MskFecha.Text
        VTValSubtitulos(6) = mskfechahasta.Text
        
        'Llamada al procedimiento de Impresión de Reportes
        PMImprimirReporte1 grdRegistros, VTNumColumnas%, VTColumnas(), VTSepColumnas, 3873, VTCapSubtitulos, VTValSubtitulos(), VTAlineacion, CG_LANDSCAPE%

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
   
   MskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
   mskfechahasta.Text = Format$(VGFecha$, VGFormatoFecha$)
   lblDescripcion(0).Caption = ""
   lblDescripcion(1).Caption = ""
   lblDescripcion(2).Caption = ""
   lblDescripcion(3).Caption = ""
   PMBorrarGrid Me.grdRegistros
   txtCampo(0).Enabled = True
   txtCampo(0).Text = ""
   txtCampo(1).Text = ""
   txtCampo(2).Text = ""
   txtCampo(0).SetFocus
   If cmdBoton(1).Enabled = True Then
      cmdBoton(1).Enabled = True
   End If
   mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)

End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
        Case 0, 1, 2
           VLPaso% = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
       Case 0
          FPrincipal!pnlHelpLine.Caption = " Código de la Oficina [F5 Ayuda]"
       Case 1
          FPrincipal!pnlHelpLine.Caption = " Código del tipo de transacción [F5 Ayuda]"
       Case 2
          FPrincipal!pnlHelpLine.Caption = " Código Producto Bancario [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode = VGTeclaAyuda% Then
       VLPaso% = True
       Select Case Index%
          Case 0
             VGOperacion$ = "sp_agencia" '"sp_oficina"
             txtCampo(Index%).Text = ""
             PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "O"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", True, " Consulta de la agencia " & "[" & txtCampo(0).Text & "]") Then
          
              'PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
              'PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
              'If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la agencia " & "[" & txtCampo(0).Text & "]") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(Index%).Text = VGACatalogo.Codigo$
                lblDescripcion(Index%).Caption = VGACatalogo.Descripcion$
                If txtCampo(Index%).Text <> "" Then
                   txtCampo(1).SetFocus
                End If
              Else
                 txtCampo(Index%).Text = ""
                 lblDescripcion(Index%).Caption = ""
                 txtCampo(Index%).SetFocus
             End If
          Case 1
             VGOperacion$ = "sp_tranhistoricos"
             txtCampo(Index%).Text = ""
              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2576"
              PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, VGProducto$
              PMPasoValores sqlconn&, "@i_qry", 0, SQLCHAR, "T"  'Total
              PMPasoValores sqlconn&, "@i_tipotrn", 0, SQLINT4, "0"
              PMPasoValores sqlconn&, "@i_tipohis", 0, SQLCHAR, VGTipoHis$  'Monetarias
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
                txtCampo(Index%).Text = VGACatalogo.Codigo$
                lblDescripcion(Index%).Caption = VGACatalogo.Descripcion$
                If txtCampo(Index%).Text <> "" Then
                   MskFecha.SetFocus
                End If
             Else
                  PMChequea sqlconn&
                  txtCampo(Index%).Text = ""
                  lblDescripcion(Index%).Caption = ""
                  txtCampo(Index%).SetFocus
             End If
          Case 2
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
             PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
             PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "4"
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_productoban", True, " Ok... Consulta de Productos Bancarios") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                'VLPaso% = True
                FCatalogo.Show 1
                txtCampo(2).Text = VGACatalogo.Codigo$
                lblDescripcion(2).Caption = VGACatalogo.Descripcion$
                'mskCuenta.SetFocus
             Else
                 PMChequea sqlconn&
                 txtCampo(2).Text = ""
                 lblDescripcion(2).Caption = ""
                 txtCampo(2).SetFocus
             End If
       End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
   Select Case Index%
      Case 0, 1, 2
         If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
         End If
  End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    If txtCampo(Index).Text = "" Then
        lblDescripcion(Index).Caption = ""
    End If
    
    If VLPaso% = False And txtCampo(Index%).Text <> "" Then
       Select Case Index%
          Case 0
            If txtCampo(0).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "Q"
                 PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(0).Text)
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "34"
                 PMPasoValores sqlconn&, "@i_sig", 0, SQLINT2, "1"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_agencia", True, " Consulta de la agencia " & "[" & txtCampo(0).Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(0)
                    PMChequea sqlconn&
                Else
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                    txtCampo(0).SetFocus
                End If
            End If
          Case 1
            If txtCampo(1).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2576"
                 PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, VGProducto$
                 PMPasoValores sqlconn&, "@i_qry", 0, SQLCHAR, "I"             'Individual
                 PMPasoValores sqlconn&, "@i_tipohis", 0, SQLCHAR, VGTipoHis$  'Monetarias
                 PMPasoValores sqlconn&, "@i_tipotrn", 0, SQLINT4, (txtCampo(1).Text)
                 PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, "0"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_qry_tranms", True, " Ok... Consulta de Tipos de Transacciones Monetarias") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(1)
                     PMChequea sqlconn&
                     MskFecha.SetFocus
                Else
                    PMChequea sqlconn&
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Caption = ""
                    txtCampo(1).SetFocus
                End If
            End If
          Case 2
            If txtCampo(2).Text <> "" Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
                PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_prodfin", 0, SQLINT2, (txtCampo(2).Text)
                PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "4"
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
                    
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_productoban", True, "Ok.. Consulta de Producto Bancaria") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(2)
                    PMChequea sqlconn&
                    'VLPaso% = True
                Else
                    PMChequea sqlconn&
                    txtCampo(2).Text = ""
                    lblDescripcion(2).Caption = ""
                    txtCampo(2).SetFocus
                End If
            End If
       End Select
       PMBorrarGrid Me.grdRegistros
    End If
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
   Select Case Index
        Case 0, 1, 2
            'Bloquea el Click Derecho
            Clipboard.Clear
            Clipboard.SetText ""
   End Select
End Sub

