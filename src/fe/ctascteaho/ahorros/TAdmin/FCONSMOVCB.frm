VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FConsMovCB 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Consulta de Movimientos de Cuenta de Corresponsal Bancario"
   ClientHeight    =   5190
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9630
   ForeColor       =   &H00C0C0C0&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5190
   ScaleWidth      =   9630
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2280
      TabIndex        =   0
      Top             =   45
      Width           =   2085
      _ExtentX        =   3678
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
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   285
      Index           =   1
      Left            =   7200
      TabIndex        =   4
      Top             =   690
      Width           =   1390
      _ExtentX        =   2461
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
   Begin MSMask.MaskEdBox mskFecha 
      Height          =   285
      Index           =   0
      Left            =   2280
      TabIndex        =   3
      Top             =   690
      Width           =   1350
      _ExtentX        =   2381
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
   Begin MSGrid.Grid grdMovimientos 
      Height          =   2865
      Left            =   120
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   2280
      Width           =   8475
      _Version        =   65536
      _ExtentX        =   14949
      _ExtentY        =   5054
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
   Begin Threed.SSCommand cmdSiguientes 
      Height          =   750
      Left            =   8700
      TabIndex        =   10
      Top             =   2100
      WhatsThisHelpID =   2020
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1543
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
      Enabled         =   0   'False
   End
   Begin Threed.SSCommand cmdTransmitir 
      Height          =   750
      Left            =   8700
      TabIndex        =   11
      Top             =   2865
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1543
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
   Begin Threed.SSCommand cmdLimpiar 
      Height          =   750
      Left            =   8700
      TabIndex        =   12
      Top             =   3630
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1543
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
   Begin Threed.SSCommand cmdSalir 
      Height          =   750
      Left            =   8700
      TabIndex        =   13
      Top             =   4395
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Transacciones:"
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
      Index           =   10
      Left            =   120
      TabIndex        =   23
      Top             =   2050
      WhatsThisHelpID =   5336
      Width           =   1395
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cupo Disponible:"
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
      Index           =   9
      Left            =   120
      TabIndex        =   22
      Top             =   1660
      Width           =   1455
   End
   Begin VB.Label lblDisponible 
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
      Height          =   225
      Left            =   2280
      TabIndex        =   8
      Top             =   1660
      Width           =   2775
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8640
      Y1              =   1970
      Y2              =   1970
   End
   Begin VB.Label lblFechaUltMov 
      Alignment       =   2  'Center
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
      Height          =   225
      Left            =   2280
      TabIndex        =   5
      Top             =   1125
      Width           =   1350
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha último mov.:"
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
      Left            =   120
      TabIndex        =   21
      Top             =   1125
      WhatsThisHelpID =   5331
      Width           =   1695
   End
   Begin VB.Label lblMoneda 
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
      Height          =   225
      Left            =   6480
      TabIndex        =   7
      Top             =   1400
      Width           =   2110
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Moneda:"
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
      Left            =   5160
      TabIndex        =   20
      Top             =   1400
      WhatsThisHelpID =   5209
      Width           =   825
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Oficial de Cuenta:"
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
      Left            =   120
      TabIndex        =   19
      Top             =   1400
      WhatsThisHelpID =   5014
      Width           =   1620
   End
   Begin VB.Label lblOficial 
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
      Height          =   225
      Left            =   2280
      TabIndex        =   6
      Top             =   1400
      Width           =   2775
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8640
      X2              =   8640
      Y1              =   0
      Y2              =   5280
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8640
      Y1              =   1050
      Y2              =   1050
   End
   Begin VB.Label lblNombre 
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
      Left            =   2280
      TabIndex        =   2
      Top             =   375
      UseMnemonic     =   0   'False
      Width           =   6315
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Corresponsal:"
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
      Height          =   285
      Index           =   3
      Left            =   120
      TabIndex        =   18
      Top             =   390
      WhatsThisHelpID =   5420
      Width           =   2145
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha hasta:"
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
      Left            =   5160
      TabIndex        =   17
      Top             =   720
      WhatsThisHelpID =   5173
      Width           =   1200
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha desde:"
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
      Left            =   120
      TabIndex        =   16
      Top             =   720
      WhatsThisHelpID =   5172
      Width           =   1245
   End
   Begin VB.Label lblEstado 
      Alignment       =   2  'Center
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
      Left            =   6480
      TabIndex        =   1
      Top             =   45
      Width           =   2110
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Estado Red:"
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
      Left            =   5160
      TabIndex        =   15
      Top             =   75
      Width           =   1065
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de Cuenta Ahorros:"
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
      Height          =   285
      Index           =   1
      Left            =   120
      TabIndex        =   14
      Top             =   70
      WhatsThisHelpID =   5016
      Width           =   2505
   End
