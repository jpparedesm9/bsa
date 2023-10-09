VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FTipRango 
   Appearance      =   0  'Flat
   Caption         =   "Tipos de Rango"
   ClientHeight    =   5325
   ClientLeft      =   150
   ClientTop       =   1605
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
   Icon            =   "FTIPRAN1.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1485
      MaxLength       =   4
      TabIndex        =   1
      Top             =   615
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1485
      MaxLength       =   4
      TabIndex        =   0
      Top             =   315
      Width           =   930
   End
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
      Left            =   8400
      Picture         =   "FTIPRAN1.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   8
      Tag             =   "4033"
      Top             =   3015
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
      Left            =   8400
      Picture         =   "FTIPRAN1.frx":0614
      Style           =   1  'Graphical
      TabIndex        =   7
      Tag             =   "4032"
      Top             =   2280
      Width           =   870
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
      Left            =   8400
      Picture         =   "FTIPRAN1.frx":091E
      Style           =   1  'Graphical
      TabIndex        =   5
      Tag             =   "4034"
      Top             =   0
      Width           =   870
   End
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   435
      Left            =   1485
      TabIndex        =   14
      Top             =   1215
      Width           =   2430
      Begin VB.OptionButton optEstado 
         Caption         =   "No Vigente"
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   1
         Left            =   1110
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   150
         Width           =   1230
      End
      Begin VB.OptionButton optEstado 
         Caption         =   "Vigente"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   0
         Left            =   90
         TabIndex        =   3
         Top             =   135
         Value           =   -1  'True
         Width           =   990
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1485
      MaxLength       =   40
      TabIndex        =   2
      Top             =   915
      Width           =   6855
   End
   Begin MSGrid.Grid grdRangos 
      Height          =   3375
      Left            =   15
      TabIndex        =   6
      Top             =   1935
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14685
      _ExtentY        =   5954
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
      Left            =   8400
      Picture         =   "FTIPRAN1.frx":0B80
      Style           =   1  'Graphical
      TabIndex        =   10
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
      Left            =   8400
      Picture         =   "FTIPRAN1.frx":0EE6
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   3780
      Width           =   875
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Moneda:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   20
      Top             =   615
      Width           =   750
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2430
      TabIndex        =   19
      Top             =   615
      Width           =   5910
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2430
      TabIndex        =   13
      Top             =   315
      Width           =   5910
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Atributo:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   60
      TabIndex        =   15
      Top             =   315
      Width           =   1170
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   1485
      TabIndex        =   11
      Top             =   15
      Width           =   930
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
      TabIndex        =   18
      Top             =   1290
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Rango:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   60
      TabIndex        =   17
      Top             =   15
      Width           =   1065
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Descripción:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   16
      Top             =   915
      Width           =   1080
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Tipos de Rango:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   45
      TabIndex        =   12
      Top             =   1695
      Width           =   2160
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8370
      Y1              =   1680
      Y2              =   1680
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8370
      X2              =   8370
      Y1              =   0
      Y2              =   5385
   End
