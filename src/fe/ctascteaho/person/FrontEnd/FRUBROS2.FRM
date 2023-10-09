VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FRubros 
   Appearance      =   0  'Flat
   Caption         =   "Servicios Personalizables"
   ClientHeight    =   5325
   ClientLeft      =   165
   ClientTop       =   1500
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
   Icon            =   "FRUBROS2.frx":0000
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   4
      Left            =   2220
      MaxLength       =   5
      TabIndex        =   0
      Top             =   315
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   2220
      MaxLength       =   3
      TabIndex        =   4
      Top             =   1815
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
      Picture         =   "FRUBROS2.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   8
      Tag             =   "4015"
      Top             =   2310
      Width           =   870
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
      Height          =   740
      Index           =   4
      Left            =   8415
      Picture         =   "FRUBROS2.frx":0614
      Style           =   1  'Graphical
      TabIndex        =   9
      Tag             =   "4016"
      Top             =   3075
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   2220
      MaxLength       =   3
      TabIndex        =   2
      Top             =   915
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   2220
      MaxLength       =   3
      TabIndex        =   1
      Top             =   615
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   2220
      MaxLength       =   3
      TabIndex        =   3
      Top             =   1515
      Width           =   930
   End
   Begin MSGrid.Grid grdRubros 
      Height          =   2910
      Left            =   15
      TabIndex        =   5
      Top             =   2385
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   5133
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
      Height          =   740
      Index           =   2
      Left            =   8415
      Picture         =   "FRUBROS2.frx":097A
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   4575
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
      Height          =   740
      Index           =   5
      Left            =   8415
      Picture         =   "FRUBROS2.frx":0CE0
      Style           =   1  'Graphical
      TabIndex        =   6
      Tag             =   "4013"
      Top             =   45
      Width           =   875
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
      Height          =   740
      Index           =   3
      Left            =   8415
      Picture         =   "FRUBROS2.frx":0F42
      Style           =   1  'Graphical
      TabIndex        =   7
      Tag             =   "4013"
      Top             =   795
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
      Height          =   740
      Index           =   1
      Left            =   8415
      Picture         =   "FRUBROS2.frx":1174
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   3825
      Width           =   875
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código Sucursal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   10
      Left            =   45
      TabIndex        =   35
      Top             =   315
      Width           =   1455
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   12
      Left            =   3165
      TabIndex        =   34
      Top             =   315
      Width           =   5190
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Grupo de Rango:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   45
      TabIndex        =   33
      Top             =   1815
      Width           =   1470
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   150
      TabIndex        =   16
      Top             =   3765
      Width           =   840
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Moneda:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   165
      TabIndex        =   19
      Top             =   3435
      Width           =   750
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Producto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   45
      TabIndex        =   20
      Top             =   4620
      Width           =   1545
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   3060
      TabIndex        =   24
      Top             =   4515
      Width           =   5175
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   4
      Left            =   3120
      TabIndex        =   25
      Top             =   3990
      Width           =   5175
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   6
      Left            =   2160
      TabIndex        =   27
      Top             =   4500
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   7
      Left            =   2160
      TabIndex        =   28
      Top             =   3495
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   8
      Left            =   3090
      TabIndex        =   29
      Top             =   3570
      Width           =   5175
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   10
      Left            =   2070
      TabIndex        =   31
      Top             =   3825
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   11
      Left            =   2220
      TabIndex        =   32
      Top             =   1215
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   9
      Left            =   3165
      TabIndex        =   30
      Top             =   1515
      Width           =   5190
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   5
      Left            =   3165
      TabIndex        =   26
      Top             =   1215
      Width           =   5190
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   3165
      TabIndex        =   23
      Top             =   915
      Width           =   5190
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   3165
      TabIndex        =   22
      Top             =   615
      Width           =   5190
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Servicios Personalizables"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   30
      TabIndex        =   12
      Top             =   2175
      Width           =   2940
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
      TabIndex        =   21
      Top             =   615
      Width           =   1305
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio Personalizable:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   45
      TabIndex        =   13
      Top             =   15
      Width           =   2055
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rubro del Servicio:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   45
      TabIndex        =   14
      Top             =   1215
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio Disponible:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   45
      TabIndex        =   15
      Top             =   915
      Width           =   1710
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2220
      TabIndex        =   17
      Top             =   15
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Rango:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   45
      TabIndex        =   18
      Top             =   1515
      Width           =   1335
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   15
      X2              =   8385
      Y1              =   2130
      Y2              =   2130
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
Attribute VB_Name = "FRubros"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
'! removed Dim VLProducto As String

