VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FConCostos 
   Appearance      =   0  'Flat
   Caption         =   "Consulta de Valores Vigentes "
   ClientHeight    =   5325
   ClientLeft      =   135
   ClientTop       =   1845
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
   Icon            =   "FCONCOS.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   2190
      MaxLength       =   5
      TabIndex        =   0
      Top             =   15
      Width           =   1005
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Buscar"
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
      Picture         =   "FCONCOS.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   4
      Tag             =   "4052"
      Top             =   15
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   2190
      MaxLength       =   2
      TabIndex        =   2
      Top             =   1215
      Width           =   1005
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   2190
      MaxLength       =   4
      TabIndex        =   1
      Top             =   315
      Width           =   1005
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
      Picture         =   "FCONCOS.frx":056C
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   4545
      Width           =   875
   End
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
      Picture         =   "FCONCOS.frx":08D2
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   3780
      Width           =   875
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3540
      Left            =   30
      TabIndex        =   3
      Top             =   1770
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14685
      _ExtentY        =   6245
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
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   6
      Left            =   3210
      TabIndex        =   19
      Top             =   15
      Width           =   5130
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código Sucursal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   45
      TabIndex        =   18
      Top             =   15
      Width           =   1455
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   5
      Left            =   3210
      TabIndex        =   17
      Top             =   915
      Width           =   5130
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Final:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   45
      TabIndex        =   16
      Top             =   900
      Width           =   1305
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   4
      Left            =   2190
      TabIndex        =   15
      Top             =   915
      Width           =   1005
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Valores para el Servicio"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   45
      TabIndex        =   14
      Top             =   1560
      Width           =   2775
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2190
      TabIndex        =   13
      Top             =   615
      Width           =   1005
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Categoría:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   45
      TabIndex        =   7
      Top             =   1215
      Width           =   915
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio Personalizable:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   45
      TabIndex        =   8
      Top             =   315
      Width           =   2055
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   3210
      TabIndex        =   9
      Top             =   1215
      Width           =   5130
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   3210
      TabIndex        =   10
      Top             =   315
      Width           =   5130
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Rango:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   45
      TabIndex        =   11
      Top             =   615
      Width           =   1335
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   3210
      TabIndex        =   12
      Top             =   615
      Width           =   5130
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
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   -60
      X2              =   8355
      Y1              =   1530
      Y2              =   1530
   End
End
Attribute VB_Name = "FConCostos"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer

Private Sub cmdBoton_Click(Index As Integer)
Dim VTFilas%
Dim VTRango$
Dim VTCategoria$
    Select Case Index%
    
    Case 0

        'Siguientes
        ' Si la consulta es para todos los costos del servicio
        If txtCampo(0).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

        If txtCampo(3).Text = "" Then
            MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
                VTFilas% = VGMaxRows%
                VTRango$ = "0"
                VTCategoria$ = "0"
                While VTFilas% = VGMaxRows%
        
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4052"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, txtCampo(3).Text
                 PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, VTCategoria$
                 PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, VTRango$
                
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_costos", True, "Ok...Consulta de Costos por Categoría") Then
                    If VTRango$ = "0" Then
                         PMMapeaGrid sqlconn&, grdRegistros, False
                    Else
                         PMMapeaGrid sqlconn&, grdRegistros, True
                    End If
        
                     PMChequea sqlconn&
                    If Val(grdRegistros.Tag) > 0 Then
                        grdRegistros.ColAlignment(5) = 1
                        grdRegistros.ColAlignment(6) = 1
                        grdRegistros.ColAlignment(7) = 1
                        grdRegistros.ColAlignment(8) = 1
                        grdRegistros.ColAlignment(9) = 1
                        grdRegistros.ColAlignment(10) = 2


                    End If
                    grdRegistros.Col = 1
                    grdRegistros.Row = grdRegistros.Rows - 1
                    VTCategoria$ = grdRegistros.Text
                    
                    grdRegistros.Col = 4
                    grdRegistros.Row = grdRegistros.Rows - 1
                    VTRango$ = grdRegistros.Text
        
                End If
                VTFilas% = Val(grdRegistros.Tag)
            Wend
            grdRegistros.Col = 1
        Exit Sub
        End If
        ' Si la consulta es para una categoría dada
         
            VTFilas% = VGMaxRows%
            VTRango$ = "0"
            While VTFilas% = VGMaxRows%
                
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4052"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "I"
             PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, txtCampo(3).Text
             PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
             PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT2, lblDescripcion(2).Caption
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, VTRango$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_costos", True, "Ok...Consulta de Costos por Categoría") Then
                If VTRango$ = "0" Then
                     PMMapeaGrid sqlconn&, grdRegistros, False
                Else
                     PMMapeaGrid sqlconn&, grdRegistros, True
                End If
    
                 PMChequea sqlconn&
                If Val(grdRegistros.Tag) > 0 Then
                    grdRegistros.ColAlignment(3) = 1
                    grdRegistros.ColAlignment(4) = 1
                    grdRegistros.ColAlignment(5) = 1
                    grdRegistros.ColAlignment(6) = 1
                    grdRegistros.ColAlignment(7) = 1
                    grdRegistros.ColAlignment(8) = 2


                End If
    
                grdRegistros.Col = 2
                grdRegistros.Row = grdRegistros.Rows - 1
                VTRango$ = grdRegistros.Text
    
            End If
            VTFilas% = Val(grdRegistros.Tag)
        Wend
        grdRegistros.Col = 1
    
    Case 1 'Limpiar
        
        If txtCampo(2) <> "" Then
            txtCampo(2).Text = ""
            lblDescripcion(3).Caption = ""
            txtCampo(2).SetFocus
        Else
            If txtCampo(3).Text <> "" Then
                txtCampo(3).Text = ""
                lblDescripcion(0).Caption = ""
                lblDescripcion(1).Caption = ""
                lblDescripcion(2).Caption = ""
                lblDescripcion(4).Caption = ""
                lblDescripcion(5).Caption = ""
                
                PMLimpiaGrid grdRegistros
                txtCampo(3).SetFocus
            Else
                txtCampo(0) = ""
                lblDescripcion(6).Caption = ""
                txtCampo(0).SetFocus
            End If
        End If
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""

    Case 2  ' Salir
        
        Unload FConCostos

    End Select
