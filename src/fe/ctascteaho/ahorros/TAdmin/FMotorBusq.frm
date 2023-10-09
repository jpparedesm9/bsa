VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Begin VB.Form FMotorBusq 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   ClientHeight    =   5490
   ClientLeft      =   2160
   ClientTop       =   2715
   ClientWidth     =   9300
   ForeColor       =   &H00C0C0C0&
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   5490
   ScaleWidth      =   9300
   Begin VB.Frame fraTasas 
      Caption         =   "Criterios de Búsqueda"
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
      Height          =   765
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   8295
      Begin MSMask.MaskEdBox mskCuenta 
         Height          =   255
         Left            =   1560
         TabIndex        =   9
         Top             =   360
         Width           =   1605
         _ExtentX        =   2831
         _ExtentY        =   450
         _Version        =   393216
         Appearance      =   0
         PromptChar      =   "_"
      End
      Begin TxtinLib.TextValid txtCliente 
         Height          =   255
         Left            =   4320
         TabIndex        =   10
         Top             =   360
         Width           =   1605
         _Version        =   65536
         _ExtentX        =   2646
         _ExtentY        =   1323
         _StockProps     =   253
         BorderStyle     =   1
         Range           =   ""
         MaxLength       =   0
         Character       =   0
         Type            =   2
         HelpLine        =   ""
         Pendiente       =   ""
         Connection      =   0
         AsociatedLabelIndex=   742
         TableName       =   ""
         MinChar         =   0
         Error           =   0
      End
      Begin VB.Label Label2 
         Caption         =   "Cliente:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   3480
         TabIndex        =   8
         Top             =   360
         Width           =   1095
      End
      Begin VB.Label Label1 
         Caption         =   "No. Producto:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   240
         TabIndex        =   7
         Top             =   360
         Width           =   1815
      End
   End
   Begin MSGrid.Grid grdCuentas 
      Height          =   4215
      Left            =   0
      TabIndex        =   1
      Top             =   1200
      Width           =   8295
      _Version        =   65536
      _ExtentX        =   14631
      _ExtentY        =   7435
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
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
      Height          =   855
      Index           =   0
      Left            =   8385
      TabIndex        =   2
      Top             =   15
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Buscar"
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
      Picture         =   "FMotorBusq.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   1
      Left            =   8385
      TabIndex        =   3
      Top             =   885
      WhatsThisHelpID =   2020
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "Si&guiente"
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
      Picture         =   "FMotorBusq.frx":001C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   4
      Left            =   8400
      TabIndex        =   4
      Top             =   4545
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Salir"
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
      Picture         =   "FMotorBusq.frx":0038
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   5
      Left            =   8400
      TabIndex        =   5
      Top             =   2865
      WhatsThisHelpID =   2002
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Escoger"
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
      Picture         =   "FMotorBusq.frx":0054
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   855
      Index           =   2
      Left            =   8400
      TabIndex        =   6
      Top             =   3705
      WhatsThisHelpID =   2002
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "&Limpiar"
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
      Picture         =   "FMotorBusq.frx":0070
   End
   Begin VB.Label lblTitulo 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      Caption         =   "Datos:"
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
      Left            =   0
      TabIndex        =   11
      Top             =   840
      Width           =   570
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8355
      X2              =   8355
      Y1              =   90
      Y2              =   5390
   End
End
Attribute VB_Name = "FMotorBusq"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*********************************************************
'   Archivo:        FMOTORBUSQ.FRM
'   Producto:       CUENTAS DE AHORROS
'   Diseñado por:   Carlos Muñoz
'   Fecha de Documentación: 28/12/2009
'*********************************************************
'                       IMPORTANTE
' Esta Aplicación es parte de los paquetes bancarios pro-
' piedad de MACOSA, representantes exclusivos para el Ecua-
' dor de la NCR CORPORATION.  Su uso no autorizado queda
' expresamente prohibido así como cualquier alteración o
' agregado hecho por alguno de sus usuarios sin el debido
' consentimiento por escrito de la Presidencia Ejecutiva
' de MACOSA o su representante
'*********************************************************
' Pantalla de Cosnulta previa a acceso a Funcionalidades
'   de Cuentas Corrientes
'*********************************************************
Option Explicit
Const F5 = 116            'codigo ascii de la tecla F5
Dim VLProdbanc As String
Dim VLCategoria As String
Dim VLTipoEnte As String
Dim VLNumDoc As String
Dim VLTitularidad As String
'! removed Dim VLNumCta As String

