VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FVarServ 
   Appearance      =   0  'Flat
   Caption         =   "Rubros del Servicio"
   ClientHeight    =   5325
   ClientLeft      =   165
   ClientTop       =   1245
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
   ForeColor       =   &H80000008&
   Icon            =   "FVARSER.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Actualizar"
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
      Index           =   4
      Left            =   8415
      Picture         =   "FVARSER.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   9
      Tag             =   "4026"
      Top             =   3030
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Crear"
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
      Picture         =   "FVARSER.frx":0614
      Style           =   1  'Graphical
      TabIndex        =   8
      Tag             =   "4025"
      Top             =   2265
      Width           =   870
   End
   Begin MSGrid.Grid grdProductos 
      Height          =   3255
      Left            =   15
      TabIndex        =   6
      Top             =   2055
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   5742
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
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   480
      Left            =   1860
      TabIndex        =   21
      Top             =   1245
      Width           =   2505
      Begin VB.OptionButton optEstado 
         Caption         =   "Vigente"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   0
         Left            =   135
         TabIndex        =   4
         Top             =   180
         Value           =   -1  'True
         Width           =   990
      End
      Begin VB.OptionButton optEstado 
         Caption         =   "No Vigente"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   1
         Left            =   1155
         TabIndex        =   5
         TabStop         =   0   'False
         Top             =   180
         Width           =   1290
      End
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
      Picture         =   "FVARSER.frx":091E
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   4560
      Width           =   875
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
      Index           =   3
      Left            =   8415
      Picture         =   "FVARSER.frx":0C84
      Style           =   1  'Graphical
      TabIndex        =   7
      Tag             =   "4017"
      Top             =   15
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
      Picture         =   "FVARSER.frx":0EE6
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   3795
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   4
      Left            =   1860
      MaxLength       =   1
      TabIndex        =   2
      Top             =   630
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   1860
      MaxLength       =   4
      TabIndex        =   0
      Top             =   30
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   315
      Index           =   1
      Left            =   1860
      MaxLength       =   40
      TabIndex        =   3
      Top             =   930
      Width           =   6495
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1860
      MaxLength       =   4
      TabIndex        =   1
      Top             =   330
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Rubros del Servicio:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   90
      TabIndex        =   20
      Top             =   1815
      Width           =   2475
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8370
      Y1              =   1770
      Y2              =   1770
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2805
      TabIndex        =   19
      Top             =   630
      Width           =   5550
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2805
      TabIndex        =   18
      Top             =   330
      Width           =   5550
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   90
      TabIndex        =   15
      Top             =   1470
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Dato:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   90
      TabIndex        =   17
      Top             =   630
      Width           =   1185
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2805
      TabIndex        =   16
      Top             =   30
      Width           =   5550
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio Disponible:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   90
      TabIndex        =   14
      Top             =   30
      Width           =   1710
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código Rubro:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   90
      TabIndex        =   13
      Top             =   330
      Width           =   1230
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Descripción:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   90
      TabIndex        =   12
      Top             =   930
      Width           =   1080
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
Attribute VB_Name = "FVarServ"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010

Dim VLPaso As Integer
'! removed Dim VLTrans As Integer


