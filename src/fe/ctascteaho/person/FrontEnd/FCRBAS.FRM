VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FCreaBas 
   Appearance      =   0  'Flat
   Caption         =   "Servicios Básicos"
   ClientHeight    =   5325
   ClientLeft      =   60
   ClientTop       =   1860
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
   Icon            =   "FCRBAS.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1635
      MaxLength       =   3
      TabIndex        =   0
      Top             =   15
      Width           =   1020
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "Sig&tes."
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
      Index           =   6
      Left            =   8415
      Picture         =   "FCRBAS.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   5
      Top             =   780
      Width           =   875
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Crear"
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
      Picture         =   "FCRBAS.frx":053C
      Style           =   1  'Graphical
      TabIndex        =   6
      Tag             =   "4040"
      Top             =   2265
      Visible         =   0   'False
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Actualizar"
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
      Picture         =   "FCRBAS.frx":0846
      Style           =   1  'Graphical
      TabIndex        =   7
      Tag             =   "4042"
      Top             =   3030
      Visible         =   0   'False
      Width           =   870
   End
   Begin MSGrid.Grid grdServicios 
      Height          =   3900
      Left            =   15
      TabIndex        =   11
      Top             =   1410
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   6880
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
      Left            =   1650
      TabIndex        =   10
      Top             =   600
      Width           =   2745
      Begin VB.OptionButton optEstado 
         Caption         =   "No Vigente"
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   1
         Left            =   1350
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   180
         Width           =   1230
      End
      Begin VB.OptionButton optEstado 
         Caption         =   "Vigente"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   0
         Left            =   195
         TabIndex        =   2
         Top             =   165
         Value           =   -1  'True
         Width           =   990
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1635
      MaxLength       =   4
      TabIndex        =   1
      Top             =   315
      Width           =   1020
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
      Picture         =   "FCRBAS.frx":0B50
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   4560
      Width           =   875
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
      Index           =   3
      Left            =   8415
      Picture         =   "FCRBAS.frx":0EB6
      Style           =   1  'Graphical
      TabIndex        =   4
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
      Picture         =   "FCRBAS.frx":1118
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   3795
      Width           =   875
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Mercado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   12
      Top             =   15
      Width           =   810
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2670
      TabIndex        =   14
      Top             =   15
      Width           =   5685
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Servicios Básicos"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   17
      Top             =   1155
      Width           =   2250
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2670
      TabIndex        =   16
      Top             =   315
      Width           =   5685
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Serv. Disponible:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   60
      TabIndex        =   15
      Top             =   315
      Width           =   1470
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   13
      Top             =   615
      Width           =   660
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   0
      X2              =   8385
      Y1              =   1095
      Y2              =   1110
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
Attribute VB_Name = "FCreaBas"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer

Private Sub cmdBoton_Click(Index As Integer)
Dim VTEstado$
Dim VTFilas%
Dim VTMercado$
Dim VTServicio$
    Select Case Index%
    Case 0
        
        'Crear un nuevo servicio básico

        ' Verifica mandatoriedades

        If txtCampo(0).Text = "" Then
            MsgBox "El código de servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "El código de mercado es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        
        ' Determina el estado del servicio básico

        If optEstado(0).Value = True Then
                VTEstado$ = "V"
        Else
                VTEstado$ = "N"
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4040"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_mercado", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_basico_pe", True, "Ok...Creación de Servicios") Then
             PMChequea sqlconn&
            cmdBoton(0).Enabled = False
            cmdBoton_Click (3)
        End If
    Case 1 'Limpiar
        If txtCampo(0).Text <> "" Then
            txtCampo(0).Text = ""
            lblDescripcion(1).Caption = ""
            txtCampo(0).Enabled = True
            txtCampo(0).SetFocus
        Else
            txtCampo(1).Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(1).Enabled = True
            txtCampo(1).SetFocus
        End If

        optEstado(0).Value = True
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        cmdBoton(0).Enabled = True
        cmdBoton(4).Enabled = False
        cmdBoton_Click (3)
        
        
    Case 2 'Salir
        Unload FCreaBas
    Case 3  'Buscar con siguientes automáticos
         VTFilas% = VGMaxRows%
         VTMercado$ = "0"
         VTServicio$ = "0"

         While VTFilas% = VGMaxRows%
            
            
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4041"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_mercado", 0, SQLINT2, VTMercado$
             PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, VTServicio$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_basico_pe", True, "Ok... Consulta de Servicios") Then
                If VTMercado$ = "0" And VTServicio$ = "0" Then
                     PMMapeaGrid sqlconn&, grdServicios, False
                Else
                     PMMapeaGrid sqlconn&, grdServicios, True
                End If

                 PMChequea sqlconn&

                grdServicios.Col = 1
                grdServicios.Row = grdServicios.Rows - 1
                VTMercado$ = grdServicios.Text
                grdServicios.Col = 3
                grdServicios.Row = grdServicios.Rows - 1
                VTServicio$ = grdServicios.Text

                If Val(grdServicios.Tag) > 0 Then
                    'cmdBoton(3).Enabled = True
                    grdServicios.ColAlignment(5) = 2
                End If
               
            End If
            VTFilas% = Val(grdServicios.Tag)
        Wend
        grdServicios.Col = 1
         

    Case 4

        ' Actualizar el estado del servicio
        
        If txtCampo(0).Text = "" Then
            MsgBox "El código de servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "El código de mercado es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        
        If optEstado(0).Value = True Then
                VTEstado$ = "V"
        Else
                VTEstado$ = "N"
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4042"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
         PMPasoValores sqlconn&, "@i_mercado", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_basico_pe", True, "Ok...Actualización de Servicios") Then
             PMChequea sqlconn&
            cmdBoton(4).Enabled = False
            cmdBoton_Click (3)
        End If

    End Select
