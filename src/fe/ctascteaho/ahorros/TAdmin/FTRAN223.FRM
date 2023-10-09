VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.ocx"
Begin VB.Form FTran223 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "*Solicitud de Estado de Cuenta de Ahorros sin Costo"
   ClientHeight    =   4425
   ClientLeft      =   1245
   ClientTop       =   2145
   ClientWidth     =   7020
   ControlBox      =   0   'False
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
   HelpContextID   =   1129
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4425
   ScaleWidth      =   7020
   StartUpPosition =   1  'CenterOwner
   Tag             =   "1048"
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   2250
      MaxLength       =   120
      TabIndex        =   21
      Top             =   1995
      Width           =   3825
   End
   Begin VB.Frame FraOpcGen 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Opción de Generación"
      ForeColor       =   &H00800000&
      Height          =   1650
      Left            =   120
      TabIndex        =   17
      Top             =   2730
      Width           =   5895
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   3
         Left            =   1710
         MaxLength       =   2
         TabIndex        =   27
         Top             =   990
         Width           =   510
      End
      Begin VB.Frame FraOpciones 
         BackColor       =   &H00C0C0C0&
         Height          =   615
         Left            =   120
         TabIndex        =   18
         Top             =   240
         Width           =   5655
         Begin VB.OptionButton OptGeneracion 
            BackColor       =   &H00C0C0C0&
            Caption         =   "Impresión"
            ForeColor       =   &H00800000&
            Height          =   255
            Index           =   0
            Left            =   840
            TabIndex        =   20
            Top             =   240
            Width           =   1335
         End
         Begin VB.OptionButton OptGeneracion 
            BackColor       =   &H00C0C0C0&
            Caption         =   "Correo Electrónico"
            ForeColor       =   &H00800000&
            Height          =   255
            Index           =   1
            Left            =   2880
            TabIndex        =   19
            Top             =   240
            Width           =   1935
         End
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Correo Electrónico:"
         ForeColor       =   &H00800000&
         Height          =   285
         Index           =   2
         Left            =   75
         TabIndex        =   29
         Top             =   990
         Width           =   1770
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   570
         Index           =   4
         Left            =   2235
         TabIndex        =   28
         Top             =   990
         Width           =   3540
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   2250
      MaxLength       =   2
      TabIndex        =   1
      Top             =   1395
      Width           =   970
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   2250
      MaxLength       =   4
      TabIndex        =   3
      Top             =   1695
      Width           =   970
   End
   Begin Crystal.CrystalReport rptCristal_co 
      Left            =   4800
      Top             =   90
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      PrintFileLinesPerPage=   60
   End
   Begin Crystal.CrystalReport rptCristal 
      Left            =   5220
      Top             =   75
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      WindowWidth     =   480
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
      PrintFileType   =   2
      WindowControls  =   -1  'True
      PrintFileLinesPerPage=   60
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   1
      Left            =   5670
      TabIndex        =   4
      Top             =   75
      Visible         =   0   'False
      Width           =   150
      _ExtentX        =   265
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   0
      Left            =   5895
      TabIndex        =   2
      Top             =   120
      Visible         =   0   'False
      Width           =   120
      _ExtentX        =   212
      _ExtentY        =   503
      _Version        =   393216
      Enabled         =   0   'False
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   2250
      TabIndex        =   0
      Top             =   270
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   6150
      TabIndex        =   6
      Top             =   2100
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   6150
      TabIndex        =   7
      Top             =   2865
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
         Size            =   6.75
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
      Left            =   6150
      TabIndex        =   8
      Top             =   3630
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
         Size            =   6.75
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
      Left            =   6150
      TabIndex        =   5
      Top             =   1335
      Visible         =   0   'False
      WhatsThisHelpID =   2029
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Borrar"
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
   End
   Begin VB.Label Lblcli 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   6315
      TabIndex        =   26
      Top             =   120
      Visible         =   0   'False
      Width           =   525
   End
   Begin VB.Label lbldesalianza 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   407
      Left            =   3240
      TabIndex        =   25
      Top             =   2295
      Width           =   2835
   End
   Begin VB.Label Lblalianza 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   2250
      TabIndex        =   24
      Top             =   2295
      Width           =   975
   End
   Begin VB.Label Label5 
      BackStyle       =   0  'Transparent
      Caption         =   "Alianza:"
      ForeColor       =   &H00800000&
      Height          =   270
      Left            =   105
      TabIndex        =   23
      Top             =   2355
      Width           =   735
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Concepto:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   1
      Left            =   105
      TabIndex        =   22
      Top             =   1995
      Width           =   2130
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      Enabled         =   0   'False
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   5160
      TabIndex        =   16
      Top             =   1815
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      Enabled         =   0   'False
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   5160
      TabIndex        =   15
      Top             =   1815
      Visible         =   0   'False
      Width           =   390
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   3255
      TabIndex        =   14
      Top             =   1395
      Width           =   2790
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
      Left            =   105
      TabIndex        =   13
      Top             =   570
      WhatsThisHelpID =   5265
      Width           =   1920
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Mes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   105
      TabIndex        =   12
      Top             =   1395
      WhatsThisHelpID =   5307
      Width           =   495
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. de cuenta ahorros:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   105
      TabIndex        =   11
      Top             =   270
      WhatsThisHelpID =   5254
      Width           =   2055
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   6105
      X2              =   6090
      Y1              =   0
      Y2              =   4425
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   810
      Index           =   0
      Left            =   2250
      TabIndex        =   10
      Top             =   570
      UseMnemonic     =   0   'False
      Width           =   3810
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Año:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   105
      TabIndex        =   9
      Top             =   1695
      WhatsThisHelpID =   5461
      Width           =   480
   End
