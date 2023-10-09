VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FParExt 
   Appearance      =   0  'Flat
   Caption         =   "Parametrizacion Extracto de Cuenta"
   ClientHeight    =   5220
   ClientLeft      =   885
   ClientTop       =   1350
   ClientWidth     =   9270
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
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5220
   ScaleWidth      =   9270
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1800
      MaxLength       =   2
      TabIndex        =   4
      Top             =   1000
      Width           =   1275
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1800
      MaxLength       =   2
      TabIndex        =   3
      Top             =   700
      Width           =   1275
   End
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   1800
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Tag             =   "2"
      Top             =   360
      Width           =   2445
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1800
      MaxLength       =   1
      TabIndex        =   6
      Top             =   1300
      Width           =   1275
   End
   Begin MSGrid.Grid grdCategorias 
      Height          =   2940
      Left            =   0
      TabIndex        =   13
      Top             =   2160
      Width           =   8235
      _Version        =   65536
      _ExtentX        =   14526
      _ExtentY        =   5186
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
      Left            =   8400
      Picture         =   "FPAREXT.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   7
      Tag             =   "4138"
      Top             =   0
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
      Index           =   2
      Left            =   8400
      Picture         =   "FPAREXT.frx":0262
      Style           =   1  'Graphical
      TabIndex        =   11
      Tag             =   "4136"
      Top             =   1520
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
      Index           =   3
      Left            =   8400
      Picture         =   "FPAREXT.frx":056C
      Style           =   1  'Graphical
      TabIndex        =   12
      Tag             =   "4137"
      Top             =   2250
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
      Height          =   735
      Index           =   4
      Left            =   8400
      Picture         =   "FPAREXT.frx":0876
      Style           =   1  'Graphical
      TabIndex        =   14
      Tag             =   "4139"
      Top             =   2990
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
      Index           =   6
      Left            =   8400
      Picture         =   "FPAREXT.frx":0BDC
      Style           =   1  'Graphical
      TabIndex        =   16
      Top             =   4440
      Width           =   870
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
      Index           =   5
      Left            =   8400
      Picture         =   "FPAREXT.frx":0F42
      Style           =   1  'Graphical
      TabIndex        =   15
      Top             =   3710
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "Si&guiente"
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
      Height          =   795
      Index           =   1
      Left            =   8400
      Picture         =   "FPAREXT.frx":12A8
      Style           =   1  'Graphical
      TabIndex        =   9
      Tag             =   "4138"
      Top             =   720
      Width           =   900
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   3120
      TabIndex        =   20
      Top             =   1000
      Width           =   4995
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Categoria :"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   30
      TabIndex        =   19
      Top             =   1005
      Width           =   945
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Codigo :"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   30
      TabIndex        =   18
      Top             =   80
      Width           =   720
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   1800
      TabIndex        =   17
      Top             =   80
      Width           =   1275
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   3120
      TabIndex        =   8
      Top             =   700
      Width           =   4995
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Producto :"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   30
      TabIndex        =   2
      Top             =   360
      Width           =   1335
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valor Ref :"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   30
      TabIndex        =   10
      Top             =   1300
      Width           =   930
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Bancario :"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   30
      TabIndex        =   5
      Top             =   700
      Width           =   1710
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Variables:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   0
      TabIndex        =   0
      Top             =   1920
      Width           =   1590
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -15
      X2              =   8355
      Y1              =   1800
      Y2              =   1800
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8370
      X2              =   8370
      Y1              =   0
      Y2              =   5160
   End
