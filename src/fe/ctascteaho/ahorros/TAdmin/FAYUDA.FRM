VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "THREED32.OCX"
Begin VB.Form FAyuda 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Lista de Registros"
   ClientHeight    =   3555
   ClientLeft      =   915
   ClientTop       =   1695
   ClientWidth     =   6360
   ControlBox      =   0   'False
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
   Icon            =   "FAYUDA.frx":0000
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   3555
   ScaleWidth      =   6360
   Begin Threed.SSCommand cmdSeleccion 
      Height          =   870
      Index           =   3
      Left            =   5475
      TabIndex        =   4
      Top             =   2670
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Salir"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      RoundedCorners  =   0   'False
      Picture         =   "FAYUDA.frx":000C
   End
   Begin Threed.SSCommand cmdSeleccion 
      Height          =   870
      Index           =   2
      Left            =   5475
      TabIndex        =   3
      Top             =   1785
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Escoger"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
      RoundedCorners  =   0   'False
      Picture         =   "FAYUDA.frx":0382
   End
   Begin Threed.SSCommand cmdSeleccion 
      Height          =   870
      Index           =   1
      Left            =   5475
      TabIndex        =   2
      Top             =   900
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "Sig&tes."
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
      RoundedCorners  =   0   'False
      Picture         =   "FAYUDA.frx":06F8
   End
   Begin Threed.SSCommand cmdSeleccion 
      Height          =   870
      Index           =   0
      Left            =   5475
      TabIndex        =   1
      Top             =   15
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Buscar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      RoundedCorners  =   0   'False
      Picture         =   "FAYUDA.frx":0A6E
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3525
      Left            =   15
      TabIndex        =   0
      Top             =   15
      Width           =   5400
      _Version        =   65536
      _ExtentX        =   9526
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
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   5445
      X2              =   5445
      Y1              =   0
      Y2              =   3540
   End
End
Attribute VB_Name = "FAyuda"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub cmdSeleccion_Click(Index As Integer)
    Select Case Index%
    Case 0
        PLBuscar VGOperacion$
    Case 1
        PLSiguientes VGOperacion$
    Case 2
        PLSeleccionar
    Case 3
        PLSalir
    End Select
End Sub

Private Sub Form_KeyPress(KeyAscii As Integer)
    If KeyAscii% = 27 Then
        PLSalir
    End If
End Sub

Private Sub Form_Load()
    PLBuscar VGOperacion$
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

Private Sub grdRegistros_DblClick()
    PLSeleccionar
End Sub

Private Sub grdRegistros_KeyDown(KeyCode As Integer, Shift As Integer)
   ' If KeyCode% = 115 Then
   '     PMCopyClip grdRegistros
   ' End If
End Sub

Private Sub grdRegistros_KeyPress(KeyAscii As Integer)
    If KeyAscii% = 13 Then
        PLSeleccionar
    End If
End Sub

