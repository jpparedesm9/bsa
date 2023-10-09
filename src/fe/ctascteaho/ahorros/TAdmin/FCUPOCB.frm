VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{DECFDD03-1E4B-11D1-B65E-0000C039C248}#5.0#0"; "mskedit.ocx"
Begin VB.Form FMantenimientoCupoCB 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Mantenimiento Cupo Corresponsal Bancario Red Posicionada "
   ClientHeight    =   5310
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   8955
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5310
   ScaleWidth      =   8955
   Begin VB.OptionButton optTipoMov 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Vigencia"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   3
      Left            =   6120
      TabIndex        =   22
      Top             =   1800
      Width           =   1215
   End
   Begin VB.OptionButton optTipoMov 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Registro"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   0
      Left            =   4440
      TabIndex        =   4
      Top             =   1440
      Width           =   1215
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   2775
      Left            =   120
      TabIndex        =   8
      Top             =   2520
      Width           =   7695
      _Version        =   65536
      _ExtentX        =   13573
      _ExtentY        =   4895
      _StockProps     =   77
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.OptionButton optTipoMov 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Disminución"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   1
      Left            =   4440
      TabIndex        =   7
      Top             =   1800
      Width           =   1215
   End
   Begin VB.OptionButton optTipoMov 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Incremento"
      ForeColor       =   &H00800000&
      Height          =   255
      Index           =   2
      Left            =   6120
      TabIndex        =   5
      Top             =   1440
      Width           =   1215
   End
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   285
      Left            =   2040
      TabIndex        =   6
      Top             =   1695
      Width           =   1215
      _ExtentX        =   2143
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      MaxLength       =   10
      Mask            =   "##/##/####"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   255
      Left            =   2040
      TabIndex        =   1
      Top             =   360
      Width           =   1845
      _ExtentX        =   3254
      _ExtentY        =   450
      _Version        =   393216
      Appearance      =   0
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   2
      Left            =   8040
      TabIndex        =   19
      Top             =   1800
      WhatsThisHelpID =   2007
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1614
      _ExtentY        =   1455
      _StockProps     =   78
      Caption         =   "&Transmitir"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FCUPOCB.frx":0000
   End
   Begin VB.Frame fraCupo 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Registro de Cupo del Corresponsal"
      ForeColor       =   &H00800000&
      Height          =   2175
      Left            =   120
      TabIndex        =   0
      Top             =   120
      Width           =   7785
      Begin VB.TextBox txtDiasVig 
         Height          =   285
         Left            =   1920
         MaxLength       =   4
         TabIndex        =   3
         Top             =   1200
         Width           =   975
      End
      Begin VB.Frame fraTipoMov 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Tipo de Movimiento"
         ForeColor       =   &H000000C0&
         Height          =   1095
         Left            =   4200
         TabIndex        =   13
         Top             =   960
         Width           =   3135
      End
      Begin MskeditLib.MaskInBox mskCupo 
         Height          =   255
         Left            =   1920
         TabIndex        =   2
         Top             =   840
         Width           =   1815
         _Version        =   262144
         _ExtentX        =   3201
         _ExtentY        =   450
         _StockProps     =   253
         Text            =   "0.00"
         Appearance      =   1
         Decimals        =   2
         Separator       =   -1  'True
         MaskType        =   0
         HideSelection   =   0   'False
         MaxLength       =   0
         AutoTab         =   0   'False
         DateString      =   ""
         FormattedText   =   ""
         Mask            =   ""
         HelpLine        =   ""
         ClipText        =   "0.00"
         ClipMode        =   0
         StringIndex     =   0
         DateType        =   0
         DateSybase      =   "12/16/13"
         AutoDecimal     =   0   'False
         MinReal         =   -1.1e38
         MaxReal         =   3.4e38
         Units           =   0
         Errores         =   0
      End
      Begin VB.Label Label2 
         BackStyle       =   0  'Transparent
         Caption         =   "Días de Vigencia:"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   165
         TabIndex        =   15
         Top             =   1245
         Width           =   1335
      End
      Begin VB.Label Label1 
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha de Vencimiento:"
         ForeColor       =   &H00800000&
         Height          =   255
         Left            =   165
         TabIndex        =   14
         Top             =   1620
         Width           =   1695
      End
      Begin VB.Label lblCorresponsal 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
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
         Left            =   1920
         TabIndex        =   12
         Top             =   510
         Width           =   5775
      End
      Begin VB.Label lblEtiqueta 
         BackStyle       =   0  'Transparent
         Caption         =   "Cupo:"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   2
         Left            =   165
         TabIndex        =   11
         Top             =   900
         Width           =   1575
      End
      Begin VB.Label lblEtiqueta 
         BackStyle       =   0  'Transparent
         Caption         =   "Corresponsal:"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   1
         Left            =   165
         TabIndex        =   10
         Top             =   600
         Width           =   1695
      End
      Begin VB.Label lblEtiqueta 
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "No. de Cuenta Ahorros:"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   0
         Left            =   150
         TabIndex        =   9
         Top             =   285
         Width           =   1695
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   0
      Left            =   8040
      TabIndex        =   17
      Tag             =   "388;389"
      Top             =   120
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Buscar"
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
      Picture         =   "FCUPOCB.frx":0376
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   1
      Left            =   8040
      TabIndex        =   18
      Tag             =   "388;389"
      Top             =   960
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "Si&guiente"
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
      Picture         =   "FCUPOCB.frx":1908
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   3
      Left            =   8040
      TabIndex        =   20
      Top             =   3600
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Limpiar"
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
      Picture         =   "FCUPOCB.frx":21E2
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   4
      Left            =   8040
      TabIndex        =   21
      Top             =   4440
      Width           =   915
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Salir"
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
      Picture         =   "FCUPOCB.frx":2ABC
   End
   Begin VB.Label Label3 
      BackStyle       =   0  'Transparent
      Caption         =   "Registros Existentes:"
      ForeColor       =   &H00800000&
      Height          =   255
      Left            =   120
      TabIndex        =   16
      Top             =   2280
      Width           =   1695
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   7920
      X2              =   7920
      Y1              =   0
      Y2              =   5280
   End
