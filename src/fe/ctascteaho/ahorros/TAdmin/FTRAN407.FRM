VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran407 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Confirmación de Remesas"
   ClientHeight    =   5310
   ClientLeft      =   555
   ClientTop       =   1860
   ClientWidth     =   9240
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
   HelpContextID   =   1032
   Icon            =   "FTRAN407.frx":0000
   LinkMode        =   1  'Source
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5307.009
   ScaleMode       =   0  'User
   ScaleWidth      =   536.516
   Tag             =   "3882"
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7740
      Picture         =   "FTRAN407.frx":030A
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   8
      Top             =   1770
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   7965
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   9
      Top             =   1770
      Visible         =   0   'False
      Width           =   195
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   6
      Left            =   8370
      TabIndex        =   6
      Top             =   3795
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
      Picture         =   "FTRAN407.frx":03E4
   End
   Begin VB.TextBox txtCarta 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1680
      MaxLength       =   9
      TabIndex        =   0
      Top             =   30
      Width           =   1605
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   5
      Left            =   8370
      TabIndex        =   3
      Top             =   1545
      WhatsThisHelpID =   2036
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Reversar"
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
      Picture         =   "FTRAN407.frx":0400
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3570
      Left            =   90
      TabIndex        =   10
      Top             =   1710
      Width           =   8190
      _Version        =   65536
      _ExtentX        =   14446
      _ExtentY        =   6297
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
      Index           =   4
      Left            =   8370
      TabIndex        =   7
      Top             =   4545
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
      Picture         =   "FTRAN407.frx":041C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8370
      TabIndex        =   5
      Top             =   3045
      WhatsThisHelpID =   2028
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Postergar"
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
      Picture         =   "FTRAN407.frx":0438
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8370
      TabIndex        =   4
      Top             =   2295
      WhatsThisHelpID =   2037
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Conf. C&art"
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
      Picture         =   "FTRAN407.frx":0454
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8370
      TabIndex        =   2
      Top             =   795
      WhatsThisHelpID =   2022
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Devolver"
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
      Picture         =   "FTRAN407.frx":0470
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8370
      TabIndex        =   1
      Top             =   45
      WhatsThisHelpID =   2035
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Conf. Chq"
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
      Picture         =   "FTRAN407.frx":048C
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   483.387
      Y1              =   1430.194
      Y2              =   1430.194
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   483.387
      X2              =   483.387
      Y1              =   5351.983
      Y2              =   -29.983
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   8419.991
      X2              =   8419.991
      Y1              =   0
      Y2              =   5310.007
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
      TabIndex        =   28
      Top             =   1485
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
      Left            =   5790
      TabIndex        =   31
      Top             =   840
      Width           =   2490
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
      Left            =   3930
      TabIndex        =   30
      Top             =   900
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
      Left            =   120
      TabIndex        =   29
      Top             =   60
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
      Index           =   9
      Left            =   5790
      TabIndex        =   27
      Top             =   30
      Width           =   2490
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   8
      Left            =   1680
      TabIndex        =   26
      Top             =   1110
      Width           =   855
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   7
      Left            =   5790
      TabIndex        =   25
      Top             =   1110
      Width           =   2490
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   6
      Left            =   1680
      TabIndex        =   24
      Top             =   840
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
      Left            =   3300
      TabIndex        =   23
      Top             =   570
      Width           =   4980
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   4
      Left            =   1680
      TabIndex        =   22
      Top             =   570
      Width           =   1605
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   3
      Left            =   3315
      TabIndex        =   21
      Top             =   1395
      Visible         =   0   'False
      Width           =   4965
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   2
      Left            =   1695
      TabIndex        =   20
      Top             =   1395
      Visible         =   0   'False
      Width           =   1605
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   1
      Left            =   3300
      TabIndex        =   19
      Top             =   300
      Width           =   4980
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   0
      Left            =   1680
      TabIndex        =   18
      Top             =   300
      Width           =   1605
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
      Left            =   3945
      TabIndex        =   17
      Top             =   60
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
      Left            =   120
      TabIndex        =   16
      Top             =   1140
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
      Left            =   3930
      TabIndex        =   15
      Top             =   1170
      WhatsThisHelpID =   5426
      Width           =   1425
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Días retención:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   120
      TabIndex        =   14
      Top             =   870
      WhatsThisHelpID =   5424
      Width           =   1410
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
      Left            =   120
      TabIndex        =   13
      Top             =   600
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
      Left            =   135
      TabIndex        =   12
      Top             =   1425
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
      Left            =   120
      TabIndex        =   11
      Top             =   330
      WhatsThisHelpID =   5420
      Width           =   1245
   End
