VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FMantCausalOfi 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenimiento Causales NC/ND por Oficina"
   ClientHeight    =   5355
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9330
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5355
   ScaleWidth      =   9330
   Begin VB.OptionButton optOpcion 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Oficina Específica"
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
      Height          =   255
      Index           =   1
      Left            =   5520
      TabIndex        =   20
      Top             =   60
      Width           =   2655
   End
   Begin VB.OptionButton optOpcion 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Generales"
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
      Height          =   255
      Index           =   0
      Left            =   3800
      TabIndex        =   19
      Top             =   60
      Width           =   1455
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   2
      Left            =   1680
      MaxLength       =   10
      TabIndex        =   1
      Top             =   400
      Width           =   1875
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   1
      Left            =   1680
      MaxLength       =   10
      TabIndex        =   2
      Top             =   730
      Width           =   1875
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   0
      Left            =   1680
      MaxLength       =   4
      TabIndex        =   3
      Top             =   1070
      Width           =   1875
   End
   Begin VB.ComboBox CmbProducto 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   1700
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   45
      Width           =   1890
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8450
      TabIndex        =   8
      Top             =   3700
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Limpiar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8450
      TabIndex        =   4
      Top             =   0
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Buscar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8450
      TabIndex        =   9
      Top             =   4455
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3435
      Left            =   0
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   1800
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   6059
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8450
      TabIndex        =   6
      Top             =   2205
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Transmitir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdSiguiente 
      Height          =   795
      Left            =   8450
      TabIndex        =   5
      Tag             =   "1564;1222;1209;1389"
      Top             =   750
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "Siguiente"
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
      Picture         =   "FMantCausalOfi.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   4
      Left            =   8450
      TabIndex        =   7
      Tag             =   "2516"
      Top             =   2970
      WhatsThisHelpID =   2006
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Eliminar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Enabled         =   0   'False
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   3600
      TabIndex        =   18
      Top             =   730
      Width           =   4605
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
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   3600
      TabIndex        =   17
      Top             =   1070
      UseMnemonic     =   0   'False
      Width           =   4605
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Causal:"
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
      Left            =   120
      TabIndex        =   16
      Top             =   730
      Width           =   645
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Catalogo:"
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
      Left            =   120
      TabIndex        =   13
      Top             =   400
      Width           =   825
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   3600
      TabIndex        =   14
      Top             =   400
      Width           =   4605
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Oficina:"
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
      Index           =   14
      Left            =   120
      TabIndex        =   11
      Top             =   1065
      Width           =   675
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
      Height          =   195
      Index           =   7
      Left            =   120
      TabIndex        =   12
      Top             =   90
      Width           =   840
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Causales Asociadas a Oficina :"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   3
      Left            =   120
      TabIndex        =   15
      Top             =   1560
      Width           =   2655
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8395
      Y1              =   1440
      Y2              =   1440
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8400
      X2              =   8400
      Y1              =   0
      Y2              =   5280
   End
End
Attribute VB_Name = "FMantCausalOfi"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
' Este programa esta protegido por la ley de derechos de autor
' y por las  convenciones  internacionales de  propiedad inte-
' lectual.  Su uso no  autorizado dara  derecho a  MACOSA para
' obtener ordenes  de secuestro o  retencion y para  perseguir
' penalmente a los autores de cualquier infraccion.
'*************************************************************
'                         PROPOSITO
' Consulta de Transferencias Automáticas, cuenta origen
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 03162011       S.Molano        Emisión Inicial
'*************************************************************
Option Explicit
Dim VLPaso As Integer
Dim VLFlag As Integer
Dim VLTablaCausal As String


Private Sub cmbProducto_Click()
    PMLimpiaGrid grdRegistros
    txtCampo(0) = ""
    txtCampo(1) = ""
    txtCampo(2) = ""
    lblDescripcion(1) = ""
    lblDescripcion(2) = ""
    lblDescripcion(3) = ""
    If cmbProducto.ListIndex = 0 Then
        VLTablaCausal = "ah_" + "tablas_causales_ndc"
    Else
        VLTablaCausal = "cc_" + "tablas_causales_ndc"
    End If
End Sub


