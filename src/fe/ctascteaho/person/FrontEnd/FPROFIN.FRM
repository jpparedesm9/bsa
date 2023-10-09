VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FProFin 
   Appearance      =   0  'Flat
   Caption         =   "Productos Finales"
   ClientHeight    =   5325
   ClientLeft      =   135
   ClientTop       =   1785
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
   Icon            =   "FPROFIN.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1890
      MaxLength       =   5
      TabIndex        =   0
      Top             =   15
      Width           =   930
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Eliminar"
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
      Picture         =   "FPROFIN.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   7
      Tag             =   "4010"
      Top             =   3030
      Width           =   875
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
      Picture         =   "FPROFIN.frx":0670
      Style           =   1  'Graphical
      TabIndex        =   5
      Tag             =   "4008"
      Top             =   1500
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
      Picture         =   "FPROFIN.frx":097A
      Style           =   1  'Graphical
      TabIndex        =   6
      Tag             =   "4009"
      Top             =   2265
      Width           =   870
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1890
      MaxLength       =   50
      TabIndex        =   3
      Top             =   1215
      Width           =   6465
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   1890
      MaxLength       =   3
      TabIndex        =   1
      Top             =   315
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1890
      MaxLength       =   2
      TabIndex        =   2
      Top             =   615
      Width           =   930
   End
   Begin MSGrid.Grid grdProductos 
      Height          =   3525
      Left            =   30
      TabIndex        =   10
      Top             =   1770
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14685
      _ExtentY        =   6218
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
      Picture         =   "FPROFIN.frx":0C84
      Style           =   1  'Graphical
      TabIndex        =   8
      Top             =   3795
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
      Index           =   5
      Left            =   8415
      Picture         =   "FPROFIN.frx":0FEA
      Style           =   1  'Graphical
      TabIndex        =   4
      Tag             =   "4122"
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
      Picture         =   "FPROFIN.frx":124C
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   4560
      Width           =   875
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   5
      Left            =   2835
      TabIndex        =   22
      Top             =   15
      Width           =   5520
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código Sucursal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   75
      TabIndex        =   21
      Top             =   15
      Width           =   1455
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   4
      Left            =   2835
      TabIndex        =   20
      Top             =   315
      Width           =   5520
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Productos Finales:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   11
      Top             =   1575
      Width           =   2325
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código Mercado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   12
      Top             =   315
      Width           =   1455
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Moneda:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   13
      Top             =   615
      Width           =   1575
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Producto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   60
      TabIndex        =   14
      Top             =   915
      Width           =   1275
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Descripción:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   60
      TabIndex        =   15
      Top             =   1215
      Width           =   1080
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   3780
      TabIndex        =   16
      Top             =   615
      Width           =   4575
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2835
      TabIndex        =   19
      Top             =   615
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2835
      TabIndex        =   18
      Top             =   915
      Width           =   5520
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   1890
      TabIndex        =   17
      Top             =   915
      Width           =   930
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8370
      Y1              =   1530
      Y2              =   1530
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
Attribute VB_Name = "FProFin"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
'! removed Dim VTMarca As Integer


Private Sub cmdBoton_Click(Index As Integer)
    Const MB_YESNO = 4
    Const MB_ICONQUESTION = 32
    Const MB_DEBUTTON1 = 0
    '! removed Const IDCANCEL = 2
    '! removed Const IDNO = 7
    '! removed Const MB_DEFBUTTON1 = 0
    Const IDYES = 6
'FIXIT: Declare 'DgDef' and 'Response' with an early-bound data type                       FixIT90210ae-R1672-R1B8ZE
    Dim DgDef As Integer
    Dim Response As String
    Dim VTFilas%
    Dim VTProFinal$
    'DgDef = MB_YESNOCANCEL + MB_ICONQUESTION + MB_DEBUTTON1
    DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
    