End
Attribute VB_Name = "FTran223"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTRAN223.frm
' NOMBRE LOGICO:    FTran223
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
' Muestra la información relacionada con el estado de cuenta
' de una Cuenta de ahorros sin costo.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

Dim VLEjecuta As Integer
'Dim VLFormatoFecha As String
Dim VTarreglo2(10) As String
Dim VLPaso As Integer

Private Sub Form_Activate()
    mskCuenta_LostFocus
    cmdBoton_Click 3
End Sub

Private Sub Form_Load()
    Dim i As Integer
    PMLoadResStrings Me
    PMLoadResIcons Me
    For i% = 0 To 1
        mskValor(i%).Mask = "" 'FMMascaraFecha(VGFormatoFecha$)
        mskValor(i%).Text = VGFecha$ 'Format$(VGFecha$, VGFormatoFecha$)
        mskValor(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
    Next i%
    mskCuenta.Mask = VGMascaraCtaCte$
    rptCristal.DataFiles(0) = VGPath$ & "\soctaaho.mdb"
    'CMUNOZ REQ 09 25/02/10
    rptCristal_co.DataFiles(0) = VGPath$ & "\soctaaho.mdb"
    rptCristal.ReportFileName = VGPath$ & "\esctaaho.rpt"
    'CMUNOZ REQ 09 25/02/10
    rptCristal_co.ReportFileName = VGPath$ & "\esctaaho_co.rpt"
    VLEjecuta% = True
    
    'Se deshabilita las opciones de generación del extracto
    OptGeneracion(0).Value = True
    OptGeneracion(1).Value = False
    txtCampo(3).Enabled = False
    lblDescripcion(4).Enabled = False

End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Dim VTFDesde As String
    Dim VTFHasta As String
    Dim VTTotalFilas As Integer
    Dim VTSaldoContableIni As Currency
    Dim VTBanderaSCI As Boolean
    Dim VTExtMail As Boolean
    Dim VTFHoy As String
    Dim VTNumDep As Integer
    Dim VTDepositos As Integer
    Dim VTNumNC As Integer
    Dim VTTranDiario As Integer
    Dim VTSalir As Boolean
    Dim VTLimpiar As Boolean
    Dim VTPrimera As String
    Dim VTTotInt As Integer
    Dim VTError As Boolean
    
    Dim VTNotasCredito As Integer
    Dim VTNumND As Integer
    Dim VTNotasDebito As Integer
    Dim contador As Integer
    Dim VTSaldo As Integer
    Dim VTR As Integer
    Dim VTSecuencial As String
    Dim VTSecAlterno As String
    Dim VTHora As String
    Dim VTR1 As Integer
    Dim VTR2 As Integer
    Dim VTFono As String
    Dim VTResult As Integer
    Dim i As Integer
    Dim VTIva As Double
    Dim VTCliente As String
    Dim VTTabla As String
    Dim SQL As String

    On Error GoTo error2
    Select Case Index%
    Case 0
        ' Limpia totales
        cmdBoton_Click 3
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4141"
        PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "Q"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_control_manejo_extracto", True, "Ok.. Consulta de parametro de consulta maxima de periodos") Then
            PMMapeaObjeto sqlconn&, lblDescripcion(3)
            PMChequea sqlconn&
        End If
        
        If Trim$(txtCampo(1).Text) = "" Then
            MsgBox "El mes es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        If Trim$(txtCampo(2).Text) = "" Then
            MsgBox "El año es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        
        VTFDesde$ = (txtCampo(1).Text + "/01/" + txtCampo(2).Text)
        VTFDesde$ = FMConvFecha((VTFDesde$), VGFormatoFecha$, CGFormatoBase$)
        VTFHasta$ = DateAdd("m", 1, VTFDesde$)
        VTFHoy$ = DateAdd("d", (-1) * (Day(VTFDesde$)), VTFHasta$)
    
        If FMDateDiff("d", VTFHoy$, VGFecha$, VGFormatoFecha$) <= 0 Then
            MsgBox "Periodo de Extracto Solicitado No Disponible", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        
        If FMDateDiff("m", VTFDesde$, VGFecha$, VGFormatoFecha$) > lblDescripcion(3).Caption Then
           MsgBox "Consulta de Informacion permitida Maximo :" & " [" & lblDescripcion(3).Caption & "] " & "Meses", 0 + 48, "Mensaje de Error"
           txtCampo(1).SetFocus
           Exit Sub
        End If
        
        ' Verificar si los datos fueron borrados
        If VLEjecuta% = False Then
            MsgBox "El usuario no ha procedido a borrar los datos locales", 0 + 16, "Mensaje de Error"
            cmdBoton(3).SetFocus
            Exit Sub
        End If
        

        ' Validacion de Mandatoriedades
        ' Numero de cuenta
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El número de Cuenta de Ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

        ' Fecha de inicio de la consulta
        If Trim$(mskValor(0).ClipText) = "" Then
            MsgBox "La fecha desde es mandatoria", 0 + 16, "Mensaje de Error"
            mskValor(0).SetFocus
            Exit Sub
        End If

        ' Fecha de fin de la consulta
        If Trim$(mskValor(1).ClipText) = "" Then
            MsgBox "La fecha hasta es mandatoria", 0 + 16, "Mensaje de Error"
            mskValor(1).SetFocus
            Exit Sub
        End If
        
        ' Valida aue se halla ingresado concepto del extracto
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El concepto es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

       'Valida si el extracto se envia al correo electronico del cliente
       If OptGeneracion(1).Value Then
          VTExtMail = True
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
          If Trim$(lblDescripcion(4).Caption) = "" Then
            MsgBox "El correo electrónico es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
          End If
          
          If MsgBox("Esta Seguro de Enviar Extracto de Cuenta de Ahorros por Correo Electrónico?", vbYesNo, "Mensaje del Sistema") = vbNo Then
             Exit Sub
          End If
       End If
       
        'La fecha fin no puede ser mayor a "hoy"

    
        If MsgBox("Esta transacción podría tomar algún tiempo" & Chr$(13) & "Está seguro de realizar esta operación?", 1 + 32 + 0, "Mensaje del Sistema") <> 1 Then
           Exit Sub
        End If
        
        Screen.MousePointer = 11

        VTNumDep% = 0
        VTDepositos = 0
        VTNumNC% = 0
        VTNotasCredito = 0
        VTNumND% = 0
        VTNotasDebito = 0
        VTTranDiario% = 0
        VTSalir = True
        VTLimpiar = True
        VTPrimera$ = "S"
        'CMUNOZ REQ 09 25/02/10
        VTTotInt = 0
        VTError = False
            
        ' Arreglo temporal para recpecion de la cabecera
        ReDim VTArregloCab(30) As String
        
        ' HA20060822
        ' Arreglo temporal para recpecion del pie
        'CMUNOZ REQ 09 25/02/10 CAMBIO A 8
        ReDim VTArregloPie(15) As String
            
        ' Arreglo temporal para recepcion de cotitulares


        ' Matriz temporal para recepcion de datos
        ReDim VTMatriz(21, 30) As String

        ' Matriz para recepción de saldos diarios
        'ReDim VTMatHis(5, 100) As String
        contador% = 1
        
        VTTotalFilas% = 0
        VTSaldoContableIni = 0
        VTBanderaSCI = False
        VTSaldo = 0

        If VTExtMail = False Then
            While VTSalir = True
                ' Transaccion que trae los datos del corte de cuenta
    
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "236"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
                If VTPrimera$ = "S" Then
                     VTFDesde$ = (txtCampo(1).Text + "/01/" + txtCampo(2).Text)
                     VTFDesde$ = FMConvFecha((VTFDesde$), VGFormatoFecha$, CGFormatoBase$)
                Else
                     VTFDesde$ = (txtCampo(1).Text + "/01/" + txtCampo(2).Text)
                     VTFDesde$ = FMConvFecha((VTFDesde$), VGFormatoFecha$, CGFormatoBase$)
                End If
                VTFHasta$ = DateAdd("m", 1, VTFDesde$)
                VTFHasta$ = DateAdd("d", (-1) * (Day(VTFDesde$)), VTFHasta$)
                'VTFHoy$ = DateAdd("d", (-1) * (Day(VTFDesde$)), VTFHasta$)
                VTFDesde$ = FMConvFecha((VTFDesde$), VGFormatoFecha$, CGFormatoBase$)
                VTFHasta$ = FMConvFecha((VTFHasta$), VGFormatoFecha$, CGFormatoBase$)
                PMPasoValores sqlconn&, "@i_fchdsde", 0, SQLDATETIME, VTFDesde$
                PMPasoValores sqlconn&, "@i_fchhsta", 0, SQLDATETIME, VTFHasta$
                
                If VTPrimera$ = "S" Then
                    PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, "0"
                    PMPasoValores sqlconn&, "@i_sec_alt", 0, SQLINT4, "0"
                    PMPasoValores sqlconn&, "@i_hora", 0, SQLDATETIME, "01/01/1900 12:00AM"
                    If VGCodPais = "CO" Then
                       VTR% = MsgBox("¿Esta transacción es solicitada por el cliente?", vbYesNo, "Mensaje del Sistema")
                       If VTR% = vbYes Then
                           PMPasoValores sqlconn&, "@i_escliente", 0, SQLCHAR, "S"
                       Else
                           PMPasoValores sqlconn&, "@i_escliente", 0, SQLCHAR, "N"
                       End If
                    End If
                Else
                     PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, VTSecuencial$
                     PMPasoValores sqlconn&, "@i_sec_alt", 0, SQLINT4, VTSecAlterno$
                     PMPasoValores sqlconn&, "@i_hora", 0, SQLDATETIME, VTHora$
                End If
                PMPasoValores sqlconn&, "@i_diario", 0, SQLINT1, Trim$(Str$(VTTranDiario%))
                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                PMPasoValores sqlconn&, "@i_frontn", 0, SQLCHAR, "S"
                PMPasoValores sqlconn&, "@o_hist", 1, SQLINT1, "0"
                PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
                PMPasoValores sqlconn&, "@i_concepto", 0, SQLCHAR, txtCampo(0).Text
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_ahsoestcta", True, "Ok... Solicitud del estado de cuenta") Then
                    If VTPrimera$ = "S" Then
                         VTR1% = FMMapeaArreglo(sqlconn&, VTArregloCab())
                         PMMapeaVariable sqlconn&, VTFono$
                         VTR2% = FMMapeaArreglo(sqlconn&, VTArregloPie())
                        
                        ' Inicializacion de la base de datos local
                        Dim DB As Database
                        Set DB = DBEngine.OpenDatabase(VGPath & "\soctaaho.mdb")
                         'Set DB = DBEngine.OpenDatabase("C:\CMUNOZ\MIGRACION\FRONTEND\TAdmin-Integracion\soctaaho.mdb") ' ojo modificar
                        Dim T As Recordset
                        Dim L As Recordset
                        Dim M As Recordset
                        Set T = DB.OpenRecordset("Header")
                        Set L = DB.OpenRecordset("Footer")
                        Set M = DB.OpenRecordset("Details")
                        T.AddNew
                        T("Cuenta") = mskCuenta.Text
                        T("Nombre") = VTArregloCab(1)
                        T("Moneda") = VTArregloCab(4)
                        If VTArregloCab(20) = "C" Then
                            T("Direccion") = "APARTADO: " + VTArregloCab(5)
                        Else
                            T("Direccion") = VTArregloCab(5)
                        End If
                        T("Zona") = Val(VTArregloCab(8))
                        T("SubZona") = Val(VTArregloCab(9))
                        T("Telefono") = VTFono$
                        T("Saldo") = CCur(VTArregloCab(10))
                        'T("FechaMesAnterior") = Format$(Me.mskValor(0).FormattedText, VGFormatoFecha$)
                        'T("FechaCierre") = Format$(Me.mskValor(1).FormattedText, VGFormatoFecha$)
                        
                        T("FechaMesAnterior") = VTArregloCab(24)
                        T("FechaCierre") = VTFHasta$
                        
                        'Requerimiento: Modificación del Estado de Cuenta Mensual y en Línea: 02/15/2000
                        'T("Oficial") = VTArregloCab(7)
                        T("NombreOficial") = VTArregloCab(11)
                        'T("TelefonoOficial") = VTArregloCab(12)
                        If VTArregloCab(10) = "" Then
                            VTArregloCab(10) = "0"
                        End If
                        'CMUNOZ REQ 09 25/02/10
                        If VGCodPais$ = "CO" Then
                            T("FechaImpresion") = VTArregloPie(10) 'se usa fechaimp para fecha corte
                            T("Saldo") = CCur(IIf(VTArregloPie(9) = "", 0, VTArregloPie(9)))
                            VTSaldo = CCur(IIf(VTArregloPie(9) = "", 0, VTArregloPie(9)))
                        Else
                            T("FechaImpresion") = VGFecha$
                            T("Saldo") = CCur(IIf(VTArregloCab(10) = "", 0, VTArregloCab(10)))
                            VTSaldo = CCur(IIf(VTArregloCab(10) = "", 0, VTArregloCab(10)))
                        End If
                        T("fideicomiso") = VTArregloCab(19)
                        T("tdireccion") = VTArregloCab(20)
                        T("producto") = VTArregloCab(21)
                        T("filial") = Val(VGLOGO$)
                        T("filial") = Val(VGLOGO$)
                        T("TelefonoOficial") = VTArregloCab(22) 'se usa telefono oficial para mensaje dinamico
                        T("Oficina") = VTArregloCab(23)
                        T.Update
                    End If
                            
                     VTResult% = FMMapeaMatriz(sqlconn&, VTMatriz())
    
                    ' Limpiar el buffer de comunicaciones
                     PMChequea sqlconn&
    
                     VTTranDiario% = Val(FMRetParam(sqlconn&, 1))
    
                    ' Almacenar las transacciones en la base de datos local
                    VTTotalFilas% = VTTotalFilas% + VTResult%
                    For i% = 1 To VTResult%
                        VTFDesde$ = VTMatriz(0, i%)
                        M.AddNew
                        M("Cuenta") = mskCuenta.Text
                        M("Fecha") = VTMatriz(0, i%) ' FMConvFecha(VTMatriz(0, i%), VGFormatoFecha$, CGFormatoBase$)
                        M("Lugar") = VTMatriz(2, i%)
                        If Len(VTMatriz(15, i%)) < 3 Then
                           If Len(VTMatriz(15, i%)) = 1 Then
                              VTMatriz(15, i%) = "00" & VTMatriz(15, i%)
                           Else
                              VTMatriz(15, i%) = "0" & VTMatriz(15, i%)
                           End If
                        End If
                        
                        M("Referencia") = VTMatriz(10, i%) 'VTMatriz(14, i%) 'VTMatriz(15, i%) & VTMatriz(14, i%)
                        M("Oficina") = VTMatriz(1, i%)
                        M("Descripcion") = VTMatriz(4, i%)
                        '  CAMBIAR  AQUI -REVERSO, VER DONDE VIENE LA R
                        If VTMatriz(3, i%) = "S" Then
                            M("Descripcion") = M("Descripcion") & " - REVERSO"
                        End If
                        
                        If VTMatriz(5, i%) = "*" Then
                            M("Descripcion") = M("Descripcion") & " REMESA"
                        End If
                        
                        If VTMatriz(6, i%) = "" Then
                            VTMatriz(6, i%) = "0"
                        End If
                                   
                        M("Valor") = CCur(VTMatriz(6, i%))
                        
                        If VTMatriz(5, i%) = "C" Or VTMatriz(5, i%) = "*" Then
                            M("Signo") = "+"
                            M("Credito") = CCur(VTMatriz(6, i%))
                            If VTMatriz(5, i%) = "C" Then
                                VTSaldo = VTSaldo + CCur(VTMatriz(6, i%))
                            End If
                        Else
                            If VTMatriz(5, i%) = "D" Then
                                M("Signo") = "-"
                                M("Debito") = CCur(VTMatriz(6, i%))
                                VTSaldo = VTSaldo - CCur(VTMatriz(6, i%))
                            Else
                                M("Signo") = ""
                            End If
                        End If
                        
                        ' No Imprime Saldos Contables y Disponibles por Trans. (Pedido por B. de Préstamos)
                        If VTMatriz(7, i%) = "" Then
                            VTMatriz(7, i%) = "0"
                        End If
                        If Not VTBanderaSCI Then
                            VTSaldoContableIni = CCur(VTMatriz(7, i%))
                            If VTMatriz(5, i%) = "C" Then
                                VTSaldoContableIni = VTSaldoContableIni - CCur(VTMatriz(6, i%))
                            Else
                                VTSaldoContableIni = VTSaldoContableIni + CCur(VTMatriz(6, i%))
                            End If
                            VTBanderaSCI = True
                        End If
                        'cmunoz req 09 25/02/10
                        If VGCodPais$ = "CO" Then
                            If VTMatriz(8, i%) = "" Then
                                VTMatriz(8, i%) = "0"
                            End If
                            If VTPrimera$ = "S" Then
                                VTIva = VTMatriz(19, i%)
                            Else
                                VTIva = VTMatriz(19, i%)
                            End If
                            If VTIva = "" Then
                                VTIva = 0
                            End If
                            M("SaldoContable") = VTSaldo 'CCur(VTMatriz(7, i%)) + VTMatriz(8, i%) + VTIva
                        Else
                            M("SaldoContable") = CCur(VTMatriz(7, i%))
                        End If
      
                        M("Interes") = VTMatriz(9, i%)
                        VTSecuencial$ = VTMatriz(10, i%)
                        VTSecAlterno$ = VTMatriz(11, i%)
                        VTHora$ = VTMatriz(18, i%)
                        M("TranCode") = VTMatriz(12, i%)
                        Select Case VTMatriz(12, i%)
                        Case "207", "246", "248", "251", "252", "254"
                            If VTMatriz(5, i%) <> "*" Then
                                VTNumDep% = VTNumDep% + 1
                                VTDepositos = VTDepositos + CCur(VTMatriz(6, i%))
                            End If
                        Case "229", "253", "255", "257", "2503", "221", "294", "300", "304", "315"
                            VTNumNC% = VTNumNC% + 1
                            VTNotasCredito = VTNotasCredito + CCur(VTMatriz(6, i%))
                        Case "228", "240", "262", "264", "266", "2502", "237", "239", "263", "371", "213", "308", "309", "316", "392", "380"
                            VTNumND% = VTNumND% + 1
                            VTNotasDebito = VTNotasDebito + CCur(VTMatriz(6, i%))
                        'CMUNOZ REQ 09 25/02/10
                        End Select
                        Select Case VTMatriz(12, i%)
                        Case "221"
                            VTTotInt = VTTotInt + CCur(VTMatriz(6, i%))
                        End Select
                        M("filial") = Val(VGLOGO$)
                        M.Update
                        'OUS
                        If VGCodPais$ = "CO" Then
                            If VTMatriz(8, i%) = "" Then
                                VTMatriz(8, i%) = "0"
                            End If
                            If VTPrimera$ = "S" Then
                                VTIva = VTMatriz(19, i%)
                            Else
                                VTIva = VTMatriz(19, i%)
                            End If
                            If VTIva = "" Then
                                VTIva = 0
                            End If
                            If VTIva > 0 Then
                                M.AddNew
                                M("Cuenta") = mskCuenta.Text
                                M("Fecha") = VTMatriz(0, i%)
                                M("Lugar") = VTMatriz(2, i%)
                                M("Referencia") = VTMatriz(10, i%)
                                M("Oficina") = VTMatriz(1, i%)
                                If VTMatriz(3, i%) = "S" Then
                                    M("Descripcion") = M("Descripcion") & "IMPUESTO IVA - REVERSO"
                                    M("Signo") = "+"
                                    M("Credito") = CCur(VTIva)
                                    VTNotasDebito = VTNotasDebito - CCur(VTIva)
                                    VTSaldo = VTSaldo + VTIva
                                Else
                                    M("Descripcion") = M("Descripcion") & "IMPUESTO IVA"
                                    M("Signo") = "-"
                                    M("Debito") = CCur(VTIva)
                                    VTNotasDebito = VTNotasDebito + CCur(VTIva)
                                    VTSaldo = VTSaldo - VTIva
                                End If
                                'CMUNOZ REQ 09 25/02/10
                                M("SaldoContable") = CCur(VTMatriz(7, i%)) + CCur(VTMatriz(8, i%))
                                M("filial") = Val(VGLOGO$)
                                M.Update
                            End If
                            If VTMatriz(8, i%) > 0 Then
                                M.AddNew
                                M("Cuenta") = mskCuenta.Text
                                M("Fecha") = VTMatriz(0, i%)
                                M("Lugar") = VTMatriz(2, i%)
                                M("Referencia") = VTMatriz(10, i%)
                                M("Oficina") = VTMatriz(1, i%)
                                '  CAMBIAR  AQUI -REVERSO, VER DONDE VIENE LA R
                                If VTMatriz(3, i%) = "S" Then
                                    M("Descripcion") = M("Descripcion") & "IMPUESTO GMF - REVERSO"
                                    M("Signo") = "+"
                                    M("Credito") = CCur(VTMatriz(8, i%))
                                    VTNotasDebito = VTNotasDebito - CCur(VTMatriz(8, i%))
                                    VTSaldo = VTSaldo + CCur(VTMatriz(8, i%))
                                Else
                                    M("Descripcion") = M("Descripcion") & "IMPUESTO GMF"
                                    M("Signo") = "-"
                                    M("Debito") = CCur(VTMatriz(8, i%))
                                    VTNotasDebito = VTNotasDebito + CCur(VTMatriz(8, i%))
                                    VTSaldo = VTSaldo - CCur(VTMatriz(8, i%))
                                End If
                                'CMUNOZ REQ 09 25/02/10
                                M("SaldoContable") = VTSaldo 'CCur(VTMatriz(7, i%))
                                M("filial") = Val(VGLOGO$)
                                
                                M.Update
                            End If
                            
                            
                        End If
                    Next i%
    
                    VTPrimera$ = "N"
    
                    ' Determinar si terminaron las transacciones del historico
                    If VTTranDiario% = 1 Then
                        VTSecuencial$ = "0"
                        VTSecAlterno$ = "0"
                        VTHora$ = "01/01/1900 12:00AM"
                    End If
    
                    If VTTranDiario% = 3 Then
                        VTSalir = False
                    End If
    
                Else
                    VTSalir = False
                    VTError = True
                End If
            Wend
        End If
        
        If VTError = False Then
            Screen.MousePointer = 0
            'Registro que permite que el reporte salga aunque la cuenta
            'no tenga movimientos. De otra forma el reporte sale completamente
            'en blanco: sin logo ni número de cuenta, inclusive.
            If VTExtMail = False Then
                If VTTotalFilas% = 0 Then
                    M.AddNew
                    M("filial") = Val(VGLOGO$)
                    M.Update
                End If
                L.AddNew
                'cmunoz req 09 se cambia a 5
                If VTArregloPie(5) = "" Then
                    VTArregloPie(5) = "0"
                End If
                If VTArregloPie(9) = "" Then
                    VTArregloPie(9) = "0"
                End If
                If VGCodPais$ = "CO" Then
                    L("SaldoPromedio") = CCur(VTArregloPie(9))
                Else
                    L("SaldoPromedio") = CCur(VTArregloPie(5))
                End If
                If VTArregloPie(2) = "" Then
                    VTArregloPie(2) = "0"
                End If
                L("RetBancosLoc") = CCur(VTArregloPie(2))
                If VTArregloPie(3) = "" Then
                    VTArregloPie(3) = "0"
                End If
                L("RetOtrasPlazas") = CCur(VTArregloPie(3))
                If VTArregloPie(4) = "" Then
                    VTArregloPie(4) = "0"
                End If
                L("SaldoContable") = CCur(VTArregloPie(4))
                If VTArregloPie(5) = "" Then
                    VTArregloPie(5) = "0"
                End If
                L("SaldoDisponible") = CCur(VTArregloPie(5))
                If VTArregloPie(6) = "" Then
                    VTArregloPie(6) = "0"
                End If
                L("SaldoPromConfirma") = CCur(VTArregloPie(6))
                If VTArregloPie(7) = "" Then
                    VTArregloPie(7) = "0"
                End If
                L("SaldoPromContable") = CCur(VTArregloPie(7))
                
                If VGCodPais$ = "CO" Then
                    If VTArregloPie(8) = "" Then
                       VTArregloPie(8) = "0"
                    End If
                    L("NumDep") = VTArregloPie(8) ' se usa numdep para tasa
                    L("Depositos") = VTTotInt
                    VTNumNC% = VTNumNC% + VTNumDep%
                    VTNotasCredito = VTNotasCredito + VTDepositos
                Else
                 L("NumDep") = VTNumDep%
                 L("Depositos") = VTDepositos
                End If
                
                L("NumNC") = VTNumNC%
                L("NC") = VTNotasCredito
                L("NumND") = VTNumND%
                L("ND") = VTNotasDebito
                L("Cuenta") = mskCuenta.Text
                L("filial") = Val(VGLOGO$)
                If VTBanderaSCI Then
                    L("SaldoContableInicial") = VTSaldoContableIni
                Else
                    L("SaldoContableInicial") = CCur(VTArregloPie(4))
                End If
                L.Update
                T.Close
                L.Close
                M.Close
                DB.Close
            End If
            
            VLEjecuta% = False
            On Error GoTo Error1
            
            If VTExtMail Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "236"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
                If VTPrimera$ = "S" Then
                     VTFDesde$ = (txtCampo(1).Text + "/01/" + txtCampo(2).Text)
                     VTFDesde$ = FMConvFecha((VTFDesde$), VGFormatoFecha$, CGFormatoBase$)
                Else
                     VTFDesde$ = (txtCampo(1).Text + "/01/" + txtCampo(2).Text)
                     VTFDesde$ = FMConvFecha((VTFDesde$), VGFormatoFecha$, CGFormatoBase$)
                End If
                VTFHasta$ = DateAdd("m", 1, VTFDesde$)
                VTFHasta$ = DateAdd("d", (-1) * (Day(VTFDesde$)), VTFHasta$)
                VTFDesde$ = FMConvFecha((VTFDesde$), VGFormatoFecha$, CGFormatoBase$)
                VTFHasta$ = FMConvFecha((VTFHasta$), VGFormatoFecha$, CGFormatoBase$)
                PMPasoValores sqlconn&, "@i_fchdsde", 0, SQLDATETIME, VTFDesde$
                PMPasoValores sqlconn&, "@i_fchhsta", 0, SQLDATETIME, VTFHasta$
                  
                PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, "0"
                PMPasoValores sqlconn&, "@i_sec_alt", 0, SQLINT4, "0"
                PMPasoValores sqlconn&, "@i_hora", 0, SQLDATETIME, "01/01/1900 12:00AM"
                If VGCodPais = "CO" Then
                   VTR% = MsgBox("¿Esta transacción es solicitada por el cliente?", vbYesNo, "Mensaje del Sistema")
                   If VTR% = vbYes Then
                       VTCliente$ = "S"
                   Else
                       VTCliente$ = "N"
                   End If
                End If
                PMPasoValores sqlconn&, "@i_diario", 0, SQLINT1, Trim$(Str$(VTTranDiario%))
                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                PMPasoValores sqlconn&, "@i_frontn", 0, SQLCHAR, "S"
                PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
                PMPasoValores sqlconn&, "@i_escliente", 0, SQLCHAR, VTCliente$
                PMPasoValores sqlconn&, "@i_envio_mail", 0, SQLCHAR, "S"
                PMPasoValores sqlconn&, "@i_email", 0, SQLCHAR, lblDescripcion(4).Caption
                PMPasoValores sqlconn&, "@i_concepto", 0, SQLCHAR, txtCampo(0).Text
                PMPasoValores sqlconn&, "@o_hist", 1, SQLINT1, "0"
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_ahsoestcta", True, "Ok... Solicitud del estado de cuenta") Then
                    PMChequea sqlconn&
                    MsgBox "Orden de envío registrada satisfactoriamente", vbInformation, "Generación Extracto"
                Else
                   MsgBox "Error al generar orden de envío", 0 + 16, "Mensaje de Error"
                   Exit Sub
                End If
            Else
                'CMUNOZ REQ 09 25/02/10
                If VGCodPais$ = "CO" Then
                    rptCristal_co.DataFiles(0) = VGPath & "\soctaaho.mdb"
                    rptCristal_co.Destination = 0
                    rptCristal_co.Action = 1
                Else
                    rptCristal.DataFiles(0) = VGPath & "\soctaaho.mdb"
                    rptCristal.Destination = 0
                    rptCristal.Action = 1
                    
                End If
           End If
        End If
        Screen.MousePointer = 0
    Case 1
        'mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
'        mskValor(0).Text = Format$(VGFecha$, VGFormatoFecha$)
'        mskValor(0).Enabled = True
'        mskValor(1).Text = Format$(VGFecha$, VGFormatoFecha$)
        'lblDescripcion(0).Caption = ""
        'mskCuenta.SetFocus
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""
        txtCampo(3).Text = ""
        txtCampo(0).Text = ""
        lblDescripcion(1).Caption = ""
        lblDescripcion(2).Caption = ""
        lblDescripcion(4).Caption = ""
        'cmdBoton(4).Enabled = False
        
    Case 2
        ' Limpia totales
        cmdBoton_Click 3

        If VLEjecuta% = True Then
            Unload FTran223
        Else
            MsgBox "El usuario no ha procedido a borrar los datos locales", 0 + 16, "Mensaje de Error"
            cmdBoton(3).SetFocus
        End If
    Case 3
        Screen.MousePointer = 11
        Dim DBA As Database
        Set DBA = DBEngine.OpenDatabase(VGPath$ & "\soctaaho.mdb")
            Dim Tabla As Recordset
        Set Tabla = DBA.OpenRecordset("Header")
        If Tabla.EOF = False Then
                Dim qDeleteh As QueryDef
            VTTabla$ = "Header"
            SQL = "DELETE FROM " & VTTabla$ & ";"
            Set qDeleteh = DBA.CreateQueryDef("", "delete * from Header")
            qDeleteh.Execute
            Set qDeleteh = Nothing
            'qDeleteh.Close
            'DBA.DeleteQueryDef ("EmptyTable")
        End If
        Set Tabla = DBA.OpenRecordset("Details")
        If Tabla.EOF = False Then
                Dim qDeleted As QueryDef
            VTTabla$ = "Details"
            SQL = "DELETE FROM " & VTTabla$ & ";"
            Set qDeleted = DBA.CreateQueryDef("", "delete * from Details")
            qDeleted.Execute
            Set qDeleteh = Nothing
            'qDeleted.Close
            'DBA.DeleteQueryDef ("EmptyTable")
        End If
        Set Tabla = DBA.OpenRecordset("Footer")
        If Tabla.EOF = False Then
                Dim qDeletef As QueryDef
            VTTabla$ = "Footer"
            SQL = "DELETE FROM " & VTTabla$ & ";"
            Set qDeletef = DBA.CreateQueryDef("", "delete * from Footer")
            qDeletef.Execute
            Set qDeleteh = Nothing
            'qDeletef.Close
            'DBA.DeleteQueryDef ("EmptyTable")
        End If
        Tabla.Close
        DBA.Close
        VLEjecuta% = True
        Screen.MousePointer = 0
    End Select
    Exit Sub
Error1:
    MsgBox "Error en la Impresión del Reporte " + Err.Description, 0 + 16, "Mensaje de Error"
    Screen.MousePointer = 0
    Exit Sub
error2:
    MsgBox "Faltan Librerias o Dll's para la transacción:" + error$
    'mskCuenta.SetFocus
    Screen.MousePointer = 0
    Exit Sub
End Sub


Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta de Ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    Dim VTR1 As Integer
    On Error Resume Next
    If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_codcliente", 0, SQLINT4, Lblcli.Caption
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                VTR1% = FMMapeaArreglo(sqlconn&, VTarreglo2())
                lblDescripcion(0).Caption = VTarreglo2(1)
                Lblalianza.Caption = VTarreglo2(7)
                lbldesalianza.Caption = VTarreglo2(8)
                PMChequea sqlconn&
                'cmdBoton(4).Enabled = True
            Else
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(0).Caption = ""
                lblDescripcion(0).Caption = ""
                Lblalianza.Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
            lblDescripcion(0).Caption = ""
            mskCuenta.SetFocus
            Exit Sub
        End If
    
End Sub

Private Sub mskValor_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Fecha de inicial de la consulta [" & VGFormatoFecha & "]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Fecha final de la consulta [" & VGFormatoFecha & "]"
    End Select
    mskValor(Index%).SelStart = 0
    mskValor(Index%).SelLength = Len(mskValor(Index%).Text)
End Sub

Private Sub mskValor_KeyPress(Index As Integer, KeyAscii As Integer)
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub

Private Sub mskValor_LostFocus(Index As Integer)
'*********************************************************
'PROPOSITO: Verifica la validez de la fecha ingresada
'           de acuerdo con el formato de la fecha
'           ingresada
'INPUT    : Index       Identificador de campo
'OUTPUT   : ninguna
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'07/Jul/94  J.Bucheli           Revisión General
'*********************************************************
    On Error Resume Next
    
    Dim VTValido As Integer
    Dim VTDias As Long
    Dim i As Integer
    Select Case Index%
    Case 0, 1
        If mskValor(Index%).ClipText <> "" Then
            VTValido% = FMVerFormato((mskValor(Index).FormattedText), VGFormatoFecha$)
            If Not VTValido% Then
                MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
                mskValor(Index%).SetFocus
                Exit Sub
            End If
        End If
        If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
            VTDias& = FMDateDiff("d", (mskValor(0).FormattedText), (mskValor(0).FormattedText), VGFormatoFecha$)
            If VTDias& < 0 Then
                MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
                For i% = 0 To 1
                    mskValor(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
                    mskValor(i%).Text = Format$(VGFecha$, VGFormatoFecha$)
                Next i%
                mskValor(Index%).SetFocus
                Exit Sub
            End If
        End If
    End Select
End Sub

Private Sub OptGeneracion_Click(Index As Integer)
    Select Case Index
        Case 0
            txtCampo(3).Enabled = False
            lblDescripcion(4).Enabled = False
            txtCampo(3).Text = ""
            lblDescripcion(4).Caption = ""
        Case 1
            txtCampo(3).Enabled = True
            lblDescripcion(4).Enabled = True
    End Select
End Sub

Private Sub txtCampo_Change(Index As Integer)
 Select Case Index%
    Case 3
        VLPaso% = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Mes de la consulta "
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Año de la consulta "
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Correo Electrónico del Cliente [F5 Ayuda] "

    End Select
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    Dim VTListCount As Integer
If Keycode% = VGTeclaAyuda% Then

    Select Case Index%
    Case 1
        VLPaso% = True
        VGOperacion$ = "sp_parametro_extracto"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4140"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "X"
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT2, 1
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_parametro_extracto", True, " OK... Consulta de Productos COBIS") Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtCampo(1).Text = VGACatalogo.Codigo$
            lblDescripcion(1).Caption = VGACatalogo.Descripcion$
            If Trim$(txtCampo(1).Text) = "" Then
                txtCampo(1).Text = ""
                lblDescripcion(1).Caption = ""
                txtCampo(1).SetFocus
            End If
        End If
    Case 2
        VLPaso% = True
        VGOperacion$ = "sp_parametro_extracto"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4140"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "A"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_parametro_extracto", True, " OK... Consulta de Productos COBIS") Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtCampo(2).Text = VGACatalogo.Codigo$
        '        lblDescripcion(1).Caption = VGACatalogo.Descripcion$
        '        If Trim$(txtCampo(1).Text) = "" Then
        '            txtCampo(1).Text = ""
        '            lblDescripcion(1).Caption = ""
        '            txtCampo(1).SetFocus
        '        End If
        End If
    Case 3
        VLPaso% = True
        If mskCuenta.ClipText = "" Then
            MsgBox ("Debe indicar la cuenta de ahorros")
            mskCuenta.SetFocus
            mskCuenta.Text = ""
            Exit Sub
        End If
        VGOperacion$ = "sp_direccion_cons"
        PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "E"
        PMPasoValores sqlconn&, "@i_cta_ah", 0, SQLCHAR, mskCuenta.ClipText
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1227"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de direcciones") Then
         
           PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
           PMChequea sqlconn&
           VTListCount = FCatalogo!lstCatalogo.ListCount
           If VTListCount = 0 Then
              MsgBox "No Existen Cuentas de Correo Asociadas al Cliente", vbInformation, "Cobis Clientes"
              Exit Sub
           End If
              
           FCatalogo.Show 1
           txtCampo(3).Text = VGACatalogo.Codigo$
           lblDescripcion(4).Caption = VGACatalogo.Descripcion$
           If txtCampo(3).Text <> "" Then
              VLPaso% = True
           End If
          
        Else
           txtCampo(3).Tag = ""
        End If

    End Select