Dim VLMoneda As String

Private Sub cmdBoton_Click(Index As Integer)
    Const MB_YESNO = 4
    Const MB_ICONQUESTION = 32
    Const MB_DEBUTTON1 = 0
    '! removed Const IDCANCEL = 2
    '! removed Const MB_DEFBUTTON1 = 0
    '! removed Const IDNO = 7
    Const IDYES = 6
'FIXIT: Declare 'DgDef' and 'Response' with an early-bound data type                       FixIT90210ae-R1672-R1B8ZE
    Dim DgDef As Integer
    Dim Response As String
    Dim i%
    'DgDef = MB_YESNOCANCEL + MB_ICONQUESTION + MB_DEBUTTON1
    DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
    
    
    Select Case Index%
    Case 0    'Crear
        If txtCampo(4).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If

        If txtCampo(2).Text = "" Then
            MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            MsgBox "El código del servicio disponible  es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        If txtCampo(1).Text = "" Then
            MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        If txtCampo(3).Text = "" Then
            MsgBox "El grupo de rango es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4015"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT4, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_cod_subser", 0, SQLINT2, txtCampo(0).Text 'serv dis
         PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_cod_detalle", 0, SQLCHAR, lblDescripcion(11).Caption
         PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT2, txtCampo(3).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rubros", True, "Ok...Creación de Rubro") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(3)
             PMChequea sqlconn&
            cmdBoton(0).Enabled = False
        Else
            cmdBoton_Click (1)
        End If
        FPrincipal.pnlHelpLine.Caption = ""
        cmdBoton_Click (5)

Case 1 'Limpiar
        If txtCampo(0).Text <> "" Then
            txtCampo(3).Text = ""
            txtCampo(3).Enabled = True
            lblDescripcion(3).Caption = ""
            txtCampo(1).Text = ""
            txtCampo(1).Enabled = True
            lblDescripcion(9).Caption = ""
            
            txtCampo(0).Text = ""
            txtCampo(0).Enabled = True
            lblDescripcion(1).Caption = ""
            lblDescripcion(5).Caption = ""
            lblDescripcion(11).Caption = ""
            txtCampo(0).SetFocus
        Else
            If txtCampo(2).Text <> "" Then
                txtCampo(2).Text = ""
                lblDescripcion(0).Caption = ""
                txtCampo(2).Enabled = True
                txtCampo(2).SetFocus
            Else
                txtCampo(4).Text = ""
                For i% = 0 To 12
                    lblDescripcion(i%).Caption = ""
                Next i%
                txtCampo(4).Enabled = True
                txtCampo(4).SetFocus
            End If
        End If
        
        'cmdBoton(0).Enabled = True
        'cmdBoton(4).Enabled = False
        PMObjetoSeguridad cmdBoton(0)
        PMObjetoSeguridad cmdBoton(4)

        PMLimpiaGrid grdRubros
        
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
    
    Case 2 'Salir
        
        Unload FRubros
        Unload FAyudaProdFinal
        Unload FAyudaSubserv
    
    Case 3  'Siguientes
         
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4013"
        
        grdRubros.Row = grdRubros.Rows - 1
        grdRubros.Col = 1
         PMPasoValores sqlconn&, "@i_cod_subser", 0, SQLINT2, (grdRubros.Text)
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(4).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_corubros", True, "Ok... Consulta de Servicios Personalizables") Then
             PMMapeaGrid sqlconn&, grdRubros, True
             PMChequea sqlconn&
             If Val(grdRubros.Tag) > 0 Then
                 grdRubros.ColWidth(2) = 1
                grdRubros.ColWidth(4) = 1
                grdRubros.ColWidth(6) = 1
                grdRubros.ColWidth(8) = 1
                grdRubros.ColWidth(10) = 1
                grdRubros.ColWidth(14) = 1
             
             End If
            
            If Val(grdRubros.Tag) = VGMaxRows% Then
                cmdBoton(3).Enabled = True
            Else
                cmdBoton(3).Enabled = False
            End If
            grdRubros.Row = 1
        End If
    
    Case 4 'Eliminar Registros
        
        Response = MsgBox("Desea Eliminar el Servicio Personalizable " + (lblDescripcion(3).Caption) + "?", DgDef, "Mensaje de Seguridad")
        If Response = IDYES Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4016"
             PMPasoValores sqlconn&, "@i_rubro", 0, SQLINT2, lblDescripcion(3).Caption
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rubros", True, "Ok...Eliminación de Rubro") Then
                
                 PMChequea sqlconn&
                cmdBoton(4).Enabled = False
            
            End If
            
            cmdBoton_Click (5)
        Else
            Exit Sub
        End If

    Case 5 'Buscar
        If txtCampo(4).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If
         
          PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4013"
          PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
          PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
          PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
          PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(4).Text
          If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_corubros", True, "Ok... Consulta de Rubros") Then
              PMMapeaGrid sqlconn&, grdRubros, False
              PMChequea sqlconn&
             
             If Val(grdRubros.Tag) > 0 Then
                grdRubros.ColWidth(2) = 1
                grdRubros.ColWidth(4) = 1
                grdRubros.ColWidth(6) = 1
                
                grdRubros.ColWidth(8) = 1
                grdRubros.ColWidth(10) = 1
                grdRubros.ColWidth(14) = 1
             End If
             
             If Val(grdRubros.Tag) = VGMaxRows% Then
                cmdBoton(3).Enabled = True
             End If
             
             grdRubros.Row = 1
             
         End If