End
Attribute VB_Name = "FTran407"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit

Dim VLVez As Integer
Dim VLPaso As Boolean
Dim VLProcesar As Boolean
Dim VLFila As Integer
Dim VLSalir As Boolean
Dim VLStatus As String
Dim VLRef As String
Dim VLEstado As String
Dim VLDatosCheque() As String

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
    Case 0  'Confirmacion de cheques de una carta
        PLConfirmaCheques
    Case 1  'Ingreso de cheques devueltos de remesas
        PLDevuelveCheques
    Case 2  'Confirmación de toda la carta
        PLConfirmaCarta
    Case 3  'Postergar la fecha de la carta
        PLPostergar
    Case 4
        Unload FTran407
    Case 5   'Corrige Confirmaciones o Devoluciones
       PLReversar
    Case 6   'Limpiar
       PLLimpiar
    End Select
End Sub

Private Function FLMarcados(modo As Integer) As Integer
Dim VTVistos As Integer
Dim VTPendientes As Integer
Dim i As Integer
    VTVistos = 0
    VTPendientes = 0
    For i = 1 To grdRegistros.Rows - 1
        grdRegistros.Col = 0
        grdRegistros.Row = i
        If grdRegistros.Picture = picVisto(0) Then
           VTVistos = VTVistos + 1
        End If
        If modo = 1 Then  'Cheques Pendientes
           grdRegistros.Col = 6
           If grdRegistros.Text = "PENDIENTE" Then
              VTPendientes = VTPendientes + 1
           End If
        End If
    Next i

    Select Case modo
        Case 0   ' Chequea Vistos
            If VTVistos > 0 Then
                FLMarcados = 1
            Else
                FLMarcados = 0
            End If
        Case 1   ' Chequea Pendientes
            If VTPendientes = grdRegistros.Rows - 1 Then
                FLMarcados = 1
            Else
                FLMarcados = 0
            End If
    End Select
End Function

Private Sub Form_Activate()
    VGHelpRem = "N"
    VGTipoOper = "C"
End Sub

Private Sub Form_Load()

    FTran407.Left = 15
    FTran407.Top = 15
    FTran407.Width = 9420
    FTran407.Height = 5820
    txtCarta.Height = 255
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmdBoton(0).Enabled = False 'Conf. Chq
    cmdBoton(1).Enabled = False 'Devolver
    cmdBoton(2).Enabled = False 'Conf. Cart
    cmdBoton(3).Enabled = False 'Postergar
    cmdBoton(5).Enabled = False 'Reversar

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

   VLFila = 0
   PLMarcarRegistro

End Sub

Private Sub PLConfirmaCarta()
Dim VTR1 As Integer
'Dim VTSalir As String
    VLProcesar = True
    While VLProcesar
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "403"
         PMPasoValores sqlconn&, "@i_propie", 0, SQLVARCHAR, (lblDescripcion(2).Caption)
         PMPasoValores sqlconn&, "@i_corres", 0, SQLVARCHAR, (lblDescripcion(0).Caption)
         PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, txtCarta.Text
         PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, (lblDescripcion(11).Caption)
         PMPasoValores sqlconn&, "@i_hablt", 0, SQLVARCHAR, "C"
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
         If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_confcarman", True, " Ok... Confirmación de carta remesa") Then
            ReDim VLDatosCheque(3) As String
             PMMapeaGrid sqlconn&, grdRegistros, False
             VTR1 = FMMapeaArreglo(sqlconn&, VLDatosCheque())
             PMMapeaVariable sqlconn&, CStr(VLSalir)
            VLProcesar = CInt(VLSalir)
             PMChequea sqlconn&
            lblDescripcion(8).Caption = VLDatosCheque(1)
            lblDescripcion(9).Caption = VLDatosCheque(2)
            PLProducto
            cmdBoton(5).Enabled = True
            PLObtenerDatos
          Else
          Exit Sub
        End If
    Wend