End
Attribute VB_Name = "FTipRango"
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
Dim VTTipoRango$
    Select Case Index%
    Case 0

        'Crear un nuevo servicio disponible
        If txtCampo(0).Text = "" Then
            MsgBox "El tipo de atributo es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "El código de moneda es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        If txtCampo(2).Text = "" Then
            MsgBox "La descripción del tipo de rango es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If


        If optEstado(0).Value = True Then
            VTEstado$ = "V"
        ElseIf optEstado(1).Value = True Then
            VTEstado$ = "N"
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4032"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
         PMPasoValores sqlconn&, "@i_atributo", 0, SQLCHAR, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, txtCampo(1).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tip_rng_pe", True, " Ok... Creación de Tipo de Rango") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(1)
             PMChequea sqlconn&
            cmdBoton(0).Enabled = False
            cmdBoton_Click (3)
        End If

    Case 1

        'Limpiar
        
        
        txtCampo(2).Text = ""
        txtCampo(1).Text = ""
        txtCampo(1).Enabled = True
        txtCampo(0).Text = ""
        txtCampo(0).Enabled = True
        lblDescripcion(0).Caption = ""
        lblDescripcion(1).Caption = ""
        lblDescripcion(2).Caption = ""
        optEstado(0).Value = True
        
        PMObjetoSeguridad cmdBoton(0)
        PMObjetoSeguridad cmdBoton(4)
        
        'cmdBoton(4).Enabled = False
        'cmdBoton(0).Enabled = True
        
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        cmdBoton_Click (3)
        txtCampo(0).SetFocus
    Case 2

        'Salir

        Unload FTipRango

    Case 3
         'Siguientes 20 en el grid
         VTFilas% = VGMaxRows%
         VTTipoRango$ = "0"

         While VTFilas% = VGMaxRows%
            
              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4034"
              PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
              PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT2, VTTipoRango$
              If txtCampo(0).Text <> "" Then
                PMPasoValores sqlconn&, "@i_atributo", 0, SQLCHAR, txtCampo(0).Text
              End If
              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tip_rng_pe", True, "Ok... Consulta de Tipos de Rango") Then
                If VTTipoRango$ = "0" Then
                     PMMapeaGrid sqlconn&, grdRangos, False
                Else
                     PMMapeaGrid sqlconn&, grdRangos, True
                End If
                 PMChequea sqlconn&
                If Val(grdRangos.Tag) > 0 Then
                    grdRangos.ColAlignment(7) = 2
                End If
                VTFilas% = Val(grdRangos.Tag)

                grdRangos.Col = 1
                grdRangos.Row = grdRangos.Rows - 1
                VTTipoRango$ = grdRangos.Text
                
                ' Determinar que existan servicions bancarios
    
             End If

        Wend
        grdRangos.Row = 1
    


    Case 4
   
        'Actualizar
        If txtCampo(0).Text = "" Then
            MsgBox "El tipo de atributo es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "El código de moneda es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        
        If txtCampo(2).Text = "" Then
            MsgBox "La descripción del tipo de rango es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        

        If optEstado(0).Value = True Then
                VTEstado$ = "V"
        ElseIf optEstado(1).Value = True Then
                VTEstado$ = "N"
        End If
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4033"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
         PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
         PMPasoValores sqlconn&, "@i_atributo", 0, SQLCHAR, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT2, lblDescripcion(1).Caption
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, txtCampo(1).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tip_rng_pe", True, " Ok... Actualización de Tipo de Rango") Then
             PMChequea sqlconn&
            cmdBoton(4).Enabled = False
            cmdBoton_Click (3)
        End If
                            

    End Select
End Sub

Private Sub Form_Load()

    '*********************************************************
    'Objetivo:  Carga la forma que se encargara de actualizar
    '           y crear Rangos disponibles
    '*********************************************************
    '                    MODIFICACIONES
    'FECHA      AUTOR               RAZON
    '---------  A.Rodriguez         Emisión Inicial
    '06/Ene/95  J.Bucheli           Revisión General
    '*********************************************************

    ' Coordenadas para el despliegue de la forma
    
    FTipRango.Left = 15
    FTipRango.Top = 15
    FTipRango.Width = 9420
    FTipRango.Height = 5800

    ' Rutina de seguridad para los botones de Inserción y
    ' Actualizacion
    
    '''    PMBotonSeguridad FTipRango, 4
    '''    cmdBoton(4).Enabled = False
    PMObjetoSeguridad cmdBoton(3)
    PMObjetoSeguridad cmdBoton(0)
    PMObjetoSeguridad cmdBoton(4)
    
    cmdBoton_Click (3)
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdRangos_Click()
    grdRangos.Col = 0
    grdRangos.SelStartCol = 1
    grdRangos.SelEndCol = grdRangos.Cols - 1
    If grdRangos.Row = 0 Then
        grdRangos.SelStartRow = 1
        grdRangos.SelEndRow = 1
    Else
        grdRangos.SelStartRow = grdRangos.Row
        grdRangos.SelEndRow = grdRangos.Row
    End If


End Sub

Private Sub grdRangos_DblClick()
Dim VTRow%
VTRow% = grdRangos.Row
grdRangos.Row = 1
grdRangos.Col = 1

