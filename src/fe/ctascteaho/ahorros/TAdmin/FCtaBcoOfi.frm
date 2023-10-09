VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FCtaBcoOfi 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Parametrización Cuenta de Consignación por Oficina"
   ClientHeight    =   5700
   ClientLeft      =   45
   ClientTop       =   1800
   ClientWidth     =   9300
   ForeColor       =   &H00FFFFFF&
   HelpContextID   =   1072
   Icon            =   "FCtaBcoOfi.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   6101.408
   ScaleMode       =   0  'User
   ScaleWidth      =   9300
   Tag             =   "672"
   Begin VB.Frame Frame1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Cuenta de Consignacion en Banco x Oficina"
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
      Height          =   3420
      Index           =   0
      Left            =   45
      TabIndex        =   11
      Top             =   2235
      Width           =   8190
      Begin MSGrid.Grid grdRegistros 
         Height          =   3030
         Left            =   120
         TabIndex        =   12
         TabStop         =   0   'False
         Top             =   240
         Width           =   7935
         _Version        =   65536
         _ExtentX        =   13996
         _ExtentY        =   5345
         _StockProps     =   77
         ForeColor       =   0
         BackColor       =   16777215
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "Times New Roman"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
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
      Height          =   2160
      Index           =   0
      Left            =   45
      TabIndex        =   13
      Top             =   -15
      Width           =   8175
      Begin VB.Frame Frame3 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Compensa?"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000080&
         Height          =   1335
         Left            =   120
         TabIndex        =   17
         Top             =   720
         Width           =   7935
         Begin VB.Frame FrmComprensa 
            BackColor       =   &H00C0C0C0&
            BorderStyle     =   0  'None
            Height          =   495
            Left            =   1560
            TabIndex        =   22
            Top             =   120
            Width           =   2655
            Begin VB.OptionButton Optcompensa 
               BackColor       =   &H00C0C0C0&
               Caption         =   "Si"
               Height          =   330
               Index           =   0
               Left            =   120
               TabIndex        =   1
               TabStop         =   0   'False
               Top             =   120
               Value           =   -1  'True
               Width           =   600
            End
            Begin VB.OptionButton Optcompensa 
               BackColor       =   &H00C0C0C0&
               Caption         =   "No"
               Height          =   330
               Index           =   1
               Left            =   1860
               TabIndex        =   2
               TabStop         =   0   'False
               Top             =   120
               Width           =   600
            End
         End
         Begin VB.TextBox txtCampo 
            Appearance      =   0  'Flat
            Enabled         =   0   'False
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
            Left            =   1635
            MaxLength       =   3
            TabIndex        =   3
            Top             =   645
            Width           =   1725
         End
         Begin VB.TextBox txtCampo 
            Appearance      =   0  'Flat
            Enabled         =   0   'False
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
            Index           =   2
            Left            =   1635
            MaxLength       =   15
            TabIndex        =   4
            Top             =   960
            Width           =   1725
         End
         Begin VB.Label lblEtiquetas 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Banco:"
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
            Index           =   3
            Left            =   720
            TabIndex        =   21
            Top             =   675
            Width           =   615
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
            Left            =   3375
            TabIndex        =   20
            Top             =   645
            Width           =   4395
         End
         Begin VB.Label lblEtiquetas 
            Appearance      =   0  'Flat
            AutoSize        =   -1  'True
            BackColor       =   &H80000005&
            BackStyle       =   0  'Transparent
            Caption         =   "Cuenta:"
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
            Index           =   2
            Left            =   720
            TabIndex        =   19
            Top             =   990
            Width           =   675
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
            Index           =   2
            Left            =   3375
            TabIndex        =   18
            Top             =   960
            Width           =   4395
         End
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
         Index           =   0
         Left            =   1815
         MaxLength       =   5
         TabIndex        =   0
         Top             =   255
         Width           =   885
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
         Left            =   2715
         TabIndex        =   15
         Top             =   255
         Width           =   5235
      End
      Begin VB.Label lblEtiquetas 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Codigo de oficina:"
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
         Index           =   0
         Left            =   180
         TabIndex        =   14
         Top             =   285
         Width           =   1560
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   1
      Left            =   8385
      TabIndex        =   6
      Tag             =   "697"
      Top             =   1590
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "&Ingresar"
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
      Picture         =   "FCtaBcoOfi.frx":000C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   4
      Left            =   8385
      TabIndex        =   9
      Top             =   4017
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "&Limpiar"
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
      Picture         =   "FCtaBcoOfi.frx":0326
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   0
      Left            =   8390
      TabIndex        =   5
      Tag             =   "696"
      Top             =   57
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "&Buscar"
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
      Picture         =   "FCtaBcoOfi.frx":13A8
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   2
      Left            =   8385
      TabIndex        =   7
      Tag             =   "697"
      Top             =   2400
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "&Eliminar"
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
      Picture         =   "FCtaBcoOfi.frx":242A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   5
      Left            =   8390
      TabIndex        =   10
      Top             =   4825
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "&Salir"
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
      Picture         =   "FCtaBcoOfi.frx":2D04
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   795
      Index           =   3
      Left            =   8385
      TabIndex        =   8
      Tag             =   "697"
      Top             =   3214
      Width           =   855
      _Version        =   65536
      _ExtentX        =   1508
      _ExtentY        =   1402
      _StockProps     =   78
      Caption         =   "&Modificar"
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
      Picture         =   "FCtaBcoOfi.frx":3D86
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   -15
      X2              =   8220
      Y1              =   2328.169
      Y2              =   2328.169
   End
   Begin VB.Label lblEtiquetas 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Codigo de la oficina:"
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
      Index           =   1
      Left            =   2640
      TabIndex        =   16
      Top             =   3000
      Width           =   1770
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8280
      X2              =   8265
      Y1              =   0
      Y2              =   6053.239
   End
