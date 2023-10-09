VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran433 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Marcacion Servicio"
   ClientHeight    =   5355
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9330
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5355
   ScaleWidth      =   9330
   Begin VB.TextBox txtCampo 
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
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   1860
      MaxLength       =   15
      TabIndex        =   7
      Top             =   700
      Width           =   1875
   End
   Begin VB.ComboBox cmbprodb 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   1860
      Style           =   2  'Dropdown List
      TabIndex        =   2
      Top             =   50
      Width           =   1890
   End
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   495
      Left            =   1860
      TabIndex        =   10
      Top             =   990
      Width           =   3435
      Begin Threed.SSOption optEstado 
         Height          =   195
         Index           =   1
         Left            =   1680
         TabIndex        =   16
         TabStop         =   0   'False
         Top             =   200
         Width           =   1305
         _Version        =   65536
         _ExtentX        =   2302
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "No"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optEstado 
         Height          =   195
         Index           =   0
         Left            =   120
         TabIndex        =   0
         Top             =   200
         Width           =   1110
         _Version        =   65536
         _ExtentX        =   1958
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Si"
         ForeColor       =   0
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8445
      TabIndex        =   14
      Top             =   3675
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
      TabIndex        =   12
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
      Left            =   8445
      TabIndex        =   15
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
      Height          =   3075
      Left            =   0
      TabIndex        =   11
      TabStop         =   0   'False
      Top             =   2160
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   5424
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSMask.MaskEdBox Mskcuentadb 
      Height          =   285
      Left            =   1860
      TabIndex        =   4
      Top             =   390
      Width           =   1875
      _ExtentX        =   3307
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8445
      TabIndex        =   13
      Tag             =   "727"
      Top             =   2925
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Servicio:"
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
      Left            =   60
      TabIndex        =   6
      Top             =   705
      WhatsThisHelpID =   5444
      Width           =   840
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   3765
      TabIndex        =   8
      Top             =   705
      Width           =   4605
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto:"
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
      Left            =   60
      TabIndex        =   1
      Top             =   50
      WhatsThisHelpID =   5048
      Width           =   915
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de Cuenta:"
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
      Left            =   60
      TabIndex        =   3
      Top             =   390
      WhatsThisHelpID =   5449
      Width           =   1380
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   3765
      TabIndex        =   5
      Top             =   390
      UseMnemonic     =   0   'False
      Width           =   4605
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Habilitado:"
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
      Index           =   9
      Left            =   60
      TabIndex        =   9
      Top             =   1100
      WhatsThisHelpID =   5445
      Width           =   1005
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Servicios Aplicados :"
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
      Left            =   15
      TabIndex        =   17
      Top             =   1800
      Width           =   1800
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8395
      Y1              =   1680
      Y2              =   1680
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8400
      X2              =   8400
      Y1              =   0
      Y2              =   5310
   End
End
Attribute VB_Name = "FTran433"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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
Dim VLPaso As Integer
Dim VLFlag As Integer
Dim VLExiste As String

Private Sub cmbprodb_Click()
    txtCampo(0).Text = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
 Select Case Index
  Case 0 ' Buscar
         VLFlag% = False
         PLBuscar
  Case 1 'Transmitir
         PLTransmitir
  Case 2 ' Limpiar
         PLLimpiar
  Case 3 ' Salir
         Screen.MousePointer = 0
         Unload Me
End Select
End Sub

Private Sub Form_Load()
    FTran433.Left = 0   '15
    FTran433.Top = 0
    FTran433.Width = 9450
    FTran433.Height = 5900
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmbprodb.AddItem "AHORROS", 0
    cmbprodb.AddItem "CORRIENTES", 1
    cmbprodb.ListIndex = 0
    PMObjetoSeguridad FTran433.cmdBoton(1)
    Mskcuentadb.Mask = VGMascaraCtaAho$
     VLExiste = "N"
    VLPaso% = True
End Sub
Private Sub cmbprodb_LostFocus()
    If cmbprodb.ListIndex = 0 Then  '' Corrientes
        Mskcuentadb.Mask = VGMascaraCtaCte$
    Else
        Mskcuentadb.Mask = VGMascaraCtaAho$
    End If
    PMLimpiaGrid grdRegistros
    cmdBoton(0).Enabled = True  ' Buscar
    cmdBoton(1).Enabled = True  ' Transmitir
    Call Mskcuentadb_LostFocus
End Sub
Private Sub cmbprodb_GotFocus()
FPrincipal!pnlHelpLine.Caption = " Tipo de Producto"
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
If grdRegistros.Rows > 0 Then
    grdRegistros.Col = 1
    Select Case grdRegistros.Text
     Case "CORRIENTES"
        cmbprodb.ListIndex = 1
     Case "AHORROS"
        cmbprodb.ListIndex = 0
    End Select
    
    grdRegistros.Col = 3
    txtCampo(0).Text = grdRegistros.Text
    
    grdRegistros.Col = 5
    If grdRegistros.Text = "S" Then
       optEstado(0).Value = True
    Else
       optEstado(1).Value = True
    End If

End If

End Sub
Private Sub Mskcuentadb_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    Mskcuentadb.SelStart = 0
    Mskcuentadb.SelLength = Len(Mskcuentadb.Text)
