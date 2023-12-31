VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran090 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Consulta de Totales por Operador"
   ClientHeight    =   5325
   ClientLeft      =   105
   ClientTop       =   1515
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
   HelpContextID   =   1073
   Icon            =   "FTRAN090.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   11
      Tag             =   "6335"
      Top             =   2260
      WhatsThisHelpID =   2009
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Imprimir"
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
      Picture         =   "FTRAN090.frx":030A
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   4620
      Left            =   15
      TabIndex        =   7
      Top             =   690
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   8150
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   6540
      MaxLength       =   8
      TabIndex        =   2
      Top             =   345
      Width           =   1815
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1935
      MaxLength       =   5
      TabIndex        =   0
      Top             =   45
      Width           =   555
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1935
      TabIndex        =   1
      Top             =   345
      Width           =   1815
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   5
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
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRAN090.frx":0326
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   4
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
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRAN090.frx":0342
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   3
      Top             =   3030
      WhatsThisHelpID =   2030
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Transmitir"
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
      Picture         =   "FTRAN090.frx":035E
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8385
      X2              =   8385
      Y1              =   15
      Y2              =   5380
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Rol:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   6015
      TabIndex        =   8
      Top             =   345
      Width           =   360
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2505
      TabIndex        =   9
      Top             =   45
      Width           =   5850
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "C�digo de la oficina:"
      ForeColor       =   &H00800000&
      Height          =   270
      Index           =   2
      Left            =   90
      TabIndex        =   10
      Top             =   45
      Width           =   1845
   End
   Begin VB.Label Label1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Operador:"
      ForeColor       =   &H00800000&
      Height          =   240
      Index           =   5
      Left            =   90
      TabIndex        =   6
      Top             =   345
      Width           =   1815
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   15
      X2              =   8385
      Y1              =   660
      Y2              =   645
   End
End
Attribute VB_Name = "FTran090"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
Dim VLPaso As Integer
Dim VTNiveles() As String

