VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FTrprobaen 
   Appearance      =   0  'Flat
   Caption         =   "Mercado "
   ClientHeight    =   5325
   ClientLeft      =   150
   ClientTop       =   1545
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
   HelpContextID   =   190
   Icon            =   "FPRBAEN.frx":0000
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
      Left            =   1455
      MaxLength       =   3
      TabIndex        =   0
      Top             =   315
      Width           =   930
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
      Picture         =   "FPRBAEN.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   5
      Tag             =   "4004"
      Top             =   2250
      Width           =   870
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
      Left            =   8415
      Picture         =   "FPRBAEN.frx":0614
      Style           =   1  'Graphical
      TabIndex        =   6
      Tag             =   "4005"
      Top             =   3015
      Width           =   870
   End
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   460
      Left            =   1470
      TabIndex        =   10
      Top             =   900
      Width           =   2775
      Begin VB.OptionButton optBoton 
         Caption         =   "No Vigente"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   1
         Left            =   1440
         TabIndex        =   3
         TabStop         =   0   'False
         Top             =   165
         Width           =   1305
      End
      Begin VB.OptionButton optBoton 
         Caption         =   "Vigente"
         ForeColor       =   &H00800000&
         Height          =   285
         Index           =   0
         Left            =   60
         TabIndex        =   2
         Top             =   135
         Value           =   -1  'True
         Width           =   1125
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1455
      MaxLength       =   3
      TabIndex        =   1
      Top             =   615
      Width           =   930
   End
   Begin MSGrid.Grid grdProductos 
      Height          =   3690
      Left            =   15
      TabIndex        =   9
      Top             =   1620
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   6509
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
      Picture         =   "FPRBAEN.frx":091E
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   3780
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
      Picture         =   "FPRBAEN.frx":0C84
      Style           =   1  'Graphical
      TabIndex        =   4
      Tag             =   "4006"
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
      Picture         =   "FPRBAEN.frx":0EE6
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   4545
      Width           =   875
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Sector:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   17
      Top             =   315
      Width           =   1335
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   2400
      TabIndex        =   20
      Top             =   315
      Width           =   5955
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   60
      TabIndex        =   11
      Top             =   1050
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Cod. Mercado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   12
      Top             =   15
      Width           =   1260
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Prod.Bancario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   13
      Top             =   615
      Width           =   1275
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Último Cambio Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   5070
      TabIndex        =   14
      Top             =   1080
      Width           =   1920
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   7065
      TabIndex        =   16
      Top             =   1080
      Width           =   1290
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   2
      Left            =   2400
      TabIndex        =   18
      Top             =   615
      Width           =   5955
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   1455
      TabIndex        =   19
      Top             =   15
      Width           =   930
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   15
      X2              =   8385
      Y1              =   1410
      Y2              =   1410
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Mercados Asociados"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   45
      TabIndex        =   15
      Top             =   1425
      Width           =   2505
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
Attribute VB_Name = "FTrprobaen"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
'! removed Dim VLTrans As Integer

Dim VLEnte As String

