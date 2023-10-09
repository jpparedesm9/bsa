VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran490 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Domiciliación de Pagos"
   ClientHeight    =   5325
   ClientLeft      =   915
   ClientTop       =   1830
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
   HelpContextID   =   1098
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Tag             =   "0"
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7785
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   19
      Top             =   1725
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8025
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   18
      Top             =   1725
      Visible         =   0   'False
      Width           =   195
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   4
      Top             =   45
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2010
      TabIndex        =   1
      Top             =   360
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3315
      Left            =   15
      TabIndex        =   5
      TabStop         =   0   'False
      Top             =   1950
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14712
      _ExtentY        =   5848
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
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   2010
      MaxLength       =   60
      TabIndex        =   3
      Top             =   1275
      Width           =   6300
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   6
      Tag             =   "2516"
      Top             =   2265
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
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   2010
      MaxLength       =   6
      TabIndex        =   2
      Top             =   960
      Width           =   780
   End
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      Height          =   300
      Left            =   2010
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   30
      Width           =   2445
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   10
      Top             =   4560
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
      Index           =   2
      Left            =   8420
      TabIndex        =   8
      Top             =   3795
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
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
      Index           =   1
      Left            =   8415
      TabIndex        =   7
      Top             =   3030
      WhatsThisHelpID =   2007
      Width           =   875
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Domiciliaciones de Pagos para la cuenta:"
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   1
      Left            =   120
      TabIndex        =   17
      Top             =   1740
      Width           =   3540
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de la cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   120
      TabIndex        =   16
      Top             =   375
      WhatsThisHelpID =   5016
      Width           =   1575
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   120
      TabIndex        =   15
      Top             =   675
      WhatsThisHelpID =   5017
      Width           =   1920
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   2
      Left            =   2010
      TabIndex        =   14
      Top             =   660
      UseMnemonic     =   0   'False
      Width           =   6300
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Comentario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   120
      TabIndex        =   9
      Top             =   1275
      Width           =   1020
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Pago:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   120
      TabIndex        =   11
      Top             =   975
      Width           =   1215
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   2820
      TabIndex        =   12
      Top             =   960
      Width           =   5490
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Producto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   120
      TabIndex        =   13
      Top             =   30
      Width           =   840
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -30
      X2              =   8365
      Y1              =   1695
      Y2              =   1695
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
Attribute VB_Name = "FTran490"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTRAN490.frm
' NOMBRE LOGICO:    FTran490
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
' Permite administrar la Domiciliación de Pagos
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Option Explicit
Dim VLPaso As Boolean
Dim VLTipoCuenta As String

Private Sub cmbTipo_Change()
    VLPaso = False
    PLLimpiar
End Sub

Private Sub cmbTipo_GotFocus()
Dim aux1 As String
     FPrincipal!pnlHelpLine.Caption = " Tipo de Producto "
     If mskCuenta.ClipText <> "" Then
        aux1 = mskCuenta.Mask
        mskCuenta.Mask = ""
        mskCuenta.Text = ""
        mskCuenta.Mask = aux1
     End If
End Sub

Private Sub cmbTipo_KeyPress(KeyAscii As Integer)
    If KeyAscii = Asc("+") Then
        SendKeys "{TAB}"
        KeyAscii = 0
        Exit Sub
    End If
    If KeyAscii = Asc("-") Then
        SendKeys "+{TAB}"
        KeyAscii = 0
        Exit Sub
    End If
End Sub

Private Sub cmbTipo_LostFocus()
  If cmbTipo.Text = "CUENTA CORRIENTE" Then
        mskCuenta.Mask = VGMascaraCtaCte
  Else
        mskCuenta.Mask = VGMascaraCtaAho
  End If

End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
    Case 0 'Eliminar
      PLEliminar
    Case 1 'Transmitir
      PLTransmitir
    Case 2 'Limpiar
      PLLimpiar
    Case 3 'Salir
        'Salir
        Unload FTran490
    Case 4
      PLBuscar
    End Select
End Sub

Private Sub cmdBoton_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii = Asc("+") Then
        SendKeys "{TAB}"
        KeyAscii = 0
        Exit Sub
    End If
    If KeyAscii = Asc("-") Then
        SendKeys "+{TAB}"
        KeyAscii = 0
        Exit Sub
    End If
End Sub

