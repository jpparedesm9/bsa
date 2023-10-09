VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FConsultaCupoCB 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Consulta de Cupos  de Corresponsales Bancarios Red Posicionada"
   ClientHeight    =   5760
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9735
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5760
   ScaleWidth      =   9735
   Begin MSGrid.Grid grdRegistros 
      Height          =   2655
      Left            =   120
      TabIndex        =   27
      Top             =   3000
      Width           =   8415
      _Version        =   65536
      _ExtentX        =   14843
      _ExtentY        =   4683
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   0
      Left            =   8760
      TabIndex        =   0
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
      Picture         =   "FCONCUPOCB.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   1
      Left            =   8760
      TabIndex        =   1
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
      Picture         =   "FCONCUPOCB.frx":1592
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   2
      Left            =   8760
      TabIndex        =   2
      Top             =   3960
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
      Picture         =   "FCONCUPOCB.frx":1E6C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   3
      Left            =   8760
      TabIndex        =   3
      Top             =   4800
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
      Picture         =   "FCONCUPOCB.frx":2746
   End
   Begin VB.Frame fraConCupo 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Consulta de Cupo de Corresponsal"
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
      Height          =   2535
      Left            =   120
      TabIndex        =   4
      Top             =   120
      Width           =   8415
      Begin MSMask.MaskEdBox mskCuenta 
         Height          =   255
         Left            =   2400
         TabIndex        =   28
         TabStop         =   0   'False
         Top             =   315
         Width           =   1845
         _ExtentX        =   3254
         _ExtentY        =   450
         _Version        =   393216
         Appearance      =   0
         PromptChar      =   "_"
      End
      Begin VB.Label lblFechaVen 
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
         Left            =   6495
         TabIndex        =   25
         Top             =   2175
         Width           =   1845
      End
      Begin VB.Label lblTotCreditos 
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
         Left            =   6495
         TabIndex        =   24
         Top             =   1860
         Width           =   1845
      End
      Begin VB.Label lblSaldo1 
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
         Left            =   6495
         TabIndex        =   23
         Top             =   1545
         Width           =   1845
      End
      Begin VB.Label lblCupoDis 
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
         Left            =   6495
         TabIndex        =   22
         Top             =   1230
         Width           =   1845
      End
      Begin VB.Label lblEtiqueta 
         BackStyle       =   0  'Transparent
         Caption         =   "Total Débitos Hoy:"
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
         Height          =   255
         Index           =   6
         Left            =   105
         TabIndex        =   21
         Top             =   1920
         Width           =   2175
      End
      Begin VB.Label lblDiasVig 
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
         Left            =   2400
         TabIndex        =   20
         Top             =   2175
         Width           =   1845
      End
      Begin VB.Label lblTotDebitos 
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
         Left            =   2400
         TabIndex        =   19
         Top             =   1860
         Width           =   1845
      End
      Begin VB.Label lblSaldo2 
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
         Left            =   2400
         TabIndex        =   18
         Top             =   1545
         Width           =   1845
      End
      Begin VB.Label lblCupoUtil 
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
         Left            =   2400
         TabIndex        =   17
         Top             =   1230
         Width           =   1845
      End
      Begin VB.Label lblCupo 
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
         Left            =   2400
         TabIndex        =   16
         Top             =   915
         Width           =   1845
      End
      Begin VB.Label lblNombre 
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
         Left            =   2400
         TabIndex        =   15
         Top             =   600
         Width           =   5925
      End
      Begin VB.Label Label9 
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha de Vencimiento:"
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
         Height          =   255
         Left            =   4425
         TabIndex        =   14
         Top             =   2205
         Width           =   2055
      End
      Begin VB.Label lblEtiqueta 
         BackStyle       =   0  'Transparent
         Caption         =   "Total Créditos Hoy:"
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
         Height          =   255
         Index           =   10
         Left            =   4410
         TabIndex        =   13
         Top             =   1905
         Width           =   1815
      End
      Begin VB.Label lblEtiqueta 
         BackStyle       =   0  'Transparent
         Caption         =   "Saldo Ayer:"
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
         Height          =   255
         Index           =   9
         Left            =   4425
         TabIndex        =   12
         Top             =   1560
         Width           =   1815
      End
      Begin VB.Label lblEtiqueta 
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
         Height          =   255
         Index           =   8
         Left            =   4410
         TabIndex        =   11
         Top             =   1245
         Width           =   1815
      End
      Begin VB.Label lblEtiqueta 
         BackStyle       =   0  'Transparent
         Caption         =   "Dias de Vigencia:"
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
         Height          =   255
         Index           =   7
         Left            =   120
         TabIndex        =   10
         Top             =   2205
         Width           =   2175
      End
      Begin VB.Label lblEtiqueta 
         BackStyle       =   0  'Transparent
         Caption         =   "Saldo 2 Días Atrás:"
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
         Height          =   255
         Index           =   5
         Left            =   105
         TabIndex        =   9
         Top             =   1605
         Width           =   2175
      End
      Begin VB.Label lblEtiqueta 
         BackStyle       =   0  'Transparent
         Caption         =   "Cupo Utilizado:"
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
         Height          =   255
         Index           =   4
         Left            =   105
         TabIndex        =   8
         Top             =   1290
         Width           =   2175
      End
      Begin VB.Label lblEtiqueta 
         BackStyle       =   0  'Transparent
         Caption         =   "Cupo Aprobado:"
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
         Height          =   255
         Index           =   3
         Left            =   105
         TabIndex        =   7
         Top             =   945
         Width           =   2175
      End
      Begin VB.Label lblEtiqueta 
         BackStyle       =   0  'Transparent
         Caption         =   "Corresponsal:"
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
         Height          =   255
         Index           =   2
         Left            =   105
         TabIndex        =   6
         Top             =   630
         Width           =   2175
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "No. de Cuenta de Ahorro:"
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
         Left            =   120
         TabIndex        =   5
         Top             =   360
         Width           =   2190
      End
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Registros Existentes"
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
      Left            =   120
      TabIndex        =   26
      Top             =   2760
      Width           =   1740
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8640
      X2              =   8640
      Y1              =   0
      Y2              =   5760
   End