End
Attribute VB_Name = "FConsMovCB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
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
' Permite realizar la consulta de movimientos de la cuenta de
' corresponsl bancario.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 13-Ene-14      A. Muñoz        Emisión Inicial
'*************************************************************
Dim VLTranDiario As Integer
Dim VLTotalHistorico As Integer
Dim VLTotalDiario As Integer
Dim VLSecuencial As String
Dim VLFormatoFecha$

Private Sub cmdLimpiar_Click()

lblNombre.Caption = ""
lblDisponible.Caption = ""
lblEstado.Caption = ""
lblFechaUltMov.Caption = ""
lblMoneda.Caption = ""
lblOficial.Caption = ""
cmdSiguientes.Enabled = False
For i% = 0 To 1
   mskFecha(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
   mskFecha(i%).Text = Format$(VGFecha$, VGFormatoFecha$)
Next i%
mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
mskCuenta.Enabled = True
mskCuenta.SetFocus
PMLimpiaGrid grdMovimientos()
mskFecha(0).Enabled = True
mskFecha(1).Enabled = True

End Sub

Private Sub cmdLimpiar_GotFocus()
   FPrincipal.pnlHelpLine.Caption = "Click en el Boton Para Limpiar Datos"
End Sub

Private Sub cmdSalir_Click()
   Unload FConsMovCB
End Sub

Private Sub cmdSalir_GotFocus()
   FPrincipal.pnlHelpLine.Caption = "Click en el Boton Para Salir de la Forma"
End Sub

Private Sub cmdSiguientes_Click()
Dim VTFDesde As String
Dim VTFHasta As String

   ' Validacion de Mandatoriedades

   ' Numero de la Cuenta Corriente
   If Trim$(mskCuenta.ClipText) = "" Then
      MsgBox "El número de Cuenta de Ahorros es mandatorio", 0 + 16, "Mensaje de Error"
      mskCuenta.SetFocus
      Exit Sub
   End If

   ' Fecha de inicio de la Consulta
   If Trim$(mskFecha(0).ClipText) = "" Then
      MsgBox "La fecha de inicio es mandatorio", 0 + 16, "Mensaje de Error"
      mskFecha(0).SetFocus
      Exit Sub
   End If

   ' Fecha de Fin de la Consulta
   If Trim$(mskFecha(1).ClipText) = "" Then
      MsgBox "La fecha de fin es mandatorio", 0 + 16, "Mensaje de Error"
      mskFecha(1).SetFocus
      Exit Sub
   End If

   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "399"
   PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
   PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
   VTFDesde = FMConvFecha((mskFecha(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
   PMPasoValores sqlconn&, "@i_fchdsde", 0, SQLDATETIME, VTFDesde$
   VTFHasta = FMConvFecha((mskFecha(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
   PMPasoValores sqlconn&, "@i_fchhsta", 0, SQLDATETIME, VTFHasta$
   grdMovimientos.Row = grdMovimientos.Rows - 1
   grdMovimientos.col = grdMovimientos.Cols - 1
   VLSecuencial$ = grdMovimientos.Text
   PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, VLSecuencial$
   PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, 0
   PMPasoValores sqlconn&, "@i_diario", 0, SQLINT1, Str$(VLTranDiario%)
   PMPasoValores sqlconn&, "@i_sec_alt", 0, SQLINT4, "-1"
   PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
   PMPasoValores sqlconn&, "@o_hist", 1, SQLINT1, "0"
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_cons_mov_cb", True, "Ok... Consulta del estado de cuenta") Then
      PMMapeaGrid sqlconn&, grdMovimientos, True
      PMChequea sqlconn&
      VLTranDiario = Val(FMRetParam(sqlconn&, 1))

      If VLTranDiario = 0 Then
        cmdSiguientes.Enabled = False
      Else
        cmdSiguientes.Enabled = True
      End If
   End If
End Sub

Private Sub cmdSiguientes_GotFocus()
   FPrincipal.pnlHelpLine.Caption = "Click en el Boton Para Buscar Siguientes"
End Sub

Private Sub cmdTransmitir_Click()
Dim VTFDesde As String
Dim VTFHasta As String
Dim VTR1 As Integer
Dim VTFono As String
Dim VTResult As Integer






' Validacion de Mandatoriedades

' Numero de la Cuenta Corriente
If Trim$(mskCuenta.ClipText) = "" Then
   MsgBox "El número de Cuenta de Ahorros es mandatorio", 0 + 16, "Mensaje de Error"
   mskCuenta.SetFocus
   Exit Sub
End If

' Fecha de inicio de la consulta
If Trim$(mskFecha(0).ClipText) = "" Then
   MsgBox "La fecha desde es mandatoria", 0 + 16, "Mensaje de Error"
   mskFecha(0).SetFocus
   Exit Sub
End If

' Fecha de fin de la consulta
If Trim$(mskFecha(1).ClipText) = "" Then
   MsgBox "La fecha hasta es mandatoria", 0 + 16, "Mensaje de Error"
   mskFecha(1).SetFocus
   Exit Sub
End If

VLTotalHistorico% = 0
VLTotalDiario% = 0

   ' Matriz temporal para recepcion de transacciones
   ReDim VTMatriz(210, 210) As String

   ' Arreglo temporal para recepcion de cabecera
   ReDim VTArregloCab(50) As String

   ' Variable de control de datos del historico
   VLTranDiario% = 0
                    
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "399"
   PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
   PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
   VTFDesde = FMConvFecha((mskFecha(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
   PMPasoValores sqlconn&, "@i_fchdsde", 0, SQLDATETIME, VTFDesde$
   VTFHasta = FMConvFecha((mskFecha(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
   PMPasoValores sqlconn&, "@i_fchhsta", 0, SQLDATETIME, VTFHasta$
   PMPasoValores sqlconn&, "@i_sec", 0, SQLINT2, "0"
   PMPasoValores sqlconn&, "@i_sec_alt", 0, SQLINT4, "-1"
   PMPasoValores sqlconn&, "@i_hora", 0, SQLDATETIME, "01/01/1900 12:00AM"
   PMPasoValores sqlconn&, "@i_diario", 0, SQLINT1, "0"
   PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
   PMPasoValores sqlconn&, "@o_hist", 1, SQLINT1, "0"
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_cons_mov_cb", True, "Ok... Consulta del Estado de Cuenta") Then
      
      VTR1 = FMMapeaArreglo(sqlconn&, VTArregloCab())
      
      PMMapeaVariable sqlconn&, VTFono
      PMMapeaGrid sqlconn&, grdMovimientos, False
      VTResult = FMMapeaMatriz(sqlconn&, VTMatriz())
      PMChequea sqlconn&
      VLTranDiario% = Val(FMRetParam(sqlconn&, 1))
      ' Grabar datos de la cabecera
      lblFechaUltMov.Caption = VTArregloCab(1)
      lblMoneda.Caption = VTArregloCab(3)
      lblDisponible.Caption = VTArregloCab(8)
      lblOficial.Caption = VTArregloCab(9)
      lblEstado.Caption = VTArregloCab(11)
            
      ' Activar/ Desactivar el boton de siguientes
      If VLTranDiario% = 0 Then
         cmdSiguientes.Enabled = False
      Else
         cmdSiguientes.Enabled = True
      End If

      mskCuenta.Enabled = False
      mskFecha(0).Enabled = False
      mskFecha(1).Enabled = False
      'If grdMovimientos.Rows > 2 Then
      '   grdMovimientos.RemoveItem 1
      'End If
   End If
   
End Sub

Private Sub cmdTransmitir_GotFocus()
   FPrincipal.pnlHelpLine.Caption = "Click en el Boton Para Transmitir"
End Sub

Private Sub Form_Load()
   FConsMovCB.Left = 0   '15
   FConsMovCB.Top = 0   '15
   FConsMovCB.Width = 9740   '9420
   FConsMovCB.Height = 5700   '5730
   PMLoadResStrings Me
   PMLoadResIcons Me
   VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
   For i% = 0 To 1
      mskFecha(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
      mskFecha(i%).Text = Format$(VGFecha$, VGFormatoFecha$)
   Next i%
   mskCuenta.Mask = VGMascaraCtaAho$
End Sub

Private Sub mskCuenta_GotFocus()
   FPrincipal!pnlHelpLine.Caption = " Número de la cuenta de ahorros"
   mskCuenta.SelStart = 0
   mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()

'! removed Dim VTArreglo(20) As String

   
   On Error Resume Next
   If mskCuenta.ClipText <> "" Then
      If FMChequeaCtaAho((mskCuenta.ClipText)) Then
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
         PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "N"
         PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
            PMMapeaObjeto sqlconn&, lblNombre
            PMChequea sqlconn&
            PMLimpiaGrid grdMovimientos
         Else
            cmdLimpiar_Click
            Exit Sub
         End If
      Else
         MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
         cmdLimpiar_Click
         Exit Sub
      End If
   End If
End Sub

Private Sub mskFecha_GotFocus(Index As Integer)
    Select Case Index%
        Case 0
            FPrincipal!pnlHelpLine.Caption = " Fecha inicial de la consulta [" & VGFormatoFecha & "]"
        Case 1
            FPrincipal!pnlHelpLine.Caption = " Fecha final de la consulta [" & VGFormatoFecha & "]"
    End Select
    mskFecha(Index%).SelStart = 0
    mskFecha(Index%).SelLength = Len(mskFecha(Index%).Text)
End Sub

Private Sub mskFecha_KeyPress(Index As Integer, KeyAscii As Integer)
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub MskFecha_LostFocus(Index As Integer)
'*********************************************************
'PORPOSITO: Verifica la validez de la fecha ingresada
'           de acuerdo con el formato de la fecha
'           ingresada
'INPUT    : Index    Identificador de campo
'OUTPUT   : ninguna
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'13/Ene/14  A.Muñoz             Emisión Inicial
'*********************************************************
    On Error Resume Next
    Dim VTValido As Integer
    Dim VTDias As Integer
  
    
    
    
    Select Case Index
    Case 0, 1
        If mskFecha(Index%).ClipText <> "" Then
            VTValido = FMVerFormato((mskFecha(Index).FormattedText), VGFormatoFecha$)
            If Not VTValido% Then
                MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
                mskFecha(Index%).SetFocus
                Exit Sub
            End If
        Else
            For i% = 0 To 1
                mskFecha(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
            Next i%
        End If
        
        If mskFecha(0).ClipText <> "" And mskFecha(1).ClipText <> "" Then
            VTDias = FMDateDiff("d", (mskFecha(0).FormattedText), (mskFecha(1).FormattedText), VGFormatoFecha$)
            If VTDias < 0 Then
                MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
                For i% = 0 To 1
                    mskFecha(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
                    mskFecha(i%).Text = Format$(VGFecha$, VGFormatoFecha$)
                Next i%
                mskFecha(Index%).SetFocus
                Exit Sub
            End If
        End If
    End Select
End Sub

