VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FPrint 
   Caption         =   "Seleccion de Impresora"
   ClientHeight    =   1560
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6285
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   1560
   ScaleWidth      =   6285
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame fraPrinters 
      Caption         =   "Lista de Impresoras Disponibles: "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000080&
      Height          =   1335
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   4455
      Begin VB.OptionButton optOrientacion 
         Caption         =   "Horizontal"
         Height          =   375
         Index           =   1
         Left            =   3240
         TabIndex        =   6
         Top             =   840
         Value           =   -1  'True
         Width           =   1095
      End
      Begin VB.OptionButton optOrientacion 
         Caption         =   "Vertical"
         Height          =   375
         Index           =   0
         Left            =   2280
         TabIndex        =   5
         Top             =   840
         Width           =   975
      End
      Begin VB.ComboBox cmbPrinters 
         Height          =   315
         Left            =   1080
         TabIndex        =   0
         Top             =   480
         Width           =   3255
      End
      Begin VB.Label Label1 
         Caption         =   "Orientación:"
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
         Left            =   1200
         TabIndex        =   7
         Top             =   840
         Width           =   1095
      End
      Begin VB.Label lblPrinters 
         Caption         =   "Impresora:"
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
         Left            =   120
         TabIndex        =   2
         Top             =   480
         Width           =   975
      End
   End
   Begin Threed.SSCommand cmdboton 
      Height          =   285
      Index           =   1
      Left            =   4680
      TabIndex        =   3
      Top             =   600
      Width           =   1500
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   503
      _StockProps     =   78
      Caption         =   "&Cancelar"
      ForeColor       =   8388608
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
   Begin Threed.SSCommand cmdboton 
      Height          =   285
      Index           =   0
      Left            =   4680
      TabIndex        =   4
      Top             =   240
      Width           =   1500
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   503
      _StockProps     =   78
      Caption         =   "&Aceptar"
      ForeColor       =   8388608
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
Attribute VB_Name = "FPrint"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Private Sub cmbPrinters_Click()
'Seleccion de impresora desde el Combo Box
Dim X As Printer
VGImpresora = ""
If cmbPrinters.ListIndex > 0 Then
   For Each X In Printers
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
       If UCase$(X.DeviceName) = UCase$(cmbPrinters.Text) Then
          Set Printer = X
          VGImpresora = Printer.DeviceName
          Exit For
       End If
   Next
End If
End Sub

Private Sub cmdBoton_Click(Index As Integer)
Dim ret As Integer
Select Case Index
    Case 0 'Aceptar
        If VGImpresora <> "" Then
           If optOrientacion(0).Value = True Then
              VGImpOrientacion = 1
           Else
              VGImpOrientacion = 2
           End If
           Unload Me
        Else
           ret% = MsgBox("No ha seleccionado la impresora.", vbOKOnly, "Selección de impresora")
        End If
    Case 1 'Cancelar
        VGImpresora = ""
        Unload Me
End Select
End Sub

Private Sub Form_Load()
    Call FMCargarPrinters
    
    If VGCodPais = "CO" Then
        optOrientacion(0).Value = True
    End If
    
End Sub

'FIXIT: Declare 'FMCargarPrinters' with an early-bound data type                           FixIT90210ae-R1672-R1B8ZE
Private Sub FMCargarPrinters()
'Coloca cada impresora definida en Windows en el combo box de Seleccion
Dim X As Printer

cmbPrinters.Clear
cmbPrinters.AddItem ""
For Each X In Printers
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
    cmbPrinters.AddItem UCase$(X.DeviceName)
Next
End Sub


