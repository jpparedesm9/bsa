VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran601 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Acuse de Remesas"
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
   LinkMode        =   1  'Source
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5307.009
   ScaleMode       =   0  'User
   ScaleWidth      =   536.516
   Tag             =   "3888"
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7740
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   5
      Top             =   1515
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
      TabIndex        =   6
      Top             =   1515
      Visible         =   0   'False
      Width           =   195
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   6
      Left            =   8385
      TabIndex        =   3
      Top             =   3765
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
   Begin VB.TextBox txtCarta 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1680
      MaxLength       =   9
      TabIndex        =   0
      Top             =   25
      Width           =   1605
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3495
      Left            =   90
      TabIndex        =   7
      Top             =   1785
      Width           =   8220
      _Version        =   65536
      _ExtentX        =   14499
      _ExtentY        =   6165
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
      Left            =   8385
      TabIndex        =   4
      Top             =   4530
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8385
      TabIndex        =   2
      Top             =   3000
      WhatsThisHelpID =   2507
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Acuse"
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
      Height          =   795
      Index           =   2
      Left            =   8385
      TabIndex        =   1
      Tag             =   "8005;8006"
      Top             =   15
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "*&Buscar"
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
      Picture         =   "Ftran601.frx":0000
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   484.258
      Y1              =   1409.206
      Y2              =   1409.206
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   485.129
      X2              =   485.129
      Y1              =   -14.992
      Y2              =   5292.017
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
      TabIndex        =   25
      Top             =   1530
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
      TabIndex        =   28
      Top             =   840
      Width           =   2520
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
      Left            =   3960
      TabIndex        =   27
      Top             =   840
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
      TabIndex        =   26
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
      TabIndex        =   24
      Top             =   30
      Width           =   2520
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
      TabIndex        =   23
      Top             =   1111
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
      TabIndex        =   22
      Top             =   1110
      Width           =   2520
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
      TabIndex        =   21
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
      TabIndex        =   20
      Top             =   570
      Width           =   5010
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
      TabIndex        =   19
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
      Left            =   3285
      TabIndex        =   18
      Top             =   1440
      Visible         =   0   'False
      Width           =   5025
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   255
      Index           =   2
      Left            =   1665
      TabIndex        =   17
      Top             =   1440
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
      TabIndex        =   16
      Top             =   300
      Width           =   5010
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
      TabIndex        =   15
      Top             =   305
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
      Left            =   3960
      TabIndex        =   14
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
      TabIndex        =   13
      Top             =   1110
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
      Left            =   3960
      TabIndex        =   12
      Top             =   1110
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
      TabIndex        =   11
      Top             =   840
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
      TabIndex        =   10
      Top             =   570
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
      Left            =   121
      TabIndex        =   9
      Top             =   1470
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
      TabIndex        =   8
      Top             =   300
      WhatsThisHelpID =   5420
      Width           =   1245
   End
End
Attribute VB_Name = "FTran601"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLPaso As Integer
Dim VLVez As Integer
Dim VLSalir As Boolean
Dim VLStatus As String
Dim VLRef As String
Dim VLConfirmar As String
Dim VLFila As Integer
Dim VLDatosCheque() As String

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0  'Acuse de Carta
        PLAcuse
       
    Case 2  'Buscar
        PLBuscar
    
    Case 4
        Unload FTran601
        
    Case 6   'Limpiar
       PLLimpiar
    End Select
End Sub

Private Sub Form_Activate()
    VGHelpRem$ = "N"
    VGTipoOper = "A"
End Sub

Private Sub Form_Load()

    FTran601.Left = 15
    FTran601.Top = 15
    FTran601.Width = 9420
    FTran601.Height = 5820
    txtCarta.Height = 255
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmdBoton(0).Enabled = False 'Acuse
    cmdBoton(2).Enabled = True 'Buscar
    
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

   VLFila% = 0
   PLMarcarRegistro

End Sub

Private Sub PLBuscar()
Dim VTR1 As Integer
Dim VTValor As String
        VLVez = 1
        VLSalir = False
        VLStatus = " "
        VLRef = "0"
        While Not VLSalir
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "407"
             PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, txtCarta.Text
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
             PMPasoValores sqlconn&, "@i_consulta", 0, SQLVARCHAR, "N"
             PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
             PMPasoValores sqlconn&, "@i_status", 0, SQLVARCHAR, VLStatus$
             PMPasoValores sqlconn&, "@i_ref", 0, SQLINT4, VLRef$
             PMPasoValores sqlconn&, "@i_vez", 0, SQLINT1, Str$(VLVez%)
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, VGTipoOper
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_consulcar", True, " OK... Consulta general de la carta remesa") Then
             
                If VLVez = 1 Then
                    ReDim VTArreglo(20) As String
                     VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                     PMMapeaVariable sqlconn&, VLConfirmar
                     PMMapeaGrid sqlconn&, grdRegistros, False
                Else
                     PMMapeaGrid sqlconn&, grdRegistros, True
                End If
                 PMChequea sqlconn&
                 grdRegistros.Col = 8
                VTValor = grdRegistros.Text
                 If VTValor$ = "S" Then
                   MsgBox "Carta ya ha sido Acusada", 64, "Mensaje de Error"
                    cmdBoton(0).Enabled = False
                   Exit Sub
                End If
                VLVez% = VLVez% + 1
                If grdRegistros.Tag < 45 Then VLSalir = True
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
                VLStatus$ = grdRegistros.Text
                grdRegistros.Col = 7
                VLRef$ = grdRegistros.Text
                
                
            Else
                PLLimpiar
                Exit Sub
            End If
        Wend
        PLHabilitaBotones
        PLProducto