End Sub
Private Sub Mskcuentadb_LostFocus()
    On Error Resume Next
    If Mskcuentadb.ClipText <> "" Then
        If cmbprodb.ListIndex = 1 Then          '  Corrientes
            If FMChequeaCtaCte((Mskcuentadb.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(0)
                    PMChequea sqlconn&
                Else
                    Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte$)
                    lblDescripcion(0).Caption = ""
                    If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                    Exit Sub
                End If
            Else
               MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(0).Caption = ""
                If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                Exit Sub
            End If
        Else  '  Ahorros
            If FMChequeaCtaAho((Mskcuentadb.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & Mskcuentadb.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(0)
                    PMChequea sqlconn&
                Else
                    Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho$)
                    lblDescripcion(0).Caption = ""
                    If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(0).Caption = ""
                If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.SetFocus
                Exit Sub
            End If
        End If
    End If
End Sub
Sub PLLimpiar()
    PMLimpiaGrid grdRegistros
    Mskcuentadb.Enabled = True
    Mskcuentadb.Mask = FMMascara("", VGMascaraCtaAho$)
    cmbprodb.ListIndex = 0
    optEstado(0).Value = True
    lblDescripcion(0).Caption = ""
    lblDescripcion(1).Caption = ""
    txtCampo(0).Text = ""
    cmdBoton(1).Enabled = True
    cmbprodb.ListIndex = 0
    cmbprodb.SetFocus
    VLExiste = "N"
End Sub

Private Sub txtCampo_Change(Index As Integer)
    VLPaso% = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
   Select Case Index%
   Case 0
     FPrincipal!pnlHelpLine.Caption = "Código del Servicio [F5 Ayuda]"
   End Select
   txtCampo(Index%).SelStart = 0
   txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub
Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
   If (KeyAscii% <> 8) And ((KeyAscii% < 65) Or (KeyAscii% > 90)) And ((KeyAscii% < 97) Or (KeyAscii% > 122)) Then
       KeyAscii% = 0
   Else
       KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
   End If
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode% = VGTeclaAyuda% Then
       VLPaso% = True
       Select Case Index%
            Case 0
               PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_marca_servicio"
               PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
               If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta del Servicio " & "[" & txtCampo(Index%).Text & "]") Then
                  PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                  PMChequea sqlconn&
                  FCatalogo.Show 1
                  txtCampo(0).Text = VGACatalogo.Codigo$
                  lblDescripcion(1).Caption = VGACatalogo.Descripcion$
               End If
               VLPaso% = True
       End Select
    End If
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
         Case 0
           If VLPaso% = False Then
               If txtCampo(0).Text <> "" Then
                  PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_marca_servicio"
                  PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                  PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(Index%).Text)
                  If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta del Servicio " & "[" & txtCampo(Index%).Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(1)
                     PMChequea sqlconn&
                  Else
                     VLPaso% = True
                     txtCampo(0).Text = ""
                     lblDescripcion(1).Caption = ""
                     txtCampo(0).SetFocus
                  End If
               Else
                  lblDescripcion(1).Caption = ""
               End If
           End If
    End Select
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

If Mskcuentadb.ClipText = "" Then
      MsgBox "El campo cuenta es mandatorio", 0 + 16, "Mensaje de Error"
      Mskcuentadb.SetFocus
      Exit Sub
End If

If txtCampo(0).Text = "" Then
      MsgBox "El servicio es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo(0).SetFocus
      Exit Sub
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 727
PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
Select Case cmbprodb.ListIndex
   Case 0
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "4"
   Case 1
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
  End Select
If optEstado(0).Value = True Then
   PMPasoValores sqlconn&, "@i_habilitado", 0, SQLCHAR, "S"
Else
   PMPasoValores sqlconn&, "@i_habilitado", 0, SQLCHAR, "N"
   If grdRegistros.Row > 0 Then
      VLRespuesta% = MsgBox("Desea eliminar la marca del servicio " + txtCampo(0).Text + " " + lblDescripcion(1) + " ?", 1 + 32 + 256, "Eliminar Registros")
        If VLRespuesta% = 2 Then
           Exit Sub
        End If
   End If
End If
If VLExiste = "S" Then
   PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
Else
   PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
End If
PMPasoValores sqlconn&, "@i_servicio", 0, SQLVARCHAR, (txtCampo(0).Text)
If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mto_marca_servicio", True, "Ok... Ingresa Marca Servicio") Then
       PMMapeaGrid sqlconn&, grdRegistros, False
       PMChequea sqlconn&
       'cmdBoton(1).Enabled = False
       'PLBuscar
End If
End Sub

Private Sub PLBuscar()
PMLimpiaGrid grdRegistros
If Mskcuentadb.ClipText = "" Then
      MsgBox "El campo cuenta es mandatorio", 0 + 16, "Mensaje de Error"
      Mskcuentadb.SetFocus
      Exit Sub
End If
PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 722
PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, (Mskcuentadb.ClipText)
Select Case cmbprodb.ListIndex
   Case 0
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "4"
   Case 1
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, "3"
  End Select
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mto_marca_servicio", True, "Ok... Consulta de Servicios Marcados") Then
   PMMapeaGrid sqlconn&, grdRegistros, VLFlag%
   PMChequea sqlconn&
   VLExiste = "S"
End If
End Sub