Dim VLTipoTran As String
Dim VLProdBancBloq As String
Dim VLCliente As String
Dim VTFila As Integer
Dim VTR1 As Integer
    
    

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
  
    Case 0
        PLBuscar False
    Case 1
        PLBuscar True
    Case 5
        PLEscoger
    Case 2
        PLLimpiar
    Case 4
        Unload Me
        
        
     
    End Select
End Sub


Private Sub Form_Activate()
        
    mskCuenta.SetFocus
End Sub

Private Sub Form_Load()

    PMLoadResIcons Me
    Me.Top = 15
    Me.Left = 15
    Me.Height = 6000
    Me.Width = 9420
    VGCB = False
    mskCuenta.Mask = VGMascaraCtaAho$
    
End Sub

Private Sub Form_Unload(Cancel As Integer)
    VGCB = True
End Sub

Private Sub grdCuentas_Click()
    PMLineaG grdCuentas
End Sub

Private Sub grdCuentas_DblClick()
    PLEscoger
End Sub

Private Sub mskCuenta_Change()
    PMLimpiaG grdCuentas
End Sub

Private Sub txtCliente_Change()
    PMLimpiaG grdCuentas
End Sub

Private Sub txtCliente_KeyDown(Keycode As Integer, Shift As Integer)

    Dim VLFormatoFecha As String
    Dim VTRes As Boolean
    Dim VLPaso As Integer
    If Keycode% <> F5% Then
        Exit Sub
    End If
     ' F5 para ayuda de cliente
            ' Forma de busqueda de clientes
            txtCliente.Text = ""
            'VLBloqueado = "N"
            If VGFBusCliente Is Nothing Then
               Set VGFBusCliente = New BuscarClientes
            End If
            Set FMain = FPrincipal
            'Abrir forma de búsqueda de clientes
            VTRes = VGFBusCliente.FMBuscarCliente(FMain, VGMap, sqlconn&, ServerName$, ServerNameLocal$, VLFormatoFecha$, VGRol$)
            'Si se selecciona un cliente visualizar datos
              If VTRes = True Then
                If VGFBusCliente.DatosCliente(1) <> "" Then
                    txtCliente.Text = VGFBusCliente.DatosCliente(1)
                End If
                VLPaso% = True
                txtCliente.SetFocus
             End If
    PMChequea sqlconn&
 
End Sub

