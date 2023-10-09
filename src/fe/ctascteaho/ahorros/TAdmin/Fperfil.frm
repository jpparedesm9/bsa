VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FPerfil 
   Caption         =   "Perfiles Contables"
   ClientHeight    =   6210
   ClientLeft      =   45
   ClientTop       =   435
   ClientWidth     =   9105
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   6210
   ScaleWidth      =   9105
   Begin VB.Frame frmDatos 
      Height          =   1572
      Left            =   15
      TabIndex        =   11
      Top             =   0
      Width           =   8052
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   2
         Left            =   1500
         MaxLength       =   10
         TabIndex        =   4
         Top             =   1140
         Width           =   930
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   1500
         MaxLength       =   10
         TabIndex        =   3
         Top             =   840
         Width           =   930
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   1
         Left            =   1500
         MaxLength       =   3
         TabIndex        =   1
         Top             =   240
         Width           =   930
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   3
         Left            =   1500
         MaxLength       =   7
         TabIndex        =   2
         Top             =   540
         Width           =   930
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   288
         Index           =   2
         Left            =   2450
         TabIndex        =   18
         Top             =   1140
         Width           =   5520
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo Trn:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   192
         Index           =   2
         Left            =   60
         TabIndex        =   17
         Top             =   1140
         Width           =   768
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Perfil:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   192
         Index           =   1
         Left            =   60
         TabIndex        =   16
         Top             =   876
         Width           =   492
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   288
         Index           =   1
         Left            =   2450
         TabIndex        =   15
         Top             =   240
         Width           =   5520
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Producto:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   192
         Index           =   3
         Left            =   60
         TabIndex        =   14
         Top             =   240
         Width           =   804
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   288
         Index           =   3
         Left            =   2450
         TabIndex        =   13
         Top             =   540
         Width           =   5520
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Transacción:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   192
         Index           =   0
         Left            =   60
         TabIndex        =   12
         Top             =   540
         Width           =   1092
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   3
      Left            =   8160
      TabIndex        =   8
      Tag             =   "4010"
      Top             =   3852
      WhatsThisHelpID =   2006
      Width           =   876
      _Version        =   65536
      _ExtentX        =   1545
      _ExtentY        =   1333
      _StockProps     =   78
      Caption         =   "*&Eliminar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "Fperfil.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   0
      Left            =   8160
      TabIndex        =   5
      Tag             =   "4008"
      Top             =   2328
      WhatsThisHelpID =   2030
      Width           =   876
      _Version        =   65536
      _ExtentX        =   1545
      _ExtentY        =   1333
      _StockProps     =   78
      Caption         =   "*&Crear"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "Fperfil.frx":001C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   4
      Left            =   8160
      TabIndex        =   7
      Tag             =   "4009"
      Top             =   3096
      WhatsThisHelpID =   2031
      Width           =   876
      _Version        =   65536
      _ExtentX        =   1545
      _ExtentY        =   1333
      _StockProps     =   78
      Caption         =   "*&Actualizar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "Fperfil.frx":0038
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   1
      Left            =   8160
      TabIndex        =   9
      Top             =   4620
      WhatsThisHelpID =   2003
      Width           =   876
      _Version        =   65536
      _ExtentX        =   1545
      _ExtentY        =   1333
      _StockProps     =   78
      Caption         =   "*&Limpiar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "Fperfil.frx":0054
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   2
      Left            =   8160
      TabIndex        =   10
      Top             =   5388
      WhatsThisHelpID =   2008
      Width           =   876
      _Version        =   65536
      _ExtentX        =   1545
      _ExtentY        =   1333
      _StockProps     =   78
      Caption         =   "*&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "Fperfil.frx":0070
   End
   Begin MSGrid.Grid GrdPerfiles 
      Height          =   4332
      Left            =   36
      TabIndex        =   6
      Top             =   1800
      Width           =   7968
      _Version        =   65536
      _ExtentX        =   14055
      _ExtentY        =   7641
      _StockProps     =   77
      BackColor       =   16777215
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   756
      Index           =   5
      Left            =   8160
      TabIndex        =   0
      Tag             =   "4011"
      Top             =   120
      WhatsThisHelpID =   2000
      Width           =   876
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Buscar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "Fperfil.frx":008C
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00400000&
      BorderWidth     =   2
      X1              =   0
      X2              =   8040
      Y1              =   1600
      Y2              =   1600
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00400000&
      BorderWidth     =   2
      X1              =   8076
      X2              =   8076
      Y1              =   0
      Y2              =   6960
   End
End
Attribute VB_Name = "FPerfil"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLPaso As Integer
Dim VLSecuencia As Integer