End Sub

Private Sub PLAcuse()
         
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "603"
         PMPasoValores sqlconn&, "@i_propie", 0, SQLVARCHAR, (lblDescripcion(2).Caption)
         PMPasoValores sqlconn&, "@i_corres", 0, SQLVARCHAR, (lblDescripcion(0).Caption)
         PMPasoValores sqlconn&, "@i_secuen", 0, SQLINT4, txtCarta.Text
         PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, (lblDescripcion(11).Caption)
         PMPasoValores sqlconn&, "@i_hablt", 0, SQLVARCHAR, "C"
         PMPasoValores sqlconn&, "@i_acuse", 0, SQLVARCHAR, "S"
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_acuse_remesas", True, " Ok... Confirmación de carta remesa") Then
            PMChequea sqlconn&
            cmdBoton(0).Enabled = False
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
       
    If VLConfirmar$ = "S" Then
       cmdBoton(0).Enabled = True  'Conf. Chq
       cmdBoton(2).Enabled = True  'Conf. Cart
       cmdBoton(0).SetFocus
     Else
       cmdBoton(0).Enabled = True  'Conf. Chq
       cmdBoton(2).Enabled = False  'Conf. Cart
       cmdBoton(6).SetFocus
    End If
   
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

       cmdBoton(0).Enabled = False
       cmdBoton(2).Enabled = True
       
    End Sub

Private Sub PLMarcarRegistro()
Dim i As Integer
    VLFila% = grdRegistros.Row
    grdRegistros.Col = 0
    For i = 0 To grdRegistros.Rows - 1
       grdRegistros.Row = i
       If grdRegistros.Picture = picVisto(0) Then
          grdRegistros.Text = Str$(grdRegistros.Row)
          grdRegistros.Picture = picVisto(1)
       End If
    Next i
    grdRegistros.Col = 0
    grdRegistros.Row = VLFila%
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
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
        PMPasoValores sqlconn&, "@i_consulta", 0, SQLVARCHAR, "N"
        PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
        PMPasoValores sqlconn&, "@i_status", 0, SQLVARCHAR, VLStatus$
        PMPasoValores sqlconn&, "@i_ref", 0, SQLINT4, VLRef$
        PMPasoValores sqlconn&, "@i_vez", 0, SQLINT1, Str$(VLVez%)
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, VGTipoOper
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_consulcar", True, " OK... Consulta general de la carta remesa") Then
            If VLVez% = 1 Then
                ReDim VTArreglo(20) As String
                 VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                 PMMapeaGrid sqlconn&, grdRegistros, False
            Else
                 PMMapeaGrid sqlconn&, grdRegistros, True
            End If
            PMChequea sqlconn&
            VLVez% = VLVez% + 1
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
                VLStatus$ = grdRegistros.Text
                grdRegistros.Col = 7
                VLRef$ = grdRegistros.Text
            Else
                PLLimpiar
                Exit Sub
            End If
    Wend
    PLHabilitaBotones
    PLProducto
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

Private Sub txtCarta_Change()
    VLPaso% = False
End Sub

Private Sub txtCarta_GotFocus()
    VLPaso% = True
    FPrincipal!pnlHelpLine.Caption = " Número de Carta [F5 Ayuda]"
    txtCarta.SelStart = 0
    txtCarta.SelLength = Len(txtCarta.Text)
End Sub

Private Sub txtCarta_KeyDown(Keycode As Integer, Shift As Integer)
       If Keycode = VGTeclaAyuda% Then
       VLPaso% = True
       VGOperacion$ = "sp_rem_ayuda"
       txtCarta.Text = ""
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "447"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "R"
        PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
        PMPasoValores sqlconn&, "@i_ultimo", 0, SQLINT4, "0"
        PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda$
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, VGTipoOper
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_ayuda", True, " Ok... Consulta de Número de Carta Remesa") Then
           Load FRegistros
           PMMapeaGrid sqlconn&, FRegistros!grdRegistros, False
           PMChequea sqlconn&
          FRegistros.Show 1
          If Val(FRegistros!grdRegistros.Tag) = VGMaxRows% Then
             FRegistros!cmdSiguientes.Enabled = True
            Else
               FRegistros!cmdSiguientes.Enabled = False
          End If
          txtCarta.Text = VGACatalogo.Codigo$
          If txtCarta.Text <> "" Then
             PLObtenerDatos
          End If
       End If
    End If
End Sub

Private Sub txtCarta_KeyPress(KeyAscii As Integer)

   KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)

End Sub

Private Sub txtCarta_LostFocus()
    If VLPaso% = False And txtCarta.Text <> "" Then
       FPrincipal!pnlHelpLine.Caption = ""
       FPrincipal!pnlTransaccionLine.Caption = ""
       PLObtenerDatos
    End If
End Sub

Private Sub txtCarta_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Clipboard.Clear
    Clipboard.SetText ""
End Sub