End
Attribute VB_Name = "FParExt"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*************************************************************
' ARCHIVO:          FCATPRO.FRM
' NOMBRE LOGICO:    FParExt
' PRODUCTO:         Personalización
'*************************************************************
'                       IMPORTANTE
' Esta aplicacion es parte de los paquetes bancarios propiedad
' de MACOSA S.A.
' Su uso no  autorizado queda  expresamente prohibido asi como
' cualquier  alteracion o  agregado  hecho por  alguno  de sus
' usuarios sin el debido consentimiento por escrito de MACOSA.
' Este programa esta protegido por la ley de derechos de autor
' y por las  convenciones  internacionales de  propiedad inte-
' lectual.  Su uso no  autorizado dara  derecho a  MACOSA para
' obtener ordenes  de secuestro o  retencion y para  perseguir
' penalmente a los autores de cualquier infraccion.
'*************************************************************
'                         PROPOSITO
' Realiza el mantenimiento de las Categorías por Producto Final
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR               RAZON
' 26-Ene-95      Angela Rodríguez    Emisión Inicial
'************************************************************
Dim VLPaso As Integer
Dim VLProducto As String
Private Sub cmbTipo_LostFocus()
txtCampo(1).Text = ""
lblDescripcion(1).Caption = ""
End Sub
Private Sub Form_Load()

    '*********************************************************
    'Objetivo:  Carga la forma que se encargara de crear
    '           y eliminar categorías por productos finales
    '*********************************************************
    '                    MODIFICACIONES
    'FECHA      AUTOR               RAZON
    '20/Ene/99  J. Salazar          Emisión Inicial
    '*********************************************************

    ' Coordenadas para el despliegue de la forma
    
    FParExt.Left = 0    '15
    FParExt.Top = 0    '15
    FParExt.Width = 9390   '9420
    FParExt.Height = 5730   '5730
   
    'CCB TIPO DE PRODUCTO
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 1

    PMLoadResStrings Me
    PMLoadResIcons Me
    PLModoInsertar True
    PMBotonSeguridad FParExt, 5
    
    PMObjetoSeguridad cmdBoton(0)
    PMObjetoSeguridad cmdBoton(1)
    PMObjetoSeguridad cmdBoton(3)
    PMObjetoSeguridad cmdBoton(4)

    FPrincipal.pnlHelpLine.Caption = "FParExt - Version VSS 5"

End Sub
Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub
Private Sub grdCategorias_Click()
    
    grdCategorias.Col = 0
    grdCategorias.SelStartCol = 1
    grdCategorias.SelEndCol = grdCategorias.Cols - 1
    If grdCategorias.Row = 0 Then
        grdCategorias.SelStartRow = 1
        grdCategorias.SelEndRow = 1
    Else
        grdCategorias.SelStartRow = grdCategorias.Row
        grdCategorias.SelEndRow = grdCategorias.Row
    End If

End Sub
Private Sub grdCategorias_DblClick()
Dim VTRow%
    VTRow% = grdCategorias.Row
    grdCategorias.Row = 1
    grdCategorias.Col = 1

    If Trim$(grdCategorias.Text) <> "" Then
        grdCategorias.Row = VTRow%
        PMMarcarRegistro
        
        PLModoInsertar False
    End If

End Sub
Private Sub grdCategorias_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga doble click para habilitar el botón eliminar"
End Sub
Private Sub PLModoInsertar(Modo As Integer)
'*************************************************************
' PROPOSITO: Habilita o deshabilita ciertos objetos de la
'            forma.
' INPUT    : Modo = Entero que indica si el campo se habilita
'                   o no.
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 27-Ene-94      A.Rodríguez     Emisión Inicial
'*************************************************************
If Modo Then
     'PMObjetoSeguridad cmdBoton(1)
     cmdBoton(1).Enabled = Not Modo 'Siguientes
     cmdBoton(3).Enabled = Not Modo 'Actualizar
     cmdBoton(4).Enabled = Not Modo 'Eliminar
Else
     cmdBoton(1).Enabled = Modo 'Crear
     cmdBoton(2).Enabled = Not Modo 'Siguientes
     cmdBoton(3).Enabled = Not Modo 'Actualizar
     cmdBoton(4).Enabled = Not Modo 'Eliminar
     PMObjetoSeguridad cmdBoton(2)
 End If