Sub PMProducto(ICampo As Integer, operacion As String, Producto As String)
    'Operacion: A - Search (F5), V - Query (LostFocus)
    VLPaso% = True
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "475"
    PMPasoValores sqlconn&, "@i_ope", 0, SQLCHAR, operacion
    If operacion = "V" Then
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, Producto
    End If
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_prod", True, " OK... Consulta de Productos COBIS") Then
        If operacion = "A" Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtCampo(ICampo).Text = VGACatalogo.Codigo$
            If ICampo > 0 Then lblDescripcion(ICampo).Caption = VGACatalogo.Descripcion$
        Else
            If ICampo > 0 Then PMMapeaObjeto sqlconn&, lblDescripcion(ICampo)
            PMChequea sqlconn&
        End If
        If Trim$(txtCampo(ICampo).Text) = "" Then
            If ICampo > 0 Then lblDescripcion(ICampo).Caption = ""
            If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                txtCampo(ICampo).SetFocus
            End If
        End If
    Else
            txtCampo(ICampo).Text = ""
            If ICampo > 0 Then lblDescripcion(ICampo).Caption = ""
            If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                txtCampo(ICampo).SetFocus
            End If

    End If
End Sub

Sub PMTransaccion(ICampo As Integer, IProducto As Integer, operacion As String, Transaccion As String)
    'Transacciones por producto
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(IProducto).Text) = "" Then
        MsgBox "CODIGO DE PRODUCTO ES OBLIGATORIO"
        If txtCampo(IProducto).Enabled And txtCampo(IProducto).Visible Then
           txtCampo(ICampo).Text = ""
           If ICampo > 0 Then lblDescripcion(ICampo).Caption = ""
           txtCampo(IProducto).SetFocus
        End If
        Exit Sub
    End If
    VLPaso% = True
    If operacion = "S" Then
        VGOperacion$ = "sp_pro_transaccion"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "15020"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, operacion
        PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "9"
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(IProducto)
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "R"
        PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda
        PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT4, "0"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_pro_transaccion", True, " OK... Consulta de Transacción") Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtCampo(ICampo).Text = VGACatalogo.Codigo$
            If ICampo > 0 Then lblDescripcion(ICampo).Caption = VGACatalogo.Descripcion$
            If Trim$(txtCampo(ICampo).Text) = "" Then
                txtCampo(ICampo).Text = ""
                If ICampo > 0 Then lblDescripcion(ICampo).Caption = ""
                If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                   txtCampo(ICampo).SetFocus
                End If
            End If
        End If
    Else
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "494"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, operacion
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, Transaccion
        PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP$
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
            If ICampo > 0 Then PMMapeaObjeto sqlconn&, lblDescripcion(ICampo)
            PMChequea sqlconn&
        Else
            txtCampo(ICampo).Text = ""
            If ICampo > 0 Then lblDescripcion(ICampo).Caption = ""
            If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                txtCampo(ICampo).SetFocus
            End If
        End If
    End If
End Sub

Sub PMPerfil(ICampo As Integer, IProducto As Integer)
    'Perfiles por producto
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(IProducto).Text) = "" Then
        MsgBox "CODIGO DE PRODUCTO ES OBLIGATORIO"
        If txtCampo(IProducto).Enabled And txtCampo(IProducto).Visible Then
           txtCampo(IProducto).SetFocus
        End If
        Exit Sub
    End If
    VLPaso% = True
    VGOperacion$ = "sp_perfil"
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6907"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "0"
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(IProducto)
    PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGFilial
    PMPasoValores sqlconn&, "@i_perfil", 0, SQLVARCHAR, "%"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_conta", "sp_perfil", True, " OK... Consulta de Productos COBIS") Then
        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
        PMChequea sqlconn&
        FCatalogo.Show 1
        txtCampo(ICampo).Text = VGACatalogo.Codigo
        If ICampo > 0 Then lblDescripcion(ICampo).Caption = VGACatalogo.Descripcion
        txtCampo(ICampo).Text = VGACatalogo.Descripcion         'mapea el codigo en la descripcion
        If ICampo > 0 Then lblDescripcion(ICampo).Caption = ""
        If Trim$(txtCampo(ICampo).Text) = "" And txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
            txtCampo(ICampo).SetFocus
        End If
    End If
End Sub