Private Sub cmdBoton_Click(Index As Integer)
Dim VTEstado$
Dim i%
Dim VTFilas%
Dim VTRubro$
    Select Case Index%
    Case 0
        
        'Crea un nuevo detalle de servicio
        If txtCampo(3).Text = "" Then
            MsgBox "El código de servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            MsgBox "El código del rubro es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        If txtCampo(4).Text = "" Then
            MsgBox "El tipo de dato es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "La descripción del rubro es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        If optEstado(0).Value = True Then
                VTEstado$ = "V"
        ElseIf optEstado(1).Value = True Then
                VTEstado$ = "N"
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4025"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_tipo_dato", 0, SQLCHAR, txtCampo(4).Text
         PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
         PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR, txtCampo(1).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_det_serv_pe", True, "Ok...Creación de Subservicio") Then
             PMChequea sqlconn&
            cmdBoton(0).Enabled = False
        End If
        cmdBoton_Click (3)
    
    Case 1
    
        'Limpiar
        
        If txtCampo(2).Text <> "" Then
        
            txtCampo(1).Text = ""
            txtCampo(2).Text = ""
            txtCampo(4).Text = ""
    
            lblDescripcion(0).Caption = ""
            lblDescripcion(2).Caption = ""

            optEstado(0).Value = True
            txtCampo(1).Enabled = True
            txtCampo(2).Enabled = True
            txtCampo(4).Enabled = True
            FPrincipal.pnlHelpLine.Caption = ""
            FPrincipal.pnlTransaccionLine.Caption = ""
            'cmdBoton(4).Enabled = False
            txtCampo(2).SetFocus
        Else
            
            For i% = 1 To 4
                txtCampo(i%).Text = ""
            Next i%
    
            For i% = 0 To 2
                lblDescripcion(i%).Caption = ""
            Next i%
            optEstado(0).Value = True
            txtCampo(2).Enabled = True
            txtCampo(3).Enabled = True
            txtCampo(4).Enabled = True
            FPrincipal.pnlHelpLine.Caption = ""
            FPrincipal.pnlTransaccionLine.Caption = ""
            PMLimpiaGrid grdProductos
            'cmdBoton(4).Enabled = False
            txtCampo(3).SetFocus
        End If
        'cmdBoton(0).Enabled = True
        PMObjetoSeguridad cmdBoton(0)
        PMObjetoSeguridad cmdBoton(4)
    Case 2 'Salir
        
        Unload FVarServ

    Case 3  'Siguientes
        
        If txtCampo(3).Text = "" Then
            MsgBox "El código de servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
         

         VTFilas% = VGMaxRows%
         VTRubro$ = "0"

         While VTFilas% = VGMaxRows%
            
              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4017"
              PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(3).Text
              PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, VTRubro$
              PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cosub", True, "Ok... Consulta de Detalle de Servicios") Then
                If VTRubro$ = "0" Then
                     PMMapeaGrid sqlconn&, grdProductos, False
                Else
                     PMMapeaGrid sqlconn&, grdProductos, True
                End If
                 PMChequea sqlconn&
                'VTFilas% = Val(grdServicios.Tag)

                grdProductos.Col = 1
                grdProductos.Row = grdProductos.Rows - 1
                VTRubro$ = grdProductos.Text
                
                ' Determinar que existan servicions bancarios
                'If Val(grdServicios.Tag) > 0 Then
                '    grdServicios.ColAlignment(5) = 1
                '    grdServicios.ColAlignment(4) = 2
                'End If
    
             End If
             VTFilas% = Val(grdProductos.Tag)
        Wend
        grdProductos.Row = 1
    

    Case 4 'Actualizar el estado y el signo, únicamente, de un detalle de
           'servicio
        
        If txtCampo(3).Text = "" Then
            MsgBox "El código de servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            MsgBox "El código del rubro es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        If txtCampo(4).Text = "" Then
            MsgBox "El tipo de dato es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If
        
        
        If optEstado(0).Value = True Then
                VTEstado$ = "V"
        ElseIf optEstado(1).Value = True Then
                VTEstado$ = "N"
        End If
        
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4026"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_tipo_dato", 0, SQLCHAR, txtCampo(4).Text
         PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
         PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR, txtCampo(1).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_det_serv_pe", True, "Ok...Actualización de Subservicio") Then
             PMChequea sqlconn&
            cmdBoton(4).Enabled = False
        End If
        cmdBoton_Click (3)
         
         
End Select
End Sub

Private Sub Form_Load()
    FVarServ.Left = 15
    FVarServ.Top = 15
    FVarServ.Width = 9420
    FVarServ.Height = 5730