Private Sub PLBuscar(Tipo As String)
    Select Case Tipo$
    Case "sp_tipo_plan"
        FAyuda.Caption = "Lista de Plan Tipo"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6007"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_tipo_plan", True, " Consulta de tipos de planes") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "cb_categoria"
        FAyuda.Caption = "Lista de Categorías"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "cb_categoria"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, "1"
         'PMPasoValores SqlConn&, "@i_oficina", 0, SQLINT1, "1"
        'Cambio del tipo de dato para el campo oficina
        'M. Silva.  Banco del Estado.  Febrero 25 1998
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, "1"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de categorías") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_moneda"
        FAyuda.Caption = "Lista de Monedas"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1556"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_moneda", True, " Consulta de monedas") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_empresa"
        FAyuda.Caption = "Lista de Empresas"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6037"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_empresa", True, " Consulta de empresas") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_oficina"
        FAyuda.Caption = "Lista de Entidades"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6157"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_oficina", True, " Consulta de entidades") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_organizacion"
        FAyuda.Caption = "Lista de Niveles Organizacionales"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6057"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT2, VGAyuda(1)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_organizacion", True, " Lista de niveles jerárquicos") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_relacion"
        FAyuda.Caption = "Lista de Cuentas de Movimiento"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6070"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT2, VGAyuda(1)
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGAyuda(2)
         PMPasoValores sqlconn&, "@i_seccion", 0, SQLVARCHAR, VGAyuda(3)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_relacion", True, " Consulta de cuentas de movimiento") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_cuenta_movimiento"
        FAyuda.Caption = "Lista de Cuentas de Movimiento"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6077"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT2, VGAyuda(1)
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGAyuda(2)
         PMPasoValores sqlconn&, "@i_departamento", 0, SQLINT2, VGAyuda(4)
         PMPasoValores sqlconn&, "@i_seccion", 0, SQLVARCHAR, VGAyuda(3)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_cuenta_movimiento", True, " Consulta de cuentas de movimiento") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If

    Case "sp_comp_tipo"
        FAyuda.Caption = "Lista de Comprobantes Tipo"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6127"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_comp_tipo", True, " Lista de comprobantes tipo") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_departamento"
        FAyuda.Caption = "Lista de Departamento"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6197"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_departamento", True, " Consulta de departamentos") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_oficina_departamento"
        FAyuda.Caption = "Lista de Departamento"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6247"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
         'PMPasoValores SqlConn&, "@i_oficina", 0, SQLINT1, VGAyuda(2)
        'Cambio del tipo de dato para el campo oficina
        'M. Silva.  Banco del Estado.  Febrero 25 1998
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGAyuda(2)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_oficina_departamento", True, " Consulta de departamentos") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_periodo"
        FAyuda.Caption = "Lista de Períodos Contables"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6097"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_periodo", True, " Lista de períodos contables") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_nivel_departamento"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6185"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_nivel_departamento", True, " Lista de niveles departamentales") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_seccion"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "ca_seccion"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         'PMPasoValores SqlConn&, "@i_oficina", 0, SQLINT1, VGOficina$
        'Cambio del tipo de dato para el campo oficina.
        'M. Silva.  Banco del Estado.  Febrero 25 1998.
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Lista de secciones bancarias") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_proceso"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_conta", "sp_proceso", True, " Lista de procesos") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_batch"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "8007"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         'PMPasoValores SqlConn&, "@i_producto", 0, SQLINT1, "11"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_batch", True, " Lista de procesos") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_pro_transaccion"
        FAyuda.Caption = "Lista de Transacciones"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "15020"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VGAyuda(1)
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGAyuda(2)
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, VGAyuda(3)
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "8"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_pro_transaccion", True, " Consulta de transacciones") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_parametriza_sol"
        FAyuda.Caption = "Grupos Solicitud de Productos"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "162"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametriza_sol", True, " Consulta Grupos Solictud Productos") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    Case "sp_alianzas"
          FAyuda.Caption = "Alianzas Comerciales"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "Q"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1615"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_alianzas", True, "Ayuda Cliente") Then
             PMMapeaGrid sqlconn&, grdRegistros, False
             PMChequea sqlconn&
        End If
    End Select
    If Val(grdRegistros.Tag) > 0 Then
        cmdSeleccion(2).Enabled = True
        If Val(grdRegistros.Tag) >= 20 Then
            cmdSeleccion(1).Enabled = True
        Else
            cmdSeleccion(1).Enabled = False
        End If
    Else
        cmdSeleccion(2).Enabled = False
    End If
End Sub

Private Sub PLSalir()
    ReDim VGAyuda(5) As String
    For i% = 1 To 5
        VGAyuda(i%) = ""
    Next i%
    Unload FAyuda
End Sub