Private Sub cmdBoton_Click(Index As Integer)
 Select Case Index
  Case 0 ' Buscar
         VLFlag% = False
         PLBuscar
  Case 1 'Transmitir
         PLTransmitir
  Case 2 ' Limpiar
        PLimpiar
  Case 3 ' Salir
        Screen.MousePointer = 0
        Unload Me
  Case 4
        PLEliminar
End Select
End Sub
Private Sub PLEliminar()
Dim VTResp As Integer
If txtCampo(2).Text = "" Then
      MsgBox "El campo  CATALOGO  es Obligatorio", 0 + 16, "Tadmin. Mensaje de Error"
      If txtCampo(2).Enabled = True Then txtCampo(2).SetFocus
      Exit Sub
End If

If txtCampo(1).Text = "" Then
      MsgBox "El campo CAUSAL es Obligatorio", 0 + 16, "Tadmin. Mensaje de Error"
      If txtCampo(1).Enabled = True Then txtCampo(1).SetFocus
      Exit Sub
End If


If txtCampo(0).Text = "" And optOpcion(1).Value = True Then
      MsgBox "El campo OFICINA es Obligatorio", 0 + 16, "Tadmin. Mensaje de Error"
      If txtCampo(0).Enabled = True Then txtCampo(0).SetFocus
      Exit Sub
End If


VTResp = MsgBox("Esta seguro que desea eliminar la causal  ( " + txtCampo(1) + " )  " + lblDescripcion(3) + " ?", vbOKCancel, "Causales X ROL")
If VTResp = vbCancel Then Exit Sub
PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 740
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
If optOpcion(1).Value = True Then
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, txtCampo(0).Text
End If
PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, lblDescripcion(1)
PMPasoValores sqlconn&, "@i_cod_tabla", 0, SQLVARCHAR, txtCampo(2).Text
PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, txtCampo(1).Text
If optOpcion(0).Value = True Then
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "T"
Else
    If optOpcion(1).Value = True Then
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "O"
    Else
        MsgBox "Tipo de Causal no valido", vbCritical + vbOKOnly, "Atencion"
        Exit Sub
    End If
End If
If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_causal_ndc_oficina", True, "Ok... Eliminar Causal por Oficina") Then
    PMChequea sqlconn&
    If grdRegistros.Rows <= 0 Then cmdBoton(4).Enabled = True
    txtCampo(1).Text = ""
    lblDescripcion(3).Caption = ""
    If optOpcion(0).Value = True Then
        txtCampo(0).Text = ""
        lblDescripcion(2).Caption = ""
    End If
    PMLimpiaGrid grdRegistros
    PLBuscar
End If

End Sub
Private Sub cmdSiguiente_Click()
Dim VTSig As String
If optOpcion(0).Value = True Then
    grdRegistros.Col = 1
    grdRegistros.Row = grdRegistros.Rows - 1
    VTSig = grdRegistros.Text
    PLBuscar (VTSig)
Else
    If optOpcion(1).Value = True Then
        grdRegistros.Col = 2
        grdRegistros.Row = grdRegistros.Rows - 1
        VTSig = grdRegistros.Text
        PLBuscar (VTSig)
    End If
End If
End Sub

Private Sub Form_Load()
    FMantCausalOfi.Left = 0   '15
    FMantCausalOfi.Top = 0
    FMantCausalOfi.Width = 9450
    FMantCausalOfi.Height = 5900
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmbProducto.AddItem "CUENTA DE AHORROS", 0
    cmbProducto.AddItem "CUENTA CORRIENTE", 1
    cmbProducto.ListIndex = 0
    optOpcion(0).Value = True
    VLPaso% = True
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
      
If grdRegistros.Rows > 1 Then
    If grdRegistros.Cols - 1 > 2 Then
        grdRegistros.Col = 1
        txtCampo(0).Text = grdRegistros.Text
        If txtCampo(0).Text <> "" Then txtCampo_LostFocus (0)
        grdRegistros.Col = 2
        txtCampo(1).Text = grdRegistros.Text
        If txtCampo(1).Text <> "" Then txtCampo_LostFocus (1)
    Else
        grdRegistros.Col = 1
        txtCampo(1).Text = grdRegistros.Text
        If txtCampo(1).Text <> "" Then txtCampo_LostFocus (1)
    End If
End If

End Sub