End
Attribute VB_Name = "FConsultaCupoCB"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLCuentaCupo As String

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
' Permite realizar la consulta del cupo de CB
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 13-Ene-14      C. Avendaño     Emisión Inicial
'*************************************************************
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
        Case 0 'Buscar
            PLBuscar
        Case 1 'Siguientes
            PLSiguientes
        Case 2 'Limpiar
            PLLimpiar
        Case 3 'Salir
            Unload FConsultaCupoCB
    End Select
End Sub
Sub PLSiguientes()

End Sub
Sub PLBuscar()
    If mskCuenta.ClipText <> "" Then
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "398"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
        PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR&, mskCuenta.ClipText
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
            PMMapeaGrid sqlconn&, grdRegistros, False
            If Val(grdRegistros.Tag) = 20 Then
                cmdBoton(1).Enabled = True
            Else
                cmdBoton(1).Enabled = False
            End If
            PMChequea sqlconn&
        Else
            PMChequea sqlconn&
            PLLimpiar
        End If
    End If
End Sub

Private Sub Form_Load()
    Me.Width = 9855
    Me.Height = 6270
    Me.Top = 15
    Me.Left = 15
    mskCuenta.Mask = VGMascaraCtaAho
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "398"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "C"
    PMPasoValores sqlconn&, "@i_cod_cb", 0, SQLVARCHAR&, "0"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
        PMMapeaGrid sqlconn&, grdRegistros, False
        PMChequea sqlconn&
        Do While grdRegistros.Tag = 20
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "398"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "C"
            grdRegistros.col = 1
            grdRegistros.Row = grdRegistros.Rows - 1
            PMPasoValores sqlconn&, "@i_cod_cb", 0, SQLVARCHAR&, grdRegistros.Text
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "") Then
                PMMapeaGrid sqlconn&, grdRegistros, True
                PMChequea sqlconn&
            End If
        Loop
    Else
        PMChequea sqlconn&
    End If
End Sub

Private Sub grdregistros_DblClick()
    grdRegistros.col = 3
    VLCuentaCupo = grdRegistros.Text
    mskCuenta.Text = FMMascara(VLCuentaCupo$, VGMascaraCtaAho$)
    mskCuenta_LostFocus
End Sub

Sub PLLimpiar()
    mskCuenta.Mask = ""
    mskCuenta.Text = ""
    mskCuenta.Mask = VGMascaraCtaAho
    lblNombre.Caption = ""
    lblCupo.Caption = ""
    lblCupoUtil.Caption = ""
    lblSaldo2.Caption = ""
    lblTotDebitos.Caption = ""
    lblDiasVig.Caption = ""
    lblCupoDis.Caption = ""
    lblSaldo1.Caption = ""
    lblTotCreditos.Caption = ""
    lblFechaVen.Caption = ""
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de Cuenta del Cupo "
End Sub

Private Sub mskCuenta_LostFocus()
Dim VTFecha1 As String
Dim VTFecha As String

Dim VTR1 As Integer

If mskCuenta.ClipText <> "" Then
    If FMChequeaCtaAho((mskCuenta.ClipText)) Then
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "Q"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
        PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR&, "N"
        PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLCHAR&, "S"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
            PMMapeaObjeto sqlconn&, lblNombre
            PMChequea sqlconn&
            'Para llenar los label
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "398"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
        PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR&, mskCuenta.ClipText
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_cupo_cb", True, "Ok... Datos de la cuenta " & "[" & mskCuenta.Text & "]") Then
            ReDim VTArreglo(20) As String
            VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
            PMChequea sqlconn&
            lblNombre.Caption = VTArreglo(2)
            lblCupo.Caption = VTArreglo(6)
            lblCupoUtil.Caption = VTArreglo(7)
            lblCupoDis.Caption = VTArreglo(8)
            lblSaldo2.Caption = VTArreglo(9)
            lblSaldo1.Caption = VTArreglo(10)
            lblTotDebitos.Caption = VTArreglo(11)
            lblTotCreditos.Caption = VTArreglo(12)
            lblDiasVig.Caption = VTArreglo(4)
            VTFecha1 = VTArreglo(5)
            VTFecha = FMConvFecha(VTArreglo(5), VGFormatoFecha, VGFormatoFecha)
            lblFechaVen.Caption = VTFecha$
        End If
        Else
            PLLimpiar
            mskCuenta.Mask = ""
            mskCuenta.Text = ""
            mskCuenta.Mask = VGMascaraCtaAho
            mskCuenta.SetFocus
            Exit Sub
        End If
    Else
        MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
        'cmdBoton_Click (2)
        Exit Sub
    End If
End If
End Sub