End Sub

Private Sub PMMarcarRegistro()
'*************************************************************
' PROPOSITO: Captura los valores respectivos del grid,
'            y los coloca en ciertos objetos de la forma.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 27-Ene-94      A.Rodríguez     Emisión Inicial
'*************************************************************

    grdCategorias.Col = 1
    lblDescripcion(0).Caption = grdCategorias.Text
    
    grdCategorias.Col = 2
    VLProducto = grdCategorias.Text
    
    If VLProducto = "4" Then
       cmbTipo.Text = "CUENTA DE AHORRO"
    ElseIf VLProducto = "3" Then
       cmbTipo.Text = "CUENTA CORRIENTE"
    End If
    
    grdCategorias.Col = 4
    txtCampo(1).Text = grdCategorias.Text
    
    grdCategorias.Col = 5
    lblDescripcion(1).Caption = grdCategorias.Text
    
    grdCategorias.Col = 6
    txtCampo(2).Text = grdCategorias.Text
    
    grdCategorias.Col = 7
    txtCampo(0).Text = grdCategorias.Text
    

End Sub

Private Sub txtCampo_Change(Index As Integer)
Select Case Index%
    Case 0, 1, 2
        VLPaso% = False
End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
       FPrincipal.pnlHelpLine.Caption = " Código de la Categoria [F5 Ayuda]"
    Case 1
       FPrincipal.pnlHelpLine.Caption = " Código del Producto Final [F5 Ayuda]"
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Valor de Referencia"
    End Select

    ' Resalta el contenido del objeto
    
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub
Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)

If cmbTipo.Text = "CUENTA DE AHORRO" Then
   VLProducto = "4"
ElseIf cmbTipo.Text = "CUENTA CORRIENTE" Then
  VLProducto = "3"
End If

txtCampo(0).FontBold = True

If KeyCode% = VGTeclaAyuda% Then
    VLPaso% = True
    Select Case Index%
    
    Case 0
    
    If Trim$(txtCampo(1).Text) = "" Then
        MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(1).SetFocus
        Exit Sub
    End If

    VLPaso% = True
    VGOperacion$ = "sp_parametro_extracto"
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4140"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "V1"
    PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT1, txtCampo(1).Text
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, 1
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_parametro_extracto", True, " OK... Consulta de Productos COBIS") Then
        PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
        PMChequea sqlconn&
        FCatalogo.Show 1
        txtCampo(0).Text = VGACatalogo.Codigo$
        lblDescripcion(2).Caption = VGACatalogo.Descripcion$
        If Trim$(txtCampo(0).Text) = "" Then
            txtCampo(0).Text = ""
            lblDescripcion(2).Caption = ""
            txtCampo(2).Text = ""
            txtCampo(0).SetFocus
        End If
    End If
        
    Case 1
        VLPaso% = True
        VGOperacion$ = "sp_parametro_extracto"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4140"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLProducto
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_parametro_extracto", True, " OK... Consulta de Productos COBIS") Then
            PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtCampo(1).Text = VGACatalogo.Codigo$
            lblDescripcion(1).Caption = VGACatalogo.Descripcion$
            If Trim$(txtCampo(1).Text) = "" Then
                txtCampo(1).Text = ""
                lblDescripcion(1).Caption = ""
                txtCampo(0).Text = ""
                lblDescripcion(2).Caption = ""
                txtCampo(2).Text = ""
                txtCampo(1).SetFocus
            Else
                txtCampo(0).Text = ""
                lblDescripcion(2).Caption = ""
                txtCampo(2).Text = ""
                txtCampo(1).SetFocus
            End If
        End If
    End Select
End If
End Sub
Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
 Select Case Index%
    Case 1, 2
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Case 0
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
    End Select