Private Sub PLBuscar(VTAnadir%)
    
    If txtCliente.Text = "" And mskCuenta.ClipText = "" Then
        MsgBox " Debe ingresar al menos una de las 2 condiciones", 16, "Atención"
        mskCuenta.SetFocus
        Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@i_ctaint", 0, SQLINT2&, "0"
    If VTAnadir% Then
        grdCuentas.Col = 1
        VTFila% = grdCuentas.Row
        grdCuentas.Row = 1
        If grdCuentas.Rows <= 2 And grdCuentas.Text = "" Then
            Exit Sub
        End If
        grdCuentas.Row = VTFila%
        
        grdCuentas.Row = grdCuentas.Rows - 1
        grdCuentas.Col = 12
       ' grdCuentas.Col = grdCuentas.Cols - 4
       ' grdCuentas.ColWidth(grdCuentas.Col) = 1100  'REAJUSTE
    
        PMPasoValores sqlconn&, "@i_ctaint", 0, SQLINT2&, (grdCuentas.Text)
    End If
     
    'Paso de parametros de búsqueda
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "206"
     PMPasoValores sqlconn&, "@i_codcliente", 0, SQLVARCHAR&, txtCliente.Text
     PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR&, mskCuenta.ClipText
     PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
     PMPasoValores sqlconn&, "@i_trn", 0, SQLINT2&, Me.Tag
     
     
     
     If Me.Caption = "Reactivación de Cuentas" Then
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR&, "I"
     End If
     
     If Me.Caption = "Reapertura de Cuentas" Then
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR&, "C"
     End If
     
     If Me.Caption = "Activación de Cuenta sin Depósito Inicial" Then
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR&, "G"
     End If
     If Me.Caption = "Liberación de Cupo CB Red Posicionada" Or Me.Caption = "Cancelación de Cuentas C.B." Then
        PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLCHAR&, "S"
     End If
    
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
         PMMapeaGrid sqlconn&, grdCuentas, VTAnadir%
         'PMMapeaVariable sqlconn&, VLContractual
         
         PMChequea sqlconn&
         If Val(grdCuentas.Tag) = 20 Then
            cmdBoton(1).Enabled = True
         Else
            cmdBoton(1).Enabled = False
        End If
    End If
        'JLO 2001/10/02 Cambio para que la escoger el primer registro
        grdCuentas.Row = 1
       ' grdCuentas_Click
        
        
End Sub

Private Sub PLEscoger()
Dim VLEstado As String
Dim VLNombre As String
Dim VLOficina As String
Dim VLOficinaO As String
Dim VTR As Integer
Dim i As Integer
Dim VLTraslado_dtn As String
grdCuentas.Col = 1
VTFila% = grdCuentas.Row
grdCuentas.Row = 1
If grdCuentas.Rows <= 2 And grdCuentas.Text = "" Then
    Exit Sub
End If
grdCuentas.Row = VTFila%
'grdCuentas.Col = 1
'mskCuenta.Mask = grdCuentas.Text

