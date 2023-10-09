VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran2689 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Consulta de Consumos de ATM"
   ClientHeight    =   5265
   ClientLeft      =   1710
   ClientTop       =   2895
   ClientWidth     =   9285
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
   HelpContextID   =   1039
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5265
   ScaleWidth      =   9285
   Begin MSMask.MaskEdBox mskTarjeta 
      Height          =   285
      Left            =   1710
      TabIndex        =   19
      Top             =   540
      Visible         =   0   'False
      Width           =   2250
      _ExtentX        =   3969
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   1710
      Style           =   2  'Dropdown List
      TabIndex        =   6
      Top             =   840
      Visible         =   0   'False
      Width           =   2235
   End
   Begin VB.TextBox txtEstado 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1710
      MaxLength       =   1
      TabIndex        =   9
      Top             =   1470
      Visible         =   0   'False
      Width           =   345
   End
   Begin VB.TextBox txtClave 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1710
      MaxLength       =   6
      TabIndex        =   8
      Top             =   1170
      Visible         =   0   'False
      Width           =   855
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   315
      Left            =   3960
      TabIndex        =   7
      Top             =   840
      Visible         =   0   'False
      Width           =   1515
      _ExtentX        =   2672
      _ExtentY        =   556
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Left            =   1710
      TabIndex        =   5
      Top             =   240
      Visible         =   0   'False
      Width           =   1665
      _ExtentX        =   2937
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCheck chkEstado 
      Height          =   210
      Left            =   15
      TabIndex        =   4
      Top             =   1470
      Width           =   945
      _Version        =   65536
      _ExtentX        =   1667
      _ExtentY        =   370
      _StockProps     =   78
      Caption         =   "Estado"
      ForeColor       =   8388608
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
   Begin Threed.SSCheck chkClave 
      Height          =   195
      Left            =   15
      TabIndex        =   3
      Top             =   1170
      Width           =   885
      _Version        =   65536
      _ExtentX        =   1561
      _ExtentY        =   344
      _StockProps     =   78
      Caption         =   "Clave"
      ForeColor       =   8388608
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
   Begin Threed.SSCheck chkCuenta 
      Height          =   210
      Left            =   15
      TabIndex        =   2
      Top             =   855
      WhatsThisHelpID =   5016
      Width           =   1560
      _Version        =   65536
      _ExtentX        =   2752
      _ExtentY        =   370
      _StockProps     =   78
      Caption         =   "*No. de cuenta"
      ForeColor       =   8388608
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
   Begin Threed.SSCheck chkTarjeta 
      Height          =   210
      Left            =   15
      TabIndex        =   1
      Top             =   555
      Width           =   1680
      _Version        =   65536
      _ExtentX        =   2964
      _ExtentY        =   370
      _StockProps     =   78
      Caption         =   "Num. de Tarjeta"
      ForeColor       =   8388608
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
   Begin Threed.SSCheck chkFecha 
      Height          =   210
      Left            =   15
      TabIndex        =   0
      Top             =   255
      Width           =   1680
      _Version        =   65536
      _ExtentX        =   2964
      _ExtentY        =   370
      _StockProps     =   78
      Caption         =   "Fecha Consumo"
      ForeColor       =   8388608
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8400
      TabIndex        =   13
      Top             =   4500
      WhatsThisHelpID =   2008
      Width           =   875
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
      Index           =   0
      Left            =   8400
      TabIndex        =   10
      Top             =   15
      WhatsThisHelpID =   2000
      Width           =   875
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
      Index           =   1
      Left            =   8400
      TabIndex        =   11
      Top             =   780
      WhatsThisHelpID =   2001
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Sig&tes."
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8400
      TabIndex        =   12
      Top             =   3735
      WhatsThisHelpID =   2003
      Width           =   875
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
   Begin MSGrid.Grid grdDevueltos 
      Height          =   3225
      Left            =   0
      TabIndex        =   15
      Top             =   2040
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14685
      _ExtentY        =   5689
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
   Begin VB.Label lblDesEstado 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Left            =   2070
      TabIndex        =   16
      Top             =   1470
      Visible         =   0   'False
      Width           =   2055
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   315
      Left            =   5490
      TabIndex        =   17
      Top             =   840
      Visible         =   0   'False
      Width           =   2850
   End
   Begin VB.Label lblCriterio 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Criterios de Búsqueda:"
      ForeColor       =   &H00800000&
      Height          =   195
      Left            =   0
      TabIndex        =   18
      Top             =   0
      Width           =   1935
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Consumos:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   -15
      TabIndex        =   14
      Top             =   1845
      Width           =   1665
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -75
      X2              =   8340
      Y1              =   1845
      Y2              =   1845
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8370
      X2              =   8370
      Y1              =   0
      Y2              =   5265
   End