Private Sub cmdBoton_Click(Index As Integer)
    Dim VTTransaccion As String
    Dim VTNivelAnt As String
    Dim VTGrupo As String
    Dim VTVez As Integer
    Dim VTR As Integer
    Dim VTNumOfRow As Integer
    Dim VTN As Integer
    Dim n As Integer
    Dim VTDentro As Integer
    Dim VTNivel As Integer
    Dim VTNomGrupo As String
    Dim i As Integer
    Dim j As Integer
    Dim VTNiv As Integer
    Dim VTNRow As Integer
    Dim k As Integer
    Dim VTTotal As Integer
    Dim VLTotal As Integer
    Dim VTIniciaGrupo As Integer
    Dim VTTran As String
    Dim VTRow As Integer
    Dim VTSigno As Integer
    

    Select Case Index%
    Case 0
        If txtCampo(1).Text = "" Then
            MsgBox "El c�digo de oficina es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            MsgBox "El nombre del operador es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            MsgBox "El c�digo del rol del operador es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        VTNivelAnt$ = "0"
        VTGrupo$ = "0"
        VTVez% = 1
        VTR% = 3
        VTNumOfRow% = 0
        
        'Encuentra niveles definidos
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "90"
        PMPasoValores sqlconn&, "@i_caj", 0, SQLVARCHAR, (txtCampo(0).Text)
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
        PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(1).Text)
        PMPasoValores sqlconn&, "@i_tran", 0, SQLINT1, "0"
        PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT1, VTGrupo$
        PMPasoValores sqlconn&, "@i_rol", 0, SQLINT2, (txtCampo(2).Text)
        PMPasoValores sqlconn&, "@i_proc", 0, SQLCHAR, "N"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_tot_caj_adm", True, " Ok... Consulta de totales por operador") Then
           ReDim VTNiveles(10) As String
           VTN% = FMMapeaArreglo(sqlconn&, VTNiveles())
           For n% = 1 To VTN%
                VTGrupo$ = "0"
                VTR% = 3
                Do While VTR% = 3 'Wend
                'For i% = 1 To VGNumGCtaCte%
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "90"
                     PMPasoValores sqlconn&, "@i_caj", 0, SQLVARCHAR, (txtCampo(0).Text)
                     PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                     PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(1).Text)
                     PMPasoValores sqlconn&, "@i_tran", 0, SQLINT1, "0"
                     PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT1, VTGrupo$
                     PMPasoValores sqlconn&, "@i_nivel", 0, SQLINT1, VTNiveles(n%)
                     PMPasoValores sqlconn&, "@i_rol", 0, SQLINT2, (txtCampo(2).Text)
                    If VTVez% = 1 Then
                         PMPasoValores sqlconn&, "@i_proc", 0, SQLCHAR, "P"
                    Else
                         PMPasoValores sqlconn&, "@i_proc", 0, SQLCHAR, "G"
                    End If
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_tot_caj_adm", True, " Ok... Consulta de totales por operador") Then
                        VTDentro% = 1
                        ReDim VTArreglo(5) As String
                        VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                        If VTR% = 0 Then Exit Do
                        If VTVez% = 1 Then
                             PMMapeaGrid sqlconn&, grdRegistros, False
                            VTNumOfRow% = 2
                        End If
                        VTNivel = VTArreglo(1)
                        VTGrupo$ = VTArreglo(2)
                        VTNomGrupo = VTArreglo(3)
                         PMChequea sqlconn&
                        If VTVez% = 1 Then
                            For j% = 1 To 12
                                grdRegistros.Row = 1
                                grdRegistros.Col = j%
                                If j% = 2 Then
                                    VTNiv% = grdRegistros.Row
                                    grdRegistros.Text = "TRANSACCIONES NIVEL  " + VTNivel
                                    grdRegistros.Rows = grdRegistros.Rows + 2
                                    grdRegistros.Row = 3
                                    grdRegistros.Text = "GRUPO DE TRANSACCIONES  ''" + VTNomGrupo$ + "''"
                                    grdRegistros.ColWidth(j%) = 4000
                                    grdRegistros.Row = 1
                                Else
                                    grdRegistros.Text = ""
                                End If
                                If j% = 1 Then
                                    grdRegistros.ColWidth(j%) = 400
                                End If
                                If j% >= 4 Then
                                    grdRegistros.ColWidth(j%) = 1400
                                End If
                            Next j%
                            grdRegistros.ColWidth(13) = 1
                        Else
                            If VTNivelAnt$ <> VTNivel Then
                               VTNivelAnt$ = VTNiveles(n%)
                               grdRegistros.Col = 2
                               grdRegistros.Rows = grdRegistros.Rows + 5
                               grdRegistros.Row = grdRegistros.Rows - 3
                               VTNiv% = grdRegistros.Row
                               grdRegistros.Text = "TRANSACCIONES NIVEL  " + VTNivel
                               grdRegistros.Row = grdRegistros.Row + 2
                               grdRegistros.Text = "GRUPO DE TRANSACCIONES  ''" + VTNomGrupo$ + "''"
                               'grdRegistros.Row = 2
                            Else
                               grdRegistros.Rows = grdRegistros.Rows + 3
                               grdRegistros.Row = grdRegistros.Rows - 1
                               grdRegistros.Col = 2
                               grdRegistros.Text = "GRUPO DE TRANSACCIONES  ''" + VTNomGrupo$ + "''"
                               grdRegistros.Row = grdRegistros.Rows - 3
                               VTNRow% = grdRegistros.Row - 1
                               grdRegistros.Col = 2
                               grdRegistros.Text = "TOTALES DEL GRUPO"
                               For k% = 3 To 12
                                    grdRegistros.Col = k%
                                    VTTotal = 0
                                    For j% = VTNumOfRow% To VTNRow%
                                        grdRegistros.Row = j%
                                        If grdRegistros.Text <> "" Then
                                            grdRegistros.Col = 1
                                            If grdRegistros.Text <> "" Then
                                                VTTransaccion = grdRegistros.Text
                                            Else
                                                VTTransaccion = "0"
                                            End If
                                            If CDbl(VTTransaccion) = 26200 Then
                                               grdRegistros.Col = k%
                                               VTTotal = VTTotal + CCur(grdRegistros.Text)
                                            Else
                                               If CDbl(VTTransaccion) = 26201 Then
                                                    grdRegistros.Col = k%
                                                    VTTotal = VTTotal - CCur(grdRegistros.Text)
                                               Else
                                                   grdRegistros.Col = k%
                                                   VTTotal = VTTotal + CCur(grdRegistros.Text)
                                               End If
                                            End If
                                            'VTTotal@ = VTTotal@ + CCur(grdRegistros.Text)
                                        End If
                                    Next j%
                                    grdRegistros.Row = VTNRow% + 1
                                    If k% = 3 Then
                                        grdRegistros.Text = Str$(VTTotal)
                                    Else
                                        grdRegistros.Text = Format$(Str$(VTTotal), "#,##0.00")
                                    End If
                               Next k%
                            End If
                            VTNumOfRow% = grdRegistros.Rows
                        End If
                
                        ' Mapeo de cada uno de los grupos
                        VTIniciaGrupo% = True
                        While VTDentro% <> 0
                            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "90"
                             PMPasoValores sqlconn&, "@i_caj", 0, SQLVARCHAR, (txtCampo(0).Text)
                             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                             PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, (txtCampo(1).Text)
                            If VTIniciaGrupo% = True Then
                                 PMPasoValores sqlconn&, "@i_tran", 0, SQLINT2, "0"
                            Else
                                 PMPasoValores sqlconn&, "@i_tran", 0, SQLINT2, VTTran$
                            End If
                             PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT1, VTGrupo$
                             PMPasoValores sqlconn&, "@i_nivel", 0, SQLINT1, VTNiveles(n%)
                             PMPasoValores sqlconn&, "@i_rol", 0, SQLINT2, (txtCampo(2).Text)
                             PMPasoValores sqlconn&, "@i_proc", 0, SQLCHAR, "T"
                             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_tot_caj_adm", True, " Ok... Consulta de totales por operador") Then
                                 PMMapeaGrid sqlconn&, grdRegistros, True
                                 PMChequea sqlconn&
                                VTIniciaGrupo% = False
                                VTVez% = VTVez% + 1
                                VTDentro% = grdRegistros.Tag
                                VTRow% = grdRegistros.Rows - 1
                                grdRegistros.Col = 1
                                grdRegistros.Row = VTRow%
                                VTTran$ = grdRegistros.Text
                                If VTDentro% < 20 Then
                                    VTDentro% = 0
                                End If
                            Else
                                VTDentro% = 0
                            End If
                        Wend
                    Else
                        txtCampo(1).SetFocus
                        PMLimpiaGrid grdRegistros
                        Exit Sub
                    End If
                'Next i%
                Loop
                grdRegistros.Rows = grdRegistros.Rows + 1
                grdRegistros.Row = grdRegistros.Rows - 1
                VTNRow% = grdRegistros.Row - 1
                grdRegistros.Col = 2
                grdRegistros.Text = "TOTALES DEL GRUPO"
                For k% = 3 To 12
                    grdRegistros.Col = k%
                    VTTotal = 0
                    For j% = VTNumOfRow% To VTNRow%
                        grdRegistros.Row = j%
                        If grdRegistros.Text <> "" Then
                            VTTotal = VTTotal + CCur(grdRegistros.Text)
                        End If
                    Next j%
                    grdRegistros.Row = VTNRow% + 1
                    If k% = 3 Then
                        grdRegistros.Text = Str$(VTTotal)
                    Else
                        grdRegistros.Text = Format$(Str$(VTTotal), "#,##0.00")
                    End If
                Next k%
                grdRegistros.Rows = grdRegistros.Rows + 2
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 2
                grdRegistros.Text = "     TOTALES"
                For k% = 3 To 12
                    VLTotal = 0
                    grdRegistros.Col = k%
                    For j% = VTNiv% To grdRegistros.Rows - 3
                    'For J% = 1 To grdRegistros.Rows - 3
                        grdRegistros.Row = j%
                        grdRegistros.Col = k%
                        If grdRegistros.Text <> "" Then
                            grdRegistros.Col = 2
                            If grdRegistros.Text <> "TOTALES DEL GRUPO" And _
                               grdRegistros.Text <> "     TOTALES" Then
                                grdRegistros.Col = 13
                                VTSigno% = 0
                                If UCase$(Left$(grdRegistros.Text, 1)) = "S" Then
                                    Select Case Right$(grdRegistros.Text, 1)
                                    Case "+"
                                        VTSigno% = 1
                                    Case "-"
                                        VTSigno% = -1
                                    End Select
                                End If
                                If k% = 3 Then VTSigno% = 1
                                grdRegistros.Col = k%
                                VLTotal = VLTotal + VTSigno% * CCur(grdRegistros.Text)
                            End If
                        End If
                    Next j%
                    grdRegistros.Row = grdRegistros.Rows - 1
                    grdRegistros.Col = k%
                    If k% = 3 Then
                        grdRegistros.Text = Str$(VLTotal)
                    Else
                        grdRegistros.Text = Format$(Str$(VLTotal), "#,##0.00")
                    End If
                Next k%
                VTNivelAnt$ = VTNivel
            Next n%
            grdRegistros.ColWidth(0) = 1
            grdRegistros.ColWidth(1) = 1
            grdRegistros.ColWidth(9) = 1
            grdRegistros.ColWidth(10) = 1
            grdRegistros.ColWidth(11) = 1
            grdRegistros.ColWidth(13) = 1
            For i% = 3 To 12
                grdRegistros.ColAlignment(i%) = 1
            Next i%
            cmdBoton(3).Enabled = True
        End If
    Case 1
        txtCampo(0).Text = VGLogin$
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        lblDescripcion(0).Caption = ""
        PMLimpiaGrid grdRegistros
        txtCampo(1).SetFocus
        cmdBoton(3).Enabled = False
    Case 2
        Unload FTran090
    Case 3
        PLImprimir
    End Select
