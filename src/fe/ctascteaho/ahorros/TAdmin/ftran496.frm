VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form ftran496 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Deposito Monetario"
   ClientHeight    =   5340
   ClientLeft      =   2100
   ClientTop       =   2430
   ClientWidth     =   9345
   ForeColor       =   &H8000000E&
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   5340
   ScaleWidth      =   9345
   Begin Threed.SSFrame frmCheques 
      Height          =   2505
      Left            =   105
      TabIndex        =   0
      Top             =   2775
      Width           =   8280
      _Version        =   65536
      _ExtentX        =   14606
      _ExtentY        =   4419
      _StockProps     =   14
      Caption         =   "Datos del Depósito"
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
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   1
         Left            =   2355
         MaxLength       =   6
         TabIndex        =   7
         Top             =   2000
         Width           =   1815
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   2355
         MaxLength       =   6
         TabIndex        =   2
         Top             =   405
         Width           =   1830
      End
      Begin MSMask.MaskEdBox mskValor 
         Height          =   285
         Left            =   2355
         TabIndex        =   3
         Top             =   723
         Width           =   1830
         _ExtentX        =   3228
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         Format          =   "#,##0.00"
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox Maskpropios 
         Height          =   285
         Left            =   2355
         TabIndex        =   4
         Top             =   1041
         Width           =   1830
         _ExtentX        =   3228
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         Format          =   "#,##0.00"
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox MaskObancos 
         Height          =   285
         Left            =   2355
         TabIndex        =   5
         Top             =   1359
         Width           =   1830
         _ExtentX        =   3228
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         Format          =   "#,##0.00"
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox MaskExt 
         Height          =   285
         Left            =   2355
         TabIndex        =   6
         Top             =   1680
         Width           =   1830
         _ExtentX        =   3228
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         Format          =   "#,##0.00"
         PromptChar      =   "_"
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Secuencial:"
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
         Left            =   240
         TabIndex        =   22
         Top             =   2000
         Width           =   1020
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Cheques del Ext.:"
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
         Index           =   8
         Left            =   240
         TabIndex        =   21
         Top             =   1680
         Width           =   1515
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Cheques Otros Bancos:"
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
         Index           =   7
         Left            =   240
         TabIndex        =   20
         Top             =   1365
         Width           =   2010
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Cheques Propios:"
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
         Left            =   240
         TabIndex        =   19
         Top             =   1035
         Width           =   1500
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Boleta:"
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
         Index           =   5
         Left            =   210
         TabIndex        =   9
         Top             =   405
         Width           =   615
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Efectivo:"
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
         Left            =   225
         TabIndex        =   8
         Top             =   723
         Width           =   780
      End
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2295
      TabIndex        =   1
      Top             =   45
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8475
      TabIndex        =   10
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
      Height          =   1635
      Left            =   75
      TabIndex        =   11
      Top             =   1050
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   2884
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
      Left            =   8475
      TabIndex        =   12
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
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8475
      TabIndex        =   13
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
      Left            =   8475
      TabIndex        =   14
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
      Index           =   0
      Left            =   2295
      TabIndex        =   18
      Top             =   345
      UseMnemonic     =   0   'False
      Width           =   6120
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8445
      X2              =   8445
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8415
      Y1              =   690
      Y2              =   690
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
      Left            =   150
      TabIndex        =   17
      Top             =   45
      WhatsThisHelpID =   5016
      Width           =   2175
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8415
      Y1              =   2715
      Y2              =   2715
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
      Left            =   150
      TabIndex        =   16
      Top             =   345
      WhatsThisHelpID =   5017
      Width           =   2130
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Propietarios:"
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
      Left            =   90
      TabIndex        =   15
      Top             =   780
      Width           =   1080
   End
