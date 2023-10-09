VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTra2700 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Consulta de Totales Nacionales"
   ClientHeight    =   5325
   ClientLeft      =   120
   ClientTop       =   1560
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
   HelpContextID   =   1072
   Icon            =   "ftra2700.frx":0000
   LinkTopic       =   "Form1"
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
      TabIndex        =   4
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
      Picture         =   "ftra2700.frx":030A
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   5190
      Left            =   15
      TabIndex        =   3
      Top             =   90
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   9155
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   0
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
      Picture         =   "ftra2700.frx":0326
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   1
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
      Picture         =   "ftra2700.frx":0342
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   2
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
      Picture         =   "ftra2700.frx":035E
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   9300
   End
End
Attribute VB_Name = "FTra2700"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
Dim VGTerminal As String

Private Sub cmdBoton_Click(Index As Integer)
    Dim VTGrupo As String
    Dim VTVez As Integer
    Dim VTR As Integer
    Dim VTNumOfRow As Integer
    Dim i As Integer
    Dim VTDentro As Integer
    Dim VTNomGrupo As String
    Dim j As Integer
    Dim VTNRow As Integer
    Dim k As Integer
    Dim VTTotal As Integer
    Dim VTIniciaGrupo As Integer
    Dim VTTran As Integer
    Dim VTRow As Integer
    Dim VLTotal As Integer
    Dim VTSigno As Integer
    
    Select Case Index%
    Case 0
            VTGrupo$ = "0"
            VTVez% = 1
            VTR% = 0
            VTNumOfRow% = 0
            For i% = 1 To VGNumGCtaCte%
                 If VTVez% <> 1 And VTGrupo$ = "" Then
                    Exit For
                 End If
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2700"
                 PMPasoValores sqlconn&, "@i_tran", 0, SQLINT1, "0"
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                 PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT1, VTGrupo$
                If VTVez% = 1 Then
                     PMPasoValores sqlconn&, "@i_proc", 0, SQLCHAR, "P"
                Else
                     PMPasoValores sqlconn&, "@i_proc", 0, SQLCHAR, "G"
                End If
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_cons_tot_nal_adm", True, " Ok... Consulta de totales nacionales") Then
                    VTDentro% = 1
                    ReDim VTArreglo(5) As String
                     VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                    If VTVez% = 1 Then
                         PMMapeaGrid sqlconn&, grdRegistros, False
                        VTNumOfRow% = 2
                    End If
                    VTGrupo$ = VTArreglo(1)
                    VTNomGrupo$ = VTArreglo(2)
                     PMChequea sqlconn&
                    If VTVez% = 1 Then
                        For j% = 1 To 12
                            grdRegistros.Row = 1
                            grdRegistros.Col = j%
                            If j% = 2 Then
                                grdRegistros.Text = "GRUPO DE TRANSACCIONES  ''" + VTNomGrupo$ + "''"
                                grdRegistros.ColWidth(j%) = 5000
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
                        grdRegistros.ColWidth(9) = 1
                        grdRegistros.ColWidth(10) = 1
                        grdRegistros.ColWidth(11) = 1
                        grdRegistros.ColWidth(13) = 1
                    Else
                        If VTNomGrupo$ <> "" Then
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
                            VTNumOfRow% = grdRegistros.Rows
                        End If
                    End If
                    
                    ' Mapeo de cada uno de los grupos
                    VTIniciaGrupo% = True
                    While VTDentro% <> 0
                         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2700"
                         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                         PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT1, VTGrupo$
                         PMPasoValores sqlconn&, "@i_proc", 0, SQLCHAR, "T"
                        If VTIniciaGrupo% = True Then
                             PMPasoValores sqlconn&, "@i_tran", 0, SQLINT1, "0"
                        Else
                             PMPasoValores sqlconn&, "@i_tran", 0, SQLINT1, VTTran
                        End If
                         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_cons_tot_nal_adm", True, " Ok... Consulta de totales nacionales") Then
                             PMMapeaGrid sqlconn&, grdRegistros, True
                             PMChequea sqlconn&
                            VTIniciaGrupo = False
                            VTVez = VTVez + 1
                            VTDentro = grdRegistros.Tag
                            VTRow = grdRegistros.Rows - 1
                            grdRegistros.Col = 1
                            grdRegistros.Row = VTRow
                            VTTran = grdRegistros.Text
                            If VTDentro < 20 Then
                                VTDentro = 0
                            End If
                        Else
                            VTDentro = 0
                        End If
                    Wend
                Else
                    PMLimpiaGrid grdRegistros
                    Exit Sub
                End If
            Next i%
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
                For j% = 1 To grdRegistros.Rows - 3
                    grdRegistros.Row = j%
                    grdRegistros.Col = k%
                    If grdRegistros.Text <> "" Then
                        grdRegistros.Col = 2
                        If grdRegistros.Text <> "TOTALES DEL GRUPO" Then
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
                            If k = 3 Then VTSigno = 1
                            grdRegistros.Col = k
                            VLTotal = VLTotal + VTSigno * CCur(grdRegistros.Text)
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
            For i% = 3 To 12
                grdRegistros.ColAlignment(i%) = 1
            Next i%
            grdRegistros.ColWidth(0) = 1
            grdRegistros.ColWidth(1) = 1
            grdRegistros.ColWidth(9) = 1
            grdRegistros.ColWidth(10) = 1
            grdRegistros.ColWidth(11) = 1
            grdRegistros.ColWidth(13) = 1

            cmdBoton(3).Enabled = True
    Case 1
        PMLimpiaGrid grdRegistros
        cmdBoton(3).Enabled = False
    Case 2
        Unload FTra2700
    Case 3
        PLImprimir
    End Select
