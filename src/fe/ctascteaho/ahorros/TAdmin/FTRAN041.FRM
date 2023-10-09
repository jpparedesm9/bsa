VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "Msmask32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTRAN041 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Consulta de Cheque Declarado"
   ClientHeight    =   5355
   ClientLeft      =   810
   ClientTop       =   2250
   ClientWidth     =   9300
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
   HelpContextID   =   1019
   LinkTopic       =   "Form14"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5355
   ScaleWidth      =   9300
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   5
      Top             =   4580
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
      Index           =   6
      Left            =   8415
      TabIndex        =   0
      Top             =   750
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
      Index           =   5
      Left            =   8415
      TabIndex        =   1
      Top             =   1520
      WhatsThisHelpID =   2020
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Siguien&tes"
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
      Left            =   8415
      TabIndex        =   3
      Tag             =   "2516"
      Top             =   3045
      WhatsThisHelpID =   2006
      Width           =   875
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   2
      Tag             =   "2548"
      Top             =   2280
      WhatsThisHelpID =   2030
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Crear"
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
      Height          =   4215
      Left            =   0
      TabIndex        =   6
      Top             =   1110
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   7435
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
      Cols            =   4
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   4
      Top             =   3810
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2160
      TabIndex        =   8
      Top             =   60
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   12
      Top             =   0
      Visible         =   0   'False
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Actualizar"
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
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   2160
      TabIndex        =   11
      Top             =   380
      UseMnemonic     =   0   'False
      Width           =   6120
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta corriente:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   1
      Left            =   0
      TabIndex        =   10
      Top             =   60
      WhatsThisHelpID =   5016
      Width           =   2370
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la chequera:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   6
      Left            =   0
      TabIndex        =   9
      Top             =   380
      WhatsThisHelpID =   5017
      Width           =   2130
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cuentas Asociadas:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   0
      TabIndex        =   7
      Top             =   840
      Width           =   1695
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8370
      X2              =   0
      Y1              =   720
      Y2              =   720
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5310
   End
End
Attribute VB_Name = "FTRAN041"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTran041.frm
' NOMBRE LOGICO:    FTran041
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
' Permite realizar la consulta de cheques declarados ingresan-
' do el No. de cuenta corriente.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************


Private Sub cmdBoton_Click(Index As Integer)

  Select Case Index%
    Case 0  'Salir
         Unload Me
    Case 1  'Limpiar
       PLLimpiar
       PMLimpiaGrid grdRegistros
       cmdBoton(5).Enabled = False
    Case 2  'Eliminar
       PLEliminar
    Case 3  ' Crear
       PLCrear
    Case 5  'Siguientes
       PLSiguientes
    Case 6  'Buscar
       PLBuscar
  End Select

End Sub

Private Sub Form_Load()

    Me.Left = 0   '15
    Me.Top = 0   '15
    Me.Width = 9450   '9420
    Me.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    PMBotonSeguridad Me, 4   'Seguridades
    cmdBoton(5).Enabled = False
    mskCuenta.Mask = VGMascaraCtaCte$
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
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
    If grdRegistros.Rows <= 2 Then
       grdRegistros.Row = 1
       grdRegistros.Col = 1
       If Trim$(grdRegistros.Text) = "" Then
          MsgBox "No existen Cuentas", 0 + 16, "Mensaje de Error"
          Exit Sub
       End If
    End If

    grdRegistros.Col = 1
    mskCuenta.Text = FMMascara(grdRegistros.Text, VGMascaraCtaCte$)
    mskCuenta.Enabled = False

    cmdBoton(3).Enabled = False

    cmdBoton(2).Enabled = True
End Sub

Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Trae las primeras 20 cuentas con cheques declarados
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2731"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "S"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_cta_declarado", True, "Ok... Busqueda de Cuentas con Cheques Declarados") Then
       PMMapeaGrid sqlconn&, grdRegistros, False
       PMChequea sqlconn&
      If grdRegistros.Rows <= 2 Then
         grdRegistros.Col = 1
         grdRegistros.Row = 1
         If grdRegistros.Text = "" Then
            PLLimpiar
            Exit Sub
         End If
      End If
      If Val(grdRegistros.Tag) >= 20 Then
            cmdBoton(5).Enabled = True
           Else
            cmdBoton(5).Enabled = False
      End If
   End If

End Sub
Private Sub PLCrear()
'*************************************************************
' PROPOSITO: Ingresa al sistema una cuenta con cheques decla-
'            rados
' INPUT    : Ninguna
' OUTPUT   : Ninguna
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

   'Valida Cuenta
   If mskCuenta.ClipText = "" Then
      MsgBox "El número de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
      mskCuenta.SetFocus
      Exit Sub
   End If
         
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2745"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "I"
    PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_cta_declarado", True, "Ok... Creación de Cuenta de Cheques Declarados") Then
       PMChequea sqlconn&
       PLLimpiar
       PLBuscar  'Refresca Datos
   End If

End Sub

Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Elimina una cuenta con cheques declarados
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************


   'Valida Cuenta
   If mskCuenta.ClipText = "" Then
      MsgBox "El número de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
      mskCuenta.SetFocus
      Exit Sub
   End If
         
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2730"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "E"
    PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_cta_declarado", True, "Ok... Creación de Cuenta de Cheques Declarados") Then
       PMChequea sqlconn&
       PLLimpiar
       PLBuscar  'Refresca Datos
   End If


End Sub

Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpiar los objetos de la pantalla
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

   mskCuenta.Enabled = True
   mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
   lblDescripcion(0).Caption = ""
   PMLimpiaGrid grdRegistros
   cmdBoton(3).Enabled = True
   cmdBoton(2).Enabled = False
   mskCuenta.SetFocus

   
End Sub

Private Sub PLSiguientes()
'*************************************************************
' PROPOSITO: Mapear al grid de cuentas con cheques declarados
'            los siguientes 20 registros
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

   grdRegistros.Col = 1
   grdRegistros.Row = grdRegistros.Rows - 1
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2731"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "B"
    PMPasoValores sqlconn&, "@i_cuenta", 0, SQLVARCHAR, grdRegistros.Text
 
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_cta_declarado", True, "Ok... Busqueda de Cuentas con Cheques Declarados") Then
       PMMapeaGrid sqlconn&, grdRegistros, True
       PMChequea sqlconn&
      If Val(grdRegistros.Tag) >= 20 Then
         cmdBoton(5).Enabled = True
        Else
           cmdBoton(5).Enabled = False
      End If
   End If

End Sub


Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaCte((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                 cmdBoton(3).Enabled = True
            Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(0).Caption = ""
                cmdBoton(3).Enabled = False
                mskCuenta.SetFocus
                Exit Sub
            End If

        Else
            MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
            lblDescripcion(0).Caption = ""
            cmdBoton(3).Enabled = False
            mskCuenta.SetFocus
            Exit Sub
        End If
    End If
End Sub