Select Case Index%
    Case 0 'Crear un nuevo producto final
            
        If txtCampo(1).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        If txtCampo(3).Text = "" Then
            MsgBox "El código del mercado es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
                MsgBox "El código del producto es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(2).SetFocus
                Exit Sub
        End If
        If txtCampo(0).Text = "" Then
                MsgBox "La descripción del producto es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(0).SetFocus
                Exit Sub
        End If
                    
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4008"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_cod_merc", 0, SQLINT2, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, lblDescripcion(0).Caption
         PMPasoValores sqlconn&, "@i_tipop", 0, SQLCHAR, lblDescripcion(1).Caption
         PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR, txtCampo(0).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok...Creación de Producto Final") Then
             PMChequea sqlconn&
            cmdBoton(0).Enabled = False
            cmdBoton_Click (5)
        End If
                        

         
    Case 1 'Limpiar
        txtCampo(1).Enabled = True
        txtCampo(1).Text = ""
        PLLimpiar
        txtCampo(1).SetFocus
        lblDescripcion(5).Caption = ""
    Case 2 'Salir
         
         Unload FProFin

    Case 3
          'Eliminar
        If txtCampo(1).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        If txtCampo(3).Text = "" Then
            MsgBox "El código del mercado es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
                MsgBox "El código del producto es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(2).SetFocus
                Exit Sub
        End If
            
        cmdBoton(4).Enabled = False
        Response = MsgBox("Desea Eliminar el Producto Final No. " + (txtCampo(2).Text) + "?", DgDef, "Mensaje de Seguridad")
        If Response = IDYES Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4010"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(1).Text
             PMPasoValores sqlconn&, "@i_cod_merc", 0, SQLINT2, txtCampo(3).Text
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, txtCampo(2).Text
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, lblDescripcion(0).Caption
             PMPasoValores sqlconn&, "@i_tipop", 0, SQLCHAR, lblDescripcion(1).Caption
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok...Eliminación de Producto Final") Then
                 PMChequea sqlconn&
                cmdBoton(3).Enabled = False
                cmdBoton_Click (5)
            End If
        Else
            Exit Sub
        End If
        
    
    Case 4 'Actualizar
        
        If txtCampo(1).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        If txtCampo(3).Text = "" Then
            MsgBox "El código del mercado es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
                MsgBox "El código del producto es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(2).SetFocus
                Exit Sub
        End If
        
        cmdBoton(3).Enabled = False
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4009"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_cod_merc", 0, SQLINT2, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, lblDescripcion(0).Caption
         PMPasoValores sqlconn&, "@i_tipop", 0, SQLCHAR, lblDescripcion(1).Caption
         PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR, txtCampo(0).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok...Actualización de Producto Final") Then
             PMChequea sqlconn&
            cmdBoton(4).Enabled = False
            cmdBoton_Click (5)
        End If
    Case 5 'Buscar

        If txtCampo(1).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

         VTFilas% = VGMaxRows%
         VTProFinal$ = "0"
         While VTFilas% = VGMaxRows%
         
              PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4011"
              PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
              PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
              PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(1).Text
              PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, VTProFinal$
              If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok... Consulta de Productos") Then
                If VTProFinal$ = "0" Then
                     PMMapeaGrid sqlconn&, grdProductos, False
                Else
                     PMMapeaGrid sqlconn&, grdProductos, True
                End If
                 PMChequea sqlconn&
                VTFilas% = Val(grdProductos.Tag)

                grdProductos.Col = 1
                grdProductos.Row = grdProductos.Rows - 1
                VTProFinal$ = grdProductos.Text

                ' Determinar que existan servicios bancarios
    
             End If

        Wend
        grdProductos.ColWidth(1) = 1
        grdProductos.ColWidth(2) = 4500
        grdProductos.Row = 1
    End Select
End Sub

Private Sub Form_Load()
    FProFin.Left = 15
    FProFin.Top = 15
    FProFin.Width = 9420
    FProFin.Height = 5900
'''    PMBotonSeguridad FProFin, 5
'''    'cmdBoton_Click (5)
'''    cmdBoton(3).Enabled = False
'''    cmdBoton(4).Enabled = False
 PMObjetoSeguridad cmdBoton(5)
 PMObjetoSeguridad cmdBoton(0)
 PMObjetoSeguridad cmdBoton(4)
 PMObjetoSeguridad cmdBoton(3)
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
    If grdProductos.Text <> "" Then
        grdProductos.Row = VTRow%
        PMMarcarRegistro
    End If
End Sub

Private Sub grdProductos_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga Doble Click para Seleccionar"
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