End
Attribute VB_Name = "FCtaBcoOfi"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
        Case 0
            PLBuscar
        Case 1
            PLTransmitir "I"
        Case 2
            PLTransmitir "D"
        Case 3
            PLTransmitir "U"
        Case 4
            PLLimpiar
        Case 5
            Unload FCtaBcoOfi
    End Select
End Sub

Private Sub Form_Load()
    Me.Left = 15
    Me.Top = 15
    Me.Width = 9390
    Me.Height = 6180
    For i% = 0 To 1
        PMObjetoSeguridad cmdBoton(i%)
    Next i%
    cmdBoton(4).Enabled = True
    cmdBoton(5).Enabled = True
End Sub


Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdRegistros_Click()
    cmdBoton(5).Enabled = False
End Sub

Private Sub grdregistros_DblClick()
    grdRegistros.col = 1
    txtCampo(0).Text = grdRegistros.Text
    grdRegistros.col = 2
    lblDescripcion(0).Caption = grdRegistros.Text
    
    grdRegistros.col = 3
    Optcompensa(0).Value = False
    Optcompensa(1).Value = False
    If grdRegistros.Text = "S" Then
          Optcompensa(0).Value = True
    End If
    If grdRegistros.Text = "N" Then
          Optcompensa(1).Value = True
    End If
    
    grdRegistros.col = 4
    If grdRegistros.Text <> "" Then
       txtCampo(1).Text = grdRegistros.Text
       grdRegistros.col = 5
       lblDescripcion(1).Caption = grdRegistros.Text
    Else
       txtCampo(1).Text = ""
       lblDescripcion(1).Caption = ""
    End If
    
    grdRegistros.col = 6
    If grdRegistros.Text <> "" Then
       txtCampo(2).Text = grdRegistros.Text
       grdRegistros.col = 7
       lblDescripcion(2).Caption = grdRegistros.Text
    Else
       txtCampo(2).Text = ""
       lblDescripcion(2).Caption = ""
    End If
    
    For i% = 0 To 5
        cmdBoton(i%).Enabled = False
    Next i%
    cmdBoton(4).Enabled = True
    cmdBoton(5).Enabled = True
    PMObjetoSeguridad cmdBoton(0)
    PMObjetoSeguridad cmdBoton(2)
    PMObjetoSeguridad cmdBoton(3)
End Sub