End Sub

Private Sub PLConfirmaCheques()
    Dim VTValor As String
    Dim VTReferencia As String
    Dim VTRemesas As String
    Dim i As Integer
    Dim VTR1 As Integer
    If (FLMarcados(0)) Then
      For i = 1 To grdRegistros.Rows - 1
            grdRegistros.Col = 0
            grdRegistros.Row = i
            If grdRegistros.Picture = picVisto(0) Then
                grdRegistros.Col = 5
                VTValor = grdRegistros.Text
                grdRegistros.Col = 7
                VTReferencia = grdRegistros.Text
                grdRegistros.Col = 10
                VTRemesas = grdRegistros.Text
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "404"
                 PMPasoValores sqlconn&, "@i_propie", 0, SQLVARCHAR, (lblDescripcion(2).Caption)
                 PMPasoValores sqlconn&, "@i_emisor", 0, SQLVARCHAR, (lblDescripcion(4).Caption)
                 PMPasoValores sqlconn&, "@i_corres", 0, SQLVARCHAR, (lblDescripcion(0).Caption)
                 PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, txtCarta.Text
                 PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, (lblDescripcion(11).Caption)
                 PMPasoValores sqlconn&, "@i_chq", 0, SQLINT4, VTReferencia
                 PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, VTValor
                 PMPasoValores sqlconn&, "@i_hablt", 0, SQLVARCHAR, "C"
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
                 PMPasoValores sqlconn&, "@i_tipo_rem", 0, SQLVARCHAR, VTRemesas
                 If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_confcheque", True, " Ok... Confirmación de cheques de carta remesa") Then
                   ReDim VLDatosCheque(4) As String
                    VTR1 = FMMapeaArreglo(sqlconn&, VLDatosCheque())
                    PMChequea sqlconn&
                   PLRefrescar
                  
                  Else
                    grdRegistros.Col = 0
                    grdRegistros.Picture = picVisto(1)
                End If
            End If
        Next i
      Else
        MsgBox "Cheque a Confimar debe Seleccionarse", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If
       
End Sub

