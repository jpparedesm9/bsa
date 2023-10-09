VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form Ftran2575 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Ajuste de Intereses"
   ClientHeight    =   5415
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9300
   ForeColor       =   &H8000000E&
   LinkTopic       =   "Form1"
   MDIChild        =   -1  'True
   ScaleHeight     =   5415
   ScaleWidth      =   9300
   Tag             =   "3850"
   Begin VB.ComboBox cmbTipo 
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
      Height          =   315
      Left            =   2490
      Style           =   2  'Dropdown List
      TabIndex        =   13
      Top             =   450
      Width           =   3165
   End
   Begin VB.ComboBox cmbInteres 
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
      Height          =   315
      Left            =   2490
      Style           =   2  'Dropdown List
      TabIndex        =   12
      Top             =   2620
      Width           =   3195
   End
   Begin VB.OptionButton optOperacion 
      BackColor       =   &H00C0C0C0&
      Caption         =   "*Aumento"
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
      Height          =   285
      Index           =   1
      Left            =   2490
      TabIndex        =   11
      Top             =   3078
      WhatsThisHelpID =   5053
      Width           =   2145
   End
   Begin VB.OptionButton optOperacion 
      BackColor       =   &H00C0C0C0&
      Caption         =   "*Disminución"
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
      Height          =   285
      Index           =   0
      Left            =   510
      TabIndex        =   0
      Top             =   3060
      WhatsThisHelpID =   5052
      Width           =   1515
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8370
      TabIndex        =   3
      Top             =   4410
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8400
      TabIndex        =   2
      Top             =   1230
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
      Left            =   8400
      TabIndex        =   1
      Top             =   270
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2490
      TabIndex        =   14
      Top             =   908
      Width           =   3165
      _ExtentX        =   5583
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox MskValor 
      Height          =   285
      Left            =   2490
      TabIndex        =   15
      Top             =   3510
      Width           =   1620
      _ExtentX        =   2858
      _ExtentY        =   503
      _Version        =   393216
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskIntMes 
      Height          =   285
      Left            =   2520
      TabIndex        =   17
      Top             =   1764
      Width           =   1620
      _ExtentX        =   2858
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "#,##0.00"
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox MskIntPeriodo 
      Height          =   285
      Left            =   2520
      TabIndex        =   18
      Top             =   2192
      Width           =   1620
      _ExtentX        =   2858
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Format          =   "#,##0.00"
      PromptChar      =   "_"
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
      Left            =   2490
      TabIndex        =   16
      Top             =   1336
      UseMnemonic     =   0   'False
      Width           =   5760
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Tipo de Ajuste:"
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
      Left            =   510
      TabIndex        =   10
      Top             =   2645
      WhatsThisHelpID =   5051
      Width           =   1380
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8340
      X2              =   8340
      Y1              =   30
      Y2              =   5430
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Valor:"
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
      Index           =   8
      Left            =   510
      TabIndex        =   9
      Top             =   3570
      WhatsThisHelpID =   5054
      Width           =   585
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Interés del Período:"
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
      Left            =   510
      TabIndex        =   8
      Top             =   2230
      WhatsThisHelpID =   5050
      Width           =   1785
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Interés Mensual:"
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
      Left            =   510
      TabIndex        =   7
      Top             =   1815
      WhatsThisHelpID =   5049
      Width           =   1500
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de Cuenta:"
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
      Left            =   510
      TabIndex        =   6
      Top             =   1400
      WhatsThisHelpID =   5017
      Width           =   1725
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto: "
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
      Left            =   510
      TabIndex        =   5
      Top             =   570
      WhatsThisHelpID =   5048
      Width           =   975
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta:"
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
      Left            =   510
      TabIndex        =   4
      Top             =   985
      WhatsThisHelpID =   5016
      Width           =   1365
   End
End
Attribute VB_Name = "Ftran2575"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          Ftran2575.frm
' NOMBRE LOGICO:    Ftran2575
' PRODUCTO:         Terminal Administrativa
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
' Permite realizar los Ajuste de Intereses
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VLProducto As String
Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia todos los valores de los objetos de la forma.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

   mskIntMes.Text = ""
   MskIntPeriodo.Text = ""
   lblDescripcion(0).Caption = ""
   MskValor.Enabled = True
   MskValor.Text = ""
   mskCuenta.Enabled = True
   mskCuenta.Mask = ""
   mskCuenta.Text = ""
   cmbInteres.ListIndex = 0
   cmbTipo.ListIndex = 0
   cmbTipo.SetFocus
   cmdBoton(0).Enabled = True
   optOperacion(0).Value = True