End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 1, 2
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Select Case Index%
  Case 1
    VLPaso% = True
    VGOperacion$ = "sp_parametro_extracto"
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4140"
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "X"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLINT2, 2
    PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(1).Text
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_parametro_extracto", True, " OK... Consulta de Productos COBIS") Then
        PMMapeaObjeto sqlconn&, lblDescripcion(1)
        PMChequea sqlconn&
        'txtCampo(2).Text = ""
    End If

  Case 3
  
  If VLPaso% = False Then
     
    
      If mskCuenta.ClipText = "" Then
            MsgBox ("Debe indicar la cuenta de ahorros")
            mskCuenta.SetFocus
            mskCuenta.Text = ""
            Exit Sub
      End If
      
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
      If Trim$(txtCampo(3).Text) <> "" Then
            VGOperacion$ = "sp_direccion_cons"
            PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "D"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "E"
            PMPasoValores sqlconn&, "@i_cta_ah", 0, SQLCHAR, mskCuenta.ClipText
            PMPasoValores sqlconn&, "@i_direccion", 0, SQLINT2, txtCampo(3).Text
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1227"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_direccion_cons", True, " Ok... Consulta de direcciones") Then
                PMMapeaObjeto sqlconn&, lblDescripcion(4)
                PMChequea sqlconn&
                VLPaso% = True
            Else
               lblDescripcion(4).Caption = ""
               txtCampo(3).SetFocus
            End If
        End If
    End If
    
End Select
End Sub