Select Case Me.Caption
    
    Case "Bloqueo de Movimientos"
        Unload FTran211
        grdCuentas.Col = 1
        FTran211.mskCuenta.Mask = VGMascaraCtaAho$
        FTran211.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        'FTran211.Caption = "Actualización de Operaciones"
        FTran211.Show
        SendKeys "{TAB}"
    
    Case "Actualización de Cuentas de Ahorro"
        Unload FTran202
        grdCuentas.Col = 1
        FTran202.mskCuenta.Mask = VGMascaraCtaAho$
        FTran202.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran202.mskCuenta.Enabled = False
        FTran202.Show
        'SendKeys "{TAB}"
        
    Case "Activación de Cuenta sin Depósito Inicial"
        grdCuentas.Col = 11
        If grdCuentas.Text = "A" Then
           MsgBox "Cuenta de Ahorros ya se encuentra activa", 16, "Atención"
           Exit Sub
        End If
        If grdCuentas.Text = "N" Then
           MsgBox "Cuenta de Ahorros se encuentra anulada. No se puede activar", 16, "Atención"
           Exit Sub
        End If
        If grdCuentas.Text <> "G" Then
           MsgBox "Cuenta de Ahorros no se encuentra en estado de ingreso.", 16, "Atención"
           Exit Sub
        End If
        Unload FTran437
        grdCuentas.Col = 1
        FTran437.mskCuenta.Mask = VGMascaraCtaAho$
        FTran437.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran437.Caption = "Activación de Cuenta sin Depósito Inicial"
        FTran437.Show
        SendKeys "{TAB}"
            
    Case "Desbloqueo de Movimientos"
        Unload FTran212
        grdCuentas.Col = 1
        FTran212.mskCuenta.Mask = VGMascaraCtaAho$
        FTran212.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran212.Show
        SendKeys "{TAB}"
        
     Case "Consulta de Movimientos"
        Unload FTran232
        grdCuentas.Col = 1
        FTran232.mskCuenta.Mask = VGMascaraCtaAho$
        FTran232.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran232.mskCuenta.Enabled = False
        FTran232.Show
        'SendKeys "{TAB}"
    
    Case "Consulta de Bloqueo de Movimientos"
        Unload FTran245
        grdCuentas.Col = 1
        FTran245.mskCuenta.Mask = VGMascaraCtaAho$
        FTran245.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran245.mskCuenta.Enabled = False
        FTran245.Show
        'SendKeys "{TAB}"

    Case "De Bloqueos de Valor en Cuentas de Ahorro"
        Unload FTran218
        grdCuentas.Col = 1
        FTran218.mskCuenta.Mask = VGMascaraCtaAho$
        FTran218.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran218.Show
        SendKeys "{TAB}"

    Case "Consulta de Bloqueos de Valores en la Cuentas"
        Unload FTran216
        grdCuentas.Col = 1
        FTran216.mskCuenta.Mask = VGMascaraCtaAho$
        FTran216.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran216.mskCuenta.Enabled = False
        FTran216.Show
        'SendKeys "{TAB}"
        
    Case "Reactivación de Cuentas"
        Unload FTran203
        'INI REQ465 OCT/2014
        grdCuentas.Col = 1
        VGCuenta = grdCuentas.Text
        grdCuentas.Col = 16
        VLEstado = grdCuentas.Text
        grdCuentas.Col = 6
        VLCliente = grdCuentas.Text
        'Paso de parametros de búsqueda
        If VLEstado = "P" Then
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "S"
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "206"
            PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR&, VGCuenta
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
            PMPasoValores sqlconn&, "@i_codcliente", 0, SQLVARCHAR&, VLCliente
            PMPasoValores sqlconn&, "@i_corresponsal", 0, SQLCHAR&, "N"
            grdCuentas.Col = 11
            PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR&, grdCuentas.Text
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
                ReDim VTArreglo(20) As String
                VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
                VLNombre = VTArreglo(9)
                VLOficina = VTArreglo(4)
                VLTitularidad = "I"
                VLOficinaO = VTArreglo(13)
                PMChequea sqlconn&
                
                VTR% = grdCuentas.Rows - 1
                For i% = 1 To VTR
                    VGTipoDoc = ""
                    VLNumDoc = ""
                    VLTipoTran = ""
                    grdCuentas.Row = i%
                    VLTipoTran = "203"
                    grdCuentas.Col = 7
                    VGTipoDoc = grdCuentas.Text
                    grdCuentas.Col = 8
                    VLNumDoc = grdCuentas.Text
                    VLTipoTran = "203"
                    FMRegistraHuellaAValidar VGTipoDoc, VLNumDoc, VLTitularidad, VGCuenta, VLTipoTran
                Next i%

                VLTipoTran = "203"
                FMVerificaHuella VGCuenta, VLTipoTran

                If VGRegistraHuellaAValidar = True Then
                   grdCuentas.Col = 1
                   FTran203.mskCuenta.Mask = VGMascaraCtaAho$
                   FTran203.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
                   FTran203.Show
                   SendKeys "{TAB}"
                Else
                   Exit Sub
                End If
            End If
        Else 'INI REQ465 OCT/2014
            grdCuentas.Col = 1
            FTran203.mskCuenta.Mask = VGMascaraCtaAho$
            FTran203.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
            FTran203.Show
            SendKeys "{TAB}"
        End If
    
    Case "Reapertura de Cuentas"
        Unload FTran204
        grdCuentas.Col = 1
        FTran204.mskCuenta.Mask = VGMascaraCtaAho$
        FTran204.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran204.Show
        SendKeys "{TAB}"
        
        
    Case "Cancelación de Cuentas"
        Unload FTran214
        grdCuentas.Col = 1
        FTran214.mskCuenta.Mask = VGMascaraCtaAho$
        FTran214.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran214.Show
        SendKeys "{TAB}"
        
    Case "Cancelación de Cuentas C.B."
        Unload FTran214
        grdCuentas.Col = 1
        VGCB = True
        FTran214.Caption = "Cancelación de Cuentas C.B."
        FTran214.mskCuenta.Mask = VGMascaraCtaAho$
        FTran214.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran214.Show
        SendKeys "{TAB}"
        
    Case "Cobro de Valores en Suspenso"
        Unload FTran303
        grdCuentas.Col = 1
        FTran303.mskCuenta.Mask = VGMascaraCtaAho$
        FTran303.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran303.Show
        SendKeys "{TAB}"
        
    Case "Liberación de Cupo CB Red Posicionada"
        Unload FTran303
        grdCuentas.Col = 1
        VGCB = True
        FTran303.Caption = "Liberación de Cupo CB Red Posicionada"
        FTran303.mskCuenta.Mask = VGMascaraCtaAho$
        FTran303.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran303.Show
        SendKeys "{TAB}"
        
    Case "Consulta de Saldos"
        Unload FTran230
        grdCuentas.Col = 1
        FTran230.mskCuenta.Mask = VGMascaraCtaAho$
        FTran230.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran230.mskCuenta.Enabled = False
        FTran230.Show
        'SendKeys "{TAB}"
        
        
    Case "Consulta de Saldos y Promedios"
        Unload Ftran220
        grdCuentas.Col = 1
        Ftran220.mskCuenta.Mask = VGMascaraCtaAho$
        Ftran220.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        Ftran220.mskCuenta.Enabled = False
        Ftran220.Show
        'SendKeys "{TAB}"
        
    Case "Consulta General"
        Unload FTran235
        grdCuentas.Col = 1
        FTran235.mskCuenta.Mask = VGMascaraCtaAho$
        FTran235.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran235.mskCuenta.Enabled = False
        FTran235.Show
        'SendKeys "{TAB}"
                      
     Case "Consulta de Valores en Suspenso"
        Unload FTran247
        grdCuentas.Col = 1
        FTran247.mskCuenta.Mask = VGMascaraCtaAho$
        FTran247.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran247.mskCuenta.Enabled = False
        FTran247.Show
        'SendKeys "{TAB}"
    
    Case "Consulta de Detalle de Cálculo de Intereses"
        Unload FTran343
        grdCuentas.Col = 1
        FTran343.mskCuenta.Mask = VGMascaraCtaAho$
        FTran343.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran343.mskCuenta.Enabled = False
        FTran343.Show
        'SendKeys "{TAB}"
        
        
    Case "Consulta de Extracto de Cuenta de Ahorros"
        Unload FTran234
        grdCuentas.Col = 1
        FTran234.mskCuenta.Mask = VGMascaraCtaAho$
        FTran234.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran234.mskCuenta.Enabled = False
        grdCuentas.Col = 6
        FTran234.Lblcli.Caption = grdCuentas.Text
        FTran234.Show
        'SendKeys "{TAB}"
        
        
    Case "Extracto de Cuenta de Ahorros Sin Costo"
        Unload FTran223
        grdCuentas.Col = 1
        FTran223.mskCuenta.Mask = VGMascaraCtaAho$
        FTran223.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        grdCuentas.Col = 6
        FTran223.Lblcli.Caption = grdCuentas.Text
        FTran223.mskCuenta.Enabled = False
        FTran223.Show
        'SendKeys "{TAB}"
    
    Case "Bloqueo de Valores en Cuenta de Ahorros"
        Unload FTran217
        grdCuentas.Col = 1
        FTran217.mskCuenta.Mask = VGMascaraCtaAho$
        FTran217.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran217.Show
        SendKeys "{TAB}"
        
    Case "Liberación Anticipada de Canje"
        Unload FTran098
        grdCuentas.Col = 1
        FTran098.mskCuenta.Mask = VGMascaraCtaAho$
        FTran098.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran098.Show
        SendKeys "{TAB}"
        
        
    Case "Consulta de Canje por Cuenta"
        Unload FTran096
        grdCuentas.Col = 1
        FTran096.mskCuenta.Mask = VGMascaraCtaAho$
        FTran096.mskCuenta.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
        FTran096.mskCuenta.Enabled = False
        FTran096.Show
        'SendKeys "{TAB}"
    
    Case "Marcacion Servicio"
    grdCuentas.Col = 1
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "Q"
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "206"
    PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR&, grdCuentas.Text
    PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
        ReDim VTArreglo(20) As String
        VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
        VLNombre = VTArreglo(1)
        VLOficina = VTArreglo(2)
        VLTraslado_dtn = VTArreglo(3)
        VLTitularidad = VTArreglo(4)
        VLOficinaO = VTArreglo(5)
        PMChequea sqlconn&
    Else
       Exit Sub
    End If
    
    grdCuentas.Col = 1
    FTran433.Mskcuentadb.Mask = VGMascaraCtaAho$
    FTran433.Mskcuentadb.Text = FMMascara(grdCuentas.Text, VGMascaraCtaAho$)
    FTran433.Mskcuentadb.Enabled = False
    FTran433.lblTitularidad.Caption = VLTitularidad
    FTran433.lblFila.Caption = grdCuentas.Row
    FTran433.Show
 
    Case "Consulta Cuentas con Caracteristicas Especiales"
           Unload FTran096
           grdCuentas.Col = 1
           VGCuenta = grdCuentas.Text
           grdCuentas.Col = 2
           VLProdbanc = grdCuentas.Text
           grdCuentas.Col = 15
           VLCategoria = grdCuentas.Text
           grdCuentas.Col = 16
           VLTipoEnte = grdCuentas.Text
           PLBuscar_marca
           
    'REQ 363
    Case "Relacion Cuenta a Canales"
        Unload FRelCtaCanal
        grdCuentas.Col = 1
        VGCuenta = grdCuentas.Text
        grdCuentas.Col = 16
        VLEstado = grdCuentas.Text
        If VLEstado = "C" Then
            MsgBox "Cuenta de Persona Jurídica. No puede relacionarse a un canal ", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
        
                'Req. 371 Verificar si en el catalogo el prod bancario bloq existe
        grdCuentas.Col = 2
        VLProdbanc = grdCuentas.Text
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "747"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "V"
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, VLProdbanc
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_relacion_cta_canal", True, "Ok....Consultando") Then
            PMMapeaVariable sqlconn&, VLProdBancBloq
            PMChequea sqlconn&
        Else
            VLProdBancBloq = ""
        End If
        
        If VLProdBancBloq <> "" Then
            MsgBox "Producto Bancario bloqueado y/o excluido no puede relacionarse con canales", 0 + 48, "Advertencia"
            Exit Sub
        End If
        'Paso de parametros de búsqueda
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "Q"
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "206"
        PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR&, VGCuenta
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
            ReDim VTArreglo(20) As String
            VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
            VLNombre = VTArreglo(1)
            VLOficina = VTArreglo(2)
            VLTraslado_dtn = VTArreglo(3)
            VLTitularidad = VTArreglo(4)
            VLOficinaO = VTArreglo(5)
            PMChequea sqlconn&
            
            'Req. 371 Tarjeta Debito
            VTR% = grdCuentas.Rows - 1
            For i% = 1 To VTR
                VGTipoDoc = ""
                VLNumDoc = ""
                VLTipoTran = ""
                grdCuentas.Row = i%
                VLTipoTran = "1610"
                grdCuentas.Col = 7
                VGTipoDoc = grdCuentas.Text
                grdCuentas.Col = 8
                VLNumDoc = grdCuentas.Text
                VLTipoTran = "1610"
                FMRegistraHuellaAValidar VGTipoDoc, VLNumDoc, VLTitularidad, VGCuenta, VLTipoTran
            Next i%
            
            If VLTitularidad = "CONJUNTA" Then
                MsgBox "Cuenta con Titularidad Conjunta. No puede relacionarse a un canal ", 0 + 16, "Mensaje de Error"
                Exit Sub
            Else
                'Req. 371 Tarjeta Debito
                VLTipoTran = "1610"
                FMVerificaHuella VGCuenta, VLTipoTran
                
                'Req. 371 Tarjeta Debito
                If VGRegistraHuellaAValidar = True Then
                    FRelCtaCanal.Show
                Else
                    Exit Sub
                End If
            End If
        End If
        Unload Me