Sub PMCatalogo(ICampo As Integer, Tabla As String, operacion As String, Codigo As String)
    VGOperacion$ = ""
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, Tabla
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, operacion
    If operacion = "V" Then
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, Codigo
    End If
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de indicadores " & "[" & txtCampo(ICampo).Text & "]") Then
        If operacion = "A" Then
            VLPaso% = True
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtCampo(ICampo).Text = VGACatalogo.Codigo$
            If ICampo > 0 Then lblDescripcion(ICampo).Caption = VGACatalogo.Descripcion$
        Else
            If ICampo > 0 Then PMMapeaObjeto sqlconn&, lblDescripcion(ICampo)
            PMChequea sqlconn&
        End If
        If Trim$(txtCampo(ICampo).Text) = "" Then
            If ICampo > 0 Then lblDescripcion(ICampo).Caption = ""
            If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                txtCampo(ICampo).SetFocus
            End If
        End If
    End If
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Dim VTRespuesta As Integer
    Select Case Index%
        Case 0
            PLIngresar
        Case 1
            PLLimpiar
        Case 2
            PLSalir
        Case 3
            VTRespuesta% = MsgBox("Desea Eliminar el Perfil (S/N)", 4 + 16, "Transmision de Datos")
            If VTRespuesta = 6 Then
                PLEliminar
            End If
        Case 4
            PLActualizar
        Case 5
            PLBuscar
    End Select
End Sub