End
Attribute VB_Name = "FMantenimientoCupoCB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VTFecha As String
Dim VLFecha As String


'*************************************************************
' ARCHIVO:          FConsMovCB.frm
' NOMBRE LOGICO:    FCONSMOVCB
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
' Permite realizar el mantenimiento del cupo de CB
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 13-Ene-14      C. Avendaño     Emisión Inicial
'*************************************************************
Dim VLCuenta As String

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
        Case 0 'Buscar
            PLBuscar
        Case 1 'Siguientes
            PLSiguientes
        Case 2 'Transmitir
            PLTransmitir
        Case 3 'Limpiar
            PLLimpiar
        Case 4 'Salir
            Unload FMantenimientoCupoCB
    End Select
End Sub
Sub PLSiguientes()
    If mskCuenta.ClipText = "" And VLCuenta = "" Then
        MsgBox "Campo cuenta no puede ir vacio", vbInformation
        Exit Sub
    End If
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "398"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
    If mskCuenta.ClipText <> "" Then
        PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR&, mskCuenta.ClipText
    Else
        PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR&, VLCuenta
    End If
    grdRegistros.col = 8
    grdRegistros.Row = grdRegistros.Rows - 1
    PMPasoValores sqlconn&, "@i_hora", 0, SQLVARCHAR&, grdRegistros.Text
    PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
        PMMapeaGrid sqlconn&, grdRegistros, True
        If Val(grdRegistros.Tag) = 20 Then
            cmdBoton(1).Enabled = True
        Else
            cmdBoton(1).Enabled = False
        End If
        PMChequea sqlconn&
    Else
        PMChequea sqlconn&
    End If
End Sub
Sub PLLimpiar()
    mskCuenta.Mask = ""
    MskFecha.Mask = ""
    mskCuenta.Text = ""
    MskFecha.Text = ""
    mskCuenta.Mask = VGMascaraCtaAho
    MskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
    MskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
    lblCorresponsal.Caption = ""
    txtDiasVig.Text = 0
    mskCupo.Text = ""
    'PMLimpiaG grdRegistros
End Sub
Sub PLBuscar()
    If mskCuenta.ClipText = "" And VLCuenta = "" Then
        MsgBox "INGRESE NUMERO DE CUENTA", vbInformation
        mskCuenta.SetFocus
        Exit Sub
    End If
    VLCuenta = mskCuenta.ClipText
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "398"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
    PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR&, mskCuenta.ClipText
    PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
        PMMapeaGrid sqlconn&, grdRegistros, False
        If Val(grdRegistros.Tag) = 20 Then
            cmdBoton(1).Enabled = True
        Else
            cmdBoton(1).Enabled = False
            VLCuenta = ""
        End If
        PMChequea sqlconn&
    Else
        PMChequea sqlconn&
    End If