Private Sub Form_Load()
    FTran490.Left = 0
    FTran490.Top = 0
    FTran490.Width = 9450
    FTran490.Height = 5900
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaCte
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 0
    cmbTipo.Enabled = True
    cmdBoton(4).Enabled = True
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
    ' Verificar que existan chequeras para anular
    If grdRegistros.Rows <= 2 Then
        grdRegistros.Row = 1
        grdRegistros.Col = 1
        If Trim$(grdRegistros.Text) = "" Then
            MsgBox "No existen Registros a eliminar", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If

    PMMarcarRegistro

End Sub

Private Sub mskCuenta_Change()
    VLPaso = False
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_KeyPress(KeyAscii As Integer)
    If KeyAscii = Asc("+") Then
        SendKeys "{TAB}"
        KeyAscii = 0
        Exit Sub
    End If
    If KeyAscii = Asc("-") Then
        SendKeys "+{TAB}"
        KeyAscii = 0
        Exit Sub
    End If
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" And VLPaso = False Then
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
                 PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
                 If FMTransmitirRPC(sqlconn&, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(2)
                     PMChequea sqlconn&
                    VLPaso = True
                    PMLimpiaGrid grdRegistros
                    grdRegistros.Col = 0
                    grdRegistros.Picture = picVisto(1)
                    txtCampo(0).SetFocus
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                    lblDescripcion(2).Caption = ""
                    mskCuenta.SetFocus
                    PMLimpiaGrid grdRegistros
                    grdRegistros.Col = 0
                    grdRegistros.Picture = picVisto(1)
                    Exit Sub
                End If

            Else
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                lblDescripcion(2).Caption = ""
                mskCuenta.SetFocus
                
                PMLimpiaGrid grdRegistros
                grdRegistros.Col = 0
                grdRegistros.Picture = picVisto(1)

                
                Exit Sub
            End If
        Else
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
                 If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(2)
                     PMChequea sqlconn&
                    VLPaso = True
                    PMLimpiaGrid grdRegistros
                    grdRegistros.Col = 0
                    grdRegistros.Picture = picVisto(1)
                    txtCampo(0).SetFocus
            Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    lblDescripcion(2).Caption = ""
                    mskCuenta.SetFocus
                    PMLimpiaGrid grdRegistros
                    grdRegistros.Col = 0
                    grdRegistros.Picture = picVisto(1)
                
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                lblDescripcion(2).Caption = ""
                mskCuenta.SetFocus
                PMLimpiaGrid grdRegistros
                grdRegistros.Col = 0
                grdRegistros.Picture = picVisto(1)
                
                Exit Sub
            End If
        End If
    End If
    If mskCuenta.ClipText = "" Then
        lblDescripcion(2).Caption = ""
        PMLimpiaGrid grdRegistros
        grdRegistros.Col = 0
        grdRegistros.Picture = picVisto(1)
    End If


End Sub

Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Llena el grid con los primeros 20 registros
'            retornados por el stored procedure.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

       If Trim$(mskCuenta.ClipText) = "" Then
         MsgBox "La Cuenta del cliente es Mandatorio", 0 + 16, "Mensaje de Error"
         mskCuenta.SetFocus
         Exit Sub
       End If

       If cmbTipo.Text = "CUENTA CORRIENTE" Then
          VLTipoCuenta = "3"
       Else
          VLTipoCuenta = "4"
       End If
       
          PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "490"
          PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
          PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
          PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLTipoCuenta
          PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
          If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_domic_pagos", True, " Ok... Busca domiciliaciones de Pago para una cuenta") Then
              PMMapeaGrid sqlconn&, grdRegistros, False
              PMChequea sqlconn&
         Else
             PMLimpiaGrid grdRegistros
             grdRegistros.Col = 0
             grdRegistros.Picture = picVisto(1)
             txtCampo(0).SetFocus
             Exit Sub
         End If

End Sub

Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Permite eliminar domiciliaciones de Pago para una
'            cuenta
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Dim i As Integer
       If cmbTipo.Text = "CUENTA CORRIENTE" Then
          VLTipoCuenta = "3"
       Else
          VLTipoCuenta = "4"
       End If

  For i = 1 To (grdRegistros.Rows - 1)
    grdRegistros.Row = i
    grdRegistros.Col = 0
    If grdRegistros.Picture = picVisto(0) Then 'Cuando estan con el VISTITO
       PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "490"
       PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
       PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLTipoCuenta
       PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "E"
      grdRegistros.Col = 1
       PMPasoValores sqlconn&, "@i_tipo_pago", 0, SQLVARCHAR, grdRegistros.Text
          If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_domic_pagos", True, " Ok... Elimina domiciliaciones de Pago para una cuenta") Then
            PMChequea sqlconn&
           PLBuscar
         End If
    End If
  Next i
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

       PMLimpiaGrid grdRegistros
        mskCuenta.Enabled = True
        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
        lblDescripcion(2).Caption = ""
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        lblDescripcion(0).Caption = ""
        cmbTipo.SetFocus
        mskCuenta.Enabled = True
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""

End Sub

Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Busca domiciliaciones de Pago para una cuenta
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
       
       If Trim$(mskCuenta.ClipText) = "" Then
         MsgBox "La Cuenta del cliente es Mandatorio", 0 + 16, "Mensaje de Error"
         mskCuenta.SetFocus
         Exit Sub
       End If

       If Trim$(txtCampo(0).Text) = "" Then
         MsgBox "El tipo de Pago es Mandatorio", 0 + 16, "Mensaje de Error"
         txtCampo(0).SetFocus
         Exit Sub
       End If


       If cmbTipo.Text = "CUENTA CORRIENTE" Then
          VLTipoCuenta = "3"
       Else
          VLTipoCuenta = "4"
       End If
       
          PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "490"
          PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
          PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
          PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VLTipoCuenta
          PMPasoValores sqlconn&, "@i_tipo_pago", 0, SQLVARCHAR, (txtCampo(0).Text)
          PMPasoValores sqlconn&, "@i_comentario", 0, SQLVARCHAR, (txtCampo(1).Text)

          If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_domic_pagos", True, " Ok... Busca domiciliaciones de Pago para una cuenta") Then
            PMChequea sqlconn&
           PLBuscar

         End If

           txtCampo(0).Text = ""
           lblDescripcion(0) = ""
           txtCampo(1).Text = ""
           txtCampo(0).SetFocus


End Sub

Private Sub PMMarcarRegistro()
'*************************************************************
' PROPOSITO: Seleccionar y quitar la Seleccion de una fila del
'            grid
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    grdRegistros.Col = 0
    If grdRegistros.Picture = picVisto(1) Then
        grdRegistros.Text = Str$(grdRegistros.Row)
        grdRegistros.Picture = picVisto(0)
    Else
        grdRegistros.Text = Str$(grdRegistros.Row)
        grdRegistros.Picture = picVisto(1)
    End If

End Sub

Private Sub txtCampo_Change(Index As Integer)
    VLPaso = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Tipo de Domiciliación de Pago [F5 Ayuda]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Comentario acerca de la Domiciliación"
    txtCampo(Index).SelStart = 0
    txtCampo(Index).SelLength = Len(txtCampo(Index).Text)
    End Select
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
Select Case Index
  Case 0
    If Keycode = VGTeclaAyuda Then
       VLPaso = True
        txtCampo(0).Text = ""
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_tipo_pago"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta de los Tipos de Pago " & "[" & txtCampo(0).Text & "]") Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
           FCatalogo.Show 1
           txtCampo(0).Text = VGACatalogo.Codigo
           lblDescripcion(0).Caption = VGACatalogo.Descripcion
           If txtCampo(0).Text <> "" Then
              VLPaso = True
           End If
        End If
    End If
End Select

End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    If KeyAscii = Asc("+") Then
        SendKeys "{TAB}"
        KeyAscii = 0
        Exit Sub
    End If
    If KeyAscii = Asc("-") Then
        SendKeys "+{TAB}"
        KeyAscii = 0
        Exit Sub
    End If
    Select Case Index
    Case 0
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
    Case 1
        KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
 Select Case Index
   Case 0
   If VLPaso = False And txtCampo(0).Text <> "" Then
      If txtCampo(0).Text <> "" Then
          PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_tipo_pago"
          PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
          PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(0).Text)
          If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", True, " Consulta de Tipos de Pago " & "[" & txtCampo(0).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(0)
             PMChequea sqlconn&
           Else
              txtCampo(0).Text = ""
              lblDescripcion(0).Caption = ""
              txtCampo(0).SetFocus
           End If
      Else
          lblDescripcion(0).Caption = ""
      End If
   End If
 End Select
End Sub