Private Sub PLDevuelveCheques()
Dim VTCausaDev As String
Dim VTDescripcion As String
Dim VTValor As String
Dim VTReferencia As String
Dim VTCtadep As String
Dim VTAplicacion As String
Dim VTRemesas As String
Dim VTCheque As String
Dim VTR1 As Integer
   If (FLMarcados(0)) Then
       PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cc_causa_prot"
       PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
       If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", True, "Consulta Causas de Devolución") Then
          PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
          PMChequea sqlconn&
         FCatalogo.Show 1
         VTCausaDev = VGACatalogo.Codigo
         VTDescripcion = VGACatalogo.Descripcion
      End If
      If VTCausaDev = "" Then
         MsgBox "Causa de Devolución es mandatoria", 0 + 16, "Mensaje de Error"
         Exit Sub
      End If
      grdRegistros.Row = VLFila
      grdRegistros.Col = 5
      VTValor = grdRegistros.Text
      grdRegistros.Col = 7
      VTReferencia = grdRegistros.Text
      grdRegistros.Col = 4
      VTCheque = grdRegistros.Text
      grdRegistros.Col = 2
      VTCtadep = grdRegistros.Text
      grdRegistros.Col = 3
      VTAplicacion = grdRegistros.Text
      grdRegistros.Col = 10
      VTRemesas = grdRegistros.Text
       PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "402"
       PMPasoValores sqlconn&, "@i_propie", 0, SQLVARCHAR, (lblDescripcion(2).Caption)
       PMPasoValores sqlconn&, "@i_emisor", 0, SQLVARCHAR, (lblDescripcion(4).Caption)
       PMPasoValores sqlconn&, "@i_corres", 0, SQLVARCHAR, (lblDescripcion(0).Caption)
       PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, txtCarta.Text
       PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, (lblDescripcion(11).Caption)
       PMPasoValores sqlconn&, "@i_chq", 0, SQLINT4, VTReferencia
       PMPasoValores sqlconn&, "@i_nchq", 0, SQLINT4, VTCheque
       PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, VTValor
       PMPasoValores sqlconn&, "@i_hablt", 0, SQLVARCHAR, "C"
       PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
       PMPasoValores sqlconn&, "@i_ctadep", 0, SQLVARCHAR, VTCtadep
       PMPasoValores sqlconn&, "@i_prddep", 0, SQLVARCHAR, VTAplicacion
       PMPasoValores sqlconn&, "@i_causadev", 0, SQLVARCHAR, VTCausaDev
       PMPasoValores sqlconn&, "@i_tipo_rem", 0, SQLVARCHAR, VTRemesas 'mva
       If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_chequedev", True, " Ok... Devolución de cheques de carta remesa") Then
        ReDim VLDatosCheque(4) As String
         VTR1 = FMMapeaArreglo(sqlconn&, VLDatosCheque())
         PMChequea sqlconn&
        PLRefrescar
        PLObtenerDatos
      Else
        grdRegistros.Col = 0
        grdRegistros.Picture = picVisto(0)
      End If
   Else
       MsgBox "Cheque a Devolver debe Seleccionarse", 0 + 16, "Mensaje de Error"
       Exit Sub
   End If
End Sub

Private Sub PLHabilitaBotones()

    If grdRegistros.Rows <= 2 Then
       grdRegistros.Row = 1
       grdRegistros.Col = 1
       If grdRegistros.Text = "" Then
          Exit Sub
       End If
    End If
          
       cmdBoton(0).Enabled = True  'Conf. Chq
       cmdBoton(1).Enabled = True  'Devolver
       cmdBoton(5).Enabled = True  'Reversar
       cmdBoton(2).Enabled = True  'Conf. Cart
       cmdBoton(3).Enabled = True  'Postergar
       cmdBoton(0).SetFocus
End Sub

Private Sub PLLimpiar()

       txtCarta.Enabled = True
       txtCarta.Text = ""
       lblDescripcion(0).Caption = ""
       lblDescripcion(1).Caption = ""
       lblDescripcion(2).Caption = ""
       lblDescripcion(3).Caption = ""
       lblDescripcion(4).Caption = ""
       lblDescripcion(5).Caption = ""
       lblDescripcion(6).Caption = ""
       lblDescripcion(7).Caption = ""
       lblDescripcion(8).Caption = ""
       lblDescripcion(9).Caption = ""
       lblDescripcion(11).Caption = ""
       PMLimpiaGrid grdRegistros
       txtCarta.SetFocus

       If grdRegistros.Rows <= 2 Then
          grdRegistros.Row = 1
          grdRegistros.Col = 1
          If grdRegistros.Text = "" Then
             grdRegistros.Col = 0
             grdRegistros.Picture = picVisto(1)
          End If
       End If

       cmdBoton(0).Enabled = False 'Conf. Chq
       cmdBoton(1).Enabled = False 'Devolver
       cmdBoton(2).Enabled = False 'Conf. Cart
       cmdBoton(3).Enabled = False 'Postergar
       cmdBoton(5).Enabled = False 'Reversar

End Sub

