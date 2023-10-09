VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "Msmask32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran2687 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Recuperación Manual de Consumos ATM"
   ClientHeight    =   5340
   ClientLeft      =   345
   ClientTop       =   2850
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
   HelpContextID   =   1070
   LinkMode        =   1  'Source
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5336.993
   ScaleMode       =   0  'User
   ScaleWidth      =   540
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8400
      TabIndex        =   6
      Top             =   3015
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
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   0
      Left            =   1410
      TabIndex        =   0
      Top             =   30
      Width           =   2700
      _ExtentX        =   4763
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   5
      Left            =   8400
      TabIndex        =   3
      Top             =   795
      WhatsThisHelpID =   2020
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Si&guientes"
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
      Index           =   0
      Left            =   8400
      TabIndex        =   2
      Tag             =   "2623"
      Top             =   30
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
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   1
      Left            =   1410
      TabIndex        =   1
      Top             =   330
      Width           =   2700
      _ExtentX        =   4763
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7770
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   9
      Top             =   750
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   7995
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   10
      Top             =   750
      Visible         =   0   'False
      Width           =   195
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8400
      TabIndex        =   7
      Top             =   3780
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
   Begin MSGrid.Grid grdRegistros 
      Height          =   4290
      Left            =   90
      TabIndex        =   4
      Top             =   990
      Width           =   8205
      _Version        =   65536
      _ExtentX        =   14474
      _ExtentY        =   7568
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8400
      TabIndex        =   8
      Top             =   4545
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
      Index           =   1
      Left            =   8400
      TabIndex        =   5
      Tag             =   "2623"
      Top             =   2250
      WhatsThisHelpID =   2002
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Escoger"
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
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   485.013
      X2              =   485.013
      Y1              =   39.977
      Y2              =   5277.027
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8370
      X2              =   8370
      Y1              =   0
      Y2              =   5310.008
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   6.968
      X2              =   485.013
      Y1              =   719.595
      Y2              =   719.595
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de consumos ATM:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   120
      TabIndex        =   12
      Top             =   780
      Width           =   2100
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Núm. Tarjeta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   120
      TabIndex        =   13
      Top             =   30
      Width           =   1170
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Clave:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   120
      TabIndex        =   11
      Top             =   330
      Width           =   555
   End
End
Attribute VB_Name = "FTran2687"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTRA2687.frm
' NOMBRE LOGICO:    FTran2687
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
' Permite realizar la Recuperación Manual de Consumos ATM
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VLNumReg As Integer

Private Sub cmdBoton_Click(Index As Integer)

   Select Case Index%
      Case 0  'Buscar
          PLBuscar
      Case 1  'Escoger
          PLEscoger
      Case 2  'Transmitir
          PLTransmitir
      Case 3  'Limpiar
          PLLimpiar
      Case 4  'Salir
          Unload FTran2687
      Case 5  'Siguiente
         PLSiguientes
 End Select

End Sub

Private Sub cmdBoton_GotFocus(Index As Integer)
   Select Case Index%
      Case 0  'Buscar
            FPrincipal!pnlHelpLine.Caption = " Buscar los consumos ATM rechazados y perdidos"
      Case 1  'Escoger
            FPrincipal!pnlHelpLine.Caption = " Escoger un consumo ATM a recuperar"
      Case 2  'Transmitir
            FPrincipal!pnlHelpLine.Caption = " Recuperar los consumos ATM seleccionados"
      Case 3  'Limpiar
            FPrincipal!pnlHelpLine.Caption = " Limpiar la pantalla"
      Case 4  'Salir
            FPrincipal!pnlHelpLine.Caption = " Salir de la pantalla de Recuperaciones Manuales"
      Case 5  'Siguiente
            FPrincipal!pnlHelpLine.Caption = " Buscar los siguientes 20 consumos ATM"
   End Select

End Sub

Private Sub Form_Load()

    FTran2687.Left = 0   '15
    FTran2687.Top = 0   '15
    FTran2687.Width = 9450   '9420
    FTran2687.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    VGMascaraTarjeta$ = "######-###-######-#"
    mskValor(0).Mask = VGMascaraTarjeta$
    
    'mskValor(0).Mask = "######-###-######-#"
    mskValor(1).Mask = "#########"

    VLNumReg = 0
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

   PLEscoger
End Sub

Private Sub grdRegistros_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de consumos ATM rechazados y perdidos"
End Sub

Private Sub grdRegistros_KeyPress(KeyAscii As Integer)
   If KeyAscii = 13 Then
      grdregistros_DblClick
   End If
End Sub

Private Sub grdRegistros_KeyUp(Keycode As Integer, Shift As Integer)
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

Private Sub mskValor_GotFocus(Index As Integer)
    Select Case Index%
        Case 0
            FPrincipal!pnlHelpLine.Caption = " Número de tarjeta de débito"
        Case 1
            FPrincipal!pnlHelpLine.Caption = " Clave de consumo realizado"
    End Select
    mskValor(Index%).SelStart = 0
    mskValor(Index%).SelLength = Len(mskValor(Index%).Text)
   
End Sub

