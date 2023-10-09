VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran432 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "*Consulta de Cartas Remesa"
   ClientHeight    =   4845
   ClientLeft      =   255
   ClientTop       =   1785
   ClientWidth     =   9090
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
   ForeColor       =   &H00FFFFFF&
   Icon            =   "FTRAN432.frx":0000
   LinkMode        =   1  'Source
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4845
   ScaleWidth      =   9090
   Tag             =   "3887"
   Begin MSGrid.Grid grdRegistros 
      Height          =   3150
      Left            =   15
      TabIndex        =   0
      TabStop         =   0   'False
      Top             =   1665
      Width           =   8130
      _Version        =   65536
      _ExtentX        =   14340
      _ExtentY        =   5556
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
      Left            =   8220
      TabIndex        =   1
      Top             =   4050
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
      Picture         =   "FTRAN432.frx":030A
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Lista de cheques:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   120
      TabIndex        =   23
      Top             =   1455
      WhatsThisHelpID =   5429
      Width           =   1605
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   11
      Left            =   5595
      TabIndex        =   22
      Top             =   15
      Width           =   2550
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha emisión carta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   3765
      TabIndex        =   21
      Top             =   15
      WhatsThisHelpID =   5427
      Width           =   1860
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de carta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   90
      TabIndex        =   20
      Top             =   15
      WhatsThisHelpID =   5430
      Width           =   1215
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   10
      Left            =   1830
      TabIndex        =   19
      Top             =   15
      Width           =   1500
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -30
      X2              =   8160
      Y1              =   1410
      Y2              =   1410
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8175
      X2              =   8175
      Y1              =   15
      Y2              =   4815
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   9
      Left            =   5715
      TabIndex        =   18
      Top             =   1095
      Width           =   2430
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   8
      Left            =   1845
      TabIndex        =   17
      Top             =   1095
      Width           =   1500
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   7
      Left            =   5715
      TabIndex        =   16
      Top             =   825
      Width           =   2430
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   6
      Left            =   1830
      TabIndex        =   15
      Top             =   825
      Width           =   855
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   5
      Left            =   3345
      TabIndex        =   14
      Top             =   555
      Width           =   4800
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   4
      Left            =   1830
      TabIndex        =   13
      Top             =   555
      Width           =   1500
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   3
      Left            =   3345
      TabIndex        =   12
      Top             =   555
      Visible         =   0   'False
      Width           =   4800
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   2
      Left            =   1830
      TabIndex        =   11
      Top             =   555
      Visible         =   0   'False
      Width           =   1500
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   1
      Left            =   3345
      TabIndex        =   10
      Top             =   285
      Width           =   4800
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   0
      Left            =   1830
      TabIndex        =   9
      Top             =   285
      Width           =   1500
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Valor de la carta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   3885
      TabIndex        =   8
      Top             =   1095
      WhatsThisHelpID =   5437
      Width           =   1560
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cheques:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   90
      TabIndex        =   7
      Top             =   1095
      WhatsThisHelpID =   5431
      Width           =   1500
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha efectiva:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   3885
      TabIndex        =   6
      Top             =   825
      WhatsThisHelpID =   5426
      Width           =   1425
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Días de retención:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   90
      TabIndex        =   5
      Top             =   825
      WhatsThisHelpID =   5424
      Width           =   1680
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Emisor:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   90
      TabIndex        =   4
      Top             =   555
      WhatsThisHelpID =   5425
      Width           =   705
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Propietario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   90
      TabIndex        =   3
      Top             =   555
      Visible         =   0   'False
      Width           =   990
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Corresponsal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   90
      TabIndex        =   2
      Top             =   285
      WhatsThisHelpID =   5420
      Width           =   1245
   End
End
Attribute VB_Name = "FTran432"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLSalir As Boolean
Dim VLStatus As String
Dim VLRef As String
Dim VLVez As Integer
Dim VLConfirmar As String


Private Sub cmdBoton_Click()
    Unload FTran432
End Sub

Private Sub Form_Load()
Dim VTR1 As Integer
    PMLoadResStrings Me
    PMLoadResIcons Me
    VLSalir = False
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
    VLVez = 1
    VLSalir = False
    VLStatus = " "
    VLRef = "0"
    While Not VLSalir
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "407"
        PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, VGADatosI(1)
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
        PMPasoValores sqlconn&, "@i_consulta", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_status", 0, SQLVARCHAR, VLStatus
        PMPasoValores sqlconn&, "@i_ref", 0, SQLINT4, VLRef
        PMPasoValores sqlconn&, "@i_vez", 0, SQLINT1, Str$(VLVez)
        If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_consulcar", True, " OK... Consulta general de la carta remesa") Then
            If VLVez = 1 Then
                ReDim VTArreglo(20) As String
                 VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                 PMMapeaGrid sqlconn&, grdRegistros, False
                 PMMapeaVariable sqlconn&, VLConfirmar
            Else
                 PMMapeaGrid sqlconn&, grdRegistros, True
            End If
            PMChequea sqlconn&
            VLVez = VLVez + 1
            If grdRegistros.Tag < 40 Then VLSalir = True
                lblDescripcion(0).Caption = VTArreglo(1)
                lblDescripcion(1).Caption = VTArreglo(2)
                lblDescripcion(2).Caption = VTArreglo(3)
                lblDescripcion(3).Caption = VTArreglo(4)
                lblDescripcion(4).Caption = VTArreglo(5)
                lblDescripcion(5).Caption = VTArreglo(6)
                lblDescripcion(6).Caption = VTArreglo(7)
                lblDescripcion(7).Caption = VTArreglo(8)
                lblDescripcion(8).Caption = VTArreglo(9)
                lblDescripcion(9).Caption = VTArreglo(10)
                FTran410!grdRegistros.Col = 1
                lblDescripcion(10).Caption = FTran410!grdRegistros.Text
                FTran410!grdRegistros.Col = 2
                lblDescripcion(11).Caption = FTran410!grdRegistros.Text
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 6
                VLStatus = grdRegistros.Text
                grdRegistros.Col = 7
                VLRef = grdRegistros.Text
            Else
                VLSalir = True
            End If
    Wend
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdRegistros_Click()
    grdRegistros.Col = 0
    grdRegistros.SelStartCol = 1
    grdRegistros.SelEndCol = grdRegistros.Cols - 1
    If grdRegistros.Row = 0 Then
        grdRegistros.SelStartRow = 1
        grdRegistros.SelEndRow = 1
    Else
        grdRegistros.SelStartRow = grdRegistros.Row
        grdRegistros.SelEndRow = grdRegistros.Row
    End If
End Sub

Private Sub grdregistros_DblClick()
    grdRegistros.Col = 0
    If grdRegistros.Text <> "X" Then
        grdRegistros.Text = "X"
    Else
        If grdRegistros.Text = "X" Then
            grdRegistros.Text = Str$(grdRegistros.Row)
        End If
    End If
End Sub