End Sub

Private Sub Form_Load()
    FCreaBas.Left = 15
    FCreaBas.Top = 15
    FCreaBas.Width = 9420
    FCreaBas.Height = 5730
    'PMBotonSeguridad FCreaBas, 4
    'cmdBoton(4).Enabled = False

 PMObjetoSeguridad cmdBoton(3)
 PMObjetoSeguridad cmdBoton(6)
 PMObjetoSeguridad cmdBoton(0)
 PMObjetoSeguridad cmdBoton(4)

    cmdBoton_Click (3)
   
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdServicios_Click()
    grdServicios.Col = 0
    grdServicios.SelStartCol = 1
    grdServicios.SelEndCol = grdServicios.Cols - 1
    If grdServicios.Row = 0 Then
        grdServicios.SelStartRow = 1
        grdServicios.SelEndRow = 1
    Else
        grdServicios.SelStartRow = grdServicios.Row
        grdServicios.SelEndRow = grdServicios.Row
    End If

End Sub

Private Sub grdServicios_DblClick()
    Dim VTRow%
    
    VTRow% = grdServicios.Row

    grdServicios.Col = 1
    grdServicios.Row = 1

    ' Determinar si existen servicios básicos
    
    If (grdServicios.Text <> "") Then

        grdServicios.Row = VTRow%
        PMMarcarRegistro
        cmdBoton(4).Enabled = True
        cmdBoton(0).Enabled = False
        txtCampo(0).Enabled = False
        txtCampo(1).Enabled = False
    End If

End Sub

Private Sub grdServicios_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga Doble Click para Actualizar"
End Sub

Private Sub grdServicios_KeyUp(KeyCode As Integer, Shift As Integer)
    grdServicios.Col = 0
    grdServicios.SelStartCol = 1
    grdServicios.SelEndCol = grdServicios.Cols - 1
    If grdServicios.Row = 0 Then
        grdServicios.SelStartRow = 1
        grdServicios.SelEndRow = 1
    Else
        grdServicios.SelStartRow = grdServicios.Row
        grdServicios.SelEndRow = grdServicios.Row
    End If

End Sub

Private Sub optEstado_GotFocus(Index As Integer)
    
    ' Despliega mensaje en la barra de ayuda

    Select Case Index%
    Case 0, 1
        FPrincipal.pnlHelpLine.Caption = " Estado del Servicio"
    End Select

End Sub

 Private Sub PMMarcarRegistro()
    
    grdServicios.Col = 1
    txtCampo(1).Text = grdServicios.Text
    
    grdServicios.Col = 2
    lblDescripcion(0).Caption = grdServicios.Text
    
    grdServicios.Col = 3
    txtCampo(0).Text = grdServicios.Text
    
    grdServicios.Col = 4
    lblDescripcion(1).Caption = grdServicios.Text
    
    grdServicios.Col = 5
    If grdServicios.Text = "V" Then
        optEstado(0).Value = True
    Else
        optEstado(1).Value = True
    End If
 

End Sub

Private Sub txtCampo_Change(Index As Integer)
    
    ' Determina si ha cambiado el contenido del campo

    Select Case Index%
    Case 0, 1
        VLPaso% = False
    End Select
    
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    
    'Despliega mensaje en la barra de ayuda

    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Código del Servicio [F5 Ayuda]"
    Case 1
       FPrincipal.pnlHelpLine.Caption = " Código del Mercado [F5 Ayuda]"
    End Select
    
    'Marca el contenido del texto

    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    ' Determina si se ha presionado la tecla F5

    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
        Case 0
            ' Consulta de Servicios Disponibles
            VGOperacion$ = "sp_help_serv_pe"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4031"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT4, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_serv_pe", False, "Ok...Consulta de Servicios") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                txtCampo(0).Text = VGACatalogo.Codigo$
                lblDescripcion(1).Caption = VGACatalogo.Descripcion$
                VLPaso% = True
            Else
            VGOperacion$ = ""
            End If
            

        Case 1
            
            'Consulta de mercado y descripción del producto bancario asociado

            
            VGOperacion$ = "sp_prodfin"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4012"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", False, "") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                If VGValores(1) <> "" Then
    
                    txtCampo(1).Text = VGValores(1)
                    lblDescripcion(0).Caption = VGValores(2) & " " & VGValores(3)
                End If
                VLPaso% = True
                
            Else
            VGOperacion$ = ""
            End If
            
        
End Select
End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    
    ' Valida que se ingresen los datos requeridos

    Select Case Index%
    Case 0, 1
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    
    'Consulta por valor; si se ha ingresado algo en el campo

    Select Case Index%
    Case 0
        
        ' Consulta de la descripción del servicio ingresado
       If VLPaso% = False Then
        If txtCampo(0).Text <> "" Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4031"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_serv_pe", False, "") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(1)
                 PMChequea sqlconn&

            Else
                lblDescripcion(1).Caption = ""
                txtCampo(0).Text = ""
                txtCampo(0).SetFocus
                
            End If
        Else
            lblDescripcion(1).Caption = ""
        End If
    End If
    Case 1
        
        'Consulta de la descripción del producto bancario asociado al
        'mercado ingresado
        If VLPaso% = False Then
        If txtCampo(1).Text <> "" Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4045"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
             PMPasoValores sqlconn&, "@i_cod_merc", 0, SQLINT2, txtCampo(1).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&

            Else
                lblDescripcion(0).Caption = ""
                txtCampo(1).Text = ""
                txtCampo(1).SetFocus
            End If
        Else
            lblDescripcion(0).Caption = ""
        End If
        End If
End Select

End Sub