End Select

End Sub


Private Sub PLLimpiar()

 
    mskCuenta.Mask = VGMascaraCtaAho$
    mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
    txtCliente.Text = ""
    PMLimpiaG grdCuentas



End Sub

Private Sub PLBuscar_marca()
'*************************************************************
' PROPOSITO: Permite transmitir la informacion de la forma
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 31-Mar-2011   S. Molano        Emisión Inicial
'*************************************************************
' PARAMETRO AHORRO CONTRACTUAL
Dim VLParametro(15, 2) As String
Dim VTCambiaCategoria As String
Dim VTContractual As String
Dim VLProdfinal As String
Dim VLParametriza As String
Dim VLActiva As String

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "PAHCT"
PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "AHO"
If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, " Ok... Consulta de tipo de bloqueo de terminal") Then
    VTR1% = FMMapeaMatriz(sqlconn&, VLParametro())
    PMChequea sqlconn&
    If VLParametro(6, 1) = VLProdbanc Then
        VGContractual$ = "S"
    Else
        VGContractual$ = "N"
    End If
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "PAHPR"
PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "AHO"
If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, " Ok... Consulta de tipo de bloqueo de terminal") Then
    VTR1% = FMMapeaMatriz(sqlconn&, VLParametro())
    PMChequea sqlconn&
    If VLParametro(6, 1) = VLProdbanc Then
        VGProgresivo$ = "S"
    Else
        VGProgresivo$ = "N"
    End If
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "CAMCAT"
PMPasoValores sqlconn&, "@i_producto", 0, SQLVARCHAR, "AHO"
If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, " Ok... Consulta de tipo de bloqueo de terminal") Then
    VTR1% = FMMapeaMatriz(sqlconn&, VLParametro())
    PMChequea sqlconn&
    If VLParametro(3, 1) = VLCategoria Then
        VTCambiaCategoria = "S"
    Else
        VTCambiaCategoria = "N"
    End If