End Sub
Private Sub txtCampo_LostFocus(Index As Integer)
    If VLPaso% = True Then
        Exit Sub
    End If
        
    Select Case Index%
    Case 0

     If Trim$(txtCampo(1).Text) = "" Then
        lblDescripcion(1).Caption = ""
        Exit Sub
     End If

     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4140"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "V1"
     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLProducto
     PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
     PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(0).Text
     PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, 2
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_parametro_extracto", True, " Consulta de Producto " & "[" & txtCampo(Index%).Text & "]") Then
         PMMapeaObjeto sqlconn&, lblDescripcion(2)
         PMChequea sqlconn&
         txtCampo(2).Text = ""
         txtCampo(2).SetFocus
    Else
        txtCampo(0).Text = ""
        lblDescripcion(2).Caption = ""
        txtCampo(0).SetFocus
    End If
    
    Case 1
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4140"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLProducto
         PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_parametro_extracto", True, " Consulta de Producto " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(1)
             PMChequea sqlconn&
             txtCampo(0).Text = ""
             lblDescripcion(2).Caption = ""
             txtCampo(2).Text = ""
        Else
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            txtCampo(0).Text = ""
            lblDescripcion(2).Caption = ""
            txtCampo(2).Text = ""
            txtCampo(1).SetFocus
        End If
    End Select
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1, 2
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


Private Sub cmdBoton_Click(Index As Integer)
If cmbTipo.Text = "CUENTA CORRIENTE" Then
   VLProducto = "3"
ElseIf cmbTipo.Text = "CUENTA DE AHORRO" Then
  VLProducto = "4"
End If

Select Case Index%
Case 0
     PLBuscar
 Case 1
     PLSiguientes
Case 2
     PLTransmitir
 Case 3
    PLActualizar
 Case 4
    PLEliminar
Case 5
    PLLimpiar
Case 6
    Unload FParExt
 End Select
End Sub
Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Permite eliminar registro tope por oficina
' INPUT    : Ninguno
'OUTPUT:     Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 15-Jun-2011    S.Molano        Emisión Inicial
'*************************************************************
'Buscar
    'PLLimpiar
    PMLimpiaGrid grdCategorias
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4138"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S2"
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLProducto
    PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT1, txtCampo(1).Text
    PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(0).Text
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_parametro_extracto", True, " Ok... Consulta de Parametros Extracto") Then
       PMMapeaGrid sqlconn&, grdCategorias, False
       PMChequea sqlconn&
       PLGrilla
       
       If grdCategorias.Tag >= 20 Then
          cmdBoton(1).Enabled = True
       Else
          cmdBoton(1).Enabled = False
       End If
       'PLModoInsertar False

    Else
       PLModoInsertar True
       txtCampo(1).SetFocus
    End If