Private Sub PLActualizar()
    
    If Not FMValidaEntradas() Then Exit Sub
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "720"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
    PMPasoValores sqlconn&, "@i_secuencia", 0, SQLINT4, CStr(VLSecuencia%)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, Trim$(txtCampo(1).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT2, Trim$(txtCampo(3).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    PMPasoValores sqlconn&, "@i_perfil", 0, SQLVARCHAR, Trim$(txtCampo(0).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    PMPasoValores sqlconn&, "@i_tipo_trn", 0, SQLVARCHAR, Trim$(txtCampo(2).Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_par_perfil", True, "Ok... Actualización de Perfiles") Then
       PMChequea sqlconn&
    Else
       PMChequea sqlconn&
    End If
   
    PLLimpiar
    
    PLBuscar
End Sub
Private Sub PLEliminar()
    
    If Not FMValidaEntradas() Then Exit Sub
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "720"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
    PMPasoValores sqlconn&, "@i_secuencia", 0, SQLINT4, CStr(VLSecuencia%)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_par_perfil", True, "Ok... Eliminación de Perfiles") Then
       PMChequea sqlconn&
    Else
       PMChequea sqlconn&
    End If
     
    cmdBoton(3).Enabled = False
    
    PLLimpiar
    
    PLBuscar
    
End Sub

Private Sub PLIngresar()

    If Not FMValidaEntradas() Then Exit Sub
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "720"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, Trim$(txtCampo(1).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT2, Trim$(txtCampo(3).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    PMPasoValores sqlconn&, "@i_perfil", 0, SQLVARCHAR, Trim$(txtCampo(0).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    PMPasoValores sqlconn&, "@i_tipo_trn", 0, SQLVARCHAR, Trim$(txtCampo(2).Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_par_perfil", True, "Ok... Creación de Perfiles") Then
       PMChequea sqlconn&
    Else
       PMChequea sqlconn&
    End If
    
    cmdBoton(0).Enabled = False
    
    PLLimpiar
    
    PLBuscar

End Sub

Private Function FMValidaEntradas() As Integer
    FMValidaEntradas% = False
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(1).Text) = "" Then
        MsgBox "El campo Producto es Obligatorio", 48, "Control de Ingreso de Datos"
        txtCampo(1).SetFocus
        Exit Function
    End If
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(3).Text) = "" Then
        MsgBox "El campo Transacción es Obligatorio", 48, "Control de Ingreso de Datos"
        txtCampo(3).SetFocus
        Exit Function
    End If
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(0).Text) = "" Then
        MsgBox "El campo Perfil es Obligatorio", 48, "Control de Ingreso de Datos"
        txtCampo(0).SetFocus
        Exit Function
    End If
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(2).Text) = "" Then
        MsgBox "El campo Tipo de Transacción es Obligatorio", 48, "Control de Ingreso de Datos"
        txtCampo(2).SetFocus
        Exit Function
    End If
    FMValidaEntradas% = True
End Function

Private Sub PLBuscar()
    Dim VTSig%

    PMLimpiaG GrdPerfiles
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "721"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1&, txtCampo(1)
    PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT2&, txtCampo(3)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_par_perfil", True, "Busqueda de Registros") Then
        PMMapeaGrid sqlconn&, GrdPerfiles, False
        PMChequea sqlconn&
        VTSig% = True
        Do While VTSig% And GrdPerfiles.Rows - 1 > 1 And GrdPerfiles.Tag = 20
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "721"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1&, txtCampo(1)
            PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT2&, txtCampo(3)
            GrdPerfiles.Col = 5
            GrdPerfiles.Row = GrdPerfiles.Rows - 1
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(GrdPerfiles.Text) <> "" Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                PMPasoValores sqlconn&, "@i_secuencia", 0, SQLINT4, Trim$(GrdPerfiles.Text)
            End If
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_par_perfil", True, "Busqueda de Siguientes Registros") Then
                PMMapeaGrid sqlconn&, GrdPerfiles, True 'False
                PMChequea sqlconn&
                If GrdPerfiles.Tag = 20 Then
                    VTSig% = True
                Else
                    VTSig% = False
                End If
            Else
                VTSig% = False
            End If
        Loop
        PLFormatear
    Else
        PMChequea sqlconn&
    End If
End Sub

Private Sub PLFormatear()
    If GrdPerfiles.Rows - 1 > 1 Then
        GrdPerfiles.ColWidth(1) = 1200
        GrdPerfiles.ColWidth(2) = 2000
        GrdPerfiles.ColWidth(3) = 2000
        GrdPerfiles.ColWidth(4) = 2000
        GrdPerfiles.ColWidth(5) = 1
    End If
End Sub

Private Sub PLLimpiar()
    Dim i As Integer
    For i% = 0 To 3
        txtCampo(i%).Text = ""
    Next
    For i% = 1 To 3
        lblDescripcion(i%).Caption = ""
    Next
    PMLimpiaG GrdPerfiles
    VLSecuencia% = 0
    cmdBoton(5).Enabled = True
    cmdBoton(0).Enabled = True
    cmdBoton(3).Enabled = False
    cmdBoton(4).Enabled = False
End Sub

Private Sub PLSalir()
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
    Unload Me
End Sub

Private Sub Form_Load()
    Me.Left = 15
    Me.Top = 15
    Me.Width = 9225
    Me.Height = 6615
    PLLimpiar
    
    PMLoadResStrings Me
    PMLoadResIcons Me
End Sub


Private Sub GrdPerfiles_Click()
    PMLineaG GrdPerfiles
End Sub

Private Sub GrdPerfiles_DblClick()
    Dim VTArreglo(10) As String
    Dim VTCol As Integer
    Dim VTRow As Integer
    Dim VTR As Integer

    VTCol% = GrdPerfiles.Col
    VTRow% = GrdPerfiles.Row
    
    If VTRow% > 0 And GrdPerfiles.Text <> "" Then
        
        cmdBoton(0).Enabled = False
        cmdBoton(3).Enabled = True
        cmdBoton(4).Enabled = True
        
        PMLineaG GrdPerfiles
        
        GrdPerfiles.Col = 5
        GrdPerfiles.Row = VTRow%
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "721"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If Trim$(GrdPerfiles.Text) <> "" Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_secuencia", 0, SQLINT4, Trim$(GrdPerfiles.Text)
        End If
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_par_perfil", True, "Busqueda de Registro") Then
            VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
            PMChequea sqlconn&
            If VTR% > 0 Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                VLSecuencia% = CInt(Trim$(GrdPerfiles.Text))
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                txtCampo(1).Text = Trim$(VTArreglo(1))
                txtCampo_LostFocus (1)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                txtCampo(3).Text = Trim$(VTArreglo(2))
                txtCampo_LostFocus (3)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                txtCampo(0).Text = Trim$(VTArreglo(3))
                txtCampo_LostFocus (0)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
                txtCampo(2).Text = Trim$(VTArreglo(4))
                txtCampo_LostFocus (2)
            End If
        Else
            PMChequea sqlconn&
        End If
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(Index).Text) = "" And Index > 0 Then
        lblDescripcion(Index).Caption = ""
        If Index = 1 Then
            txtCampo(0).Text = ""
            txtCampo(3).Text = ""
            txtCampo(2).Text = ""
            PMLimpiaG GrdPerfiles
        End If
    End If
    VLPaso% = False
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda% Then
        Select Case Index%
            Case 0
                PMPerfil Index, 1
            Case 1
                PMProducto Index, "A", ""
            Case 2
                PMCatalogo Index, "re_tipo_trn", "A", ""
            Case 3
                PMTransaccion Index, 1, "S", ""
        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
        Case 0
            KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
        Case 1
            KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
        Case 2
            KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
        Case 3
            KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    If Not VLPaso% Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If Trim$(txtCampo(Index).Text) <> "" Then
            Select Case Index
                Case 0
                    'PMPerfil Index, 1
                Case 1
                    PMProducto Index, "V", txtCampo(Index).Text
                Case 2
                    PMCatalogo Index, "re_tipo_trn", "V", txtCampo(Index).Text
                Case 3
                    PMTransaccion Index, 1, "H", txtCampo(Index).Text
            End Select
        End If
    End If
End Sub

