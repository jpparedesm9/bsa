VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FSubtipo 
   Caption         =   "Subtipos por Producto"
   ClientHeight    =   5325
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9300
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   2400
      MaxLength       =   1
      TabIndex        =   4
      Top             =   1015
      Width           =   570
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   3000
      MaxLength       =   64
      TabIndex        =   3
      Top             =   690
      Width           =   5310
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   2400
      MaxLength       =   3
      TabIndex        =   2
      Top             =   690
      Width           =   570
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   2400
      MaxLength       =   3
      TabIndex        =   1
      Top             =   360
      Width           =   570
   End
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      HelpContextID   =   1
      Left            =   2400
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   15
      Width           =   2505
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "*&Actualizar"
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
      Picture         =   "FSubtipo.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   8
      Tag             =   "4158"
      Top             =   3015
      WhatsThisHelpID =   2031
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "*&Crear"
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
      Picture         =   "FSubtipo.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   7
      Tag             =   "4158"
      Top             =   2250
      WhatsThisHelpID =   2030
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "*&Limpiar"
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
      Picture         =   "FSubtipo.frx":0614
      Style           =   1  'Graphical
      TabIndex        =   9
      Top             =   3780
      WhatsThisHelpID =   2003
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "*&Buscar"
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
      Picture         =   "FSubtipo.frx":097A
      Style           =   1  'Graphical
      TabIndex        =   6
      Tag             =   "4158"
      Top             =   15
      WhatsThisHelpID =   2000
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "*&Salir"
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
      Picture         =   "FSubtipo.frx":0BDC
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   4560
      WhatsThisHelpID =   2008
      Width           =   870
   End
   Begin MSGrid.Grid grdSubtipo 
      Height          =   3525
      Left            =   0
      TabIndex        =   5
      Top             =   1755
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Subtipos Creados"
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
      Index           =   5
      Left            =   120
      TabIndex        =   17
      Top             =   1500
      Width           =   2235
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   0
      X2              =   8370
      Y1              =   1440
      Y2              =   1440
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Estado:"
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
      Index           =   4
      Left            =   120
      TabIndex        =   16
      Top             =   1065
      WhatsThisHelpID =   5036
      Width           =   735
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   1
      Left            =   3000
      TabIndex        =   15
      Top             =   1015
      Width           =   5310
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*SubTipo Tarjeta Débito:"
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
      Left            =   105
      TabIndex        =   14
      Top             =   735
      WhatsThisHelpID =   5034
      Width           =   2130
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto Bancario:"
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
      Left            =   105
      TabIndex        =   13
      Top             =   375
      WhatsThisHelpID =   5033
      Width           =   1725
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   3000
      TabIndex        =   12
      Top             =   360
      Width           =   5310
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto Cobis:"
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
      Left            =   105
      TabIndex        =   11
      Top             =   60
      WhatsThisHelpID =   5032
      Width           =   1440
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8370
      X2              =   8370
      Y1              =   0
      Y2              =   5310
   End
End
Attribute VB_Name = "FSubtipo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Private Sub cmbTipo_GotFocus()
    FPrincipal.pnlHelpLine.Caption = "Producto Bancario " + CStr(cmbTipo.Text)
End Sub

Private Sub cmdBoton_Click(Index As Integer)
Dim VTFilas%
Dim VTCodigo$
Dim VLProd  As String
    Select Case Index%
    Case 0 'Buscar
        VTFilas% = VGMaxRows%
        VTCodigo$ = "0"
        While VTFilas% = VGMaxRows%
    
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4158"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
            VLProd = Mid$(cmbTipo.Text, 1, 1)
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, VLProd
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, txtCampo(0).Text
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "0"
            PMPasoValores sqlconn&, "@i_siguiente", 0, SQLINT2, VTCodigo$
            If txtCampo(1).Text <> "" Then
                PMPasoValores sqlconn&, "@i_subtipo", 0, SQLVARCHAR, txtCampo(1).Text
                PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "1"
            End If
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_std", True, "Ok..Creación de Producto") Then
                If VTCodigo$ = "0" Then
                    PMMapeaGrid sqlconn&, grdSubtipo, False
                Else
                    PMMapeaGrid sqlconn&, grdSubtipo, True
                End If
    
                PMChequea sqlconn&
                If txtCampo(1).Text = "" Then
                    VTFilas% = Val(grdSubtipo.Tag)
                    grdSubtipo.Col = 6
                    grdSubtipo.Row = grdSubtipo.Rows - 1
                    VTCodigo$ = grdSubtipo.Text
                    If Val(grdSubtipo.Tag) > 0 Then
                        grdSubtipo.ColWidth(6) = 1
                    End If
                End If
                If Val(grdSubtipo.Tag) < VGMaxRows Then
                    Exit Sub
                End If
            End If
        Wend
    Case 1 'Crear
        If txtCampo(1).Text = "" Then
            MsgBox "Ingrese el Código de Subtipo", 48, "Control Ingreso de Datos"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            MsgBox "Ingrese la Descripción del Código de Subtipo", 48, "Control Ingreso de Datos"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        If txtCampo(3).Text = "" Then
            MsgBox "Ingrese el Estado del Código de Subtipo", 48, "Control Ingreso de Datos"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4158"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
        VLProd = Mid$(cmbTipo.Text, 1, 1)
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, VLProd
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_subtipo", 0, SQLVARCHAR, txtCampo(1).Text
        PMPasoValores sqlconn&, "@i_desc_subtipo", 0, SQLVARCHAR, txtCampo(2).Text
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, txtCampo(3)
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "0"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_std", True, "Ok..Creación de Producto") Then
            'PMMapeaGrid sqlconn&, grdSubtipo, False
            PMChequea sqlconn&
            cmdBoton_Click (3)
            cmdBoton_Click (0)
        End If
    Case 2 'Actualizar
        If txtCampo(1).Text = "" Then
            MsgBox "Ingrese el Código de Subtipo", 48, "Control Ingreso de Datos"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            MsgBox "Ingrese la Descripción del Código de Subtipo", 48, "Control Ingreso de Datos"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        If txtCampo(3).Text = "" Then
            MsgBox "Ingrese el Estado del Código de Subtipo", 48, "Control Ingreso de Datos"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4158"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
        VLProd = Mid$(cmbTipo.Text, 1, 1)
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, VLProd
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_subtipo", 0, SQLVARCHAR, txtCampo(1).Text
        PMPasoValores sqlconn&, "@i_desc_subtipo", 0, SQLVARCHAR, txtCampo(2).Text
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, txtCampo(3)
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "0"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenimiento_std", True, "Ok..Creación de Producto") Then
            'PMMapeaGrid sqlconn&, grdSubtipo, False
            PMChequea sqlconn&
            cmdBoton_Click (3)
            cmdBoton_Click (0)
        End If
    Case 3 'Limpiar
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        txtCampo(3).Text = ""
        lblDescripcion(1).Caption = ""
        cmbTipo.ListIndex = 1
        txtCampo(1).Enabled = True
        txtCampo(1).SetFocus
        cmdBoton(1).Enabled = True
        cmdBoton(2).Enabled = False
    Case 4 'Salir
        Unload Me
    End Select