Private Sub PLSeleccionar()
    If (grdRegistros.Cols - 1) = 1 Then
        ReDim VGAyuda(5) As String
        For i% = 1 To 5
            VGAyuda(i%) = ""
        Next i%
    Else
        ReDim VGAyuda(grdRegistros.Cols - 1) As String
        For i% = 1 To grdRegistros.Cols - 1
            grdRegistros.Col = i%
            VGAyuda(i%) = grdRegistros.Text
        Next i%
    End If
    Unload FAyuda
End Sub

Private Sub PLSiguientes(Tipo As String)
    Select Case Tipo$
    Case "sp_tipo_plan"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6007"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_tipo_plan", 0, SQLCHAR, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_tipo_plan", True, " Consulta de tipos de planes") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_moneda"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1556"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_moneda", True, " Consulta de monedas") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_empresa"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6037"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_empresa", True, " Consulta de empresas") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_oficina"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6157"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_oficina", True, " Consulta de entidades") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_organizacion"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6057"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_organizacion", 0, SQLINT1, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_organizacion", True, " Lista de niveles jerárquicos") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_relacion"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6070"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT2, VGAyuda(1)
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGAyuda(2)
         PMPasoValores sqlconn&, "@i_seccion", 0, SQLVARCHAR, VGAyuda(3)
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_relacion", True, " Lista de cuentas de movimiento") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_cuenta_movimiento"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6077"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT2, VGAyuda(1)
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGAyuda(2)
         PMPasoValores sqlconn&, "@i_departamento", 0, SQLINT2, VGAyuda(4)
         PMPasoValores sqlconn&, "@i_seccion", 0, SQLVARCHAR, VGAyuda(3)
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_cuenta_movimiento", True, " Lista de cuentas de movimiento") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_comp_tipo"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6127"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_comp_tipo", 0, SQLINT1, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_comp_tipo", True, " Lista de comprobantes tipo") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_oficina_departamento"
        FAyuda.Caption = "Lista de Departamento"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6247"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
         'PMPasoValores SqlConn&, "@i_oficina", 0, SQLINT1, VGAyuda(2)
        'Cambio del tipo de dato para el campo oficina.
        'M. Silva.  Banco del Estado.  Febrero 25 1998.
         PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGAyuda(2)
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_departamento", 0, SQLINT1, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_oficina_departamento", True, " Consulta de departamentos") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_departamento"
        FAyuda.Caption = "Lista de Departamento"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6197"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_departamento", 0, SQLINT1, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_departamento", True, " Consulta de departamentos") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_periodo"
        FAyuda.Caption = "Lista de Períodos Contables"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6097"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_periodo", 0, SQLINT1, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_periodo", True, " Lista de períodos contables") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_nivel_departamento"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "6185"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_nivel", 0, SQLINT1, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, DatabaseName$, "sp_nivel_departamento", True, " Lista de niveles departamentales") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_proceso"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_empresa", 0, SQLINT1, VGAyuda(1)
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_proceso", 0, SQLINT4, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_conta", "sp_proceso", True, " Lista de procesos") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_batch"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "8007"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
         'PMPasoValores SqlConn&, "@i_producto", 0, SQLINT1, "6"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_batch", 0, SQLINT4, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_batch", True, " Lista de procesos") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    Case "sp_pro_transaccion"
        FAyuda.Caption = "Lista de Transacciones"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "15020"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VGAyuda(1)
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGAyuda(2)
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, VGAyuda(3)
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "9"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        grdRegistros.Col = 1
        grdRegistros.Row = grdRegistros.Rows - 1
         PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT2, (grdRegistros.Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_pro_transaccion", True, " Consulta de transacciones") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
       Case "sp_alianzas"
          FAyuda.Caption = "Alianzas Comerciales"
          PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "Q"
          PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "1615"
          If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_alianzas", True, "Ayuda Cliente") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
        End If
    End Select
    If Val(grdRegistros.Tag) >= 20 Then
        cmdSeleccion(1).Enabled = True
    Else
        cmdSeleccion(1).Enabled = False
    End If
End Sub