Private Sub PLLimpiar()
Dim i%
    txtCampo(0).Enabled = True
    
    txtCampo(2).Enabled = True
    txtCampo(3).Enabled = True
    txtCampo(0).Text = ""
    
    txtCampo(2).Text = ""
    txtCampo(3).Text = ""
    For i% = 0 To 4
        lblDescripcion(i%).Caption = ""
    Next i%
        
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
        
    'cmdBoton(0).Enabled = True
    'cmdBoton(4).Enabled = False
    'cmdBoton(3).Enabled = False
    
    PMObjetoSeguridad cmdBoton(0)
    PMObjetoSeguridad cmdBoton(4)
    PMObjetoSeguridad cmdBoton(3)
    
    'cmdBoton_Click (5)
    grdProductos.Rows = 2
    grdProductos.Cols = 2
    grdProductos.ColWidth(1) = 600
    grdProductos.Row = 0
    grdProductos.Col = 1
    grdProductos.Text = ""
    grdProductos.Row = 1
    grdProductos.Col = 0
    grdProductos.Text = ""
    grdProductos.Col = 1
    grdProductos.Text = ""
End Sub

Private Sub PMMarcarRegistro()
    'cmdBoton(4).Enabled = True
    'cmdBoton(3).Enabled = True
    Dim i%
    PMObjetoSeguridad cmdBoton(4)
    PMObjetoSeguridad cmdBoton(3)
    cmdBoton(0).Enabled = False
    
    grdProductos.Col = 3
    txtCampo(3).Text = grdProductos.Text
    'If txtCampo(3).Text <> "" Then
     '    PMPasoValores SqlConn&, "@t_trn", 0, SQLINT2, "4045"
     '    PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "Q"
     '    PMPasoValores SqlConn&, "@i_cod_merc", 0, SQLINT2, txtCampo(3).Text
     '    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_prodfin", True, " Consulta del producto ") Then
     '        PMMapeaObjeto SqlConn&, lblDescripcion(4)
     '        PMChequea SqlConn&
            
    '    Else
    '        lblDescripcion(4).Caption = ""
    '        txtCampo(3).Text = ""
    '    End If
    'End If
    grdProductos.Col = 4
    lblDescripcion(4).Caption = grdProductos.Text
    
    grdProductos.Col = 5
    txtCampo(2).Text = grdProductos.Text
    
    grdProductos.Col = 6
    lblDescripcion(2).Caption = grdProductos.Text
    
    grdProductos.Col = 7
    lblDescripcion(0).Caption = grdProductos.Text
    grdProductos.Col = 9
    lblDescripcion(1).Caption = grdProductos.Text
    If grdProductos.Text = "R" Then
    lblDescripcion(3).Caption = "REGIONAL"
    End If
    grdProductos.Col = 2
    txtCampo(0).Text = grdProductos.Text
    
    For i% = 1 To 3
        txtCampo(i%).Enabled = False
    Next i%
    txtCampo(0).SetFocus
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 1, 2, 3
        VLPaso% = False
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
        Case 0
            FPrincipal.pnlHelpLine.Caption = " Descripción del Producto Final"
        Case 1
            FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
        Case 2
            FPrincipal.pnlHelpLine.Caption = " Producto - Moneda [F5 Ayuda]"
        Case 3
            FPrincipal.pnlHelpLine.Caption = " Código de Mercado [F5 Ayuda]"
        
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim i%
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%

    Case 1
            VGOperacion$ = "sp_hp_sucursal"
            'GBB26May98008 II:
            'Se debe hacer un load a la forma antes de cargar los valores
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
                    txtCampo(1).Text = VGValores(1)
                    lblDescripcion(5).Caption = VGValores(2)
                    PLLimpiar
                Else
                    txtCampo(1).Text = ""
                    lblDescripcion(5).Caption = ""
                    VGOperacion$ = ""
                    PLLimpiar
                End If
                VLPaso% = True
            Else
                txtCampo(1).Text = ""
                lblDescripcion(5).Caption = ""
                VGOperacion$ = ""
            End If

    Case 2
       
            VGOperacion$ = "sp_promon"
            VGTipo$ = "H"
            'GBB26May98008 II:
            'Se debe hacer un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4075"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", True, " Consulta del producto ") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                If VGValores(1) <> "" Then

                    txtCampo(2).Text = VGValores(1)
                    lblDescripcion(0).Caption = VGValores(2)
                    lblDescripcion(2).Caption = VGValores(3)
                    lblDescripcion(1).Caption = VGValores(4)
                    If VGValores(4) = "R" Then
                        lblDescripcion(3).Caption = "REGIONAL"
                    End If
                    txtCampo(0).SetFocus
                    For i% = 1 To 10
                        VGValores(i%) = ""
                    Next i%
                End If
            Else
            VGOperacion$ = ""
            VGTipo$ = ""
            End If
         
         VLPaso% = True
        
    Case 3
        VGOperacion$ = "sp_prodfin"
        'GBB26May98 II:
        'Se debe hacer un load a la forma antes de cargar los valores
        Load FRegistros
        'GBB26May98 IF:
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4012"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", False, "") Then
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
             PMChequea sqlconn&
            FRegistros.Show 1
            ' PMChequea SqlConn&
            If VGValores(1) <> "" Then

                txtCampo(3).Text = VGValores(1)
                lblDescripcion(4).Caption = VGValores(2) & " " & VGValores(3)
            End If
            VLPaso% = True
        Else
        txtCampo(3).Text = ""
        lblDescripcion(4).Caption = ""
        VGOperacion$ = ""
        End If
    
    
        