Private Sub optOpcion_Click(Index As Integer)
Select Case Index%
    Case 0
        txtCampo(0).Text = ""
        txtCampo(0).Enabled = False
        lblDescripcion(2).Caption = ""
    Case 1
        txtCampo(0).Enabled = True
        lblDescripcion(2).Caption = ""
End Select
End Sub

Private Sub txtCampo_Change(Index As Integer)
VLPaso% = False
Select Case Index
Case 2 ' tabla
    PMLimpiaGrid grdRegistros
    txtCampo(1) = ""
    lblDescripcion(3) = ""
End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
   VLPaso% = True
   Select Case Index%
   Case 0
        FPrincipal!pnlHelpLine.Caption = "Código de la OFICINA [F5 Ayuda]"
   Case 1
        FPrincipal!pnlHelpLine.Caption = "Código del CAUSAL [F5 Ayuda]"
   Case 2 'tablas
        FPrincipal!pnlHelpLine.Caption = "Código del CATALOGO [F5 Ayuda]"
   End Select
   txtCampo(Index%).SelStart = 0
   txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub
Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
   If KeyAscii% <> 8 And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
       KeyAscii% = 0
   End If
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)

    If Keycode% = VGTeclaAyuda% Then
       VLPaso% = True
       Select Case Index%
            Case 0 ' oficina
                txtCampo(Index) = ""
                PMCatalogo "A", "cl_oficina", txtCampo(Index), lblDescripcion(2)
            Case 1 ' causal
                If lblDescripcion(1) <> "" Then
                    txtCampo(Index) = ""
                    'PMCatalogo "A", lblDescripcion(1), txtCampo(Index), lblDescripcion(3)
                    VGCatCausal = lblDescripcion(1).Caption
                    FBusCausal.cmdBoton(2).Visible = True
                    FBusCausal.cmdBoton(3).Visible = False
                    'FBusCausal.HelpContextID = 310
                    FBusCausal.Show 1
                    txtCampo(Index) = VGCausal
                    txtCampo_LostFocus Index
                End If
            Case 2 ' tablas
                 If Keycode% = VGTeclaAyuda% Then
                     txtCampo(2) = ""
                     PMCatalogo "A", VLTablaCausal, txtCampo(Index), lblDescripcion(1)
                End If

       End Select
    End If
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    
If VLPaso% = False Then
    
    Select Case Index%
         Case 0 ' rol
'                If txtCampo(0).Text <> "" Then
'                    If Val(txtCampo(0)) > 255 Then
'                        VTAux = 0
'                    Else
'                        VTAux = txtCampo(0)
'                    End If
'                    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "H"
'                    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "15043"
'                    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
'                    PMPasoValores sqlconn&, "@i_rol", 0, SQLINT2&, VTAux
'                    ReDim Valores(3) As String
'                    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_ad_rol", True, "") Then
'                        VTR% = FMMapeaArreglo(sqlconn&, Valores())
'                        PMChequea sqlconn&
'                        lblDescripcion(2).Caption = Valores(1)
'                        VLPaso% = True
'                    Else
'                        lblDescripcion(2).Caption = ""
'                        txtCampo(0).Text = ""
'                    End If
'                End If
            If txtCampo(Index) <> "" Then
                PMCatalogo "V", "cl_oficina", txtCampo(Index), lblDescripcion(2)
            Else
                lblDescripcion(2) = ""
            End If
        
        Case 1 ' causal
            
            If lblDescripcion(1) = "" And txtCampo(2).Text <> "" Then
                MsgBox "El campo  CATALOGO  es Obligatorio", 0 + 16, "Tadmin. Mensaje de Error"
                If txtCampo(2).Enabled = True Then txtCampo(2).SetFocus
                txtCampo(Index) = ""
                Exit Sub
            End If
            
            If txtCampo(Index) <> "" Then
                PMCatalogo "V", lblDescripcion(1), txtCampo(Index), lblDescripcion(3)
            Else
                lblDescripcion(3) = ""
            End If
        
        Case 2 'tablas
            If txtCampo(Index) <> "" Then
                VLPaso% = True
                PMCatalogo "V", VLTablaCausal, txtCampo(Index), lblDescripcion(1)
                If txtCampo(2) = "" Then PLimpiar
            Else
                txtCampo(Index) = ""
                txtCampo(1) = ""
                lblDescripcion(1) = ""
                lblDescripcion(3) = ""
            End If

    End Select
