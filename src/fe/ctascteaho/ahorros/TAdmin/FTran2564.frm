VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran2564 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenimiento Plazas de Banco de la República"
   ClientHeight    =   5355
   ClientLeft      =   120
   ClientTop       =   1740
   ClientWidth     =   9300
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5355
   ScaleWidth      =   9300
   Begin VB.Frame Frame1 
      BackColor       =   &H00C0C0C0&
      Caption         =   " Relación Plazas Banco República - Oficinas COBIS "
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
      Height          =   4005
      Index           =   0
      Left            =   60
      TabIndex        =   12
      Top             =   1245
      Width           =   8220
      Begin MSGrid.Grid grdRegistros 
         Height          =   3615
         Left            =   90
         TabIndex        =   14
         TabStop         =   0   'False
         Top             =   270
         Width           =   8055
         _Version        =   65536
         _ExtentX        =   14208
         _ExtentY        =   6376
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
      Begin VB.Label lblSecuencial 
         Height          =   255
         Left            =   3720
         TabIndex        =   13
         Top             =   1800
         Visible         =   0   'False
         Width           =   375
      End
   End
   Begin VB.Frame Frame4 
      BackColor       =   &H00C0C0C0&
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
      Height          =   1095
      Index           =   0
      Left            =   75
      TabIndex        =   7
      Top             =   45
      Width           =   8175
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   0
         Left            =   2265
         MaxLength       =   5
         TabIndex        =   0
         Top             =   255
         Width           =   780
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   285
         Index           =   1
         Left            =   2265
         MaxLength       =   6
         TabIndex        =   1
         Top             =   630
         Width           =   780
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Plaza Bco. República:"
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
         Height          =   195
         Index           =   12
         Left            =   240
         TabIndex        =   11
         Top             =   285
         Width           =   1905
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   3075
         TabIndex        =   10
         Top             =   255
         Width           =   4875
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Oficina COBIS:"
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
         Height          =   195
         Index           =   6
         Left            =   255
         TabIndex        =   9
         Top             =   675
         Width           =   1290
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   1
         Left            =   3075
         TabIndex        =   8
         Top             =   630
         Width           =   4875
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   1
      Left            =   8400
      TabIndex        =   3
      Top             =   915
      WhatsThisHelpID =   2030
      Width           =   855
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Ingresar"
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
      Picture         =   "FTran2564.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   3
      Left            =   8400
      TabIndex        =   5
      Top             =   3660
      WhatsThisHelpID =   2003
      Width           =   855
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
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
      Picture         =   "FTran2564.frx":001C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   0
      Left            =   8400
      TabIndex        =   2
      Top             =   90
      WhatsThisHelpID =   2000
      Width           =   855
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
      Picture         =   "FTran2564.frx":0038
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   2
      Left            =   8400
      TabIndex        =   4
      Top             =   2850
      WhatsThisHelpID =   2006
      Width           =   855
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
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
      Enabled         =   0   'False
      Picture         =   "FTran2564.frx":0054
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   4
      Left            =   8400
      TabIndex        =   6
      Top             =   4485
      WhatsThisHelpID =   2008
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
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
      Picture         =   "FTran2564.frx":0070
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8310
      X2              =   8325
      Y1              =   30
      Y2              =   5535
   End
End
Attribute VB_Name = "FTran2564"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Dim VLPaso As Integer
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
        Case 0  'Buscar centro canje
            PLBuscar
        Case 1  'Ingresar
            PLIngresar
        Case 2  'Modificar centro canje
            PLEliminar
        Case 3  'Eliminar centro canje
            PLLimpiar
        Case 4  'Limpiar centro canje
            Unload Me
    End Select
End Sub





Private Sub Form_Load()
    Me.Left = 15
    Me.Top = 15
    Me.Width = 9420
    Me.Height = 5730
    PMLoadResStrings Me
    PMLoadResIcons Me
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
Private Sub grdregistros_DblClick()
    grdRegistros.Col = 1        'Plaza
    txtCampo(0).Text = grdRegistros.Text
    grdRegistros.Col = 2        'Descripcion Plaza
    lblDescripcion(0).Caption = grdRegistros.Text
    grdRegistros.Col = 3        'Oficina
    txtCampo(1).Text = grdRegistros.Text
    grdRegistros.Col = 4        'Descripcion Oficina
    lblDescripcion(1).Caption = grdRegistros.Text
    txtCampo(0).SetFocus
End Sub