End Sub

Private Sub Form_Load()
    FConCostos.Left = 15
    FConCostos.Top = 15
    FConCostos.Width = 9420
    FConCostos.Height = 5730
    
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
    FPrincipal.pnlHelpLine.Caption = " Lista de Costos Servicios"
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 2, 3
        VLPaso% = False
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
       FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Categoría [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Código del Servicio [F5 Ayuda]"
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
            
        Case 2
            VGOperacion$ = "sp_help_costos"
            VGTipo$ = "C"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4058"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "C"
             PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, txtCampo(3).Text
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_costos", False, "Ok...Consulta de Servicios") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                If VGACatalogo.Codigo$ <> "" Then
                    txtCampo(2).Text = VGACatalogo.Codigo$
                    lblDescripcion(3).Caption = VGACatalogo.Descripcion$
                    VLPaso% = True
                End If
            End If

        Case 3
            VGOperacion$ = "sp_help_costos"
            VGTipo$ = "S"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4058"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_costos", False, "Ok...Consulta de Servicios") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                If VGValores(1) <> "" Then
                    txtCampo(3).Text = VGValores(1)
                    lblDescripcion(0).Caption = VGValores(2)
                    lblDescripcion(2).Caption = VGValores(3)
                    lblDescripcion(4).Caption = VGValores(4)
                    lblDescripcion(5).Caption = VGValores(5)
                    If lblDescripcion(2).Caption = "" Then
                        Exit Sub
                    End If
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                     PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
                     PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, lblDescripcion(2).Caption
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                         PMMapeaObjeto sqlconn&, lblDescripcion(1)
                         PMChequea sqlconn&
                    End If
                End If
            Else
                VGOperacion$ = ""
                VGTipo$ = ""
                End If
            VLPaso% = True
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 2
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
            KeyAscii% = 0
        Else
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
    Case 0, 1, 3
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR%
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
        
Case 2
        If VLPaso% = False Then
            If txtCampo(2).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4058"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "C"
                 PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
                 PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, txtCampo(3).Text
                
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_costos", False, "Ok...Consulta de Servicios") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(3)
                     PMChequea sqlconn&
                Else
                    txtCampo(2).Text = ""
                    lblDescripcion(3).Caption = ""
                    txtCampo(2).SetFocus
                End If
                
            Else
                lblDescripcion(3).Caption = ""
            End If
         End If


    Case 3
        If VLPaso% = False Then
            If txtCampo(3).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4058"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "S"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
                 PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, txtCampo(3).Text
                ReDim Valores(10) As String
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_costos", False, "Ok...Consulta de Servicios") Then
                     VTR% = FMMapeaArreglo(sqlconn&, Valores())
                     PMChequea sqlconn&
                     
                    lblDescripcion(0).Caption = Valores(1)
                    lblDescripcion(2).Caption = Valores(2)
                    lblDescripcion(4).Caption = Valores(3)
                    lblDescripcion(5).Caption = Valores(4)
                    
                    If lblDescripcion(2).Caption = "" Then
                        Exit Sub
                    End If
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                     PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
                     PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, lblDescripcion(2).Caption
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                         PMMapeaObjeto sqlconn&, lblDescripcion(1)
                         PMChequea sqlconn&
                    Else
                        txtCampo(3).Text = ""
                        lblDescripcion(0).Caption = ""
                        lblDescripcion(1).Caption = ""
                        lblDescripcion(2).Caption = ""
                        lblDescripcion(4).Caption = ""
                        lblDescripcion(5).Caption = ""

                    End If
                Else
                    txtCampo(3).Text = ""
                    lblDescripcion(1).Caption = ""
                    lblDescripcion(2).Caption = ""
                    lblDescripcion(0).Caption = ""
                        lblDescripcion(4).Caption = ""
                        lblDescripcion(5).Caption = ""

                End If
            End If
        End If
    End Select
End Sub