End If
End Sub
Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Permite transmitir la informacion de la forma
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 17-Mar-2011   S. Molano        Emisión Inicial
'*************************************************************

If txtCampo(2).Text = "" Then
      MsgBox "El campo  CATALOGO  es Obligatorio", 0 + 16, "Tadmin. Mensaje de Error"
      If txtCampo(2).Enabled = True Then txtCampo(2).SetFocus
      Exit Sub
End If

If txtCampo(1).Text = "" Then
      MsgBox "El campo CAUSAL es Obligatorio", 0 + 16, "Tadmin. Mensaje de Error"
      If txtCampo(1).Enabled = True Then txtCampo(1).SetFocus
      Exit Sub
End If

If txtCampo(0).Text = "" And optOpcion(1).Value = True Then
      MsgBox "El campo OFICINA es Obligatorio", 0 + 16, "Tadmin. Mensaje de Error"
      If txtCampo(0).Enabled = True Then txtCampo(0).SetFocus
      Exit Sub
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 739
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
If optOpcion(1).Value = True Then
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, txtCampo(0).Text
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "O"
Else
    If optOpcion(0).Value = True Then
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "T"
    End If
End If
PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, lblDescripcion(1)
PMPasoValores sqlconn&, "@i_cod_tabla", 0, SQLVARCHAR, txtCampo(2).Text
PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, txtCampo(1).Text
    
If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_causal_ndc_oficina", True, "Ok... Ingresa Causal por Oficina") Then
       PMMapeaGrid sqlconn&, grdRegistros, False
       PMChequea sqlconn&
       PLBuscar
End If
End Sub

Private Sub PLBuscar(Optional PLCodigo As String)

If txtCampo(2).Text = "" Then
      MsgBox "El campo CATALOGO es obligatorio", 0 + 16, "Tadmin. Mensaje de Error"
      txtCampo(2).SetFocus
      Exit Sub
End If

' CONSULTA GENERAL DE UNA CAUSAL
If optOpcion(0).Value = True Then
       
    
    'PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, txtCampo(1).Text
    If txtCampo(1).Text <> "" Then
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "1"
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, txtCampo(1).Text
    Else
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "0"
        If PLCodigo <> "" Then
            PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, PLCodigo
        End If
    End If
Else
    ' CONSULTA OFICINA ESPECIFICA
    If optOpcion(1).Value = True Then
        If txtCampo(0).Text = "" Then
            MsgBox "El campo OFICINA es obligatorio", 0 + 16, "Tadmin. Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, txtCampo(0).Text
        
        ' SI INDICA LA CAUSAL
        If txtCampo(1).Text <> "" Then
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "3"
            PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, txtCampo(1).Text
        Else
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "2"
            If PLCodigo <> "" Then
                PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, PLCodigo
            End If
        End If
        
    End If
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 738
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, lblDescripcion(1)
PMPasoValores sqlconn&, "@i_cod_tabla", 0, SQLVARCHAR, txtCampo(2).Text


If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_causal_ndc_oficina", True, "Ok... Consulta Causales por Oficina") Then
    If cmdBoton(0).Enabled = True Then
        PMMapeaGrid sqlconn&, grdRegistros, False
    Else
        PMMapeaGrid sqlconn&, grdRegistros, True
    End If
    PMChequea sqlconn&
    If grdRegistros.Rows > 0 Then cmdBoton(4).Enabled = True
    If grdRegistros.Tag > 0 Then
        If grdRegistros.Tag < 20 Then
            cmdSiguiente.Enabled = False
            cmdBoton(0).Enabled = True
        Else
            cmdSiguiente.Enabled = True
            cmdBoton(0).Enabled = False
        End If
    Else
       cmdSiguiente.Enabled = False
       cmdBoton(0).Enabled = True
    End If

End If
End Sub



Public Sub PLimpiar()
    PMLimpiaGrid grdRegistros
    txtCampo(0) = ""
    txtCampo(1) = ""
    txtCampo(2) = ""
    lblDescripcion(1) = ""
    lblDescripcion(2) = ""
    lblDescripcion(3) = ""
    cmbProducto.ListIndex = 0
    cmdSiguiente.Enabled = False
    cmdBoton(0).Enabled = True
    cmdBoton(4).Enabled = False
    
End Sub