Private Sub mskValor_LostFocus(Index As Integer)
If mskValor(0).ClipText <> "" Then
   If Not FMChequeaTarjeta((mskValor(0).ClipText)) Then
        MsgBox "El dígito verificador de la tarjeta está incorrecto", 0 + 16, "Mensaje de Error"
        mskValor(0).Text = FMMascara("", VGMascaraTarjeta$)
        mskValor(0).SetFocus
        Exit Sub
   End If
End If
End Sub

Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Llena el grid con los datos retornados por el
'            stored procedure.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

   ' Numero de tarjeta
   If Trim$(mskValor(0).ClipText) = "" Then
      MsgBox "El número de tarjeta es mandatorio", 0 + 16, "Mensaje de Error"
      mskValor(0).SetFocus
      Exit Sub
   End If

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "2687"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
    PMPasoValores sqlconn&, "@i_tarjeta", 0, SQLVARCHAR, mskValor(0).ClipText
   If Trim$(mskValor(1).ClipText) <> "" Then
       PMPasoValores sqlconn&, "@i_clave", 0, SQLINT4, (mskValor(1).ClipText)
   End If

    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_recuperacion_man_atm", True, " OK... Consulta de consumos ATM") Then
       PMMapeaGrid sqlconn&, grdRegistros, False
       PMChequea sqlconn&
      mskValor(0).Enabled = False
      mskValor(1).Enabled = False

      grdRegistros.ColWidth(1) = 900    'Secuencial
      grdRegistros.ColWidth(2) = 800    'Producto
      grdRegistros.ColWidth(3) = 1200   'Cuenta
      grdRegistros.ColWidth(4) = 1000   'Clave
      grdRegistros.ColWidth(5) = 1000   'Valor
      grdRegistros.ColWidth(6) = 900   'Fecha
      grdRegistros.ColWidth(7) = 900   'Fecha Fin
      grdRegistros.ColWidth(8) = 600    'Estado
      grdRegistros.ColAlignment(3) = 2  'Cuenta

      If Val(grdRegistros.Tag) >= 20 Then
         cmdBoton(5).Enabled = True
        Else
           cmdBoton(5).Enabled = False
      End If
      VLNumReg = 0
   End If

End Sub

Private Sub PLEscoger()
'*************************************************************
' PROPOSITO: Permite elegir un registro, para realizar la
'            actualizacion de sus datos
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    If Val(grdRegistros.Tag) <= 0 Then
        Exit Sub
    End If

   grdRegistros.Col = 0
   If grdRegistros.Picture = picVisto(0) Then
      grdRegistros.Picture = picVisto(1)
      VLNumReg = VLNumReg - 1
   Else
      grdRegistros.Picture = picVisto(0)
      VLNumReg = VLNumReg + 1
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

   If mskValor(1).Enabled Then
      mskValor(0).Enabled = True
      mskValor(0).Text = FMMascara("", VGMascaraTarjeta$)
      mskValor(0).SetFocus
   End If
   
   If Not mskValor(1).Enabled Then
      mskValor(1).Enabled = True
      mskValor(1).Text = "_________"
      mskValor(1).SetFocus
   End If
   
   PMLimpiaG grdRegistros
   grdRegistros.Col = 0
   grdRegistros.Row = 1
   grdRegistros.Picture = picVisto(1)
   grdRegistros.ColWidth(1) = grdRegistros.ColWidth(0)
   
   cmdBoton(5).Enabled = False
   VLNumReg = 0
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

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "2687"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
    PMPasoValores sqlconn&, "@i_tarjeta", 0, SQLVARCHAR, mskValor(0).ClipText
   grdRegistros.Col = 4
   grdRegistros.Row = grdRegistros.Rows - 1
    PMPasoValores sqlconn&, "@i_clave", 0, SQLINT4, CStr(Val(grdRegistros.Text) + 1)

    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_recuperacion_man_atm", True, " OK... Consulta de consumos ATM") Then
       PMMapeaGrid sqlconn&, grdRegistros, True
       PMChequea sqlconn&

      grdRegistros.ColAlignment(3) = 2  'Cuenta

      If Val(grdRegistros.Tag) >= 20 Then
         cmdBoton(5).Enabled = True
        Else
           cmdBoton(5).Enabled = False
      End If
   End If


End Sub

Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Permite enviar los datos para recuperar datos
'            de consumo de ATM
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

   If VLNumReg = 0 Then
      MsgBox "Debe marcar al menos un Consumo para realizar la recuperación", 0 + 16, "Mensaje de Error"
      Exit Sub
   End If

   grdRegistros.Col = 0
   grdRegistros.Row = 0
   While grdRegistros.Row + 1 < grdRegistros.Rows
      grdRegistros.Row = grdRegistros.Row + 1
      If grdRegistros.Picture = picVisto(0) Then
          PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "2687"
          PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
          PMPasoValores sqlconn&, "@i_tarjeta", 0, SQLVARCHAR, mskValor(0).ClipText
         grdRegistros.Col = 4
          PMPasoValores sqlconn&, "@i_clave", 0, SQLINT4, grdRegistros.Text
         grdRegistros.Col = 0
      
          If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_recuperacion_man_atm", True, " Ok... Actualización de consumo ATM") Then
             PMChequea sqlconn&
         End If

         grdRegistros.Picture = picVisto(1)
      End If
   Wend

   PLBuscar
End Sub