End If

PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 734
PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, VLCategoria
PMPasoValores sqlconn&, "@i_prodban", 0, SQLVARCHAR, VLProdbanc
PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
PMPasoValores sqlconn&, "@i_tipoente", 0, SQLCHAR, VLTipoEnte
PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, VGCuenta

If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mto_aho_contractual", True, "Ok... Consulta Marca Contractual") Then
   PMMapeaVariable sqlconn&, VTContractual$
   PMMapeaVariable sqlconn&, VLProdfinal$
   PMMapeaVariable sqlconn&, VLParametriza$
   PMMapeaVariable sqlconn&, VLActiva$
   PMChequea sqlconn&
   
   If VLActiva$ = "S" Then
      If VLParametriza$ <> 0 Or VTCambiaCategoria = "S" Then
         VGcategoria = VLCategoria
         VGprofinal = VLProdfinal$
         VGOrigen = "1"
         Ftran434.Show 1
      Else
        MsgBox "No existe parametrizacion para el Producto Final " + VLProdfinal$ + " y Categoria " + VLCategoria + " ", 0 + 16, "Mensaje de Error"
      End If
   Else
      MsgBox "La Cuenta " + VGCuenta + " no tiene caracteristicas Especiales ", 0 + 16, "Mensaje de Error"
   End If
   PMChequea sqlconn&
End If
End Sub