Private Sub Optcompensa_Click(Index As Integer)
    If Index = 1 Then
        txtCampo(1).Enabled = True
        txtCampo(2).Enabled = True
    Else
        txtCampo(1).Enabled = False
        txtCampo(1).Text = ""
        lblDescripcion(1).Caption = ""
        txtCampo(2).Enabled = False
        txtCampo(2).Text = ""
        lblDescripcion(2).Caption = ""
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index
        Case 1
            txtCampo(2).Text = ""
            lblDescripcion(1).Caption = ""
            lblDescripcion(2).Caption = ""
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index
        Case 0
          FPrincipal!pnlHelpLine.Caption = "Oficina [F5 Ayuda]"
        Case 1
          FPrincipal!pnlHelpLine.Caption = "Banco [F5 Ayuda]"
        Case 2
          FPrincipal!pnlHelpLine.Caption = "Cuenta [F5 Ayuda]"
    End Select
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)

    If Keycode% <> VGTeclaAyuda% Then
         Exit Sub
    End If
    
    Select Case Index
        Case 0
            VGOperacion$ = "sp_oficina"
            VLPaso = True
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
            VLPaso% = True
        Case 1
            VLPaso% = False
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "452"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
            VGOperacion$ = "sp_catalogo_bancos"
            If FMTransmitirRPC(sqlconn&, "", "cob_remesas", "sp_cat_bancos", True, "Consulta de bancos") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                lblDescripcion(1).Caption = VGACatalogo.Descripcion$
                txtCampo(1).Text = VGACatalogo.Codigo$
            Else
                lblDescripcion(1).Caption = ""
                txtCampo(1).Text = ""
            End If
            VLPaso% = True
        Case 2
            Dim VTReg As String
            VLPaso% = True
'FIXIT: Replace 'RTrim' function with 'RTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'LTrim' function with 'LTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
            If LTrim$(RTrim(txtCampo(0))) = "" Then
                MsgBox "Código de la oficina es obligatorio"
                txtCampo(0).SetFocus
                Exit Sub
            End If
            
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 29265
            PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "C"
            PMPasoValores sqlconn&, "@i_comercial", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, CStr(txtCampo(0))
            PMPasoValores sqlconn&, "@i_bco", 0, SQLINT2, CStr(txtCampo(1))
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_sbancarios", "sp_bus_subtipos", True, " Consulta Cuentas") Then
                PMMapeaVariable sqlconn&, VTReg
                PMMapeaGrid sqlconn&, grid_valores!gr_SQL, False
                PMChequea sqlconn&
                grid_valores.Show 1
'FIXIT: Replace 'RTrim' function with 'RTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'LTrim' function with 'LTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
                If LTrim$(RTrim(txtCampo(1))) = "" Then
                    txtCampo(1).Text = Temporales(1)
                    lblDescripcion(1).Caption = Temporales(2)
                End If
                txtCampo(Index%).Text = Temporales(3)
                lblDescripcion(Index%).Caption = Temporales(4)
            Else
                txtCampo(Index%).Text = ""
                txtCampo(Index%).SetFocus
                lblDescripcion(Index%).Caption = ""
            End If
            VLPaso% = True
    End Select
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
  Select Case Index
    Case 0, 1, 2
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
  End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)

Dim VTR As Integer
    Select Case Index
        Case 0
            If txtCampo(Index%).Text <> "" Then
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
            End If
        Case 1
            If VLPaso% = False And txtCampo(Index%).Text <> "" Then
                VGOperacion$ = "sp_cat_bancos"
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "452"
                PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT1, txtCampo(Index%).Text
    
                If FMTransmitirRPC(sqlconn&, "", "cob_remesas", "sp_cat_bancos", True, "Consulta de bancos") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(Index%)
                    PMChequea sqlconn&
                Else
                    txtCampo(Index%).Text = ""
                    lblDescripcion(Index%).Caption = ""
                End If
            End If
        Case 2
            If txtCampo(Index%).Text <> "" Then
                ReDim VTArreglo(10)
                Dim VTReg As String
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 29265
                PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "C"
                PMPasoValores sqlconn&, "@i_comercial", 0, SQLCHAR, "S"
                PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, CStr(txtCampo(0))
                PMPasoValores sqlconn&, "@i_bco", 0, SQLINT2, CStr(txtCampo(1))
                PMPasoValores sqlconn&, "@i_cuenta", 0, SQLCHAR, CStr(txtCampo(2))
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_sbancarios", "sp_bus_subtipos", True, " Consulta Cuentas") Then
                    PMMapeaVariable sqlconn&, VTReg
                    VTR = FMMapeaArreglo(sqlconn&, VTArreglo())
                    PMChequea sqlconn&
                    If VTR% > 0 Then
                        txtCampo(Index%).Text = VTArreglo(3)
                        lblDescripcion(Index%).Caption = VTArreglo(4)
                    Else
                        txtCampo(Index%).Text = ""
                        lblDescripcion(Index%).Caption = ""
                        txtCampo(Index%).SetFocus
                    End If
                Else
                    txtCampo(Index%).Text = ""
                    txtCampo(Index%).SetFocus
                    lblDescripcion(Index%).Caption = ""
                End If
            End If
    End Select
    
    If txtCampo(Index%).Text = "" Then
        lblDescripcion(Index%).Caption = ""
    End If
