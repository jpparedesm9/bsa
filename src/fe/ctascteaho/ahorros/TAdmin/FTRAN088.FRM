VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{F856EC8B-F03C-4515-BDC6-64CBD617566A}#6.0#0"; "fpSpr60.ocx"
Begin VB.Form FTran088 
   BackColor       =   &H00C0C0C0&
   Caption         =   "Impresión de Formularios de Ingreso y Egreso de Divisas."
   ClientHeight    =   5325
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9300
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.ComboBox cboTipo 
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
      Left            =   2160
      TabIndex        =   0
      Top             =   135
      Width           =   2295
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
      Left            =   2160
      MaxLength       =   3
      TabIndex        =   1
      Top             =   510
      Width           =   555
   End
   Begin FPSpreadADO.fpSpread grdResultado 
      Height          =   4125
      Left            =   30
      TabIndex        =   2
      Top             =   1080
      Width           =   8310
      _Version        =   393216
      _ExtentX        =   14658
      _ExtentY        =   7276
      _StockProps     =   64
      AutoClipboard   =   0   'False
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaxCols         =   1
      MaxRows         =   1
      SpreadDesigner  =   "FTRAN088.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   3
      Tag             =   "6335"
      Top             =   75
      WhatsThisHelpID =   2009
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Imprimir"
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
      TabIndex        =   4
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
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   15
      X2              =   8360
      Y1              =   960
      Y2              =   960
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Formulario:"
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
      Height          =   270
      Index           =   1
      Left            =   60
      TabIndex        =   7
      Top             =   195
      WhatsThisHelpID =   5032
      Width           =   2025
   End
   Begin VB.Label il_mascara 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Código del Cliente:"
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
      Height          =   270
      Index           =   0
      Left            =   60
      TabIndex        =   6
      Top             =   510
      Width           =   2025
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
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
      Index           =   0
      Left            =   2745
      TabIndex        =   5
      Top             =   510
      Width           =   5610
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5365
   End
End
Attribute VB_Name = "FTran088"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTran088.frm
' NOMBRE LOGICO:    FTran088
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
' Permite realizar la impresion de los formularios de ingreso
' y egreso de divisas.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VTEnte As String
Dim VTNombre As String
Dim VTNit As String
Dim VTDireccion As String
Dim VTTelefono As String
Dim VTClaseMonEx As String
Dim VTMontoMonEx As String
Dim VTEquivalUSD As String
Dim VTEquivalQtz As String
Dim VTPaisProc As String
Dim VTTipoCambio As String
Dim VTChkEfectivo As Boolean
Dim VTChkCheque As Boolean
Dim i As Integer
Dim VLPaso As Boolean

Private Sub cmdBoton_Click(Index As Integer)
  Select Case Index%
  Case 0
    PLBuscar
    PLImprimir
  Case 1
    Unload Me
  End Select
End Sub

Private Sub Form_Load()
    Me.Left = 0   '15
    Me.Top = 0   '15
    Me.Width = 9450   '9420
    Me.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    
    cboTipo.Text = cboTipo.List(0)
    
    grdResultado.CellType = 5
    grdResultado.EditMode = False
    grdResultado.Lock = True
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub


Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Confirmar al usuario la impresion del listado de
'            formularios de ingreso o egreso, y llamado a la
'            funcion respectiva de impresion
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Dim VTMensaje As String
    Dim VTRespuesta As Integer
    
    If cboTipo.Text = "INGRESOS" Then
        VTMensaje$ = "Se va(n) a imprimir " & grdResultado.MaxRows & " registro(s)." & vbCrLf
        VTMensaje$ = VTMensaje$ & "Ingrese el(los) formulario(s) de Ingreso(s) en la impresora."
        VTRespuesta% = MsgBox(VTMensaje$, vbOKCancel, "Advertencia")
        If VTRespuesta = vbOK Then
        PLImprimirRegistrosIng
        End If
    Else
        VTMensaje$ = "Se va(n) a imprimir " & grdResultado.MaxRows & " registro(s)." & vbCrLf
        VTMensaje$ = VTMensaje$ & "Ingrese el(los) formulario(s) de Egreso(s) en la impresora."
        VTRespuesta% = MsgBox(VTMensaje$, vbOKCancel, "Advertencia")
        If VTRespuesta = vbOK Then
        PLImprimirRegistrosEgr
        End If
    End If
End Sub