Private Sub PLMarcarRegistro()
Dim i As Integer
    VLFila = grdRegistros.Row
    grdRegistros.Col = 0
    For i = 0 To grdRegistros.Rows - 1
       grdRegistros.Row = i
       If grdRegistros.Picture = picVisto(0) Then
          grdRegistros.Text = Str$(grdRegistros.Row)
          grdRegistros.Picture = picVisto(1)
       End If
    Next i
    grdRegistros.Col = 0
    grdRegistros.Row = VLFila
    grdRegistros.Picture = picVisto(0)


End Sub

Private Sub PLObtenerDatos()
Dim VTR1 As Integer
        VLVez = 1
        VLSalir = False
        VLStatus = " "
        VLRef = "0"
        While Not VLSalir
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "407"
             PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, txtCarta.Text
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
             PMPasoValores sqlconn&, "@i_consulta", 0, SQLVARCHAR, "N"
             PMPasoValores sqlconn&, "@i_status", 0, SQLVARCHAR, VLStatus
             PMPasoValores sqlconn&, "@i_ref", 0, SQLINT4, VLRef
             PMPasoValores sqlconn&, "@i_vez", 0, SQLINT1, Str$(VLVez)
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, VGTipoOper
             If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_consulcar", True, " OK... Consulta general de la carta remesa") Then
                If VLVez = 1 Then
                    ReDim VTArreglo(20) As String
                     VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                     PMMapeaGrid sqlconn&, grdRegistros, False
                Else
                     PMMapeaGrid sqlconn&, grdRegistros, True
                End If
                 PMChequea sqlconn&
                 VLVez = VLVez + 1
               If grdRegistros.Tag < 40 Then VLSalir = True
                grdRegistros.ColAlignment(5) = 1
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
                lblDescripcion(11).Caption = VTArreglo(12)
                txtCarta.Enabled = False
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 6
                VLStatus = grdRegistros.Text
                grdRegistros.Col = 7
                VLRef = grdRegistros.Text
            Else
                PLLimpiar
                Exit Sub
            End If
        Wend
        PLHabilitaBotones
        PLProducto
End Sub

Private Sub PLPostergar()
Dim VTDias As String
Dim i As Integer
  If (FLMarcados(0)) Then
    VTDias = InputBox("Ingrese el número de días de postergación:", "Nueva fecha de efectivización")
    If VTDias <> "" Then
        If (Val(VTDias) > 0) And (Val(VTDias) <= 900) Then
            For i = 1 To grdRegistros.Rows - 1
                grdRegistros.Row = i
                grdRegistros.Col = 0 'Marca
                If grdRegistros.Picture = picVisto(0) Then
                    grdRegistros.Col = 6 ' Estado del cheque
                    If Trim$(grdRegistros.Text) <> "PENDIENTE" Then
                        MsgBox "Solo puede postergar cheques que se encuentren pendientes"
                        grdRegistros.Col = 0
                        grdRegistros.Picture = picVisto(1)
                        Exit Sub
                    End If
                    grdRegistros.Col = 12 'Fecha efectiva
                    If Trim$(grdRegistros.Text) <> "" Then
                        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "405"
                        PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, txtCarta.Text
                        PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, (lblDescripcion(11).Caption)
                        PMPasoValores sqlconn&, "@i_dias_pos", 0, SQLINT4, VTDias
                        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
                        grdRegistros.Col = 7 'Sec. Cheque
                        PMPasoValores sqlconn&, "@i_sec_chq", 0, SQLINT4, grdRegistros.Text
                        If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_postfecha", True, " Ok... Postergación de la fecha de efectivización") Then
                            PMChequea sqlconn&
                        End If
                    Else
                        MsgBox "Cheque remesa no tiene fecha efectiva"
                        grdRegistros.Col = 0
                        grdRegistros.Picture = picVisto(1)
                        Exit Sub
                    End If
                End If
            Next i
            PLObtenerDatos
        Else
          MsgBox "Mal ingresado el número de días", 0 + 16, "Mensaje de Error"
          Exit Sub
        End If
   Else
     MsgBox "Días de Postergación no especificado", 0 + 16, "Mensaje de Error"
     Exit Sub
   End If
 Else
  MsgBox "Debe marcar el cheque a postergar", 0 + 16, "Mensaje de Error"
  Exit Sub
 End If
  