End Sub

Private Sub Form_Load()
    Me.Left = 15
    Me.Top = 15
    Me.Width = 9420
    Me.Height = 5730
    cmbTipo.AddItem "3 - CUENTA CORRIENTE", 0
    cmbTipo.AddItem "4 - CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 1
    PMLoadResStrings Me
    PMLoadResIcons Me
    PMObjetoSeguridad cmdBoton(0)
    PMObjetoSeguridad cmdBoton(1)
    PMObjetoSeguridad cmdBoton(2)
    cmdBoton(2).Enabled = False
    cmdBoton_Click (0)
End Sub



Private Sub grdSubtipo_DblClick()
Dim VTRow%
    VTRow% = grdSubtipo.Row
    grdSubtipo.Row = 1
    grdSubtipo.Col = 1

    If (grdSubtipo.Text <> "") Then
        grdSubtipo.Row = VTRow%
        ' Al marcar Registro se hace visible el botón de actualizar
        ' Se esconde el boton de insertar
        grdSubtipo.Col = 1
        txtCampo(0).Enabled = True
        txtCampo(0).Text = grdSubtipo.Text
        txtCampo(0).Enabled = False
        txtCampo_LostFocus (0)
        grdSubtipo.Col = 3
        txtCampo(1).Text = grdSubtipo.Text
        txtCampo(1).Enabled = False
        grdSubtipo.Col = 4
        txtCampo(2).Text = grdSubtipo.Text
        grdSubtipo.Col = 5
        txtCampo(3).Text = grdSubtipo.Text
        txtCampo_LostFocus (3)
        
        PMObjetoSeguridad cmdBoton(2)
        cmdBoton(1).Enabled = False
        txtCampo(2).SetFocus
        End If
End Sub


Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0
    Case 1
    Case 2, 3
'        txtCampo(Index%).Text = UCase(txtCampo(Index%).Text)
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = "Producto Cobis"
    Case 1
        FPrincipal.pnlHelpLine.Caption = "SubTipo Tarjeta Débito"
    Case 2
        FPrincipal.pnlHelpLine.Caption = "Descripción del SubTipo"
    Case 3
        FPrincipal.pnlHelpLine.Caption = "Estado [F5]"
    End Select
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
    Select Case Index%
    Case 3
        If KeyCode% = VGTeclaAyuda% Then
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "cl_estado_ser"
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de tipos de bloqueos") Then
                PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(Index%).Text = VGACatalogo.Codigo$
                lblDescripcion(1).Caption = VGACatalogo.Descripcion$
            Else
                txtCampo(Index%).Text = ""
                lblDescripcion(1).Caption = ""
                txtCampo(Index%).SetFocus
            End If
        End If
    End Select
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Case 2
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
            KeyAscii% = 0
        Else
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
    Case 3
        If (KeyAscii% <> 8) And (KeyAscii% <> 32) And (KeyAscii% < 65 Or KeyAscii% > 90) And (KeyAscii% < 97 Or KeyAscii% > 122) Then
            KeyAscii% = 0
        Else
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
        Case 0
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4003"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
            PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prod_bancario", False, "") Then
                PMMapeaObjeto sqlconn&, lblDescripcion(0)
                PMChequea sqlconn&
                txtCampo(Index%).Enabled = False
            End If
        Case 3
            If txtCampo(Index%).Text <> "" Then
                lblDescripcion(1).Caption = ""
                PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_estado"
                PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(Index%).Text)
                    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la oficina " & "[" & txtCampo(Index%).Text & "]") Then
                        PMMapeaObjeto sqlconn&, lblDescripcion(1)
                        PMChequea sqlconn&
                    Else
                        txtCampo(Index%).Text = ""
                        lblDescripcion(1).Caption = ""
                        txtCampo(Index%).SetFocus
                    End If
            Else
                lblDescripcion(1).Caption = ""
            End If
    End Select
End Sub