End Sub

Private Sub Form_Load()
    FTran090.Left = 15
    FTran090.Top = 15
    FTran090.Width = 9420
    FTran090.Height = 5730
    txtCampo(0).Text = VGLogin$
    
    PMLoadResStrings Me
    PMLoadResIcons Me
    
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

Private Sub PLImprimir()
    Dim VLRol As String
    Dim VGTerminal As String
    Dim VTLin As Integer
    Dim i As Integer
        Screen.MousePointer = 11
        Printer.FontBold = True
        Printer.CurrentX = 350
        Printer.CurrentY = 1200
        Printer.FontSize = 24
        Printer.Print VGBanco$
        Printer.FontSize = 16
        Printer.FontBold = True
        Printer.CurrentX = 350
        Printer.CurrentY = 2100
        Printer.Print "Rol :"
        Printer.FontBold = False
        Printer.CurrentX = 1200
        Printer.CurrentY = 2100
        VLRol$ = txtCampo(2)
        Printer.Print VLRol$
        Printer.FontSize = 8
        Printer.FontBold = True
        Printer.CurrentX = 4800
        Printer.CurrentY = 2100
        Printer.Print "Fecha :"
        Printer.FontBold = False
        Printer.CurrentX = 5400
        Printer.CurrentY = 2100
        Printer.Print VGFecha$
        Printer.FontBold = True
        Printer.CurrentX = 6300
        Printer.CurrentY = 2100
        Printer.Print "Hora :"
        Printer.FontBold = False
        Printer.CurrentX = 6800
        Printer.CurrentY = 2100
        Printer.Print Time$
        Printer.FontBold = True
        Printer.CurrentX = 7500
        Printer.CurrentY = 2100
        Printer.Print "Terminal: "
        Printer.FontBold = False
        Printer.CurrentX = 8300
        Printer.CurrentY = 2100
        Printer.Print VGTerminal$
        Printer.FontBold = True
        Printer.CurrentX = 9200
        Printer.CurrentY = 2100
        Printer.Print "Usuario :"
        Printer.FontBold = False
        Printer.CurrentX = 9900
        Printer.CurrentY = 2100
        Printer.Print VGLogin$
        Printer.FontBold = True
        Printer.CurrentX = 350
        Printer.CurrentY = 2500
        Printer.FontSize = 16
    Printer.Print "TOTALES DEL CAJERO  ''" + txtCampo(0) + " ''  " + "OFICINA  ''" + lblDescripcion(0).Caption + "''"
    Printer.FontSize = 6
    Printer.FontBold = True
    Printer.Print ""
    Printer.Print ""
    Printer.CurrentX = 2585
    Printer.Print "N�";
    Printer.CurrentX = 3158
    Printer.Print "Efectivo";
    Printer.CurrentX = 4566
    Printer.Print "Chq. Propios";
    Printer.CurrentX = 5983
    Printer.Print "Chq. Locales";
    Printer.CurrentX = 7401
    Printer.Print "Chq. Plazas";
    Printer.CurrentX = 8810
    Printer.Print "Otros Valores";
    Printer.CurrentX = 10236
    Printer.Print "Totales"
    Printer.Print Tab(50); String$(150, "_")
    Printer.Print ""
    Printer.FontBold = False
    VTLin% = 20
    For i% = 1 To grdRegistros.Rows - 1
        grdRegistros.Row = i%
        Printer.Print Spc(1);
        grdRegistros.Col = 2
        'Printer.FontSize = 8
        'Printer.FontBold = True
        Printer.Print grdRegistros.Text;
        Printer.CurrentX = 2585
        grdRegistros.Col = 3
        'Printer.FontBold = False
        'Printer.FontSize = 6
        Printer.Print grdRegistros.Text;
        Printer.CurrentX = 3158
        grdRegistros.Col = 4
        Printer.Print grdRegistros.Text;
        Printer.CurrentX = 4566
        grdRegistros.Col = 5
        Printer.Print grdRegistros.Text;
        Printer.CurrentX = 5983
        grdRegistros.Col = 6
        Printer.Print grdRegistros.Text;
        Printer.CurrentX = 7401
        grdRegistros.Col = 7
        Printer.Print grdRegistros.Text;
        Printer.CurrentX = 8810
        grdRegistros.Col = 8
        Printer.Print grdRegistros.Text;
        Printer.CurrentX = 10236
        grdRegistros.Col = 12
        Printer.Print grdRegistros.Text;
        Printer.Print ""
        If VTLin% = 108 Then
           VTLin% = 1
           Printer.NewPage
           Printer.CurrentY = 800
        End If
        VTLin% = VTLin% + 1
    Next i%
    Printer.CurrentX = 7000
    Printer.Print String$(50, "_")
    Printer.Print ""
    Printer.CurrentX = 7000
    Printer.Print "Firma de Responsabilidad"
    Printer.EndDoc
    Screen.MousePointer = 0 'Cursor normal