'''    PMBotonSeguridad FVarServ, 4
'''    cmdBoton(0).Enabled = True
'''    cmdBoton(4).Enabled = False

       PMObjetoSeguridad cmdBoton(3)
       PMObjetoSeguridad cmdBoton(0)
       PMObjetoSeguridad cmdBoton(4)

End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdProductos_Click()

    grdProductos.Col = 0
    grdProductos.SelStartCol = 1
    grdProductos.SelEndCol = grdProductos.Cols - 1
    If grdProductos.Row = 0 Then
        grdProductos.SelStartRow = 1
        grdProductos.SelEndRow = 1
    Else
        grdProductos.SelStartRow = grdProductos.Row
        grdProductos.SelEndRow = grdProductos.Row
    End If
End Sub

Private Sub grdProductos_DblClick()
Dim VTRow%
VTRow% = grdProductos.Row
grdProductos.Row = 1
grdProductos.Col = 1
If (grdProductos.Text <> "") Then
    grdProductos.Row = VTRow%
    PMMarcarRegistro
    txtCampo(4).Enabled = False
    txtCampo(2).Enabled = False
    txtCampo(3).Enabled = False
End If
End Sub

Private Sub grdProductos_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga Doble Click para Actualizar"
End Sub

Private Sub grdProductos_KeyUp(KeyCode As Integer, Shift As Integer)
    grdProductos.Col = 0
    grdProductos.SelStartCol = 1
    grdProductos.SelEndCol = grdProductos.Cols - 1
    If grdProductos.Row = 0 Then
        grdProductos.SelStartRow = 1
        grdProductos.SelEndRow = 1
    Else
        grdProductos.SelStartRow = grdProductos.Row
        grdProductos.SelEndRow = grdProductos.Row
    End If
    
End Sub

Private Sub optEstado_GotFocus(Index As Integer)
    Select Case Index%
    Case 0, 1
        FPrincipal.pnlHelpLine.Caption = " Estado del Servicio"
    End Select

End Sub

Private Sub PMMarcarRegistro()
    cmdBoton(0).Enabled = False
    'cmdBoton(4).Enabled = True
    PMObjetoSeguridad cmdBoton(4)
    grdProductos.Col = 1
    txtCampo(2).Text = grdProductos.Text
    grdProductos.Col = 2
    lblDescripcion(0).Caption = grdProductos.Text
    grdProductos.Col = 3
    If grdProductos.Text = "P" Then
        lblDescripcion(2).Caption = "PORCENTAJE"
    Else
        lblDescripcion(2).Caption = "MONTO"
    End If
    txtCampo(4).Text = grdProductos.Text
    grdProductos.Col = 4
    If grdProductos.Text = "V" Then
        optEstado(0).Value = True
    Else
        optEstado(1).Value = True
    End If
    grdProductos.Col = 5
    txtCampo(1).Text = grdProductos.Text
    
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 2, 3, 4
        VLPaso% = False
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Descripción del detalle de Servicio"
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Rubro del Servicio [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Código del Servicio [F5 Ayuda]"
    Case 4
        FPrincipal.pnlHelpLine.Caption = " Tipo de dato [F5 Ayuda]"
    
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
            
        Case 2

            PMCatalogo "A", "pe_rubro", txtCampo(2), lblDescripcion(0)
            txtCampo(4).SetFocus
            VLPaso% = True

        Case 3
            VLPaso% = True
            VGOperacion$ = "sp_help_serv_pe"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4031"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_serv_pe", False, "Ok...Consulta de Servicios") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                txtCampo(3).Text = VGACatalogo.Codigo$
                lblDescripcion(1).Caption = VGACatalogo.Descripcion$
                If txtCampo(3).Text <> "" Then
                    cmdBoton_Click (3)
                End If
            Else
                VGOperacion$ = ""
            End If
            VLPaso% = True

            
        Case 4
            
            PMCatalogo "A", "pe_tipo_dato", txtCampo(4), lblDescripcion(2)
            txtCampo(1).SetFocus
            VLPaso% = True
        
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 2, 1, 4
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 65) Or (KeyAscii > 123)) Then
            KeyAscii% = 0
        Else
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
        
    Case 3
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
        KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
    Case 2 'Rubro
        If VLPaso% = False Then
            If txtCampo(2).Text <> "" Then
                PMCatalogo "V", "pe_rubro", txtCampo(2), lblDescripcion(0)
                txtCampo(4).SetFocus
            
            End If
         End If
    Case 3
          If VLPaso% = False Then
            If txtCampo(3).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4031"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(3).Text
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_serv_pe", False, "Ok...Consulta de Servicios") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(1)
                     PMChequea sqlconn&
                    cmdBoton_Click (3)
                Else
                    txtCampo(3).Text = ""
                    lblDescripcion(1).Caption = ""
                End If

            Else
               VLPaso% = True
               lblDescripcion(1).Caption = ""
            End If
              
        End If
    Case 4  'Tipo de dato
        If VLPaso% = False Then
            If txtCampo(4).Text <> "" Then
                PMCatalogo "V", "pe_tipo_dato", txtCampo(4), lblDescripcion(2)
                txtCampo(1).SetFocus
            Else
                txtCampo(4).Text = ""
                lblDescripcion(2).Caption = ""
            End If

        End If
    End Select

End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 2, 3, 4
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


