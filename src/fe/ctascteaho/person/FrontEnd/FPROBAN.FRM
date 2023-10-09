VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FTrproban 
   Appearance      =   0  'Flat
   Caption         =   "Productos Bancarios "
   ClientHeight    =   5325
   ClientLeft      =   210
   ClientTop       =   1290
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
   Icon            =   "FPROBAN.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
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
      Picture         =   "FPROBAN.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   5
      Tag             =   "4001"
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
      Left            =   8415
      Picture         =   "FPROBAN.frx":0614
      Style           =   1  'Graphical
      TabIndex        =   4
      Tag             =   "4000"
      Top             =   2250
      Width           =   870
   End
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   435
      Left            =   1470
      TabIndex        =   16
      Top             =   600
      Width           =   2430
      Begin VB.OptionButton optBoton 
         Caption         =   "Vigente"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   0
         Left            =   75
         TabIndex        =   1
         Top             =   135
         Value           =   -1  'True
         Width           =   915
      End
      Begin VB.OptionButton optBoton 
         Caption         =   "No Vigente"
         ForeColor       =   &H00800000&
         Height          =   255
         Index           =   1
         Left            =   1095
         TabIndex        =   2
         TabStop         =   0   'False
         Top             =   135
         Width           =   1290
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1470
      MaxLength       =   40
      TabIndex        =   0
      Top             =   315
      Width           =   6885
   End
   Begin MSGrid.Grid grdProductos 
      Height          =   3990
      Left            =   15
      TabIndex        =   8
      Top             =   1320
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   7038
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
      Picture         =   "FPROBAN.frx":091E
      Style           =   1  'Graphical
      TabIndex        =   6
      Top             =   3780
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
      Picture         =   "FPROBAN.frx":0C84
      Style           =   1  'Graphical
      TabIndex        =   3
      Tag             =   "4002"
      Top             =   15
      Width           =   870
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
      Picture         =   "FPROBAN.frx":0EE6
      Style           =   1  'Graphical
      TabIndex        =   7
      Top             =   4560
      Width           =   875
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "Sub&tipos"
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
      Index           =   5
      Left            =   8415
      Picture         =   "FPROBAN.frx":124C
      Style           =   1  'Graphical
      TabIndex        =   17
      Tag             =   "4158"
      Top             =   1485
      Width           =   870
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   60
      TabIndex        =   10
      Top             =   690
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   15
      Top             =   15
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Descripción:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   14
      Top             =   315
      Width           =   1080
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Último Cambio Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   5205
      TabIndex        =   13
      Top             =   750
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
      Left            =   7200
      TabIndex        =   12
      Top             =   750
      Width           =   1155
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   1470
      TabIndex        =   11
      Top             =   15
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Productos Bancarios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   9
      Top             =   1110
      Width           =   2565
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   15
      X2              =   8385
      Y1              =   1065
      Y2              =   1065
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
Attribute VB_Name = "FTrproban"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'! removed Dim VLPaso As Integer

Dim VLProducto As Integer
'! removed Dim VLSiguiente As Integer


