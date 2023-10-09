VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran2688 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Levantamiento de Bloqueos de Consumos"
   ClientHeight    =   5325
   ClientLeft      =   795
   ClientTop       =   1995
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
   HelpContextID   =   1060
   LinkTopic       =   "Form14"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   2145
      Style           =   2  'Dropdown List
      TabIndex        =   17
      Top             =   30
      Width           =   2205
   End
   Begin Threed.SSFrame frmCheques 
      Height          =   2430
      Left            =   45
      TabIndex        =   12
      Top             =   2850
      Width           =   8280
      _Version        =   65536
      _ExtentX        =   14606
      _ExtentY        =   4287
      _StockProps     =   14
      Caption         =   "Datos del Consumo:"
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
      Begin MSMask.MaskEdBox mskValor 
         Height          =   285
         Index           =   1
         Left            =   4050
         TabIndex        =   5
         Top             =   1215
         Width           =   1830
         _ExtentX        =   3228
         _ExtentY        =   503
         _Version        =   393216
         PromptChar      =   "_"
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   4050
         MaxLength       =   6
         TabIndex        =   3
         Top             =   615
         Width           =   1830
      End
      Begin MSMask.MaskEdBox mskValor 
         Height          =   285
         Index           =   0
         Left            =   4050
         TabIndex        =   4
         Top             =   915
         Width           =   1830
         _ExtentX        =   3228
         _ExtentY        =   503
         _Version        =   393216
         Format          =   "#,##0.00"
         PromptChar      =   "_"
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   2220
         TabIndex        =   16
         Top             =   1185
         Width           =   600
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Valor del Consumo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   2220
         TabIndex        =   9
         Top             =   915
         Width           =   1650
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Clave de Consumo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   2205
         TabIndex        =   14
         Top             =   630
         Width           =   1650
      End
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   315
      Left            =   2145
      TabIndex        =   0
      Top             =   360
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   556
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   1
      Top             =   1050
      WhatsThisHelpID =   2026
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Propiet."
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
   Begin MSGrid.Grid grdPropietarios 
      Height          =   1335
      Left            =   0
      TabIndex        =   2
      Top             =   1395
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   2355
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
      Left            =   8415
      TabIndex        =   6
      Top             =   3015
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   7
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
      Index           =   2
      Left            =   8415
      TabIndex        =   8
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Producto: "
      ForeColor       =   &H00800000&
      Height          =   210
      Index           =   2
      Left            =   30
      TabIndex        =   18
      Top             =   75
      Width           =   1380
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Propietarios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   30
      TabIndex        =   13
      Top             =   1155
      Width           =   1080
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   30
      TabIndex        =   15
      Top             =   720
      WhatsThisHelpID =   5017
      Width           =   1920
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   -45
      X2              =   8370
      Y1              =   2790
      Y2              =   2790
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   30
      TabIndex        =   11
      Top             =   420
      WhatsThisHelpID =   5016
      Width           =   1365
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -75
      X2              =   8340
      Y1              =   1080
      Y2              =   1080
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   315
      Index           =   0
      Left            =   2145
      TabIndex        =   10
      Top             =   690
      UseMnemonic     =   0   'False
      Width           =   6120
   End
End
Attribute VB_Name = "FTran2688"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTRA2688.frm
' NOMBRE LOGICO:    FTran2688
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
' Permite realizar el Levantamiento de Bloqueos de Consumos
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

'Dim VLFormatoFecha As String
'CloVargas Oct/22/2001 Manejo de Formato Fecha
Dim VTFecha As String

Private Sub Form_Load()
    FTran2688.Left = 0   '15
    FTran2688.Top = 0   '15
    FTran2688.Width = 9450   '9420
    FTran2688.Height = 5900   '5730
    mskValor(0).MaxLength = 14
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaCte$
    mskValor(0).Format = VGDecimales$
    mskValor(0).Text = Format$(0, VGDecimales$)
    
    'VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    mskValor(1).Mask = FMMascaraFecha(VGFormatoFecha$)
    mskValor(1).Text = Format$(VGFecha$, VGFormatoFecha$)

    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 0
    cmbTipo.Enabled = True


