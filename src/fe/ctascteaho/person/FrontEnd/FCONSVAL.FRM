VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FConsVal 
   Appearance      =   0  'Flat
   Caption         =   "Consulta de Valores a entrar en Vigencia"
   ClientHeight    =   5325
   ClientLeft      =   180
   ClientTop       =   1380
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
   Icon            =   "FCONSVAL.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Limpiar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   1
      Left            =   8415
      Picture         =   "FCONSVAL.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   3
      Top             =   3795
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   2205
      MaxLength       =   5
      TabIndex        =   0
      Top             =   15
      Width           =   1005
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Buscar"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   0
      Left            =   8415
      Picture         =   "FCONSVAL.frx":0670
      Style           =   1  'Graphical
      TabIndex        =   1
      Tag             =   "4118"
      Top             =   15
      Width           =   875
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   2
      Left            =   8415
      Picture         =   "FCONSVAL.frx":08D2
      Style           =   1  'Graphical
      TabIndex        =   4
      Top             =   4545
      Width           =   875
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   4725
      Left            =   30
      TabIndex        =   2
      Top             =   585
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14685
      _ExtentY        =   8335
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
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8415
      Y1              =   330
      Y2              =   330
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código Sucursal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   60
      TabIndex        =   7
      Top             =   15
      Width           =   1455
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   6
      Left            =   3225
      TabIndex        =   6
      Top             =   15
      Width           =   5130
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Próximos Valores Vigentes"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   5
      Top             =   360
      Width           =   2985
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5310
   End
End
Attribute VB_Name = "FConsVal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer

Private Sub cmdBoton_Click(Index As Integer)
Dim VTFilas%
Dim VTSecuencial$
    Select Case Index%
    
    Case 0

        'Siguientes
        If txtCampo(0).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
    
            VTFilas% = VGMaxRows%
            VTSecuencial$ = "0"
            While VTFilas% = VGMaxRows%
    
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4059"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "CVV"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, VTSecuencial$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help2_costos", True, "Ok...Consulta de Próximos Valores") Then
                If VTSecuencial$ = "0" Then
                     PMMapeaGrid sqlconn&, grdRegistros, False
                Else
                     PMMapeaGrid sqlconn&, grdRegistros, True
                End If
    
                 PMChequea sqlconn&
                If Val(grdRegistros.Tag) > 0 Then
                    grdRegistros.ColAlignment(6) = 1
                    grdRegistros.ColAlignment(7) = 1
                    grdRegistros.ColAlignment(8) = 1
                    grdRegistros.ColAlignment(9) = 1
                    grdRegistros.ColAlignment(10) = 1
                    grdRegistros.ColAlignment(11) = 2
                    

                End If
                grdRegistros.ColWidth(12) = 1
                grdRegistros.Col = 12
                grdRegistros.Row = grdRegistros.Rows - 1
                VTSecuencial$ = grdRegistros.Text
                
    
            End If
            VTFilas% = Val(grdRegistros.Tag)
        Wend
        grdRegistros.Col = 1

    Case 1  'Limpiar
                txtCampo(0) = ""
                lblDescripcion(6).Caption = ""
                txtCampo(0).SetFocus
                PMLimpiaGrid grdRegistros
    Case 2  ' Salir
        
        Unload FConsVal

    End Select
End Sub

Private Sub Form_Load()
    FConsVal.Left = 15
    FConsVal.Top = 15
    FConsVal.Width = 9420
    FConsVal.Height = 5730
    
 PMObjetoSeguridad cmdBoton(0)
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
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

Private Sub grdRegistros_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Lista de Próximos Valores Vigentes"
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0
        VLPaso% = False
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
       FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
    Case 0
            VGOperacion$ = "sp_hp_sucursal"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4079"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", False, "") Then
             ' GBB26May98008 II:
             ' Se debe haver un load a la forma antes de cargar los valores
             Load FRegistros
             'GBB26May98008 IF:
        
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                ' PMChequea SqlConn&
                If VGValores(1) <> "" Then
                    txtCampo(0).Text = VGValores(1)
                    lblDescripcion(6).Caption = VGValores(2)
                Else
                    txtCampo(0).Text = ""
                    lblDescripcion(6).Caption = ""
                    VGOperacion$ = ""
                End If
                 
                VLPaso% = True
            Else
                txtCampo(0).Text = ""
                lblDescripcion(6).Caption = ""
                VGOperacion$ = ""
            End If
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select

End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
    Case 0
        If VLPaso% = False Then
            If txtCampo(0).Text <> "" Then
            
            
             If txtCampo(0).Text > 32000 Then
                    MsgBox "El código de sucursal fuera de rango", 0 + 16, "Mensaje de Error"
                    txtCampo(0).Text = ""
                    txtCampo(0).SetFocus
                    Exit Sub
             End If
                 
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4078"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", True, " Consulta del producto ") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(6)
                     PMChequea sqlconn&
                    
                Else
                    lblDescripcion(6).Caption = ""
                    txtCampo(0).Text = ""
                    VLPaso% = True
                End If
            Else
                lblDescripcion(6).Caption = ""
            End If
        End If
End Select
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