End Sub

Private Sub Form_Load()
    FTra2700.Left = 15
    FTra2700.Top = 15
    FTra2700.Width = 9420
    FTra2700.Height = 5730
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
        Screen.MousePointer = 11
        Printer.FontBold = True
        Printer.CurrentX = 0
        Printer.CurrentY = 1200
        Printer.FontSize = 24
        Printer.Print VGBanco$
        Printer.FontSize = 8
        Printer.FontBold = True
        Printer.CurrentX = 4100
        Printer.CurrentY = 2100
        Printer.Print "Fecha :"
        Printer.FontBold = False
        Printer.CurrentX = 4800
        Printer.CurrentY = 2100
        Printer.Print VGFecha$
        Printer.FontBold = True
        Printer.CurrentX = 5800
        Printer.CurrentY = 2100
        Printer.Print "Hora :"
        Printer.FontBold = False
        Printer.CurrentX = 6400
        Printer.CurrentY = 2100
        Printer.Print Time$
        Printer.FontBold = True
        Printer.CurrentX = 7300
        Printer.CurrentY = 2100
        Printer.Print "Terminal: "
        Printer.FontBold = False
        Printer.CurrentX = 8100
        Printer.CurrentY = 2100
        Printer.Print VGTerminal
        Printer.FontBold = True
        Printer.CurrentX = 9100
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
        Printer.Print "TOTALES DE CAJA NACIONALES"
        Printer.FontSize = 6
        Printer.FontBold = True
        Printer.Print ""
        Printer.Print ""
        Printer.CurrentX = 2585
        Printer.Print "N�"
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
        Printer.FontBold = False
        Printer.Print ""
        Dim i As Integer
    For i% = 1 To grdRegistros.Rows - 1
        grdRegistros.Row = i%
        Printer.Print Spc(1);
        grdRegistros.Col = 2
        Printer.Print grdRegistros.Text;
        Printer.CurrentX = 2585
        grdRegistros.Col = 3
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
    Next i%
    Printer.Print ""
    Printer.Print ""
    Printer.Print ""
    Printer.Print ""
    Printer.Print ""
    Printer.CurrentX = 7000
    Printer.Print String$(50, "_")
    Printer.Print ""
    Printer.CurrentX = 7000
    Printer.Print "Firma de Responsabilidad"
    Printer.EndDoc
    Screen.MousePointer = 0 'Cursor normal
End Sub