End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
        'Transmitir

        ' Validacion de Mandatoriedades

        ' Numero de Cuenta Corriente o de Ahorros
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El número de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

        ' Clave del Consumo
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "La clave del consumo es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        'Valor del consumo
        If CCur(Trim$(mskValor(0).Text)) <= 0 Then
            MsgBox "El valor del consumo debe ser mayor a cero", 0 + 16, "Mensaje de Error"
            mskValor(0).SetFocus
            Exit Sub
        End If

        ' Fecha del Levantamiento
        If Trim$(mskValor(1).ClipText) = "" Then
            MsgBox "La fecha del Levantamiento es mandatoria", 0 + 16, "Mensaje de Error"
            mskValor(1).SetFocus
            Exit Sub
        End If

       ' Si se trata de una CC
       If cmbTipo.Text = "CUENTA CORRIENTE" Then
          ' Verifica el dígito verificador
         If FMChequeaCtaCte((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2688"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
             PMPasoValores sqlconn&, "@i_clave", 0, SQLINT4, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_valor", 0, SQLMONEY, (mskValor(0).Text)
            'VTFecha$ = FMConvFecha((mskValor(1).FormattedText), VLFormatoFecha$, "mm/dd/yyyy")
             VTFecha = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
             PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFecha$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_lev_consumo", True, "Ok... Levantamiento Manual de Consumos") Then
                 PMChequea sqlconn&
                cmdBoton(0).Enabled = False
            End If
         Else
            MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
            mskCuenta.SetFocus
            Exit Sub
         End If

     ' Se trata de una CA
       Else
         ' Verifica el dígito verificador
         If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "306"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
             PMPasoValores sqlconn&, "@i_clave", 0, SQLINT4, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_valor", 0, SQLMONEY, (mskValor(0).Text)
            'VTFecha$ = FMConvFecha((mskValor(1).FormattedText), VLFormatoFecha$, "mm/dd/yyyy")
             VTFecha$ = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
             PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFecha$
        
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_lev_ah_consumo", True, "Ok... Levantamiento Manual de Consumos") Then
                 PMChequea sqlconn&
                cmdBoton(0).Enabled = False
            End If
         Else
            MsgBox "El dígito verificador de la cuenta de ahorro está incorrecto", 0 + 16, "Mensaje de Error"
               If cmbTipo.Text = "CUENTA CORRIENTE" Then
                  mskCuenta.Mask = VGMascaraCtaCte$
               Else
                  mskCuenta.Mask = VGMascaraCtaAho$
               End If
                       
             mskCuenta.SetFocus
             Exit Sub
         End If

       End If
        ' cmdBoton(0).Enabled = False
    Case 1
        'Limpiar
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        lblDescripcion(0).Caption = ""
        txtCampo(0).Text = ""
        mskValor(0).Text = ""
        PMLimpiaGrid grdPropietarios
        cmdBoton(3).Enabled = False
        mskValor(0).Format = VGDecimales$
        mskValor(0).Text = Format$(0, VGDecimales$)
        mskValor(1).Text = Format$(VGFecha$, VGFormatoFecha$)
        cmdBoton(0).Enabled = True
        mskCuenta.SetFocus
    Case 2
        'Salir
        Unload FTran2688
    Case 3
         ' Se trata de una CC
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
         ' Verifica el dígito verificador
          PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "17"
          PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
          PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
          If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_clientes", True, " Ok... Consulta de Propietarios") Then
              PMMapeaGrid sqlconn&, grdPropietarios, False
              PMChequea sqlconn&
         Else
             mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
             mskCuenta.SetFocus
             Exit Sub
         End If
    Else

         PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "298"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_clientes_ah", True, " Ok... Consulta de propietarios") Then
             PMMapeaGrid sqlconn&, grdPropietarios, False
             PMChequea sqlconn&

         Else
             mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
             mskCuenta.SetFocus
             Exit Sub
         End If
    End If

    End Select
End Sub


Private Sub grdPropietarios_Click()
    grdPropietarios.Col = 0
    grdPropietarios.SelStartCol = 1
    grdPropietarios.SelEndCol = grdPropietarios.Cols - 1
    If grdPropietarios.Row = 0 Then
        grdPropietarios.SelStartRow = 1
        grdPropietarios.SelEndRow = 1
    Else
        grdPropietarios.SelStartRow = grdPropietarios.Row
        grdPropietarios.SelEndRow = grdPropietarios.Row
    End If
End Sub

Private Sub grdPropietarios_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de propietarios de la cuenta"
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
       ' Se trata de una CC
     If cmbTipo.Text = "CUENTA CORRIENTE" Then

        If FMChequeaCtaCte((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                cmdBoton(0).Enabled = True
                cmdBoton(3).Enabled = True
                PMLimpiaGrid grdPropietarios
            Else
             If cmbTipo.Text = "CUENTA CORRIENTE" Then
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
             Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
             End If
             
                lblDescripcion(0).Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
            lblDescripcion(0).Caption = ""
            mskCuenta.SetFocus
            Exit Sub
        End If
    Else
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                cmdBoton(0).Enabled = True
                cmdBoton(3).Enabled = True
                PMLimpiaGrid grdPropietarios
            Else
             If cmbTipo.Text = "CUENTA CORRIENTE" Then
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
             Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
             End If
             
                lblDescripcion(0).Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
            lblDescripcion(0).Caption = ""
            mskCuenta.SetFocus
            Exit Sub
        End If
   End If
 End If
End Sub

Private Sub mskValor_GotFocus(Index As Integer)
  Select Case Index%
  Case 0

    FPrincipal!pnlHelpLine.Caption = " Valor del Cheque Conformado"
    mskValor(Index%).MaxLength = 14
  Case 1
    FPrincipal!pnlHelpLine.Caption = " Fecha del Levantamiento del Consumo [" & VGFormatoFecha & "]"
  End Select

    mskValor(Index%).SelStart = 0
    mskValor(Index%).SelLength = Len(mskValor(Index%).Text)

End Sub

Private Sub mskValor_KeyPress(Index As Integer, KeyAscii As Integer)
    
  Select Case Index%
  Case 0
    If VGDecimales$ = "#,##0" Then
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Else
        If (KeyAscii% <> 8) And (KeyAscii% <> 46) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End If
  Case 1
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
  End Select

End Sub

Private Sub mskValor_LostFocus(Index As Integer)
    On Error Resume Next
    Dim VTValido As String
    Select Case Index%
    Case 1
        If mskValor(Index%).ClipText <> "" Then
            VTValido = FMVerFormato((mskValor(Index).FormattedText), VGFormatoFecha$)
            If Not VTValido Then
                MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
                mskValor(Index%).SetFocus
                Exit Sub
            End If
        Else
            mskValor(1).Mask = FMMascaraFecha(VGFormatoFecha$)
                mskValor(1).Text = Format$(VGFecha$, VGFormatoFecha$)
        End If
   End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        txtCampo(0).MaxLength = 8
        FPrincipal!pnlHelpLine.Caption = " Número del Cheque Revocado"
    Case 1
        txtCampo(1).MaxLength = 25
        FPrincipal!pnlHelpLine.Caption = " Departamento o Persona que lo solicite"

    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
    
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Case 1
        KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
    End Select
End Sub