End Sub

Private Sub PLProducto()
Dim i As Integer
   If grdRegistros.Rows <= 2 Then
      grdRegistros.Col = 1
      grdRegistros.Row = 1
      If grdRegistros.Text = "" Then
         Exit Sub
      End If
   End If
        
   For i = 1 To grdRegistros.Rows - 1
      grdRegistros.Col = 3
      grdRegistros.Row = i
      Select Case grdRegistros.Text
         Case "3"
            grdRegistros.Text = "CTE"
         Case "4"
            grdRegistros.Text = "AHO"
      End Select
   Next i

End Sub

Private Sub PLRefrescar()
   Dim i As Integer
   grdRegistros.Col = 7
   For i = 1 To grdRegistros.Rows - 1
      grdRegistros.Row = i
      If grdRegistros.Text = VLDatosCheque(1) Then
         grdRegistros.Col = 0
         grdRegistros.Picture = picVisto(1)
         grdRegistros.Col = 6
         grdRegistros.Text = VLDatosCheque(2)
         lblDescripcion(8).Caption = VLDatosCheque(3)
         lblDescripcion(9).Caption = VLDatosCheque(4)
         grdRegistros.Col = 9
         grdRegistros.Text = ""
         Exit For
      End If
   Next i
End Sub

Private Sub PLReversar()
Dim VTValor As String
Dim VTReferencia As String
Dim VTCtadep As String
Dim VTAplicacion As String
Dim VTRemesas As String
Dim VTNChq As String
Dim VTCausaDev As String
Dim VTR1 As Integer
    If (FLMarcados(0)) Then
       grdRegistros.Row = VLFila
       grdRegistros.Col = 6
       If grdRegistros.Text = "CONFIRMADO" Or grdRegistros.Text = "DEVUELTO" Then
          grdRegistros.Col = 5
          VTValor = grdRegistros.Text
          grdRegistros.Col = 7
          VTReferencia = grdRegistros.Text
          grdRegistros.Col = 2
          VTCtadep = grdRegistros.Text
          grdRegistros.Col = 3
          VTAplicacion = grdRegistros.Text
          grdRegistros.Col = 10
          VTRemesas = grdRegistros.Text
          grdRegistros.Col = 4
          VTNChq = grdRegistros.Text
           PMPasoValores sqlconn&, "@t_corr", 0, SQLCHAR, "S"
           PMPasoValores sqlconn&, "@i_propie", 0, SQLVARCHAR, (lblDescripcion(2).Caption)
           PMPasoValores sqlconn&, "@i_emisor", 0, SQLVARCHAR, (lblDescripcion(4).Caption)
           PMPasoValores sqlconn&, "@i_corres", 0, SQLVARCHAR, (lblDescripcion(0).Caption)
           PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, txtCarta.Text
           PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, (lblDescripcion(11).Caption)
           PMPasoValores sqlconn&, "@i_chq", 0, SQLINT4, VTReferencia
           PMPasoValores sqlconn&, "@i_val", 0, SQLMONEY, VTValor
           PMPasoValores sqlconn&, "@i_hablt", 0, SQLVARCHAR, "C"
           PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda
           PMPasoValores sqlconn&, "@i_nchq", 0, SQLINT4, VTNChq
          grdRegistros.Col = 6
          Select Case grdRegistros.Text
             Case "CONFIRMADO"
                 PMPasoValores sqlconn&, "@i_tipo_rem", 0, SQLVARCHAR, VTRemesas
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "404"
                 If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_confcheque", True, " Ok... Corrección de Confirmación cheques remesa") Then
                   ReDim VLDatosCheque(4) As String
                    VTR1 = FMMapeaArreglo(sqlconn&, VLDatosCheque())
                    PMChequea sqlconn&
                   PLRefrescar
                  Else
                     grdRegistros.Col = 0
                     grdRegistros.Picture = picVisto(0)
                End If
             Case "DEVUELTO"
                VTCausaDev = "0"
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "402"
                 PMPasoValores sqlconn&, "@i_ctadep", 0, SQLVARCHAR, VTCtadep
                 PMPasoValores sqlconn&, "@i_prddep", 0, SQLVARCHAR, VTAplicacion
                 PMPasoValores sqlconn&, "@i_causadev", 0, SQLVARCHAR, VTCausaDev
                 PMPasoValores sqlconn&, "@i_tipo_rem", 0, SQLVARCHAR, VTRemesas
                 If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_chequedev", True, " Ok... Devolución de cheques de carta remesa") Then
                   ReDim VLDatosCheque(4) As String
                    VTR1 = FMMapeaArreglo(sqlconn&, VLDatosCheque())
                    PMChequea sqlconn&
                   PLRefrescar
                  Else
                     grdRegistros.Col = 0
                     grdRegistros.Picture = picVisto(0)
                 End If
          End Select
         Else
             Select Case grdRegistros.Text
             Case "BLOQUEADO"
                  VLEstado = "BLOQUEADO"
             Case "PENDIENTE"
                  VLEstado = "PENDIENTE"
             End Select
         
            MsgBox "Cheque " + VLEstado + " No puede Reversarse", 0 + 16, "Mensaje de Error"
            grdRegistros.Row = VLFila
            grdRegistros.Col = 0
            If grdRegistros.Picture = picVisto(0) Then
               grdRegistros.Picture = picVisto(1)
            End If
            Exit Sub
       End If
      Else
        MsgBox "Cheque a Reversar debe Seleccionarse", 0 + 16, "Mensaje de Error"
        Exit Sub
    End If