End Select
End Sub

Private Sub Form_Load()
    FRubros.Left = 15
    FRubros.Top = 15
    FRubros.Width = 9420
    FRubros.Height = 5730
'''    PMBotonSeguridad FRubros, 5
'''    cmdBoton(0).Enabled = True
'''    cmdBoton(4).Enabled = False

PMObjetoSeguridad cmdBoton(5)
PMObjetoSeguridad cmdBoton(3)
PMObjetoSeguridad cmdBoton(0)
PMObjetoSeguridad cmdBoton(4)

End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdRubros_Click()

    grdRubros.Col = 0
    grdRubros.SelStartCol = 1
    grdRubros.SelEndCol = grdRubros.Cols - 1
    If grdRubros.Row = 0 Then
        grdRubros.SelStartRow = 1
        grdRubros.SelEndRow = 1
    Else
        grdRubros.SelStartRow = grdRubros.Row
        grdRubros.SelEndRow = grdRubros.Row
    End If
End Sub

Private Sub grdRubros_DblClick()
Dim VTRow%
    VTRow% = grdRubros.Row
    grdRubros.Row = 1
    grdRubros.Col = 1

    If grdRubros.Text <> "" Then
        grdRubros.Row = VTRow%
        PMMarcarRubro
    End If
End Sub

Private Sub grdRubros_GotFocus()
FPrincipal.pnlHelpLine.Caption = " Haga Doble Click para Eliminar/Actualizar Límites"
End Sub

Private Sub grdRubros_KeyUp(KeyCode As Integer, Shift As Integer)
    grdRubros.Col = 0
    grdRubros.SelStartCol = 1
    grdRubros.SelEndCol = grdRubros.Cols - 1
    If grdRubros.Row = 0 Then
        grdRubros.SelStartRow = 1
        grdRubros.SelEndRow = 1
    Else
        grdRubros.SelStartRow = grdRubros.Row
        grdRubros.SelEndRow = grdRubros.Row
    End If
    
End Sub

Private Sub PMMarcarRubro()
       
    'cmdBoton(4).Enabled = True
    PMObjetoSeguridad cmdBoton(4)
    cmdBoton(0).Enabled = False
    grdRubros.Col = 1
    lblDescripcion(3).Caption = grdRubros.Text  'codi serper
    
    txtCampo(4).Enabled = False

    grdRubros.Col = 2 ' cod profina
    txtCampo(2).Text = grdRubros.Text
    txtCampo(2).Enabled = False
    
    grdRubros.Col = 3 ' desc profina
    lblDescripcion(0).Caption = grdRubros.Text
    
    grdRubros.Col = 4   'Cod serv disp
    txtCampo(0).Text = grdRubros.Text
    txtCampo(0).Enabled = False
    
    grdRubros.Col = 5  ' descrip serv disp
    lblDescripcion(1).Caption = grdRubros.Text
    
    grdRubros.Col = 6  ' cod rubro
    lblDescripcion(11).Caption = grdRubros.Text
    
    grdRubros.Col = 7  'descrp rubro
    lblDescripcion(5).Caption = grdRubros.Text
    
    grdRubros.Col = 8 'cod produco cobis
    lblDescripcion(6).Caption = grdRubros.Text
    grdRubros.Col = 9
    lblDescripcion(4).Caption = grdRubros.Text
    grdRubros.Col = 10 'cod mone
    lblDescripcion(7).Caption = grdRubros.Text
    grdRubros.Col = 11
    lblDescripcion(8).Caption = grdRubros.Text
    grdRubros.Col = 12 'tipo prod
    lblDescripcion(10).Caption = grdRubros.Text
    If lblDescripcion(10).Caption = "R" Then
        lblDescripcion(2).Caption = "REGIONAL"
    End If
    
    grdRubros.Col = 14  'tipo rango cod
    txtCampo(1).Text = grdRubros.Text
    txtCampo(1).Enabled = False
    grdRubros.Col = 13  'tipo rango des
    lblDescripcion(9).Caption = grdRubros.Text
    grdRubros.Col = 15  'tipo rango des
    txtCampo(3).Text = grdRubros.Text
    txtCampo(3).Enabled = False
   ' If txtCampo(1).Text <> "" Then
   '
    '     PMPasoValores SqlConn&, "@t_trn", 0, SQLINT2, "4038"
    '     PMPasoValores SqlConn&, "@i_tipo", 0, SQLCHAR, "V"
    '     PMPasoValores SqlConn&, "@i_codigo", 0, SQLINT4, txtCampo(1).Text
    '     PMPasoValores SqlConn&, "@i_modo", 0, SQLINT4, "0"
     '    If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "") Then
    '         PMMapeaObjeto SqlConn&, lblDescripcion(9)
    '         PMChequea SqlConn&
   '     End If
    'End If
End Sub

'! Private Sub PMProducto()
'!     If VGProd$ = "R" Then
'!         If VGProducto(0) = "P" Then
'!             If txtCampo(2).Text = "" Then
'!
'!                 txtCampo(2).Text = VGProducto(2) 'cod prod final
'!                 lblDescripcion(0).Caption = VGProducto(1)
'!                 lblDescripcion(6).Caption = VGProducto(4)  'producto cobis
'!                 lblDescripcion(4).Caption = VGProducto(5)
'!                 lblDescripcion(7).Caption = VGProducto(6) 'cod mon
'!                 lblDescripcion(8).Caption = VGProducto(7) ' des moneda
'!                 lblDescripcion(10).Caption = VGProducto(8) ' tipo produ cod
'!                 If lblDescripcion(10).Caption = "R" Then
'!                     lblDescripcion(2).Caption = "REGIONAL"
'!                 End If
'!
'!             Else
'!                 lblDescripcion(0).Caption = VGProducto(1) 'Descripcion de Producto Final
'!                 lblDescripcion(6).Caption = VGProducto(2)  'cod producto cobis
'!                 lblDescripcion(4).Caption = VGProducto(3) 'des producto cobis
'!                 lblDescripcion(7).Caption = VGProducto(4) 'cod mon
'!                 lblDescripcion(8).Caption = VGProducto(5) ' des moneda
'!                 lblDescripcion(10).Caption = VGProducto(6) ' tipo produ cod
'!                 If lblDescripcion(10).Caption = "R" Then
'!                     lblDescripcion(2).Caption = "REGIONAL"
'!                 End If
'!             End If
'!         End If
'!     End If
'! End Sub
'!
Private Sub PMSubserv()
    If VGDetalle(0) = "S" Then
        If txtCampo(0).Text = "" Then

            lblDescripcion(1).Caption = VGDetalle(1) 'des serv dis
            lblDescripcion(5).Caption = VGDetalle(2) 'des rubro
            txtCampo(0).Text = VGDetalle(3) 'cod serv dis
            lblDescripcion(11).Caption = VGDetalle(4) 'cod rubro
            
        Else
            
            lblDescripcion(1).Caption = VGDetalle(1) 'des serv dis
            lblDescripcion(5).Caption = VGDetalle(2) 'des rubro
            lblDescripcion(11).Caption = VGDetalle(3) 'cod rubro

        End If
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1, 2, 3, 4
        VLPaso% = False
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Servicio Disponible [F5 Ayuda]"
    
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Tipo de rango [F5 Ayuda]"
    
    Case 2
        FPrincipal.pnlHelpLine.Caption = " Producto Final [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Grupo de Rango [F5 Ayuda]"
    Case 4
        FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
    
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim VTFilas%
Dim VTCodigo$
Dim VTMoneda$
Dim VTProFinal$
Dim VTGrupo$
Dim VTRango$
        If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
            
        Case 0
            
            FAyudaSubserv.Show 1
            If VGDetalle(1) <> "" Then
                PMSubserv
                VLPaso% = True
            End If
            
        
        Case 1
            If txtCampo(2).Text = "" Then
                MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(2).SetFocus
                Exit Sub
            End If
            
            VLPaso% = True
            VGOperacion$ = "sp_help_rango_pe"
            VGTipo$ = "T"
            VTFilas% = VGMaxRows%
            VTCodigo$ = "0"
            VTMoneda$ = VLMoneda
            While VTFilas% = VGMaxRows%
                 ' GBB26May98008 II:
                ' Se debe haver un load a la forma antes de cargar los valores
                Load FRegistros
                'GBB26May98008 IF:
           
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, VTCodigo$
                 PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VTMoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Rangos") Then
                    If VTCodigo$ = "0" Then
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                    Else
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                    End If
                     PMChequea sqlconn&
                    VTFilas% = Val(FRegistros.grdRegistros.Tag)

                    FRegistros.grdRegistros.Col = 1
                    FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                    VTCodigo$ = FRegistros.grdRegistros.Text
                 
                    FRegistros.grdRegistros.Col = 3
                    FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                    VTMoneda$ = FRegistros.grdRegistros.Text
                    
                Else
                   VGOperacion$ = ""
                   VGTipo$ = ""
                End If

            Wend
            FRegistros.grdRegistros.Row = 1
                FRegistros.Show 1
                If VGValores(1) <> "" Then
                    txtCampo(1).Text = VGValores(1)
                    lblDescripcion(9).Caption = VGValores(2)
                    VLPaso% = True
                End If
        Case 2
            If txtCampo(4).Text = "" Then
                MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(4).SetFocus
                Exit Sub
            End If
    
            VTFilas% = VGMaxRows%
            VTProFinal$ = "0"
            VGOperacion$ = "sp_prodfin2"
            While VTFilas% = VGMaxRows%
                ' GBB26May98008 II:
                ' Se debe haver un load a la forma antes de cargar los valores
                  Load FRegistros
                'GBB26May98008 IF:
        
                  PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4011"
                  PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
                  PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                  PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(4).Text
                  PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, VTProFinal$
                  If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok... Consulta de Productos") Then
                    If VTProFinal$ = "0" Then
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                    Else
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                    End If
                     PMChequea sqlconn&
                   
                    VTFilas% = Val(FRegistros.grdRegistros.Tag)

                    FRegistros.grdRegistros.Col = 1
                    FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                    VTProFinal$ = FRegistros.grdRegistros.Text
                 Else
                    txtCampo(2).Text = ""
                    lblDescripcion(0).Caption = ""
                    VGOperacion$ = ""
                 End If
            Wend

            FRegistros.grdRegistros.Row = 1
            
                FRegistros.Show 1
            
                 ' PMChequea SqlConn&
                If VGValores(1) <> "" Then
                    txtCampo(2).Text = VGValores(1)
                    lblDescripcion(0).Caption = VGValores(2)
                    VLMoneda$ = VGValores(3)
                    VLPaso% = True
                Else
                    txtCampo(2).Text = ""
                    lblDescripcion(0).Caption = ""
                    VLMoneda$ = ""
                    VGOperacion$ = ""
                End If
                 
        Case 3 'Grupo
            If txtCampo(1).Text = "" Then
                MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(1).SetFocus
                Exit Sub
            End If
            VGOperacion$ = "sp_help_rango_pe"
            VGTipo$ = "G"
            VTFilas% = VGMaxRows%
            VTGrupo$ = "0"
            VTRango$ = "0"
            While VTFilas% = VGMaxRows%
                 Load FRegistros
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "G"
                 PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT2, VTGrupo$
                 PMPasoValores sqlconn&, "@i_rango", 0, SQLINT1, VTRango$
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT1, txtCampo(1).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Rangos") Then
                    If VTGrupo$ = "0" Then
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                    Else
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                    End If
                     PMChequea sqlconn&
                    VTFilas% = Val(FRegistros.grdRegistros.Tag)

                    FRegistros.grdRegistros.Col = 1
                    FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                    VTGrupo$ = FRegistros.grdRegistros.Text
                 'GBB27May98001 II:
                 'Veirifica que el número de columnas se mayor a dos para asignar los valores
                 If FRegistros.grdRegistros.Col > 2 Then
                    FRegistros.grdRegistros.Col = 2
                End If
                'GBB27May98001 IF:
                    FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                    VTRango$ = FRegistros.grdRegistros.Text
                    
                Else
                   VGOperacion$ = ""
                   VGTipo$ = ""

                End If

            Wend
            FRegistros.grdRegistros.Row = 1
            
                FRegistros.Show 1
                If VGACatalogo.Codigo$ <> "" Then
                    txtCampo(3).Text = VGACatalogo.Codigo$
                    VLPaso% = True
                End If
        Case 4
                VGOperacion$ = "sp_hp_sucursal"
                ' GBB26May98008 II:
                ' Se debe haver un load a la forma antes de cargar los valores
                Load FRegistros
                'GBB26May98008 IF:
        
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4079"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", False, "") Then
                 'If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_hp_sucursal", True, " Consulta del producto ") Then
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                     PMChequea sqlconn&
                    FRegistros.Show 1
                    ' PMChequea SqlConn&
                    If VGValores(1) <> "" Then
                        txtCampo(4).Text = VGValores(1)
                        lblDescripcion(12).Caption = VGValores(2)
                    Else
                        txtCampo(4).Text = ""
                        lblDescripcion(12).Caption = ""
                        VGOperacion$ = ""
                    End If
                     
                    VLPaso% = True
                Else
                    txtCampo(4).Text = ""
                    lblDescripcion(12).Caption = ""
                    VGOperacion$ = ""
                End If

        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1, 2, 3, 4
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
               'VLPaso% = True
               FAyudaSubserv.Show 1
               If VGDetalle(1) <> "" Then
                    PMSubserv
               Else
                    If lblDescripcion(1).Caption = "" Then
                        txtCampo(0).Text = ""
                        VLPaso% = True
                    End If
               End If
            End If
        End If
    
    Case 1
        If VLPaso% = False Then
        If txtCampo(1).Text <> "" Then
            If txtCampo(2).Text = "" Then
                MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(1).Text = ""
                txtCampo(2).SetFocus
                Exit Sub
            End If
            
            
              If txtCampo(1).Text > 251 Then
                    MsgBox " Tipo de rango fuera de limite", 0 + 16, "Mensaje de Error"
                    txtCampo(1).Text = ""
                    txtCampo(1).SetFocus
                    Exit Sub
                 End If
            
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(1).Text
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VLMoneda$
             PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(9)
                 PMChequea sqlconn&
            Else
                txtCampo(1).Text = ""
                lblDescripcion(9).Caption = ""
                VLPaso% = True
            End If
        Else
           VLPaso% = True
           lblDescripcion(5).Caption = ""
        End If
        End If
    Case 2
        If VLPaso% = False Then
            If txtCampo(2).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4077"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(4).Text
                 PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, " Consulta del producto ") Then
                    ReDim VTArreglo(2) As String
                     VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                     PMChequea sqlconn&
                    lblDescripcion(0).Caption = VTArreglo(1)
                    VLMoneda$ = VTArreglo(2)
                     'PMMapeaObjeto SqlConn&, lblDescripcion(0)
                     'PMChequea SqlConn&
                Else
                    lblDescripcion(0).Caption = ""
                    txtCampo(2).Text = ""
                    VLMoneda$ = ""
                    VLPaso% = True
                End If
            Else
                lblDescripcion(0).Caption = ""
            End If
        End If
    
    Case 3
        If VLPaso% = False Then
            If txtCampo(1).Text = "" Then
                MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(1).SetFocus
                Exit Sub
            End If
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT2, txtCampo(3).Text
             PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "G"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(1).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                 PMChequea sqlconn&
            Else
                txtCampo(3).Text = ""
                VLPaso% = True
            End If
       End If

    Case 4
        If VLPaso% = False Then
            If txtCampo(4).Text <> "" Then
            
             If txtCampo(4).Text > 32000 Then
                    MsgBox "El código de sucursal fuera de rango", 0 + 16, "Mensaje de Error"
                    txtCampo(4).Text = ""
                    txtCampo(4).SetFocus
                    Exit Sub
                 End If
            

                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4078"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(4).Text
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", True, " Consulta del producto ") Then
                 'If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_hp_sucursal", True, " Consulta del producto ") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(12)
                     PMChequea sqlconn&
                Else
                    lblDescripcion(12).Caption = ""
                    txtCampo(4).Text = ""
                    VLPaso% = True
                    txtCampo(4).SetFocus
                End If
            Else
                lblDescripcion(12).Caption = ""
            End If
        End If
    
    End Select

End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1, 2, 3, 4
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