Private Sub cmdBoton_Click(Index As Integer)
    Dim VTEstado$
    Dim VTFilas%
    Dim VTCodigo$
    Select Case Index%
    Case 0
        'Insertar nuevo producto bancario

        If txtCampo(1).Text = "" Then
            MsgBox "La descripción del producto es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        
        If optBoton(0).Value = True Then
                VTEstado$ = "V"
        Else
                VTEstado$ = "N"
        End If
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4000"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prod_bancario", True, "Ok..Creación de Producto") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(0)
             PMChequea sqlconn&
            cmdBoton(0).Enabled = False
            cmdBoton_Click (3)
        End If
           
           
    Case 1 'Limpiar
         
        txtCampo(1).Text = ""
        lblDescripcion(0).Caption = ""
        lblDescripcion(1).Caption = ""
        optBoton(0).Value = True
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        PMObjetoSeguridad cmdBoton(0)
        PMObjetoSeguridad cmdBoton(4)
        cmdBoton_Click (3)
        txtCampo(1).SetFocus
        PMLimpiaGrid grdProductos
        VLProducto = 0
        
    Case 2 'Salir

         Unload FTrproban

    Case 3 'Buscar
         VTFilas% = VGMaxRows%
         VTCodigo$ = "0"
         VLProducto = 0
         While VTFilas% = VGMaxRows%


              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4002"
              PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
              PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, VTCodigo$
              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prod_bancario", True, "Ok... Consulta de Productos") Then
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
                    grdProductos.ColAlignment(3) = 2
                    grdProductos.ColAlignment(4) = 2
                End If
             End If
        Wend
        grdProductos.Row = 1
    
    Case 4
        
        'Actualizar un registro del grid
        If txtCampo(1).Text = "" Then
            MsgBox "La descripción del producto es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        
        If optBoton(0).Value = True Then
                VTEstado$ = "V"
        Else
                VTEstado$ = "N"
        End If
    

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4001"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, lblDescripcion(0).Caption
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
         PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prod_bancario", True, "Ok..Actualización de Producto") Then
             PMChequea sqlconn&
            cmdBoton(4).Enabled = False
            cmdBoton_Click (3)
        End If
    Case 5
        If VLProducto > 0 Then
            ReDim VGProducto(0)
            FSubtipo.txtCampo(0).Text = VLProducto
            FSubtipo.txtCampo(0).SetFocus
            FSubtipo.txtCampo(1).SetFocus
            'FSubtipo.cmdBoton(0).DoClick 'RSA
            FSubtipo.Show
            Unload Me
        Else
            MsgBox "Por favor seleccione un Producto", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End Select
End Sub

Private Sub Form_Load()
    FTrproban.Left = 15
    FTrproban.Top = 15
    FTrproban.Width = 9420
    FTrproban.Height = 5730
    ''PMBotonSeguridad FTrproban, 4
    
    PMObjetoSeguridad cmdBoton(3)
    PMObjetoSeguridad cmdBoton(0)
    PMObjetoSeguridad cmdBoton(4)
    PMObjetoSeguridad cmdBoton(5)
    
    PMLoadResStrings Me
    PMLoadResIcons Me
    
    cmdBoton_Click (3)
    'cmdBoton(4).Enabled = False
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
        cmdBoton(5).Enabled = False
    Else
        grdProductos.SelStartRow = grdProductos.Row
        grdProductos.SelEndRow = grdProductos.Row
        VLProducto = grdProductos.Text
        grdProductos.Col = grdProductos.Cols - 1
        If grdProductos.Text <> "V" Then
            cmdBoton(5).Enabled = False
        Else
            PMObjetoSeguridad cmdBoton(5)
        End If
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
    End If
End Sub

Private Sub grdProductos_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga doble click para actualizar"
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

Private Sub PMMarcarRegistro()
    
    ' Al marcar Registro se hace visible el botón de actualizar
    ' Se esconde el boton de insertar

    
    grdProductos.Col = 1
    lblDescripcion(0).Caption = grdProductos.Text
    grdProductos.Col = 2
    txtCampo(1).Text = grdProductos.Text
    grdProductos.Col = 3
    lblDescripcion(1).Caption = grdProductos.Text
    
    grdProductos.Col = 4
    If grdProductos.Text = "V" Then
        optBoton(0).Value = True
    Else
        optBoton(1).Value = True
    End If
    PMObjetoSeguridad cmdBoton(4)
    cmdBoton(0).Enabled = False
    txtCampo(1).SetFocus
End Sub

Private Sub optBoton_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Estado del Producto [" + CStr(optBoton(Index%).Caption) + "]"
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Estado del Producto [" + CStr(optBoton(Index%).Caption) + "]"
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
   
    Select Case Index%
    
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Descripción del Producto"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 1
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
            KeyAscii% = 0
        Else
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
    End Select

End Sub