End
Attribute VB_Name = "FTran2689"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTRA2689.frm
' NOMBRE LOGICO:    FTran2689
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
' Permite realizar la Consulta de Consumos de ATM
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

'Dim VLFormatoFecha As String
'CloVargas Oct/23/2001 Manejo de Formato Fecha
Dim VLPaso As Boolean

Private Sub Form_Load()
    FTran2689.Left = 0   '15
    FTran2689.Top = 0   '15
    FTran2689.Width = 9450   '9420
    FTran2689.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me

'    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    mskValor.Mask = FMMascaraFecha(VGFormatoFecha$)
    mskValor.Text = Format$(VGFecha$, VGFormatoFecha$)
    
    cmbTipo.AddItem "DCUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 0

    VGMascaraTarjeta$ = "######-###-######-#"
    mskTarjeta.Mask = VGMascaraTarjeta$
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub chkClave_Click(Value As Integer)
    If chkClave.Value Then
        txtClave.Visible = True
        txtClave.SetFocus
    Else
        txtClave.Visible = False
    End If

End Sub

Private Sub chkCuenta_Click(Value As Integer)
    If chkCuenta.Value Then
        cmbTipo.Visible = True
        mskCuenta.Visible = True
        lblDescripcion.Visible = True
        'chkProducto.Value = 1
        cmbTipo.SetFocus
        'mskCuenta.SetFocus
    Else
        cmbTipo.Visible = False
        mskCuenta.Visible = False
        lblDescripcion.Visible = False
        'chkProducto.Value = 0
        
    End If
    
End Sub

Private Sub chkEstado_Click(Value As Integer)
    If chkEstado.Value Then
        txtEstado.Visible = True
        lblDesEstado.Visible = True
        txtEstado.SetFocus
    Else
        txtEstado.Visible = False
        lblDesEstado.Visible = False
    End If

End Sub

Private Sub chkFecha_Click(Value As Integer)
    If chkFecha.Value Then
        mskValor.Visible = True
        mskValor.SetFocus
    Else
        mskValor.Visible = False
    End If

End Sub

Private Sub chkTarjeta_Click(Value As Integer)
    If chkTarjeta.Value Then
        mskTarjeta.Visible = True
        mskTarjeta.SetFocus
    Else
        mskTarjeta.Visible = False
    End If

End Sub

Private Sub cmbTipo_Click()
  If cmbTipo.Text = "CUENTA CORRIENTE" Then
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        mskCuenta.Mask = VGMascaraCtaCte$
        lblDescripcion.Caption = ""
  Else
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        mskCuenta.Mask = VGMascaraCtaAho$
        lblDescripcion.Caption = ""
  End If

End Sub

Private Sub cmbTipo_GotFocus()
     FPrincipal!pnlHelpLine.Caption = " Tipo de Producto"
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
        Case 0  ' Buscar los 20 primeros registros
            PLBuscar
        Case 1  'Siguientes
            PLSiguientes
        Case 2 'Limpiar
            PLLimpiar
        Case 3 'Salir
            Unload FTran2689
      End Select
End Sub


