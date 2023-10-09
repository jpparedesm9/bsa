VERSION 5.00
Object = "{BE4F3AC8-AEC9-101A-947B-00DD010F7B46}#1.0#0"; "MSOUTL32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FHelpOficial 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Oficiales de Crédito"
   ClientHeight    =   2970
   ClientLeft      =   1380
   ClientTop       =   1845
   ClientWidth     =   5760
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
   ForeColor       =   &H00C0C0C0&
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   2970
   ScaleWidth      =   5760
   Begin Threed.SSCommand cmdBoton 
      Height          =   375
      Index           =   0
      Left            =   30
      TabIndex        =   2
      Top             =   2580
      WhatsThisHelpID =   2042
      Width           =   2760
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
      BevelWidth      =   3
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   375
      Index           =   1
      Left            =   2805
      TabIndex        =   1
      Top             =   2580
      WhatsThisHelpID =   2012
      Width           =   2940
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Cancelar"
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
      BevelWidth      =   3
   End
   Begin MSOutl.Outline otlOficiales 
      Height          =   2505
      Left            =   15
      TabIndex        =   0
      Top             =   15
      Width           =   5715
      _Version        =   65536
      _ExtentX        =   10081
      _ExtentY        =   4419
      _StockProps     =   77
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   0
      X2              =   5745
      Y1              =   2535
      Y2              =   2550
   End
End
Attribute VB_Name = "FHelpOficial"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FHLPOFI.frm
' NOMBRE LOGICO:    FHelpOficial
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
' Muestra la información de oficiales mediante un árbol
' jerárquico. Pantalla para F5 de oficiales.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Option Explicit
Dim VTCodigo As String
Dim VTR1 As Integer
Dim i As Integer
Dim VTemporal As String
Dim VTpos As Integer
' Pantalla para F5 de oficiales

Private Sub cmdBoton_Click(Index As Integer)

    ' Selección de los oficiales de crédito
    ' Mediante los botones
    ' Redimencionar la variable global

    ReDim VGBusqueda(2) As String
    Dim VTpos As Integer
    Dim VTpos1 As Integer
    Dim VTpos2 As Integer
    Dim VTNombre As String
    Select Case Index%
    Case 0

        ' Determinación del nivel y el nombres del oficial
        ' de credito seleccionado
        VTpos% = InStr(1, otlOficiales.Text, " - ")
        If VTpos% <> 0 Then
            VTCodigo$ = Trim$(Mid$(otlOficiales.Text, 1, VTpos% - 1))
            VTpos1% = InStr(VTpos% + 2, otlOficiales.Text, " - ")
            VTpos2% = InStr(VTpos1% + 2, otlOficiales.Text, " - ")
            VTNombre$ = Trim$(Mid$(otlOficiales.Text, VTpos1% + 2, VTpos2% - VTpos1% - 1))
        End If

        ' Asiganación de los datos seleccionados a las variables
        ' globales
        If otlOficiales.ListIndex <> 0 Then
            VGBusqueda(0) = VTCodigo$
            VGBusqueda(1) = VTNombre$
            Unload FHelpOficial
        End If

    Case 1

        ' Cancelar la selección de oficiales de credito
        VGBusqueda(0) = "*"
        Unload FHelpOficial
    End Select

End Sub

Private Sub cmdBoton_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = "Escoger el Funcionario actual"
    Case 1
        FPrincipal.pnlHelpLine.Caption = "Cancelar la  Operación"
    End Select
End Sub