End Sub

Private Sub cmbTipo_GotFocus()
     Dim aux1 As String
     Dim aux2 As String
     FPrincipal!pnlHelpLine.Caption = " Tipo de Producto de la Cuenta Asociada"
     If mskCuenta <> "" Then
        aux1 = mskCuenta.Mask
        aux2 = mskCuenta.Text
        mskCuenta.Mask = ""
        mskCuenta.Text = ""
        mskCuenta.Mask = aux1
        mskCuenta.Text = aux2
     End If
End Sub

Private Sub cmbTipo_LostFocus()
  If cmbTipo.Text = "CUENTA CORRIENTE" Then
        mskCuenta.Mask = VGMascaraCtaCte$
        VLProducto$ = "CTE"
  Else
        mskCuenta.Mask = VGMascaraCtaAho$
        VLProducto$ = "AHO"
  End If
End Sub

Private Sub cmdBoton_Click(Index As Integer)
Select Case Index%
   Case 0
      PLAfectarInteres
   Case 1
      PLLimpiar
   Case 2
      Unload Me
End Select
End Sub

Private Sub Form_Activate()
   cmbTipo.SetFocus
End Sub

Private Sub mskValor_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Valor en el que se modificará el interés"
    MskValor.Text = Format$(MskValor.Text)
    MskValor.SelStart = 0
    MskValor.SelLength = Len(MskValor.Text)
    MskValor.MaxLength = 14
End Sub

Private Sub mskValor_KeyPress(KeyAscii As Integer)
    If VGDecimales$ = "#,##0" Then
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    Else
        If (KeyAscii% <> 8) And (KeyAscii% <> 46) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End If

End Sub
Private Sub PLBuscarInt()
'*************************************************************
' PROPOSITO: Permite realizar la consulta del valor del interes
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

If VLProducto$ = "CTE" Then
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2749"
Else
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "324"
End If
PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
PMPasoValores sqlconn&, "@i_opcion", 0, SQLVARCHAR, "C"
'PMPasoValores SqlConn&, "@i_mon", 0, SQLINT1, VGMoneda$
PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, VLProducto$
If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_ajusta_int", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
   PMMapeaObjetoAB sqlconn&, mskIntMes, MskIntPeriodo
   PMChequea sqlconn&
End If
mskCuenta.Enabled = False
cmbInteres.SetFocus
End Sub


Private Sub Form_Load()
    Ftran2575.Left = 0   '15
    Ftran2575.Top = 0   '15
    Ftran2575.Width = 9450   '9420
    Ftran2575.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    'PMBotonSeguridad FTran2534, 5   ' Chequeo de Seguridades a nivel de Botón
'    For i% = 1 To 4
'        cmdBoton(i%).Enabled = False
'    Next i%
    
    mskCuenta.Mask = VGMascaraCtaCte$
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbInteres.AddItem "AJUSTE DE INTERES MENSUAL", 0
    cmbInteres.AddItem "AJUSTE DE INTERES DEL PERIODO", 1
    cmbTipo.ListIndex = 0
    cmbInteres.ListIndex = 0
    optOperacion(0).Value = True
    optOperacion(1).Value = False
    VLProducto = "CTE"
    
    
    
End Sub

Private Sub mskCuenta_LostFocus()
On Error Resume Next