End Sub

Private Sub txtCampo_Change(Index As Integer)
    If Index% = 1 Then
        VLPaso% = False
    End If
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Nombre del operador"
    Case 1
        VLPaso% = True
        FPrincipal!pnlHelpLine.Caption = " C�digo de la oficina [F5 Ayuda]"
    Case 2
        VLPaso% = True
        FPrincipal!pnlHelpLine.Caption = " C�digo del rol del Operador"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda% Then
        If Index% = 1 Then
            VGOperacion$ = "sp_oficina"
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(0).Text & "]") Then
                 PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(1).Text = VGACatalogo.Codigo$
                lblDescripcion(0).Caption = VGACatalogo.Descripcion$
            End If
        VLPaso% = True
        End If
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
        KeyAscii% = Asc(LCase$(Chr$(KeyAscii%)))
    Case 1, 2
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    If Index% = 1 Then
        If VLPaso% = False Then
            If txtCampo(1).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(1).Text)
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(0).Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(0)
                     PMChequea sqlconn&
                Else
                    VLPaso% = True
                    txtCampo(1).Text = ""
                    lblDescripcion(0).Caption = ""
                    txtCampo(1).SetFocus
                    PMLimpiaGrid grdRegistros
                End If
            Else
                lblDescripcion(0).Caption = ""
            End If
        End If
    End If
End Sub