End Select
End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
            KeyAscii% = 0
        Else
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
'        KeyAscii% = FMValidaTipoDato("A", KeyAscii%)
'        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    Case 1, 2, 3
'        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
'            KeyAscii% = 0
'        End If
        KeyAscii% = FMValidaTipoDato("N", KeyAscii%)
    End Select

End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim i%
    Select Case Index%

    Case 1
        If VLPaso% = False Then
            If txtCampo(1).Text <> "" Then
            
             If txtCampo(1).Text > 32000 Then
                    MsgBox "El código de sucursal fuera de rango", 0 + 16, "Mensaje de Error"
                    txtCampo(1).Text = ""
                    txtCampo(1).SetFocus
                    Exit Sub
                 End If
            
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4078"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(1).Text
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", True, " Consulta del producto ") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(5)
                     PMChequea sqlconn&
                    PLLimpiar
                Else
                    lblDescripcion(5).Caption = ""
                    txtCampo(1).Text = ""
                    txtCampo(1).SetFocus
                    VLPaso% = True
                    PLLimpiar
                End If
            Else
                lblDescripcion(5).Caption = ""
                PLLimpiar
            End If
        End If

    Case 2
    If VLPaso% = False Then
            
    
        If txtCampo(2).Text <> "" Then
            'Tiene que ser una cuenta de ahorros o una cuenta corriente
            If txtCampo(2).Text <> "3" And txtCampo(2).Text <> "4" Then
                MsgBox "Código Incorrecto", 0 + 16, "Mensaje de Error"
                txtCampo(2).Text = ""
                txtCampo(2).SetFocus
                Exit Sub
            End If
            VGOperacion$ = "sp_promon"
            VGTipo$ = "Q"
            'GBB26May98008 II:
            'Se debe hacer un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4076"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(2).Text
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
             'PMPasoValores SqlConn&, "@i_moneda", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", True, " Consulta del producto ") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                If VGValores(1) <> "" Then
                    lblDescripcion(0).Caption = VGValores(2) 'moneda
                    lblDescripcion(2).Caption = VGValores(3) ' descripcion
                    lblDescripcion(1).Caption = VGValores(4) ' tipo producto
                    If VGValores(4) = "R" Then
                        lblDescripcion(3).Caption = "REGIONAL"
                    End If
                Else
                    If lblDescripcion(0).Caption = "" Then
                        txtCampo(2).Text = ""
                        txtCampo(2).SetFocus
                    End If
                End If
                For i% = 1 To 5
                    VGValores(i%) = ""
                Next i%
            
            Else
                    VLPaso% = True
                    txtCampo(2).Text = ""
                    lblDescripcion(0).Caption = ""
                    lblDescripcion(2).Caption = ""
                    lblDescripcion(1).Caption = ""
                    lblDescripcion(3).Caption = ""
                    txtCampo(2).SetFocus
            End If
        Else
            lblDescripcion(0).Caption = ""
            lblDescripcion(2).Caption = ""
            lblDescripcion(1).Caption = ""
            lblDescripcion(3).Caption = ""

        End If
        VGOperacion$ = ""
        VGTipo$ = ""
    End If
    Case 3
        If VLPaso% = False Then
            If txtCampo(3).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4045"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                 PMPasoValores sqlconn&, "@i_cod_merc", 0, SQLINT2, txtCampo(3).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, " Consulta del producto ") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(4)
                     PMChequea sqlconn&
                    
                Else
                    lblDescripcion(4).Caption = ""
                    txtCampo(3).Text = ""
                    VLPaso% = True
                End If
            Else
                lblDescripcion(4).Caption = ""
            End If
        End If
End Select
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 1, 2, 3
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