Private Sub PLImprimirRegistrosIng()
'*************************************************************
' PROPOSITO: Imprimir el listado de formularios de Ingresos
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    For i = 1 To grdResultado.MaxRows
        
        grdResultado.Row = i
        grdResultado.Col = 1
        VTEnte = grdResultado.Text
        grdResultado.Col = 2
        VTNombre = grdResultado.Text
        grdResultado.Col = 3
        VTNit = grdResultado.Text
        grdResultado.Col = 4
        VTDireccion = grdResultado.Text
        grdResultado.Col = 5
        VTTelefono = grdResultado.Text
        grdResultado.Col = 7
        VTClaseMonEx = grdResultado.Text
        grdResultado.Col = 8
        VTMontoMonEx = grdResultado.Text
        grdResultado.Col = 9
        VTEquivalUSD = grdResultado.Text
        grdResultado.Col = 10
        VTEquivalQtz = grdResultado.Text
        grdResultado.Col = 11
        VTPaisProc = grdResultado.Text
        grdResultado.Col = 12
        VTTipoCambio = grdResultado.Text
        grdResultado.Col = 13
        If grdResultado.Text <> "" Then
            VTChkEfectivo = True
        Else
            VTChkEfectivo = False
        End If
        grdResultado.Col = 14
        If grdResultado.Text <> "" Then
            VTChkCheque = True
        Else
            VTChkCheque = False
        End If

        Screen.MousePointer = 11 'Reloj de Espera
        Printer.FontBold = True
        Printer.CurrentX = 0
        Printer.CurrentY = 0
        Printer.FontName = "Courier New"
        Printer.FontSize = 8
        Printer.FontBold = True
        Printer.CurrentX = 1700
        Printer.CurrentY = 2100
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        Printer.Print Trim(VTNombre)
        Printer.CurrentX = 8800
        Printer.CurrentY = 2100
        Printer.Print VTNit
        Printer.CurrentX = 1700
        Printer.CurrentY = 2600
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        Printer.Print Trim(VTDireccion)
        Printer.CurrentX = 6800
        Printer.CurrentY = 2600
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        Printer.Print Trim(VTTelefono)
        Printer.CurrentX = 1700
        Printer.CurrentY = 3500
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        Printer.Print Trim(VTClaseMonEx)
        Printer.CurrentX = 3000
        Printer.CurrentY = 3500
        Printer.Print VTMontoMonEx
        Printer.CurrentX = 8000
        Printer.CurrentY = 3500
        Printer.Print VTEquivalUSD
        Printer.CurrentX = 1700
        Printer.CurrentY = 3900
        Printer.Print VTEquivalQtz
        Printer.CurrentX = 5000
        Printer.CurrentY = 3900
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        Printer.Print Trim(VTPaisProc)
        Printer.CurrentX = 8000
        Printer.CurrentY = 3900
        Printer.Print VTTipoCambio
        If VTChkEfectivo = True Then
            Printer.CurrentX = 3600
            Printer.CurrentY = 4300
            Printer.Print "X"
        End If
        If VTChkCheque = True Then
            Printer.CurrentX = 7100
            Printer.CurrentY = 4300
            Printer.Print "X"
''            Printer.CurrentX = 9500
''            Printer.CurrentY = 4300
''            Printer.Print "CHEQUE"
        End If
        
        Printer.CurrentX = 2700
        Printer.CurrentY = 12500
        Printer.Print Format(Day(Date), "00")
        
        Printer.CurrentX = 3700
        Printer.CurrentY = 12500
        Printer.Print Format(Month(Date), "00")
        
        Printer.CurrentX = 4900
        Printer.CurrentY = 12500
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
        Printer.Print Mid(Year(Date), 3)

        Printer.EndDoc
        Screen.MousePointer = 0 'Cursor normal
    Next i