End
Attribute VB_Name = "ftran496"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          ftran496.frm
' NOMBRE LOGICO:    ftran496
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
' Permite realizar un Deposito Monetario
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Option Explicit

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0
        'Transmitir

        ' Validacion de Mandatoriedades

        ' Numero de Cuenta Corriente
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El número de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

        ' Numero del cheque revocado
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El número de boleta es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(1).Text) = "" Then
            MsgBox "Secuencial es obligatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@s_ssn_branch", 0, SQLINT4, (txtCampo(1).Text)
         PMPasoValores sqlconn&, "@s_sesn", 0, SQLINT4, (txtCampo(1).Text)
         PMPasoValores sqlconn&, "@s_lsrv", 0, SQLVARCHAR, ServerNameLocal$
         PMPasoValores sqlconn&, "@s_srv", 0, SQLVARCHAR, ServerNameLocal$
         PMPasoValores sqlconn&, "@s_user", 0, SQLVARCHAR, "dvasquezl"
         PMPasoValores sqlconn&, "@s_term", 0, SQLVARCHAR, "consola"
         PMPasoValores sqlconn&, "@s_date", 0, SQLDATETIME, "08/06/2002"
         PMPasoValores sqlconn&, "@s_ofi", 0, SQLINT2, "1"
         PMPasoValores sqlconn&, "@s_rol", 0, SQLINT2, "1"
         PMPasoValores sqlconn&, "@s_org", 0, SQLCHAR, "U"
         
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "40"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, mskValor.Text
         PMPasoValores sqlconn&, "@i_prop", 0, SQLMONEY, Maskpropios.Text
         PMPasoValores sqlconn&, "@i_loc", 0, SQLMONEY, MaskObancos.Text
         PMPasoValores sqlconn&, "@i_plaz", 0, SQLMONEY, MaskExt.Text
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_sp", 0, SQLVARCHAR, "sp_deposito"
         
         PMPasoValores sqlconn&, "@i_ActTot", 0, SQLCHAR, "N"
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, "1"
         PMPasoValores sqlconn&, "@i_consumo", 0, SQLMONEY, "0.00"
         PMPasoValores sqlconn&, "@i_planilla", 0, SQLVARCHAR, txtCampo(0).Text
         
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_deposito", True, "Ok... Deposito Monetario de prueba") Then
             PMChequea sqlconn&
            cmdBoton(0).Enabled = False
        End If
    Case 1
        'Limpiar
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        lblDescripcion(0).Caption = ""
        lblDescripcion(1).Caption = ""
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        mskValor.Text = ""
        PMLimpiaGrid grdPropietarios
        cmdBoton(3).Enabled = False
        mskValor.Format = VGDecimales$
        mskValor.Text = Format$(0, VGDecimales$)
        cmdBoton(0).Enabled = True
        FPrincipal!pnlHelpLine.Caption = ""
        FPrincipal!pnlTransaccionLine.Caption = ""

        mskCuenta.SetFocus
    Case 2
        'Salir
        Unload ftran496
    Case 3
        'Consultar
         PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "17"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_clientes", True, " Ok... Consulta de propietarios") Then
             PMMapeaGrid sqlconn&, grdPropietarios, False
             PMChequea sqlconn&
        End If
    End Select
End Sub

Private Sub Form_Load()
    ftran496.Left = 0
    ftran496.Top = 0
    ftran496.Width = 9450
    ftran496.Height = 5900
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskValor.MaxLength = 14
    mskCuenta.Mask = VGMascaraCtaCte$
    mskValor.Format = VGDecimales$
    mskValor.Text = Format$(0, VGDecimales$)
    Maskpropios.Format = VGDecimales$
    Maskpropios.Text = Format$(0, VGDecimales$)
    MaskObancos.Format = VGDecimales$
    MaskObancos.Text = Format$(0, VGDecimales$)
    MaskExt.Format = VGDecimales$
    MaskExt.Text = Format$(0, VGDecimales$)
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
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
        If FMChequeaCtaCte((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                cmdBoton(3).Enabled = True
                PMLimpiaGrid grdPropietarios
            Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(0).Caption = ""
                cmdBoton(3).Enabled = False
                PMLimpiaGrid grdPropietarios
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
            lblDescripcion(0).Caption = ""
            PMLimpiaGrid grdPropietarios
            cmdBoton(3).Enabled = False
            mskCuenta.SetFocus
            Exit Sub
        End If
    End If
End Sub

Private Sub mskValor_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Valor en efectivo"
    mskValor.MaxLength = 14
    mskValor.SelStart = 0
    mskValor.SelLength = Len(mskValor.Text)
End Sub

Private Sub mskValor_KeyPress(KeyAscii As Integer)
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
Private Sub maskpropios_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Valor del Cheques propios"
    Maskpropios.MaxLength = 14
    Maskpropios.SelStart = 0
    Maskpropios.SelLength = Len(Maskpropios.Text)
End Sub

Private Sub Maskpropios_KeyPress(KeyAscii As Integer)
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
Private Sub maskobancos_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Valor del Cheques de otros bancos"
    MaskObancos.MaxLength = 14
    MaskObancos.SelStart = 0
    MaskObancos.SelLength = Len(MaskObancos.Text)
End Sub

Private Sub maskobancos_KeyPress(KeyAscii As Integer)
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
Private Sub maskext_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Valor del Cheques del exterior"
    MaskExt.MaxLength = 14
    MaskExt.SelStart = 0
    MaskExt.SelLength = Len(MaskExt.Text)
End Sub

Private Sub maskext_KeyPress(KeyAscii As Integer)
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

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        txtCampo(0).MaxLength = 8
    Case 1
        txtCampo(1).MaxLength = 25

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
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    End Select
End Sub