End Sub
Sub PLTransmitir()
    If mskCuenta.ClipText = "" Then
        MsgBox "INGRESE NUMERO DE CUENTA", vbInformation
        mskCuenta.SetFocus
        Exit Sub
    End If
    
    If mskCupo.Text = "0.00" And optTipoMov(0).Value = True Then
        MsgBox "EL VALOR DEL CUPO DEBE SER MAYOR A 0 PARA REALIZAR REGISTRO DE CUPO", vbInformation
        mskCupo.SetFocus
        Exit Sub
    End If
    
    If txtDiasVig.Text = "0" And optTipoMov(0).Value = True Then
        MsgBox "LOS DIAS DE VIGENCIAS DEBEN SER MAYOR A 0 PARA REALIZAR REGISTRO DE CUPO", vbInformation
        txtDiasVig.SetFocus
        Exit Sub
    End If
    
    If MskFecha.Text = VGFecha Then
        MsgBox "LA FECHA DE VENCIMIENTO NO DEBE SER IGUAL A LA FECHA DE PROCESO", vbInformation
        MskFecha.SetFocus
        Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "398"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "I"
    PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR&, mskCuenta.ClipText
    PMPasoValores sqlconn&, "@i_cod_cb", 0, SQLINT2&, "0"
    PMPasoValores sqlconn&, "@i_valor_cupo", 0, SQLMONEY&, mskCupo.ClipText
    PMPasoValores sqlconn&, "@i_dias_vigencia", 0, SQLINT2&, txtDiasVig.Text
    VTFecha = FMConvFecha((MskFecha.FormattedText), VGFormatoFecha$, CGFormatoBase$)
    PMPasoValores sqlconn&, "@i_fecha_vencimiento", 0, SQLDATETIME, VTFecha$
    PMPasoValores sqlconn&, "@i_cod_cb", 0, SQLINT2&, "0"
    If optTipoMov(0).Value = True Then 'Registro
        PMPasoValores sqlconn&, "@i_tipo_mov", 0, SQLCHAR&, "R"
    Else
        If optTipoMov(1).Value = True Then 'Disminucion
            PMPasoValores sqlconn&, "@i_tipo_mov", 0, SQLCHAR&, "D"
        Else
            If optTipoMov(2).Value = True Then 'Incremento
                PMPasoValores sqlconn&, "@i_tipo_mov", 0, SQLCHAR&, "I"
            Else
                If optTipoMov(3).Value = True Then 'Incremento
                    PMPasoValores sqlconn&, "@i_tipo_mov", 0, SQLCHAR&, "V"
                End If
            End If
        End If
    End If
    PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
        PMChequea sqlconn&
        PLBuscar
        PLLimpiar
        MsgBox "Registro ingresado exitosamente", vbInformation
        If Val(grdRegistros.Tag) = 20 Then
            cmdBoton(1).Enabled = True
        Else
            cmdBoton(1).Enabled = False
        End If
    Else
        PMChequea sqlconn&
    End If
End Sub

Private Sub Form_Load()
    Me.Width = 9075
    Me.Height = 5820
    Me.Top = 15
    Me.Left = 15
    mskCuenta.Mask = VGMascaraCtaAho
    optTipoMov(0).Value = True
    txtDiasVig.Text = "0"
    MskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
    MskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de Cuenta del Cupo "
End Sub

Private Sub mskCuenta_LostFocus()
Dim VTR1 As Integer
Dim VTR2 As Integer


If mskCuenta.ClipText <> "" Then
    If FMChequeaCtaAho((mskCuenta.ClipText)) Then
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
        PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLCHAR&, "S"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
            PMMapeaObjeto sqlconn&, lblCorresponsal
            PMChequea sqlconn&
            'Para llenar los label
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLCHAR&, "S"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                ReDim VTArreglo(20) As String
                VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                PMChequea sqlconn&
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "398"
                PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "V"
                PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR&, mskCuenta.ClipText
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
                    ReDim VTArreglo1(4) As String
                    VTR2 = FMMapeaArreglo(sqlconn&, VTArreglo1())
                    PMChequea sqlconn&
                    If VTArreglo1(1) = "" Then
                        VTArreglo1(1) = 0
                    End If
                    If VTArreglo1(2) = "" Then
                        VTFecha = FMConvFecha(VGFecha, VGFormatoFecha, VGFormatoFecha)
                        VTArreglo1(2) = VTFecha
                    End If
                    txtDiasVig.Text = VTArreglo1(1)
                    MskFecha.Mask = ""
                    VTFecha = FMConvFecha(VTArreglo1(2), VGFormatoFecha, VGFormatoFecha)
                    MskFecha.Text = VTFecha
                End If
            End If
            cmdBoton(0).Enabled = True
        Else
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            mskCuenta.Mask = VGMascaraCtaAho
            mskCuenta.SetFocus
            Exit Sub
        End If
    Else
        MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
        cmdBoton_Click (3)
        Exit Sub
    End If