End Sub
Private Sub PLSiguientes()
'*************************************************************
' PROPOSITO: Permite eliminar registro tope por oficina
' INPUT    : Ninguno
'OUTPUT:     Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 15-Jun-2011    S.Molano        Emisión Inicial
'*************************************************************
'Buscar
    'PLSiguientes
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4138"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S3"
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLProducto
    
    grdCategorias.Col = 1
    grdCategorias.Row = grdCategorias.Rows - 1
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, (grdCategorias.Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_parametro_extracto", True, " Ok... Consulta de Parametros Extracto") Then
       PMMapeaGrid sqlconn&, grdCategorias, True
       PMChequea sqlconn&
       PLGrilla
       
       If grdCategorias.Tag >= 20 Then
          cmdBoton(1).Enabled = True
       Else
          cmdBoton(1).Enabled = False
       End If
       'PLModoInsertar False
       
    Else
       PLModoInsertar True
       txtCampo(1).SetFocus
    End If
End Sub
Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Permite eliminar registro tope por oficina
' INPUT    : Ninguno
'OUTPUT:     Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 15-Jun-2011    S.Molano        Emisión Inicial
'*************************************************************
'Transmitir

If Trim$(txtCampo(1).Text) = "" Then
    MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
    txtCampo(1).SetFocus
    Exit Sub
End If

If Trim$(txtCampo(0).Text) = "" Then
    MsgBox "La categoria es mandatoria", 0 + 16, "Mensaje de Error"
    txtCampo(0).SetFocus
    Exit Sub
End If

If Trim$(txtCampo(2).Text) = "" Then
    MsgBox "El Valor del Parametro es Obligatorio", 0 + 16, "Mensaje de Error"
    txtCampo(2).SetFocus
    Exit Sub
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4136"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLProducto
PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(0).Text
PMPasoValores sqlconn&, "@i_valor", 0, SQLINT2, txtCampo(2).Text

If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_parametro_extracto", True, " Ok... Creación de Categoría por Producto Final") Then
   PMMapeaGrid sqlconn&, grdCategorias, False
   PMChequea sqlconn&
   PLBuscar
   txtCampo(1).SetFocus
Else
   txtCampo(1).SetFocus
End If
End Sub
Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Permite eliminar registro tope por oficina
' INPUT    : Ninguno
'OUTPUT:     Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 15-Jun-2011    S.Molano        Emisión Inicial
'*************************************************************
'Eliminar
Const MB_YESNO = 4
Const MB_ICONQUESTION = 32
Const MB_DEBUTTON1 = 0
'! removed Const IDNO = 7
'! removed Const IDCANCEL = 2
'! removed Const MB_DEFBUTTON1 = 0
Const IDYES = 6
'FIXIT: Declare 'DgDef' and 'Response' with an early-bound data type                       FixIT90210ae-R1672-R1B8ZE
Dim DgDef As Integer
Dim Response As String

DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1

Response = MsgBox("Esta Seguro de Eliminar el Registro ?", DgDef, "Mensaje de Seguridad")
If Response = IDYES Then
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4139"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLProducto
     PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
     PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(0).Text
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_parametro_extracto", True, " Ok... Eliminacion Parametro Impresion de Extracto") Then
        PMChequea sqlconn&
        PMLimpiaGrid grdCategorias
        PLLimpiar
        'cmdBoton_Click (0)
    End If
Else
    Exit Sub
End If
End Sub
Private Sub PLActualizar()
'*************************************************************
' PROPOSITO: Permite eliminar registro tope por oficina
' INPUT    : Ninguno
'OUTPUT:     Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 15-Jun-2011    S.Molano        Emisión Inicial
'*************************************************************
'Actualizar
 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4137"
 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
 PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
 PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLProducto
 PMPasoValores sqlconn&, "@i_valor", 0, SQLINT1, txtCampo(2).Text
 PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(0).Text
 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_parametro_extracto", True, " Ok... Actualización Parametro Impresion de Extracto") Then
    PMChequea sqlconn&
    cmdBoton_Click (0)
End If
End Sub
Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia todos los valores de los objetos y del
'            grid de la forma.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 13-Jun-2011    Saira Molano    Emisión Inicial
'*************************************************************
PMLimpiaGrid grdCategorias
lblDescripcion(0).Caption = ""
lblDescripcion(1).Caption = ""
lblDescripcion(2).Caption = ""
txtCampo(0).Text = ""
txtCampo(1).Text = ""
txtCampo(2).Text = ""
txtCampo(1).SetFocus
PLModoInsertar True
End Sub
Private Sub PLGrilla()
'*************************************************************
' PROPOSITO: Permite eliminar registro tope por oficina
' INPUT    : Ninguno
'OUTPUT:     Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 15-Jun-2011    S.Molano        Emisión Inicial
'*************************************************************
       grdCategorias.ColWidth(1) = 700
       grdCategorias.ColWidth(2) = 1000
       grdCategorias.ColWidth(3) = 2200
       grdCategorias.ColWidth(4) = 1800
       grdCategorias.ColWidth(5) = 4200
End Sub