End Sub

Private Sub txtCarta_Change()
    VLPaso = False
End Sub

Private Sub txtCarta_GotFocus()
    VLPaso = True
    FPrincipal!pnlHelpLine.Caption = " Número de Carta [F5 Ayuda]"
    txtCarta.SelStart = 0
    txtCarta.SelLength = Len(txtCarta.Text)
End Sub

Private Sub txtCarta_KeyDown(Keycode As Integer, Shift As Integer)
    Dim i As Integer
    If Keycode = VGTeclaAyuda Then
    For i = 1 To 2 'Este ciclo es porque no despliega datos en el primer llamado con F5
        VLPaso = True
        VGOperacion = "sp_rem_ayuda"
        txtCarta.Text = ""
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "447"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "N"
        PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
        PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, "0"
        PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, VGTipoOper
        If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_rem_ayuda", True, " Ok... Consulta de Número de Carta Remesa") Then
           Load FRegistros
           PMMapeaGrid sqlconn&, FRegistros!grdRegistros, False
           PMChequea sqlconn&
           If i = 2 Then 'Para que llame la forma del catalogo en la última pasada
              FRegistros.Show 1
           End If
          If Val(FRegistros!grdRegistros.Tag) = VGMaxRows Then
             FRegistros!cmdSiguientes.Enabled = True
            Else
               FRegistros!cmdSiguientes.Enabled = False
          End If
          txtCarta.Text = VGACatalogo.Codigo
          If txtCarta.Text <> "" Then
             If i = 2 Then 'Para que cargue el grid en la última pasada
                PLObtenerDatos
            End If
          End If
       End If
    Next i
    End If
End Sub

Private Sub txtCarta_KeyPress(KeyAscii As Integer)

   KeyAscii = FMVAlidaTipoDato("N", KeyAscii)

End Sub

Private Sub txtCarta_LostFocus()
    If VLPaso = False And txtCarta.Text <> "" Then
       FPrincipal!pnlHelpLine.Caption = ""
       FPrincipal!pnlTransaccionLine.Caption = ""
       PLObtenerDatos
    End If
End Sub

Private Sub txtCarta_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Clipboard.Clear
    Clipboard.SetText ""
End Sub