Private Sub cmdBoton_Click(Index As Integer)
Dim VTEstado$
Dim VTFilas%
Dim VTCodigo$
Dim VTTipo$
    Select Case Index%
    Case 0
        'Crear nuevo mercado

        ' Este control determina el estado del producto
        If optBoton(0).Value = True Then
            VTEstado$ = "V"
        Else
            VTEstado$ = "N"
        End If

        ' Validacion de mandatoriedades
        If txtCampo(0).Text = "" Then
            MsgBox "El tipo de sector es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "El código del producto es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        ' Si es verdadero es insercion de productos bancarios
        ' Si es falso es actualización de productos bancarios

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4004"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
         PMPasoValores sqlconn&, "@i_cod_prod", 0, SQLINT2, txtCampo(1).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mercado", True, "Creación de Producto") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(3)
            cmdBoton(0).Enabled = False
             PMChequea sqlconn&
            cmdBoton_Click (3)
        End If
    

    Case 1

        'Limpiar

        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        lblDescripcion(0).Caption = ""
        lblDescripcion(1).Caption = ""
        lblDescripcion(2).Caption = ""
        lblDescripcion(3).Caption = ""
        
        optBoton(0).Value = True
        cmdBoton(0).Enabled = True
        If txtCampo(0).Enabled = False Then
            txtCampo(0).Enabled = True
        End If

        If txtCampo(1).Enabled = False Then
            txtCampo(1).Enabled = True
        End If
        
        PMObjetoSeguridad cmdBoton(0)
        PMObjetoSeguridad cmdBoton(4)
        'cmdBoton_Click (3)

        txtCampo(0).SetFocus
        PMLimpiaGrid grdProductos

    Case 2
        
        'Salir
         
         Unload FTrprobaen

    Case 3    'Buscar
        If txtCampo(0).Text = "" Then
            MsgBox "El tipo de sector es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
         
        VTFilas% = VGMaxRows%
        VTCodigo$ = "0"
        VTTipo$ = "0"
        While VTFilas% = VGMaxRows%
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4006"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_mercado", 0, SQLINT2, VTCodigo$
             PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, txtCampo(0).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mercado", True, "Ok... Consulta de Productos") Then
                If VTCodigo$ = "0" Then
                     PMMapeaGrid sqlconn&, grdProductos, False
                Else
                     PMMapeaGrid sqlconn&, grdProductos, True
                End If
                 PMChequea sqlconn&
                VTFilas% = Val(grdProductos.Tag)
                
                grdProductos.Col = 1
                grdProductos.Row = grdProductos.Rows - 1
                VTCodigo$ = grdProductos.Text
                If Val(grdProductos.Tag) > 0 Then
                    grdProductos.ColAlignment(4) = 2
                    grdProductos.ColAlignment(5) = 2
                End If
            
            End If
        Wend
        grdProductos.Row = 1
    
    Case 4

         'Escoger

        If optBoton(0).Value = True Then
            VTEstado$ = "V"
        ElseIf optBoton(1).Value = True Then
            VTEstado$ = "N"
        End If

        ' Validacion de mandatoriedades
        If txtCampo(0).Text = "" Then
            MsgBox "El tipo de sector es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "El código del producto es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        ' Si es verdadero es insecion de productos bancarios
        ' Si es falso es actualización de productos bancarios

        'Actualizar

             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4005"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
             PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
             PMPasoValores sqlconn&, "@i_cod_prod", 0, SQLINT2, txtCampo(1).Text
             'PMPasoValores SqlConn&, "@i_modo", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mercado", True, "Actualización de Productos") Then
                 PMChequea sqlconn&
                cmdBoton(4).Enabled = False
                cmdBoton_Click (3)
            End If
    End Select
End Sub

Private Sub Form_Load()
    FTrprobaen.Left = 15
    FTrprobaen.Top = 15
    FTrprobaen.Width = 9420
    FTrprobaen.Height = 5900
    
    PMBotonSeguridad FTrprobaen, 4
''    cmdBoton(0).Enabled = True
''    cmdBoton(4).Enabled = False
    'optEnte(0).Value = True
    
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
        txtCampo(1).Enabled = False
        txtCampo(0).Enabled = False
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

Private Sub optBoton_GotFocus(Index As Integer)
    Select Case Index%
    Case 0, 1
        FPrincipal.pnlHelpLine.Caption = "Estado del producto asociado"
    End Select
End Sub