Private Sub mskCuenta_GotFocus()
  If cmbTipo.Text = "CUENTA CORRIENTE" Then
        FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
  Else
        FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta de Ahorros"
  End If

  mskCuenta.SelStart = 0
  mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion
                    PMChequea sqlconn&
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                    lblDescripcion.Caption = ""
                    mskCuenta.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion.Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion
                    PMChequea sqlconn&
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                    lblDescripcion.Caption = ""
                    mskCuenta.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorro está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion.Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        End If
    End If
End Sub

Private Sub mskTarjeta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de tarjeta de débito"
    mskTarjeta.SelStart = 0
    mskTarjeta.SelLength = Len(mskTarjeta.Text)
End Sub

Private Sub mskTarjeta_LostFocus()
If mskTarjeta.ClipText <> "" Then
   If Not FMChequeaTarjeta((mskTarjeta.ClipText)) Then
        MsgBox "El dígito verificador de la tarjeta está incorrecto", 0 + 16, "Mensaje de Error"
        mskTarjeta.Text = FMMascara("", VGMascaraTarjeta$)
        mskTarjeta.SetFocus
        Exit Sub
   End If
End If


End Sub

Private Sub mskValor_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Fecha del Consumo [" & VGFormatoFecha & "]"
    mskValor.SelStart = 0
    mskValor.SelLength = Len(mskValor.Text)
End Sub

Private Sub mskValor_KeyPress(KeyAscii As Integer)
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub mskValor_LostFocus()
    
    On Error Resume Next
        Dim VTValido As String
        If mskValor.ClipText <> "" Then
            VTValido = FMVerFormato((mskValor.FormattedText), VGFormatoFecha$)
            If Not VTValido Then
                MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
                mskValor.SetFocus
                Exit Sub
            End If
        Else
            mskValor.Mask = FMMascaraFecha(VGFormatoFecha$)
            mskValor.Text = Format$(VGFecha$, VGFormatoFecha$)
        End If
End Sub