Private Sub txtCampo_Change(Index As Integer)
    VLPaso = False
    lblDescripcion(Index%).Caption = ""
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Plaza Banco República [F5 Ayuda]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Oficina [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode% <> VGTeclaAyuda% Then
        Exit Sub
    End If
    Select Case Index%
        Case 0      'Plazas Banco Republica
            VLPaso% = True
            VGOperacion$ = ""
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "cc_plazas_bco_rep"
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de Plazas Banco República") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(0).Text = VGACatalogo.Codigo$
                lblDescripcion(0).Caption = VGACatalogo.Descripcion$
            Else
                txtCampo(Index%).Text = ""
                txtCampo(Index%).SetFocus
                lblDescripcion(Index%).Caption = ""
            End If
        Case 1      'Oficina
            VGOperacion$ = "sp_oficina"
            VLPaso% = True
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina ") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(Index%).Text = VGACatalogo.Codigo$
                lblDescripcion(Index%).Caption = VGACatalogo.Descripcion$
            Else
                txtCampo(Index%).Text = ""
                txtCampo(Index%).SetFocus
                lblDescripcion(Index%).Caption = ""
            End If
  End Select
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    If VLPaso% <> False Or txtCampo(Index%).Text = "" Then
        Exit Sub
    End If
    
    Select Case Index
        Case 0      'Plazas Banco Republica
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cc_plazas_bco_rep"
            PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(Index%).Text)
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtCampo(Index%).Text & "]") Then
                VLPaso% = True
                PMMapeaObjeto sqlconn&, lblDescripcion(Index%)
                PMChequea sqlconn&
            Else
                txtCampo(Index%).Text = ""
                txtCampo(Index%).SetFocus
                lblDescripcion(Index%).Caption = ""
            End If
        Case 1      'Oficina
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
            PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(Index%).Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then
                VLPaso% = True
                PMMapeaObjeto sqlconn&, lblDescripcion(Index%)
                PMChequea sqlconn&
            Else
                txtCampo(Index%).Text = ""
                txtCampo(Index%).SetFocus
                lblDescripcion(Index%).Caption = ""
            End If
    End Select
End Sub
Public Sub PLIngresar()
    'Se validan campos mandatorios
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(0).Text) = "" Then
        MsgBox "El campo Plaza es mandatorio.", vbCritical
        txtCampo(0).SetFocus
        Exit Sub
    End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(1).Text) = "" Then
        MsgBox "El campo Oficina es mandatorio.", vbCritical
        txtCampo(1).SetFocus
        Exit Sub
    End If
                
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2564"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "I"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    PMPasoValores sqlconn&, "@i_plaza", 0, SQLINT2, Trim$(txtCampo(0).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, Trim$(txtCampo(1).Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_plazas_bco_rep", True, " Ok... Ingreso Relación Plaza-Oficina") Then
        PMChequea sqlconn&
        PLLimpiar
        PLBuscar
    Else
        PMChequea sqlconn&
        txtCampo(0).SetFocus
    End If
    
End Sub

Public Sub PLLimpiar()
    txtCampo(0).Text = ""
    txtCampo(1).Text = ""
    lblDescripcion(0).Caption = ""
    lblDescripcion(1).Caption = ""
    cmdBoton(2).Enabled = False
    PMLimpiaG grdRegistros
    txtCampo(0).SetFocus
End Sub

Public Sub PLBuscar()
Dim VTFilas As Integer
 
    VTFilas% = 56
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2564"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "S"
    If txtCampo(0).Text = "" Then
        PMPasoValores sqlconn&, "@i_plaza", 0, SQLINT2, "0"
    Else
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        PMPasoValores sqlconn&, "@i_plaza", 0, SQLINT2, Trim$(txtCampo(0).Text)
    End If
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, "0"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_plazas_bco_rep", True, " Ok... Consulta Plazas Bco. República") Then
        PMMapeaGrid sqlconn&, grdRegistros, False
        PMChequea sqlconn&
        If Val(grdRegistros.Tag) > 0 Then
            cmdBoton(2).Enabled = True
        End If
        While Val(grdRegistros.Tag) > 0 And (Val(grdRegistros.Tag) Mod VTFilas%) = 0
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2564"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "S"
            grdRegistros.Row = grdRegistros.Rows - 1
            grdRegistros.Col = 1    'Plaza
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_plaza", 0, SQLINT2, Trim$(grdRegistros.Text)
            grdRegistros.Col = 3    'Oficina
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, Trim$(grdRegistros.Text)
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_plazas_bco_rep", True, " Ok... Consulta Plazas Bco. República") Then
                PMMapeaGrid sqlconn&, grdRegistros, True
                PMChequea sqlconn&
            Else
                PMChequea sqlconn&
                Exit Sub
            End If
        Wend
    Else
        PMChequea sqlconn&
    End If
End Sub
Public Sub PLEliminar()
    Dim i As Integer
    'Se validan campos mandatorios
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(0).Text) = "" Or Trim$(lblDescripcion(0).Caption) = "" Then
        MsgBox "El campo Plaza es mandatorio.", vbCritical
        txtCampo(0).SetFocus
        Exit Sub
    End If
            
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(1).Text) = "" Or Trim$(lblDescripcion(1).Caption) = "" Then
        MsgBox "El campo Oficina es mandatorio.", vbCritical
        txtCampo(1).SetFocus
        Exit Sub
    End If
        
    i% = MsgBox("Está seguro de eliminar la relación Plaza-Oficina?", vbQuestion + vbYesNo)
    If i% = vbNo Then
        Exit Sub
    End If
            
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2564"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "D"
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    PMPasoValores sqlconn&, "@i_plaza", 0, SQLINT2, Trim$(txtCampo(0).Text)
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, Trim$(txtCampo(1).Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_plazas_bco_rep", True, " Ok... Eliminar Relación Plaza-Oficina") Then
        PMChequea sqlconn&
        PLLimpiar
        PLBuscar
    Else
        PMChequea sqlconn&
    End If
        
End Sub