'! Private Sub optEnte_Click(Index As Integer, Value As Integer)
'!     Select Case Index%
'!     Case 0
'!           'If optEnte(0).Value = True Then
'!         'optEnte(0).Value = True
'!         ' Cuando el ente es PERSONA
'!
'!         ' Limpia el grid de Productos
'!         PMLimpiaGrid grdProductos
'!
'!         VLEnte$ = "P"
'!
'!     Case 1
'!         PMLimpiaGrid grdProductos
'!         VLEnte$ = "C"
'!     End Select
'!     cmdBoton_Click (3)
'! End Sub
'!
'! Private Sub optEnte_GotFocus(Index As Integer)
'! Select Case Index%
'!
'!     Case 0, 1
'!      FPrincipal!pnlHelpLine.Caption = "Tipo de Ente"
'! End Select
'!
'! End Sub
'!
'! Private Sub optEnte_KeyPress(Index As Integer, KeyAscii As Integer)
'! If KeyAscii% = 13 Then
'!     Select Case Index%
'!     Case 0
'!             'optEnte(0).Value = True
'!             'optEnte(1).Value = False
'!             VLEnte$ = "P"
'!             PMLimpiaGrid grdProductos
'!              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4006"
'!              PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
'!              PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, VLEnte$
'!              PMPasoValores sqlconn&, "@i_modo", 0, SQLINT4, "0"
'!              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mercado", False, "") Then
'!                  PMMapeaGrid sqlconn&, grdProductos, False
'!                  PMChequea sqlconn&
'!                 grdProductos.Col = 0
'!                 If Val(grdProductos.Tag) = VGMaxRows% Then
'!                     cmdBoton(5).Enabled = True 'Boton Siguientes boton 5 = buscar
'!                 End If
'!             End If
'!     Case 1
'!             'optEnte(1).Value = True
'!             'optEnte(0).Value = False
'!             VLEnte$ = "C"
'!             PMLimpiaGrid grdProductos
'!              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4006"
'!              PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
'!              PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, VLEnte$
'!              PMPasoValores sqlconn&, "@i_modo", 0, SQLINT4, "0"
'!              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mercado", False, "") Then
'!                  PMMapeaGrid sqlconn&, grdProductos, False
'!                  PMChequea sqlconn&
'!                 grdProductos.Col = 0
'!                 If Val(grdProductos.Tag) = VGMaxRows% Then
'!                     cmdBoton(5).Enabled = True 'Boton Siguientes boton 5 = buscar
'!                 End If
'!             End If
'!
'!     End Select
'! End If
'! End Sub
'!
Private Sub PMMarcarRegistro()
    
    PMObjetoSeguridad cmdBoton(4)
    cmdBoton(0).Enabled = False
    grdProductos.Col = 1
    lblDescripcion(3).Caption = grdProductos.Text
    grdProductos.Col = 2
    txtCampo(1).Text = grdProductos.Text
    grdProductos.Col = 3
    lblDescripcion(2).Caption = grdProductos.Text
    grdProductos.Col = 4
    lblDescripcion(1).Caption = grdProductos.Text
    grdProductos.Col = 5
    If grdProductos.Text = "V" Then
        optBoton(0).Value = True
        optBoton(0).SetFocus
    Else
        optBoton(1).Value = True
        optBoton(1).SetFocus
    End If
    
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1
        VLPaso% = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = "Tipo de Sector [F5 Ayuda]"
    Case 1
        FPrincipal.pnlHelpLine.Caption = "Producto Bancario Asociado"
    End Select

    ' Resaltar el contenido del campo respectivo
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%

        Case 0
            ' Consulta sectores
            'IU ERP 02/13/2001 PE00001
            'PMCatalogo "A", "cc_sector", txtCampo(0), lblDescripcion(0)
            PMCatalogo "A", "cc_tipo_banca", txtCampo(0), lblDescripcion(0)
            'FU ERP 02/13/2001 PE00001
            VLPaso% = True
       
        Case 1
            
                VGOperacion$ = "sp_prod_bancario"
                'GBB26May98008 II:
                'Se debe hacer un load a la forma antes de cargar los valores
                Load FRegistros
                'GBB26May98008 IF:
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4002"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLINT4, "0"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prod_bancario", False, "") Then
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                     PMChequea sqlconn&
                    FRegistros.Show 1
                    txtCampo(1).Text = VGACatalogo.Codigo$
                    lblDescripcion(2).Caption = VGACatalogo.Descripcion$
                    VLPaso% = True
                    
                Else
                VGOperacion$ = ""
                End If
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 1
    If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Case 0, 2
        KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
    
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%

    Case 0
        If VLPaso% = False Then
            If txtCampo(0).Text = "" Then
                lblDescripcion(0).Caption = ""
                Exit Sub
            End If
            'IU ERP 02/13/2001 PE00001
            'PMCatalogo "V", "cc_sector", txtCampo(0), lblDescripcion(0)
            PMCatalogo "V", "cc_tipo_banca", txtCampo(0), lblDescripcion(0)
            'FU ERP 02/13/2001 PE00001
        End If



    Case 1
        If VLPaso% = False Then
            If txtCampo(1).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4003"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(1).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prod_bancario", False, "") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(2)
                     PMChequea sqlconn&
                Else
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


