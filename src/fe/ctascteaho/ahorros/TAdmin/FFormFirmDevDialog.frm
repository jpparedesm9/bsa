VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{F856EC8B-F03C-4515-BDC6-64CBD617566A}#6.0#0"; "fpSpr60.ocx"
Begin VB.Form FFormFirmDevDialog 
   Caption         =   "Listado de Registros"
   ClientHeight    =   2355
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   7350
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   ScaleHeight     =   2355
   ScaleWidth      =   7350
   StartUpPosition =   3  'Windows Default
   Begin FPSpreadADO.fpSpread fpSpread1 
      Height          =   2295
      Left            =   0
      TabIndex        =   0
      Top             =   0
      Width           =   6495
      _Version        =   393216
      _ExtentX        =   11456
      _ExtentY        =   4048
      _StockProps     =   64
      AllowDragDrop   =   -1  'True
      AllowMultiBlocks=   -1  'True
      AllowUserFormulas=   -1  'True
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaxCols         =   3
      MaxRows         =   1
      Protect         =   0   'False
      RetainSelBlock  =   0   'False
      SpreadDesigner  =   "FFormFirmDevDialog.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   6
      Left            =   6480
      TabIndex        =   1
      Top             =   0
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
End
Attribute VB_Name = "FFormFirmDevDialog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLTramaCausas As String
Dim VLFlag As Integer
Public VGEjecSatis As Boolean
Public VGSecCheque As String
Dim filas As Integer
Dim Columnas As Integer





Sub PLGuardarCausas()
Dim marca As Integer
Dim VLCodCausa As String
Dim Descrip As String

'Verificando si el usuario presionó el botón aceptar en el formulario
'Obteniendo del formulario VLFFormFirmDevDialog las causas marcadas por el usuario
For filas = 1 To fpSpread1.MaxRows
  fpSpread1.Row = filas
  For Columnas = 1 To fpSpread1.MaxCols
    fpSpread1.col = Columnas
    Select Case Columnas
    Case 1
       marca = fpSpread1.Text
    Case 2
       VLCodCausa$ = fpSpread1.Text
    Case 3
       Descrip = fpSpread1.Text
    End Select

  Next 'grdFacturas.MaxCols

  'Verificando si fue marcada la fila
  If marca = True Then
  VLFlag = 1
    If VLTramaCausas = "" Then
        VLTramaCausas = VLCodCausa$
    Else
        VLTramaCausas = VLCodCausa$ + "|" + VLTramaCausas
    End If


  End If

Next 'grdFacturas.MaxRows
    
VLTramaCausas = "|" + VLTramaCausas + "|"


If Not VLTramaCausas = "||" Then  'Si existe una trama de causas seleccionada por el usuario
    
  If VLFlag = 1 Then
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "643"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
        PMPasoValores sqlconn&, "@i_causa_dev", 0, SQLCHAR, VLTramaCausas
        PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, VGSecCheque
        
  
  
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_forma_firma", True, "Transmitiendo las Causas de Devolucion") Then
            
            VGEjecSatis = True
            PMChequea sqlconn&
            Unload Me
        End If
    Else
        MsgBox "No seleccionó ninguna causa."
  End If
Else
  MsgBox "No seleccionó ninguna causa."
End If

'@i_causa_dev
'@i_secuencial VGSecCheque


End Sub



Private Sub cmdBoton_Click(Index As Integer)
Dim PVAcepCan As Integer

Select Case Index
   Case 6 'Salir
    PVAcepCan = True
    PLGuardarCausas
    Unload Me
End Select
End Sub

Private Sub Form_Load()
VGEjecSatis = False
VLFlag = 0
PMLoadResStrings Me
PMLoadResIcons Me
End Sub






