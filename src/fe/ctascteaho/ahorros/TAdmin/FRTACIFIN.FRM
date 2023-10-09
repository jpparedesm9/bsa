VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FRTACIFIN 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Respuesta CIFIN - GMF"
   ClientHeight    =   5730
   ClientLeft      =   60
   ClientTop       =   1740
   ClientWidth     =   9360
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
   HelpContextID   =   1061
   Icon            =   "FRTACIFIN.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5730
   ScaleWidth      =   9360
   Begin Threed.SSCommand cmdSalir 
      Height          =   870
      Left            =   8460
      TabIndex        =   0
      Top             =   4815
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1535
      _StockProps     =   78
      Caption         =   "*&Salir"
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
      Picture         =   "FRTACIFIN.frx":030A
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha Fin Exención:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   17
      Left            =   4320
      TabIndex        =   36
      Top             =   2970
      Width           =   1755
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   17
      Left            =   6360
      TabIndex        =   35
      Top             =   2940
      Width           =   1965
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha Ini Exención:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   16
      Left            =   120
      TabIndex        =   34
      Top             =   2970
      Width           =   1710
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   16
      Left            =   2040
      TabIndex        =   33
      Top             =   2940
      Width           =   1965
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   15
      Left            =   2040
      TabIndex        =   32
      Top             =   5340
      Width           =   6285
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   14
      Left            =   2040
      TabIndex        =   31
      Top             =   5040
      Width           =   6285
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   13
      Left            =   2040
      TabIndex        =   30
      Top             =   4740
      Width           =   3285
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   12
      Left            =   2040
      TabIndex        =   29
      Top             =   4440
      Width           =   3285
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   11
      Left            =   2040
      TabIndex        =   28
      Top             =   4140
      Width           =   3285
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   10
      Left            =   2040
      TabIndex        =   27
      Top             =   3840
      Width           =   3285
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   9
      Left            =   2040
      TabIndex        =   26
      Top             =   3540
      Width           =   6285
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   8
      Left            =   2040
      TabIndex        =   25
      Top             =   3240
      Width           =   3285
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   7
      Left            =   2040
      TabIndex        =   24
      Top             =   2040
      Width           =   6285
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   6
      Left            =   2040
      TabIndex        =   23
      Top             =   1740
      Width           =   6285
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   5
      Left            =   2040
      TabIndex        =   22
      Top             =   1440
      Width           =   1965
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   4
      Left            =   2040
      TabIndex        =   21
      Top             =   1140
      Width           =   6285
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2040
      TabIndex        =   20
      Top             =   840
      Width           =   6285
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   6360
      TabIndex        =   19
      Top             =   540
      Width           =   1965
   End
   Begin VB.Label lblInfCuentas 
      BackColor       =   &H00C0C0C0&
      Caption         =   "INFORMACIÓN DE CUENTAS Y EXENCIONES"
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   120
      TabIndex        =   18
      Top             =   2520
      Width           =   4200
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Concepto Exención:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   15
      Left            =   120
      TabIndex        =   17
      Top             =   5385
      Width           =   1725
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Usuario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   14
      Left            =   120
      TabIndex        =   16
      Top             =   5085
      Width           =   720
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Estado de Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   13
      Left            =   120
      TabIndex        =   15
      Top             =   4785
      Width           =   1590
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   12
      Left            =   120
      TabIndex        =   14
      Top             =   4485
      Width           =   1380
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Oficina:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   120
      TabIndex        =   13
      Top             =   4185
      Width           =   675
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Nro. de Cuenta"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   10
      Left            =   120
      TabIndex        =   12
      Top             =   3885
      Width           =   1305
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre de Entidad:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   120
      TabIndex        =   11
      Top             =   3585
      Width           =   1695
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Entidad:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   120
      TabIndex        =   10
      Top             =   3285
      Width           =   1425
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Mensaje de Exención:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   120
      TabIndex        =   9
      Top             =   2085
      Width           =   1890
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Lugar Expedición Id:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   120
      TabIndex        =   8
      Top             =   1785
      Width           =   1770
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha Expedición Id:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   120
      TabIndex        =   7
      Top             =   1485
      Width           =   1815
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Estado Identificación:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   120
      TabIndex        =   6
      Top             =   1185
      Width           =   1875
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre del Cliente:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   120
      TabIndex        =   5
      Top             =   885
      Width           =   1680
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Nro. Identificación:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   4320
      TabIndex        =   4
      Top             =   585
      Width           =   1650
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Identificación:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   120
      TabIndex        =   3
      Top             =   585
      Width           =   1935
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2040
      TabIndex        =   1
      Top             =   540
      Width           =   1965
   End
   Begin VB.Label lblInfCli 
      BackColor       =   &H00C0C0C0&
      Caption         =   "INFORMACIÓN GENERAL DEL CLIENTE"
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   120
      TabIndex        =   2
      Top             =   120
      Width           =   4200
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8385
      Y1              =   2400
      Y2              =   2400
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8400
      X2              =   8400
      Y1              =   0
      Y2              =   5760
   End
End
Attribute VB_Name = "FRTACIFIN"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Private Sub cmdSalir_Click()
   Unload FRTACIFIN
End Sub

Private Sub Form_Load()
    FRTACIFIN.Left = 15
    FRTACIFIN.Top = 15
    FRTACIFIN.Width = 9450
    FRTACIFIN.Height = 6105
    
    PMLoadResStrings Me
    PMLoadResIcons Me
    
    Call PLConsultaCIFIN
End Sub

Private Sub PLConsultaCIFIN()
   Dim VTR1 As Integer
   Dim i As Integer
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1468"
   PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, FTranUpGMF.mskCuenta.ClipText
   If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_consulta_rta_cifin", True, " Ok... Actualización de la cuenta de ahorros") Then
      ReDim VTArreglo(20) As String
      VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
      PMChequea sqlconn&
      For i = 1 To lblDescripcion.UBound
          lblDescripcion(i) = VTArreglo(i)
      Next
    End If
End Sub