Private Sub Form_Load()
    Dim VLSuper As String
    PMLoadResStrings Me
    PMLoadResIcons Me
   
    ' Forma que permite tener F5 de funcionarios

    ' Limpiar la lista de oficiales de crédito
    otlOficiales.Clear

    ' Matriz para recibir los resultados de la consulta
    ReDim VTOficiales(5, 100) As String
    ' Consulta de todos los oficiales dado el nivel
    ' y dado el oficial superior

    If VGOficial$ <> "" Then
        VLSuper$ = VGOficial$
    Else
        VLSuper$ = "32001"
    End If
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "15153"
     PMPasoValores sqlconn&, "@i_super", 0, SQLINT2, VLSuper$
     PMPasoValores sqlconn&, "@i_nivel", 0, SQLVARCHAR, "1"
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
    
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_tr_cons_oficiales", True, "Ok.. Consulta de Oficiales de Crédito") Then
         VTR1% = FMMapeaMatriz(sqlconn&, VTOficiales())
         PMChequea sqlconn&

        ' Mapeo de resultados para la lista de oficiales de credito
        ' 1 Código de Oficiales
        ' 2 Nombre del Oficial
        ' 3 Nivel de Oficial

        otlOficiales.AddItem "ESTRUCTURA DE OFICIALES", 0
        For i% = 1 To VTR1%
            VTemporal$ = " " + VTOficiales(0, i%) + " - " + "N" + VTOficiales(3, 1) + " - " + VTOficiales(1, i%) + " - " + VTOficiales(2, i%)
            otlOficiales.AddItem VTemporal$
        Next i%
        If VTR1% <> 0 Then
            otlOficiales.ListIndex = 1
        End If
    
    End If

End Sub

Private Sub otlOficiales_DblClick()
    ' Determinacion del indice del oficial seleccionado
    Dim VTIndex As Integer
    Dim VTOficial As String
    VTIndex% = otlOficiales.ListIndex

    ReDim VTOficiales(5, 100) As String
    If otlOficiales.ListIndex <> 0 Then
        If otlOficiales.Expand(VTIndex%) = True Then
            otlOficiales.Expand(VTIndex%) = False
        Else
            If otlOficiales.HasSubItems(VTIndex%) = False Then
                
                ' Determinación del codigo del Oficial de Crédito
                VTpos% = InStr(1, otlOficiales.Text, " - ")
                VTCodigo$ = Trim$(Mid$(otlOficiales.Text, 1, VTpos% - 1))
                VTOficial$ = "0"
                
                Do While 1 = 1
                    ' Consulta de todos los oficiales dado el nivel
                    ' y dado el oficial superior
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "15153"
                     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                     PMPasoValores sqlconn&, "@i_super", 0, SQLINT2, VTCodigo$
                     PMPasoValores sqlconn&, "@i_nivel", 0, SQLVARCHAR, "1"
                     PMPasoValores sqlconn&, "@i_oficial", 0, SQLINT2, VTOficial$
                    
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_tr_cons_oficiales", True, "Ok.. Consulta de Oficiales de Crédito") Then
                         VTR1% = FMMapeaMatriz(sqlconn&, VTOficiales())
                         PMChequea sqlconn&
                
                        ' Mapeo de resultados para la lista de oficiales de credito
                        ' 1 Código de Oficiales
                        ' 2 Nombre del Oficial
                        ' 3 Nivel de Oficial
                
                        For i% = 1 To VTR1%
                            VTemporal$ = " " + VTOficiales(0, i%) + " - " + "N" + VTOficiales(3, 1) + " - " + VTOficiales(1, i%) + " - " + VTOficiales(2, i%)
                            otlOficiales.AddItem VTemporal$
                        Next i%
                        
                         If FMRetStatus(sqlconn&) <> 20 Then
                            Exit Do
                         End If
                         VTOficial$ = VTOficiales(0, VTR1%)
                        
                    End If
                Loop
            End If
        End If
        otlOficiales.Expand(VTIndex%) = True
    Else
        MsgBox "No se ha definido Oficiales de Crédito", 0 + 16, "Mensaje de Error"
    End If

End Sub

Private Sub otlOficiales_GotFocus()
    FPrincipal.pnlHelpLine.Caption = "Estructura de Oficiales de Crédito"
End Sub