Private Sub PLBuscar()
    Dim VTFDesde As String
    If cmbTipo.Visible = True Then
       If cmbTipo.Text = "CUENTA CORRIENTE" Then
          PMPasoValores sqlconn&, "@i_prod", 0, SQLINT4, "3"
       Else
          PMPasoValores sqlconn&, "@i_prod", 0, SQLINT4, "4"
       End If
    End If
    If mskValor.Visible = True Then
       If mskValor.ClipText = "" Then
          MsgBox "Fecha del Consumo es mandatorio", 0 + 16, "Mensaje de Error"
          mskValor.SetFocus
          Exit Sub
       End If
        'VTFDesde$ = FMConvFecha((mskValor.FormattedText), VLFormatoFecha$, "mm/dd/yyyy")
        VTFDesde$ = FMConvFecha((mskValor.FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFDesde$
    End If
    If mskTarjeta.Visible = True Then
       If mskTarjeta.ClipText = "" Then
           MsgBox "Numero de la Tarjeta es mandatorio", 0 + 16, "Mensaje de Error"
           mskTarjeta.Text = FMMascara("", VGMascaraTarjeta$)
           mskTarjeta.SetFocus
           Exit Sub
       End If
        PMPasoValores sqlconn&, "@i_tarjeta", 0, SQLVARCHAR, (mskTarjeta.ClipText)
    End If

    If mskCuenta.Visible = True Then
       If mskCuenta.ClipText = "" Then
          MsgBox "Código de la cuenta es mandatorio", 0 + 16, "Mensaje de Error"
          mskCuenta.SetFocus
          Exit Sub
       End If
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
    End If
    If txtClave.Visible = True Then
       If txtClave.Text = "" Then
          MsgBox "Clave de la Tarjeta es mandatorio", 0 + 16, "Mensaje de Error"
          txtClave.SetFocus
          Exit Sub
       End If
        PMPasoValores sqlconn&, "@i_clave", 0, SQLINT4, (txtClave.Text)
    End If
    If txtEstado.Visible = True Then
       If txtEstado.Text = "" Then
          MsgBox "Estado del consumo es mandatorio", 0 + 16, "Mensaje de Error"
          txtEstado.SetFocus
          Exit Sub
       End If
        PMPasoValores sqlconn&, "@i_estado", 0, SQLVARCHAR, (txtEstado.Text)
    End If
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2689"
     PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_con_com_atm", True, "Ok... Consulta de Consumos de ATM") Then
        PMMapeaGrid sqlconn&, grdDevueltos, False
        PMChequea sqlconn&
       
       grdDevueltos.ColWidth(1) = 1   ' SECUENCIAL
       grdDevueltos.ColWidth(3) = 1200  ' FECHA CONSUMO
       grdDevueltos.ColAlignment(3) = 0 ' FECHA CONSUMO
       grdDevueltos.ColWidth(4) = 1500  ' TARJETA
       grdDevueltos.ColAlignment(4) = 1 ' TARJETA
       grdDevueltos.ColWidth(5) = 1000  ' CUENTA
       grdDevueltos.ColAlignment(5) = 2 ' CUENTA
       grdDevueltos.ColWidth(6) = 1200  ' CLAVE
       grdDevueltos.ColWidth(7) = 600   ' ESTADO
       grdDevueltos.ColWidth(8) = 800   ' PRODUCTO
       grdDevueltos.ColWidth(9) = 1500  ' VALOR
       grdDevueltos.ColWidth(10) = 1500  ' IMP1
       grdDevueltos.ColWidth(11) = 1500  ' COMISION
       grdDevueltos.ColWidth(12) = 1500  ' IMP2
       grdDevueltos.ColWidth(13) = 1500  ' TOTAL
       grdDevueltos.ColWidth(14) = 600  ' SIGNO
       grdDevueltos.ColAlignment(14) = 1 ' SIGNO
       grdDevueltos.ColWidth(15) = 1500 ' FECHA AFECTACION
       grdDevueltos.ColAlignment(15) = 0 ' FECHA AFECTACION
       grdDevueltos.ColWidth(16) = 1500 ' FECHA RECUPERACION
       grdDevueltos.ColAlignment(16) = 0 ' FECHA RECUPERACION
       If Val(grdDevueltos.Tag) = 20 Then
          cmdBoton(1).Enabled = True
       Else
          cmdBoton(1).Enabled = False
       End If
    Else
       PLLimpiar
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
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

        cmbTipo.ListIndex = 0
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
        Else
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        End If
        mskTarjeta.Text = FMMascara("", VGMascaraTarjeta$)
        txtClave.Text = ""
        mskValor.Mask = FMMascaraFecha(VGFormatoFecha$)
        mskValor.Text = Format$(VGFecha$, VGFormatoFecha$)
        txtEstado.Text = ""
        lblDescripcion.Caption = ""
        lblDesEstado.Caption = ""
        PMLimpiaGrid grdDevueltos
End Sub

Private Sub PLSiguientes()
'*************************************************************
' PROPOSITO: Llena el grid con los siguientes 20 registros
'            retornados por el stored procedure
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Dim VTFDesde As String
    grdDevueltos.Row = grdDevueltos.Rows - 1
    grdDevueltos.Col = 1

    If cmbTipo.Visible = True Then
       If cmbTipo.Text = "CUENTA CORRIENTE" Then
          PMPasoValores sqlconn&, "@i_prod", 0, SQLINT4, "3"
       Else
          PMPasoValores sqlconn&, "@i_prod", 0, SQLINT4, "4"
       End If
    End If
    If mskValor.Visible = True Then
       If mskValor.ClipText = "" Then
          MsgBox "Fecha del Consumo es mandatorio", 0 + 16, "Mensaje de Error"
          mskValor.SetFocus
          Exit Sub
       End If
       'VTFDesde$ = FMConvFecha((mskValor.FormattedText), VLFormatoFecha$, "mm/dd/yyyy")
        VTFDesde = FMConvFecha((mskValor.FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFDesde$
    End If
    If mskTarjeta.Visible = True Then
       If mskTarjeta.ClipText = "" Then
           MsgBox "Numero de la Tarjeta es mandatorio", 0 + 16, "Mensaje de Error"
           mskTarjeta.Text = FMMascara("", VGMascaraTarjeta$)
           mskTarjeta.SetFocus
           Exit Sub
       End If
        PMPasoValores sqlconn&, "@i_tarjeta", 0, SQLVARCHAR, (mskTarjeta.ClipText)
    End If
    If mskCuenta.Visible = True Then
       If mskCuenta.ClipText = "" Then
          MsgBox "Código de la cuenta es mandatorio", 0 + 16, "Mensaje de Error"
          mskCuenta.SetFocus
          Exit Sub
       End If
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
    End If
    If txtClave.Visible = True Then
       If txtClave.Text = "" Then
          MsgBox "Clave de la Tarjeta es mandatorio", 0 + 16, "Mensaje de Error"
          txtClave.SetFocus
          Exit Sub
       End If
        PMPasoValores sqlconn&, "@i_clave", 0, SQLINT4, (txtClave.Text)
    End If
    If txtEstado.Visible = True Then
       If txtEstado.Text = "" Then
          MsgBox "Estado del consumo es mandatorio", 0 + 16, "Mensaje de Error"
          txtEstado.SetFocus
          Exit Sub
       End If
        PMPasoValores sqlconn&, "@i_estado", 0, SQLVARCHAR, (txtEstado.Text)
    End If
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2689"
     PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, (grdDevueltos.Text)
     PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)

    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_con_com_atm", True, "Ok... Consulta de Consumos de ATM") Then
        PMMapeaGrid sqlconn&, grdDevueltos, True
        PMChequea sqlconn&
                
        If Val(grdDevueltos.Tag) = 20 Then
          cmdBoton(1).Enabled = True
        Else
          cmdBoton(1).Enabled = False
        End If
    Else
       PLLimpiar
    End If

End Sub

Private Sub txtClave_GotFocus()
    FPrincipal!pnlHelpLine.Caption = "Clave de la Tarjeta"
    txtClave.SelStart = 0
    txtClave.SelLength = Len(txtClave.Text)

End Sub

Private Sub txtClave_KeyPress(KeyAscii As Integer)
    KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
       KeyAscii% = 0
    End If

End Sub

Private Sub txtEstado_Change()
    VLPaso = False
End Sub

Private Sub txtEstado_GotFocus()
    VLPaso = True
    FPrincipal!pnlHelpLine.Caption = "Estado del Consumo [F5 Ayuda]"
    txtEstado.SelStart = 0
    txtEstado.SelLength = Len(txtEstado.Text)
    
End Sub

Private Sub txtEstado_KeyDown(Keycode As Integer, Shift As Integer)
    If Keycode% = VGTeclaAyuda% Then
        VLPaso = True
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "re_consum_atm"
        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
        PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtEstado.Text = VGACatalogo.Codigo$
            lblDesEstado.Caption = VGACatalogo.Descripcion$
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim(txtEstado.Text) <> "" And Trim(lblDesEstado.Caption) <> "" Then
                SendKeys "{TAB}"
            End If
        End If
    End If
End Sub

Private Sub txtEstado_KeyPress(KeyAscii As Integer)
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
        If (KeyAscii% <> 8) And ((KeyAscii% < 65) Or (KeyAscii% > 90)) Then
            KeyAscii% = 0
        End If
End Sub

Private Sub txtEstado_lostfocus()
    If VLPaso = False Then
        If txtEstado.Text <> "" Then
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_consum_atm"
            PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtEstado.Text)
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta del parámetro " & "[" & txtEstado.Text & "]") Then
                PMMapeaObjeto sqlconn&, lblDesEstado
                PMChequea sqlconn&
                VLPaso = True
            Else
                txtEstado.Text = ""
                lblDesEstado.Caption = ""
                txtEstado.SetFocus
            End If
        Else
            lblDesEstado.Caption = ""
        End If
    End If

End Sub