End Sub
Private Sub PLImprimirRegistrosEgr()
'*************************************************************
' PROPOSITO: Imprimir el listado de formularios de Egresos
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    For i = 1 To grdResultado.MaxRows
        
        grdResultado.Row = i
        grdResultado.Col = 1
        VTEnte = grdResultado.Text
        grdResultado.Col = 2
        VTNombre = grdResultado.Text
        grdResultado.Col = 3
        VTNit = grdResultado.Text
        grdResultado.Col = 4
        VTDireccion = grdResultado.Text
        grdResultado.Col = 5
        VTTelefono = grdResultado.Text
        grdResultado.Col = 7
        VTClaseMonEx = grdResultado.Text
        grdResultado.Col = 8
        VTMontoMonEx = grdResultado.Text
        grdResultado.Col = 9
        VTEquivalUSD = grdResultado.Text
        grdResultado.Col = 10
        VTEquivalQtz = grdResultado.Text
        grdResultado.Col = 11
        VTPaisProc = grdResultado.Text
        grdResultado.Col = 12
        VTTipoCambio = grdResultado.Text
        grdResultado.Col = 13
        If grdResultado.Text <> "" Then
            VTChkEfectivo = True
        Else
            VTChkEfectivo = False
        End If
        grdResultado.Col = 14
        If grdResultado.Text <> "" Then
            VTChkCheque = True
        Else
            VTChkCheque = False
        End If

        Screen.MousePointer = 11 'Reloj de Espera
        Printer.FontBold = True
        Printer.CurrentX = 0
        Printer.CurrentY = 0
        Printer.FontName = "Courier New"
        Printer.FontSize = 8
        Printer.FontBold = True
        Printer.CurrentX = 1700
        Printer.CurrentY = 2200
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        Printer.Print Trim(VTNombre)
        Printer.CurrentX = 8800
        Printer.CurrentY = 2200
        Printer.Print VTNit
        Printer.CurrentX = 1700
        Printer.CurrentY = 2700
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        Printer.Print Trim(VTDireccion)
        Printer.CurrentX = 6800
        Printer.CurrentY = 2700
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        Printer.Print Trim(VTTelefono)
        Printer.CurrentX = 1700
        Printer.CurrentY = 3600
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        Printer.Print Trim(VTClaseMonEx)
        Printer.CurrentX = 3000
        Printer.CurrentY = 3600
        Printer.Print VTMontoMonEx
        Printer.CurrentX = 8000
        Printer.CurrentY = 3600
        Printer.Print VTEquivalUSD
        Printer.CurrentX = 1700
        Printer.CurrentY = 4000
        Printer.Print VTEquivalQtz
        Printer.CurrentX = 5000
        Printer.CurrentY = 4000
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        Printer.Print Trim(VTPaisProc)
        Printer.CurrentX = 8000
        Printer.CurrentY = 4000
        Printer.Print VTTipoCambio
        If VTChkEfectivo = True Then
            Printer.CurrentX = 3600
            Printer.CurrentY = 4800
            Printer.Print "X"
        End If
        If VTChkCheque = True Then
            Printer.CurrentX = 7100
            Printer.CurrentY = 4800
            Printer.Print "X"
''            Printer.CurrentX = 9500
''            Printer.CurrentY = 4300
''            Printer.Print "CHEQUE"
        End If
        
        Printer.CurrentX = 2700
        Printer.CurrentY = 12700
        Printer.Print Format(Day(Date), "00")
        
        Printer.CurrentX = 3700
        Printer.CurrentY = 12700
        Printer.Print Format(Month(Date), "00")
        
        Printer.CurrentX = 4900
        Printer.CurrentY = 12700
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
        Printer.Print Mid(Year(Date), 3)

        Printer.EndDoc
        Screen.MousePointer = 0 'Cursor normal
    Next i
End Sub

Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Mapea al grid de Formularios de Ingreso y Egreso
'            de divisas los primeros 20 registros retornados
'            por el stored procedure de consulta de formularios.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    grdResultado.CellType = 5
    grdResultado.EditMode = True
    grdResultado.Lock = False
  
  If cboTipo.Text = "" Then
    MsgBox "El tipo de formulario es mandatorio", 0 + 16, "Mensaje de Error"
    cboTipo.SetFocus
    Exit Sub
  End If
  
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2808"
   If cboTipo.Text = "INGRESOS" Then
        PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "I"
   Else
        PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "E"
   End If
   PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT1, "0"
   If txtCampo(0).Text <> "" Then
        PMPasoValores sqlconn&, "@i_cliente_error", 0, SQLINT1, txtCampo(0).Text
   End If
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_busca_ingegre", True, " Ok... Consulta de Formularios") Then
       PMMapeaGrid sqlconn&, grdResultado, False
       PMChequea sqlconn&
      If Val(grdResultado.MaxRows) >= 20 Then
         PLSiguientes
      End If
      If grdResultado.MaxRows <= 2 Then
         grdResultado.Col = 1
         grdResultado.Row = 1
         If grdResultado.Text = "" Then
            PMLimpiaG grdResultado
            Exit Sub
         End If
      End If
   Else
       PMLimpiaG grdResultado
   End If
    grdResultado.CellType = 5
    grdResultado.EditMode = False
    grdResultado.Lock = True
End Sub