If (grdRangos.Text <> "") Then
  grdRangos.Row = VTRow%
  PMMarcarRegistro
  txtCampo(0).Enabled = False
  txtCampo(1).Enabled = False
End If
End Sub

Private Sub grdRangos_GotFocus()
 FPrincipal.pnlHelpLine.Caption = " Haga doble click para actualizar"
End Sub

Private Sub grdRangos_KeyUp(KeyCode As Integer, Shift As Integer)
    grdRangos.Col = 0
    grdRangos.SelStartCol = 1
    grdRangos.SelEndCol = grdRangos.Cols - 1
    If grdRangos.Row = 0 Then
        grdRangos.SelStartRow = 1
        grdRangos.SelEndRow = 1
    Else
        grdRangos.SelStartRow = grdRangos.Row
        grdRangos.SelEndRow = grdRangos.Row
    End If


End Sub

Private Sub optEstado_GotFocus(Index As Integer)
    Select Case Index%
    Case 0, 1
        FPrincipal.pnlHelpLine.Caption = " Estado del Tipo de Rango"
    End Select

End Sub

Private Sub PMMarcarRegistro()

    PMObjetoSeguridad cmdBoton(4)
    'cmdBoton(4).Enabled = True
    cmdBoton(0).Enabled = False
    grdRangos.Col = 1
    lblDescripcion(1).Caption = grdRangos.Text
    
    grdRangos.Col = 2
    txtCampo(2).Text = grdRangos.Text
    
    grdRangos.Col = 3
    txtCampo(0).Text = grdRangos.Text
    
    grdRangos.Col = 4
    lblDescripcion(0).Caption = grdRangos.Text
    
    grdRangos.Col = 5
    txtCampo(1).Text = grdRangos.Text
    
    grdRangos.Col = 6
    lblDescripcion(2).Caption = grdRangos.Text

    grdRangos.Col = 7
    If grdRangos.Text = "V" Then
        optEstado(0).Value = True
    Else
        optEstado(1).Value = True
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
Select Case Index%
    Case 0, 1
        VLPaso% = False
End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Tipo de Atributo [F5 Ayuda]"
    Case 1
       FPrincipal.pnlHelpLine.Caption = " Moneda [F5 Ayuda]"
    
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Descripción del Tipo de Rango"
    End Select

    ' Resalta el contenido del objeto
    
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
If KeyCode% = VGTeclaAyuda% Then
    VLPaso% = True

    Select Case Index%
    Case 0
        PMCatalogo "A", "pe_tipo_atributo", txtCampo(0), lblDescripcion(0)
        VLPaso% = True
    Case 1
        VGOperacion$ = "sp_moneda"
        ' GBB26May98008 II:
        ' Se debe haver un load a la forma antes de cargar los valores
          Load FRegistros
        'GBB26May98008 IF:
        
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_moneda"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de monedas") Then
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
             PMChequea sqlconn&
            FRegistros.Show 1
            If VGACatalogo.Codigo$ <> "" Then
                txtCampo(1).Text = VGACatalogo.Codigo$
                lblDescripcion(2).Caption = VGACatalogo.Descripcion$
                VLPaso% = True
            End If
        Else
        VGOperacion$ = ""
        End If

    End Select
End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
 Select Case Index%
    Case 0, 2
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
            KeyAscii% = 0
        Else
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
    Case 1
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii% = 0
        Else
        KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Select Case Index%
Case 0
    If VLPaso% = False Then
        If txtCampo(0).Text <> "" Then
            PMCatalogo "V", "pe_tipo_atributo", txtCampo(0), lblDescripcion(0)
        End If
    End If
Case 1
    If VLPaso% = False Then
        If txtCampo(1).Text <> "" Then
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_moneda"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(1).Text)
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la moneda " & "[" & txtCampo(Index%).Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(2)
                 PMChequea sqlconn&
            Else
                VLPaso% = True
                txtCampo(1).Text = ""
                lblDescripcion(2).Caption = ""
                txtCampo(1).SetFocus
            End If
        Else
            lblDescripcion(2).Caption = ""
            
        End If
    End If

End Select
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