End Sub

Public Sub PLBuscar()
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "696"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "S"
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, "0"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "0"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_ctabco_oficina", True, "Consulta tipo de canje") Then
        PMMapeaGrid sqlconn&, grdRegistros, False
        PMChequea sqlconn&
        While Val(grdRegistros.Tag) >= 20
            PLSiguientes
        Wend
        
        grdRegistros.ColWidth(1) = 700
        grdRegistros.ColWidth(2) = 1800
        grdRegistros.ColWidth(3) = 1000
        grdRegistros.ColWidth(4) = 400
        grdRegistros.ColWidth(5) = 1900
        grdRegistros.ColWidth(6) = 1100
        grdRegistros.ColWidth(7) = 2500
     End If
End Sub

Public Sub PLTransmitir(operacion As String)
Dim VTTran As String

    VTTran = 697
    If operacion = "I" Or operacion = "U" Then
        If FLChequea = False Then
            Exit Sub
        End If
    End If
    If operacion = "D" Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If (Trim$(txtCampo(0).Text) = "") Then
            MsgBox "El campo codigo de oficina es mandatorio.", vbCritical
            txtCampo(0).SetFocus
            Exit Sub
        End If
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VTTran$
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, operacion
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (txtCampo(0).Text)
    If operacion = "I" Or operacion = "U" Then
        If Optcompensa(0).Value = True Then
            PMPasoValores sqlconn&, "@i_compensa", 0, SQLCHAR, "S"
        Else
            PMPasoValores sqlconn&, "@i_compensa", 0, SQLCHAR, "N"
            PMPasoValores sqlconn&, "@i_banco", 0, SQLINT2, (txtCampo(1).Text)
            PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (lblDescripcion(2).Caption)
        End If
    End If
   
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_ctabco_oficina", True, "Consulta tipo de canje") Then
         PMChequea sqlconn&
         PLLimpiar
    Else
         PMChequea sqlconn&
         txtCampo(0).SetFocus
    End If
   
   PLBuscar

 
 End Sub

Public Sub PLLimpiar()
    For i% = 0 To 2
        txtCampo(i%).Text = ""
        lblDescripcion(i%).Caption = ""
        If i% > 0 Then
            txtCampo(i%).Enabled = False
        End If
    Next i%
    grdRegistros.Rows = 2
    For i% = 0 To grdRegistros.Cols - 1
        grdRegistros.col = i%
        For j% = 0 To 1
            grdRegistros.Row = j%
            grdRegistros.Text = ""
        Next j%
    Next i%
    
    For i% = 0 To 5
        cmdBoton(i%).Enabled = False
    Next i%
    
    For i% = 0 To 1
        PMObjetoSeguridad cmdBoton(i%)
    Next i%
    
    cmdBoton(4).Enabled = True
    cmdBoton(5).Enabled = True
    
    Optcompensa(0).Value = False
    Optcompensa(1).Value = False
 
End Sub

Public Sub PLSiguientes()
    grdRegistros.Row = grdRegistros.Rows - 1
    grdRegistros.col = 1
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "696"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "S"
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (grdRegistros.Text)
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "1"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_ctabco_oficina", True, "Consulta tipo de canje") Then
        PMMapeaGrid sqlconn&, grdRegistros, True
        PMChequea sqlconn&
       If Val(grdRegistros.Tag) >= 20 Then
           cmdBoton(5).Enabled = True
       Else
           cmdBoton(5).Enabled = False
       End If
    End If
End Sub

'FIXIT: Declare 'FLChequea' with an early-bound data type                                  FixIT90210ae-R1672-R1B8ZE
Public Function FLChequea()
    FLChequea = False
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If (Trim(txtCampo(0).Text) = "") Then
       MsgBox "El campo codigo de oficina es mandatorio.", vbCritical
       txtCampo(0).SetFocus
       Exit Function
    End If
    If Optcompensa(0).Value = False And Optcompensa(1).Value = False Then
       MsgBox "El campo compensa es mandatorio.", vbCritical
       Exit Function
    End If
    
    If Optcompensa(1).Value = True Then
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If (Trim$(txtCampo(1).Text) = "") Then
           MsgBox "El campo banco es mandatorio.", vbCritical
           txtCampo(1).SetFocus
           Exit Function
        End If
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If (Trim$(txtCampo(2).Text) = "") Then
           MsgBox "El campo cuenta es mandatorio.", vbCritical
           txtCampo(2).SetFocus
           Exit Function
        End If
    End If
    FLChequea = True
End Function
 