If cmbTipo.Text = "CUENTA CORRIENTE" Then
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaCte((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                 PLBuscarInt
            Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                'lblDescripcion(7).Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
            'MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
            MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
            'lblDescripcion(7).Caption = ""
            mskCuenta.SetFocus
            Exit Sub
        End If
    End If
Else
   If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "206"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta de la cuenta de ahorros") Then
               PMMapeaObjeto sqlconn&, lblDescripcion(0)
               PMChequea sqlconn&
               PLBuscarInt
            Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(0).Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
            'MsgBox "El dígito verificador de la cuenta corriente está incorrecto", 0 + 16, "Mensaje de Error"
            MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
            lblDescripcion(0).Caption = ""
            mskCuenta.SetFocus
            Exit Sub
        End If
    End If
End If

End Sub

Private Sub PLAfectarInteres()
'*************************************************************
' PROPOSITO: Permiet realizar el ajuste de interes mensual
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VTInteresFinal As Double
Dim VTTipoInt As String
Dim VTTransaccion As String
Dim VTResp As Integer
If Val(MskValor.Text) <> 0 Then
   If cmbInteres.Text = "AJUSTE DE INTERES MENSUAL" Then
      If optOperacion(0).Value Then 'DISMINUCION DEL INTERES MENSUAL
         VTInteresFinal = (CCur(mskIntMes.Text) - CCur(MskValor.Text))
         If VTInteresFinal >= 0 Then
            VTResp = MsgBox("El valor del interés final es de: " + CStr(VTInteresFinal) + " está seguro que desea continuar", vbOKCancel, "Mensaje de Advertencia")
            If VTResp = 1 Then
               If VLProducto$ = "CTE" Then
                   VTTransaccion$ = "2751"
               Else
                  VTTransaccion$ = "326"
               End If
               VTTipoInt$ = "M"
               
            Else
               Exit Sub
            End If
         Else
            MsgBox "El valor exede el monto del interés mensual", 0 + 16, "Mensaje de Error"
            MskValor.SetFocus
            Exit Sub
         End If
      Else
        VTInteresFinal = (CCur(mskIntMes.Text) + CCur(MskValor.Text))
        
        VTResp = MsgBox("El valor del interés final es de: " + CStr(VTInteresFinal) + " está seguro que desea continuar", vbOKCancel, "Mensaje de Advertencia")
        If VTResp = 1 Then
           If VLProducto$ = "CTE" Then
              VTTransaccion$ = "2750"
           Else
              VTTransaccion$ = "325"
           End If
               
        VTTipoInt$ = "M"
        Else
          Exit Sub
        End If
      End If
   Else
      If optOperacion(0).Value Then 'DISMINUCION DEL INTERES DEL PERIODO
         VTInteresFinal = (CCur(MskIntPeriodo.Text) - CCur(MskValor.Text))
         If VTInteresFinal >= 0 Then
            VTResp = MsgBox("El valor del interés final es de: " + CStr(VTInteresFinal) + " está seguro que desea continuar", vbOKCancel, "Mensaje de Advertencia")
            If VTResp = 1 Then
               If VLProducto$ = "CTE" Then
                   VTTransaccion$ = "2751"
               Else
                  VTTransaccion$ = "326"
               End If
             VTTipoInt$ = "P"
               
            Else
               Exit Sub
            End If
         Else
            MsgBox "El valor exede el monto del interés del periodo", 0 + 16, "Mensaje de Error"
            MskValor.SetFocus
            Exit Sub
         End If
      Else
        VTInteresFinal = (CCur(MskIntPeriodo.Text) + CCur(MskValor.Text))
        VTResp = MsgBox("El valor del interés final es de: " + CStr(VTInteresFinal) + " está seguro que desea continuar", vbOKCancel, "Mensaje de Advertencia")
        If VTResp = 1 Then
           If VLProducto$ = "CTE" Then
              VTTransaccion$ = "2750"
           Else
              VTTransaccion$ = "325"
           End If
               
        VTTipoInt$ = "P"
        Else
          Exit Sub
        End If
      End If
   End If
   
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, VTTransaccion
   PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
   PMPasoValores sqlconn&, "@i_mens_per", 0, SQLVARCHAR, VTTipoInt$
   PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
   PMPasoValores sqlconn&, "@i_opcion", 0, SQLVARCHAR, "U"
   PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, VLProducto$
   PMPasoValores sqlconn&, "@i_valor_ajuste", 0, SQLMONEY, MskValor.ClipText
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_ajusta_int", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
      If VTTipoInt = "M" Then
         PMMapeaObjeto sqlconn&, mskIntMes
      Else
         PMMapeaObjeto sqlconn&, MskIntPeriodo
      End If
      PMChequea sqlconn&
      MskValor.Enabled = False
      cmdBoton(0).Enabled = False
   End If
End If



End Sub

Private Sub mskValor_LostFocus()
 If MskValor.Text <> "" Then
    cmdBoton(0).Enabled = True
 End If
End Sub