End If
End Sub

Private Sub mskCupo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Valor del Cupo "
End Sub

Private Sub mskCupo_KeyPress(KeyAscii As Integer)
    If (KeyAscii <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub mskFecha_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Fecha de Vencimiento del Cupo (" + VGFormatoFecha + ")"
End Sub

Private Sub mskFecha_KeyPress(KeyAscii As Integer)
    If (KeyAscii <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub MskFecha_LostFocus()
Dim VTValido As Integer

    If MskFecha.ClipText <> "" Then
        VTValido = FMVerFormato((MskFecha.FormattedText), VGFormatoFecha$)
        If Not VTValido% Then
            MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
            MskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
            MskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
            MskFecha.SetFocus
            Exit Sub
        Else
            If CDate(MskFecha.FormattedText) < CDate(VGFecha) Then
                MsgBox "Fecha de Vencimiento No Puede Ser Menor A La Del Sistema", 48, "Mensaje de Error"
                MskFecha.Text = VGFecha
                txtDiasVig.Text = 0
                MskFecha.SetFocus
                Exit Sub
            Else
                If FMDateDiff("d", VGFecha, MskFecha.FormattedText, VGFormatoFecha) > 9999 Then
                    VLFecha = DateAdd("d", 9999, VGFecha)
                    MsgBox "LA FECHA DE VENCIMIENTO NO PUEDE SER MAYOR A " + CStr(VLFecha), vbInformation
                    txtDiasVig.Text = ""
                    MskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
                    MskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
                    txtDiasVig.SetFocus
                    Exit Sub
                Else
                    txtDiasVig.Text = FMDateDiff("d", VGFecha, MskFecha.FormattedText, VGFormatoFecha)
                End If
            End If
        End If
    Else
        If MskFecha.Text = "" And txtDiasVig.Text <> "" Then
            MskFecha.Text = DateAdd("d", txtDiasVig, VGFecha)
        Else
            MskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
            MskFecha.Text = Format$(VGFecha$, VGFormatoFecha$)
        End If
    End If
End Sub

Private Sub optTipoMov_Click(Index As Integer)
    Select Case Index%
        Case 0
            FPrincipal!pnlHelpLine.Caption = " Tipo de Movimiento - Registro"
            If mskCupo.Enabled = False Then
                mskCupo.Enabled = True
            End If
        Case 1
            FPrincipal!pnlHelpLine.Caption = " Tipo de Movimiento - Disminución"
            If mskCupo.Enabled = False Then
                mskCupo.Enabled = True
            End If
        Case 2
            FPrincipal!pnlHelpLine.Caption = " Tipo de Movimiento - Incremento"
            If mskCupo.Enabled = False Then
                mskCupo.Enabled = True
            End If
        Case 3
            FPrincipal!pnlHelpLine.Caption = " Tipo de Movimiento - Vigencia"
            If mskCupo.Enabled = True Then
                mskCupo.Enabled = False
            End If
    End Select
End Sub

Private Sub txtDiasVig_Change()
    If txtDiasVig.Text <> "" Then
        MskFecha.Text = DateAdd("d", txtDiasVig, VGFecha)
    End If
End Sub

Private Sub txtDiasVig_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Dias de Vigencia del Cupo "
End Sub

Private Sub txtDiasVig_KeyPress(KeyAscii As Integer)
    If (KeyAscii <> 8) And (KeyAscii% <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub txtDiasVig_LostFocus()
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim(txtDiasVig.Text) <> "" Then
        If optTipoMov(0).Value = True Then
            If txtDiasVig.Text > 0 Then
                MskFecha.Text = DateAdd("d", txtDiasVig, VGFecha)
            Else
                MsgBox "LOS DIAS DE VIGENCIAS DEBEN SER MAYOR A 0", vbInformation
                txtDiasVig.SetFocus
                Exit Sub
            End If
        End If
    Else
        txtDiasVig.Text = "0"
    End If
End Sub