Private Sub PLSiguientes()
'*************************************************************
' PROPOSITO: Mapea al grid de Formularios de Ingreso y Egreso
'            de divisas los siguientes 20 registros retornados
'            por el stored procedure de consulta de formularios.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VTSecuencial As String

    grdResultado.CellType = 5
    grdResultado.EditMode = True
    grdResultado.Lock = False
   
   grdResultado.Row = grdResultado.MaxRows
   grdResultado.Col = 1
   VTSecuencial$ = grdResultado.Text
  
  If cboTipo.Text = "" Then
    MsgBox "El tipo de formulario es mandatorio", 0 + 16, "Mensaje de Error"
    cboTipo.SetFocus
    Exit Sub
  End If
  
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2808"
   If cboTipo.Text = "INGRESOS" Then
        PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "I"
   Else
        PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "E"
   End If
   PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT1, VTSecuencial$
   If txtCampo(0).Text <> "" Then
        PMPasoValores sqlconn&, "@i_cliente_error", 0, SQLINT1, txtCampo(0).Text
   End If
   
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_busca_ingegre", True, " Ok... Consulta de Formularios") Then
       PMMapeaGrid sqlconn&, grdResultado, True
       PMChequea sqlconn&
      If Val(grdResultado.Tag) >= 20 Then
         PLSiguientes
      End If
      If grdResultado.MaxRows <= 2 Then
         grdResultado.Col = 1
         grdResultado.Row = 1
         If grdResultado.Text = "" Then
            PMLimpiaG grdResultado
            txtCampo(0).SetFocus
            Exit Sub
         End If
      End If
  Else
     PMLimpiaG grdResultado
     txtCampo(0).SetFocus
  End If
    grdResultado.CellType = 5
    grdResultado.EditMode = False
    grdResultado.Lock = True
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código del cliente [F5 Ayuda]"
    End Select
    VLPaso = True
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    Dim VLFormatoFecha As String
    Dim VTRes As Boolean
    If Keycode = VGTeclaAyuda% Then
        VLPaso = True
        Select Case Index%
        Case 0
            ' F5 para ayuda de cliente
            ' Forma de busqueda de clientes
            txtCampo(0).Text = ""

            If VGFBusCliente Is Nothing Then
               Set VGFBusCliente = New BuscarClientes
            End If
            Set FMain = FPrincipal
            VGFBusCliente.Cabecera_Busqueda True, True, True, False, 1
            'Abrir forma de búsqueda de clientes
            VTRes = VGFBusCliente.FMBuscarCliente(FMain, VGMap, sqlconn&, ServerName$, ServerNameLocal$, VLFormatoFecha, VGRol$)
            'Si se selecciona un cliente visualizar datos
              If VTRes = True Then
                If VGFBusCliente.DatosCliente(1) <> "" Then
                    txtCampo(0).Text = VGFBusCliente.DatosCliente(1)
                    If VGFBusCliente.DatosCliente(0) = "P" Then
                        lblDescripcion(0).Caption = VGFBusCliente.DatosCliente(2)
                    Else
                        If VGFBusCliente.DatosCliente(87) = "" Then
                          lblDescripcion(0).Caption = VGFBusCliente.DatosCliente(2)
                        Else
                          lblDescripcion(0).Caption = VGFBusCliente.DatosCliente(87)
                        End If
                    End If
                    VLPaso = True
                    txtCampo(0).SetFocus
                End If
             End If
          End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Dim VTR1 As Integer
    Dim VLNombre As String
    Select Case Index%
    Case 0
        If VLPaso = False Then
            If txtCampo(0).Text <> "" Then
                PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "T"
                PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCampo(0).Text)
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2543"
                If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_desc_cliente_cc", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then
                    ReDim VTValores(20) As String
                    VTR1 = FMMapeaArreglo(sqlconn&, VTValores())
                    PMChequea sqlconn&
                    If VTValores(7) = "I" Then
                       MsgBox "Es un cliente cifrado", 0 + 16, "Mensaje de Error"
                       txtCampo(0).Text = ""
                       lblDescripcion(0).Caption = ""
                       txtCampo(0).SetFocus
                       Exit Sub
                    End If
                    If VTValores(6) <> "" Then
                      VLNombre = VTValores(6) + ", " + VTValores(4) + " " + VTValores(5) + " " + VTValores(2) + " " + VTValores(3) + " " + "DE"
                    Else
                      VLNombre = VTValores(4) + " " + VTValores(5) + " " + VTValores(2) + " " + VTValores(3)
                    End If
'FIXIT: Replace 'LTrim' function with 'LTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
                    lblDescripcion(0).Caption = LTrim(VLNombre)
                    cmdBoton(0).SetFocus
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

